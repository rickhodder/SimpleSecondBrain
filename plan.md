# Plan: AI-Assisted PARA Second Brain

Build a multi-agent knowledge management system using folder-based markdown with specialized agents for intake, classification, organization, and search.

**TL;DR**: Create a PARA folder structure (People, Projects, Areas, Resources, Archives) with four specialized Copilot agents. The Admin agent routes user input through a Classifier (determines category), Organizer (files content), and Search agent (retrieves knowledge). Uses `.agent.md` files for custom agents that invoke each other.

---

## Steps

### Phase 1: Foundation Setup ✓ COMPLETED
1. **✓ Create folder structure** — Set up PARA folders plus Inbox for unclassified items
   - `People/` — contacts, relationships, notes about individuals
   - `Projects/` — time-bound initiatives with goals and deadlines
   - `Areas/` — ongoing responsibilities and interests
   - `Resources/` — reference material, articles, bookmarks
   - `Archives/` — completed or inactive items
   - `Inbox/` — temporary holding for unclassified items

2. **✓ Create template files** — One markdown template per category showing expected structure
   - `People/template-person.md` — Name, contact info, tags, notes
   - `Projects/template-project.md` — Goal, status, dates, related items
   - `Areas/template-area.md` — Scope, key notes, related projects
   - `Resources/template-resource.md` — Source, summary, tags
   - Each template includes frontmatter with metadata fields

3. **✓ Create agent configuration folder** — `.github/agents/` for workspace-scoped agents

### Phase 2: Agent Development ✓ COMPLETED
4. **✓ Create Classifier agent** — Analyzes input and determines category/tags
   - Tools: `[read, search]` (read-only access)
   - Logic: Examines input, checks existing notes for similar patterns, returns category + tags + confidence
   - Output: JSON-like structure with category, filename suggestion, tags, metadata
   - Handles ambiguity: If confidence < 70%, suggests Inbox with explanation

5. **✓ Create Organizer agent** — Files content into folder structure
   - Tools: `[read, edit, search]` (write access)
   - Takes Classifier output and creates/updates markdown files
   - Uses templates for structure
   - Handles naming conflicts (appends date/number)
   - Creates cross-references (links between related notes)

6. **✓ Create Search agent** — Queries and retrieves knowledge
   - Tools: `[read, search]` (read-only)
   - Handles natural language queries ("everyone in NY")
   - Can search across categories
   - Supports inference (connects related information)
   - Returns formatted results with links to source files

7. **✓ Create Brain agent (entry point)** — Orchestrates workflow
   - Tools: `[agent]` (orchestration only)
   - User-invocable: true (appears in agent picker)
   - Routes input through: Classifier → Organizer → confirms storage
   - Routes queries to: Search agent
   - Provides friendly feedback at each step

### Phase 3: Configuration & Documentation ✓ COMPLETED
8. **✓ Create AGENTS.md** — Documents folder conventions, tagging standards, naming rules
   - Shared context for all agents
   - Examples of each category
   - Tag taxonomy
   - Cross-linking conventions

9. **✓ Create README.md** — User guide for the system
   - How to add information ("@Brain Add: Rick Hodder (203) 555-1212")
   - How to search ("@Brain Find everyone in NY")
   - How to manually organize items in Inbox
   - Folder structure explanation

### Phase 4: Activity Logging ✓ COMPLETED
10. **✓ Create Logs folder** — Create directory for activity logs
    - `Logs/` — Stores all activity and debug logs

11. **✓ Update Organizer agent with logging** — Add automatic activity logging
    - Log every file creation/update to `Logs/activity.log`
    - Include: timestamp, action, file path, category, tags
    - Format: Human-readable markdown entries

12. **✓ Create initial log file** — Set up log structure with header

### Phase 5: Search Logging ✓ COMPLETED
13. **✓ Create search log file** — Set up log for tracking all searches
    - `Logs/searches.log` — Stores all search queries and results count

14. **✓ Update Search agent with logging** — Add automatic search logging
    - Log every search query to `Logs/searches.log`
    - Include: timestamp, query text, results count, categories searched
    - Format: Human-readable entries for debugging and analytics

### Phase 6: Reset Functionality ✓ COMPLETED
15. **✓ Create PowerShell reset script** — `reset-brain.ps1` for Windows/cross-platform
    - Remove all user-created files from PARA folders
    - Preserve template files (template-*.md) and README.md files
    - Truncate log files (keep headers, remove entries)
    - Confirmation prompt required (type 'RESET' to confirm)
    - Detailed operation logging and summary
    - Exit codes: 0 = success, 1 = errors occurred

16. **✓ Create Bash reset script** — `reset-brain.sh` for macOS/Linux/WSL
    - Identical functionality to PowerShell version
    - Cross-platform compatibility
    - Color-coded output for better readability
    - Same safety measures and confirmation prompts

17. **✓ Create .gitignore** — Prevent backup file commits
    - Ignore *.backup, *.bak, *.tmp files
    - Ignore OS-specific files (.DS_Store, Thumbs.db)
    - Ignore editor files (.vscode, .idea, *.swp)

18. **✓ Update README.md** — Document reset functionality
    - "Resetting Your Brain" section with clear warnings
    - What gets removed vs preserved
    - How to use scripts on different platforms
    - Safety features and use cases
    - Strong recommendation to commit to git first

---

## Relevant Files

**To create:**
- `.github/agents/admin.agent.md` (renamed to Brain) — Entry point, orchestrates other agents
- `.github/agents/classifier.agent.md` — Categorizes and tags input
- `.github/agents/organizer.agent.md` — Creates/updates markdown files
- `.github/agents/search.agent.md` — Retrieves and queries knowledge
- `.github/AGENTS.md` — Shared conventions and structure
- `README.md` — User guide
- `People/template-person.md` — Person note structure
- `Projects/template-project.md` — Project note structure
- `Areas/template-area.md` — Area note structure
- `Resources/template-resource.md` — Resource note structure
- `reset-brain.ps1` — PowerShell script to reset brain to empty state
- `reset-brain.sh` — Bash script to reset brain to empty state
- `.gitignore` — Git ignore patterns for backup and temp files

**Folder structure:**
```
SimpleSecondBrain/
├── .github/
│   ├── agents/
│   │   ├── admin.agent.md
│   │   ├── classifier.agent.md
│   │   ├── organizer.agent.md
│   │   └── search.agent.md
│   └── AGENTS.md
├── Logs/
│   ├── activity.log
│   └── searches.log
├── People/
│   └── template-person.md
├── Projects/
│   └── template-project.md
├── Areas/
│   └── template-area.md
├── Resources/
│   └── template-resource.md
├── Archives/
├── Inbox/
└── README.md
```

---

## Verification

1. **Test classification** — Provide varied inputs to Brain agent, verify Classifier correctly categorizes them
2. **Test organization** — Verify Organizer creates properly formatted files in correct folders
3. **Test Inbox fallback** — Provide ambiguous input, confirm it goes to Inbox with explanation
4. **Test search - simple** — "Find all projects" should return project notes
5. **Test search - filtered** — "Find everyone in NY" should filter People by location
6. **Test search - cross-category** — "Find all resources related to Project X" should link across folders
7. **Test inference** — "What am I working on with Alice?" should connect People + Projects
8. **Manual verification** — Check markdown files have correct frontmatter, links, and formatting

---

## Decisions

**Agent Architecture:**
- Using VS Code's built-in agent system (.agent.md files) — no MCP server initially to keep it simple
- Brain is user-facing; others are subagents only (not directly invokable)
- Single responsibility per agent with minimal tool access for focus

**Folder Organization:**
- PARA method with explicit Inbox for ambiguous items
- Templates establish consistent structure
- Frontmatter in all notes for metadata (tags, dates, status)

**Content Flow:**
- **Add flow**: User → Brain → Classifier → Organizer → Confirmation
- **Search flow**: User → Brain → Search → Results
- **Fallback**: Low confidence → Inbox with explanation for manual review

**Scope Included:**
- Natural language input processing
- Automatic categorization with confidence threshold
- File creation and organization
- Cross-category search with inference
- Unclassified item handling (Inbox)

**Scope Excluded (future enhancements):**
- Web clipping/import
- Automated periodic review prompts
- Link graph visualization
- Export to other formats
- Integration with external tools (Obsidian, Notion)
- Voice input processing
- Image/attachment handling
- Agent testing and evaluation using Chat Customizations Evaluations extension

---

## Further Considerations

**Frontmatter Schema** — What metadata fields should each category require?
- Recommendation: Keep minimal initially (title, tags, date, status), expand as patterns emerge

**Naming Convention** — How should files be named?
- Option A: kebab-case with date prefix (2026-06-01-rick-hodder.md)
- Option B: Title case with category prefix (People-Rick-Hodder.md)
- Option C: Simple descriptive (rick-hodder.md)
- Recommendation: **Option C** (simple) with folders providing context, easier to read and type

**Tagging System** — Hierarchical tags vs flat tags?
- Option A: Flat tags (#meeting, #urgent, #technical)
- Option B: Hierarchical (#work/project, #personal/health)
- Recommendation: **Option A** (flat) initially, easy to search and less cognitive overhead

**Agent Testing & Evaluation** — Using Chat Customizations Evaluations extension
- Purpose: Systematically test agent behavior, classification accuracy, and response quality
- Create test cases for each agent (Classifier accuracy, Organizer file creation, Search relevance)
- Measure confidence thresholds (is 70% the right cutoff for Inbox?)
- Track improvements over time as the knowledge base grows
- Extension: [Chat Customizations Evaluations](https://marketplace.visualstudio.com/items?itemName=GitHub.vscode-copilot-customization-eval)
- Future Phase: Add comprehensive evaluation suite for all agents
