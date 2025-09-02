import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

interface GitHubIssue {
  id: number
  title: string
  body: string
  state: string
  labels: Array<{ name: string }>
  assignee?: { login: string }
  created_at: string
  updated_at: string
  html_url: string
}

serve(async (req) => {
  // Handle CORS preflight requests
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_ANON_KEY') ?? '',
    )

    const { data, error } = await req.json()
    
    if (error) {
      throw new Error(`Request parsing error: ${error}`)
    }

    // GitHub webhook payload
    const issue: GitHubIssue = data.issue
    const action = data.action

    if (!issue) {
      return new Response(
        JSON.stringify({ error: 'No issue data provided' }),
        { headers: { ...corsHeaders, 'Content-Type': 'application/json' }, status: 400 }
      )
    }

    // Determine task category from labels
    let category = 'projects' // default
    const labels = issue.labels.map(label => label.name.toLowerCase())
    
    if (labels.includes('equipment')) category = 'equipment'
    else if (labels.includes('operations')) category = 'operations'
    else if (labels.includes('administrative')) category = 'administrative'

    // Determine priority from labels
    let priority = 'medium' // default
    if (labels.includes('high-priority') || labels.includes('urgent')) priority = 'high'
    else if (labels.includes('low-priority')) priority = 'low'

    // Determine status from GitHub issue state
    let status = 'pending'
    if (issue.state === 'closed') status = 'completed'
    else if (labels.includes('in-progress')) status = 'in_progress'

    const taskData = {
      title: issue.title,
      description: issue.body || '',
      category,
      priority,
      status,
      github_issue_url: issue.html_url,
      created_at: issue.created_at,
      updated_at: issue.updated_at,
    }

    let result
    
    if (action === 'opened') {
      // Create new task
      const { data: newTask, error: insertError } = await supabaseClient
        .from('tasks')
        .insert([{
          ...taskData,
          created_by: (await supabaseClient.from('users').select('id').eq('email', 'john.barr@yccc.edu').single()).data?.id
        }])
        .select()

      if (insertError) throw insertError
      result = { action: 'created', task: newTask }
      
    } else if (action === 'edited' || action === 'closed' || action === 'reopened') {
      // Update existing task
      const { data: updatedTask, error: updateError } = await supabaseClient
        .from('tasks')
        .update(taskData)
        .eq('github_issue_url', issue.html_url)
        .select()

      if (updateError) throw updateError
      result = { action: 'updated', task: updatedTask }
    }

    return new Response(
      JSON.stringify({ success: true, ...result }),
      { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    )

  } catch (error) {
    console.error('Error syncing GitHub issue:', error)
    return new Response(
      JSON.stringify({ error: error.message }),
      { headers: { ...corsHeaders, 'Content-Type': 'application/json' }, status: 500 }
    )
  }
})