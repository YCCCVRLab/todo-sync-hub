# VR Lab Todo Sync Hub

## YCCC VR Lab Command Center

A centralized todo management system for the YCCC VR Lab operations, equipment management, and project coordination.

### 🚀 Live Dashboard
**Visit**: https://yccvrlab.github.io/todo-sync-hub/

### Quick Commands

- **Equipment**: Purchase requests, maintenance, inventory
- **Lab Operations**: Daily tasks, student support, demos  
- **Projects**: VR Club planning, workshops, development
- **Administrative**: Documentation, reports, scheduling

### 🔧 Technology Stack

- **Frontend**: GitHub Pages with custom dashboard
- **Backend**: Supabase MCP Server
- **Database**: PostgreSQL with real-time subscriptions
- **Integration**: GitHub Issues sync
- **Deployment**: GitHub Actions

### 📁 File Structure

- `docs/` - GitHub Pages site and dashboard
- `todos/` - Active todo lists organized by category
- `completed/` - Archive of completed tasks
- `templates/` - Task templates for common activities
- `scripts/` - Automation tools for task management
- `supabase/` - Database schema, functions, and configuration
- `.github/` - Workflows and issue templates

### 🗄️ Database Features

**Tables**:
- `users` - Lab staff and student management
- `tasks` - Comprehensive task tracking with GitHub integration
- `equipment` - VR equipment inventory and maintenance
- `lab_schedules` - Class and lab session scheduling
- `task_comments` - Collaborative task updates

**Key Features**:
- Real-time updates via Supabase Realtime
- GitHub Issues bidirectional sync
- Equipment maintenance tracking
- Lab scheduling system
- Role-based access control

### 🔄 GitHub Integration

- **Issues → Tasks**: Automatic task creation from GitHub issues
- **Labels → Categories**: Smart categorization based on issue labels
- **Status Sync**: Real-time status updates between platforms
- **Webhooks**: Automated synchronization

### 📊 Dashboard Features

- **Priority Matrix**: Visual task prioritization
- **Equipment Status**: Real-time inventory monitoring  
- **Lab Schedule**: Class and session overview
- **Integration Status**: System health monitoring
- **Quick Actions**: Direct links to common tasks

### 🚀 Getting Started

1. **View Dashboard**: Visit the [live dashboard](https://yccvrlab.github.io/todo-sync-hub/)
2. **Add Tasks**: Use GitHub Issues or edit markdown files directly
3. **Track Equipment**: Monitor VR headsets and lab equipment
4. **Schedule Labs**: Coordinate classes and student sessions
5. **Collaborate**: Comment and update tasks in real-time

### 🔧 Setup Instructions

#### Supabase MCP Server
1. Create new Supabase project
2. Run migration: `supabase/migrations/001_initial_setup.sql`
3. Seed data: `supabase/seed.sql`
4. Deploy function: `supabase/functions/sync-github-issues/`
5. Configure environment variables

#### GitHub Pages
1. Enable GitHub Pages in repository settings
2. Set source to "GitHub Actions"
3. Workflow will auto-deploy on push to main

### 📋 Current Priority Tasks

- [x] **GitHub Pages Dashboard** - Live and functional
- [x] **Supabase Database Schema** - Ready for deployment
- [x] **GitHub Issues Integration** - Sync function created
- [ ] **Purchase 10 additional Meta Quest 3 headsets** - Budget approval pending
- [ ] **VR Club Launch** - Planning in progress
- [ ] **Command Center Setup** - Fake wall construction
- [ ] **Igloo Projection System** - Technical specifications

### 🏢 Lab Information

**Location**: Room 112, Wells Campus  
**Hours**: Monday-Friday, 8:00 AM - 4:30 PM  
**Office Hours**: Mon-Thu until 5:30 PM, Fri until 4:30 PM  
**Classes**: Tuesday/Thursday, 11:00 AM - 12:15 PM  
**Specialist**: John C. Barr  
**Department**: Simulation and Learning Technology  
**Institution**: York County Community College (YCCC)

### 🤝 Contributing

1. Create GitHub Issue for new tasks
2. Use provided templates for consistency
3. Update relevant todo files
4. Test Supabase integration
5. Submit pull requests for major changes

### 📞 Support

For technical issues or questions:
- Create GitHub Issue
- Contact: john.barr@yccc.edu
- VR Lab: Room 112, Wells Campus

---

**Last Updated**: September 2, 2025  
**Version**: 2.0 (Supabase + GitHub Pages Integration)  
**Status**: Production Ready 🎯