# Simple Second Brain

An AI-assisted, folder-based knowledge management system using the PARA method (People, Projects, Areas, Resources, Archives).

## What Is This?

This is your personal second brain - a place to capture, organize, and retrieve information using AI assistance. Instead of trying to remember everything, store it here and let the AI help you find it later.

## Folder Structure

```
📁 SimpleSecondBrain/
├── 📇 People/        - Contacts, relationships, interaction notes
├── 🎯 Projects/      - Time-bound goals with specific outcomes  
├── 🔄 Areas/         - Ongoing responsibilities and interests
├── 📚 Resources/     - Reference material, articles, tools
├── 📦 Archives/      - Completed or inactive items
├── 📥 Inbox/         - Unclassified items pending review
└── 📋 Logs/          - Activity and search logs for debugging
```

### When to Use Each Folder

**People** 📇 - Information about individuals
- Contact details (phone, email, address)
- Notes from conversations and meetings
- Relationship context
- Example: "Rick Hodder, (203) 555-1212, discussed project X"

**Projects** 🎯 - Things you're working toward that will be "done"
- Has a clear goal or deliverable
- Time-bound (even if loosely)
- Example: "Launch podcast by September", "Complete Python course"

**Areas** 🔄 - Ongoing responsibilities that never end
- Requires continuous maintenance
- Has standards to uphold
- Example: "Health & Fitness", "Team Management", "Personal Finance"

**Resources** 📚 - Reference material for later
- Articles, books, videos, tutorials
- Tools and documentation
- Inspiration and examples
- Example: "Python tutorial notes", "Design inspiration collection"

**Archives** 📦 - Completed or inactive
- Finished projects
- People you no longer interact with
- Old resources you might reference someday

**Inbox** 📥 - Temporary holding area
- When the AI isn't sure where something belongs
- Items you need to manually organize later
- Keep this empty or near-empty by reviewing weekly

**Logs** 📋 - System activity tracking
- Automatically tracks all file operations and searches
- [activity.log](Logs/activity.log) - File creations and updates
- [searches.log](Logs/searches.log) - All search queries performed
- Used for debugging and understanding usage patterns

---

## How to Use It

### Adding Information

Simply tell the **Brain** agent what you want to store. The AI will:
1. Figure out which folder it belongs in
2. Extract relevant information (tags, dates, contacts, etc.)
3. Create a properly formatted note
4. Confirm where it was saved

**Examples:**

```
@Brain Add: Rick Hodder, (203) 555-1212, lives in Connecticut

@Brain Store this: Article about productivity - 
"Getting Things Done" by David Allen

@Brain New project: Launch weekly podcast by September, 
need to research equipment and guests

@Brain Jane Smith, jane@example.com, met at conference, 
works on machine learning at TechCorp
```

**Manual classification** (if you know where it should go):
```
@Brain Add to People: John Doe, john@example.com

@Brain Create project: Website Redesign, due June 30
```

### Searching Information

Ask the **Brain** agent what you're looking for using natural language.

**Simple searches:**
```
@Brain Find everyone in New York

@Brain Show me all active projects

@Brain What resources do I have about Python?
```

**Connection searches:**
```
@Brain What am I working on with Sarah?

@Brain Find all information about machine learning

@Brain Show everything related to the podcast project
```

**Complex queries:**
```
@Brain Find people I met at conferences in 2026

@Brain What projects are due this month?

@Brain Show me resources about productivity and time management
```

### Organizing the Inbox

When the AI isn't confident about classification (< 70%), items go to [Inbox/](Inbox/).

**Review weekly:**
1. Open files in [Inbox/](Inbox/)
2. Decide which folder they belong in
3. Move them manually or ask Brain to reclassify with more context
4. Keep Inbox empty

---

## Behind the Scenes: The AI Agents

You primarily interact with the **Brain** agent, which coordinates three specialist agents:

- **Classifier** 🏷️ - Analyzes content and determines which folder it belongs in
- **Organizer** 📂 - Creates and updates files in the proper structure  
- **Search** 🔍 - Finds and retrieves information across all folders
- **Brain** 🎯 - Your main interface, orchestrates the other agents

You don't need to know how they work - just talk to Brain naturally.

---

## Activity Logging

The system automatically tracks all operations for debugging and history:

### What Gets Logged

**File Operations** ([Logs/activity.log](Logs/activity.log)):
- Every file created or updated
- Timestamp, action, file path, category, tags
- Example: `2026-06-02 14:35:20 | CREATED | People/rick-hodder.md | people | [contact, connecticut]`

**Search Queries** ([Logs/searches.log](Logs/searches.log)):
- Every search performed
- Timestamp, query text, results count, categories searched
- Example: `2026-06-02 15:42:10 | "Find everyone in New York" | 3 results | People`

### Why This Is Useful

- **Debug issues**: See exactly what was created and when
- **Track patterns**: Understand what you search for most
- **Find gaps**: Searches with 0 results show missing information
- **Audit trail**: Complete history of all operations
- **Analytics**: See how you use the system over time

### Privacy Note

Logs are stored locally in your workspace. They contain:
- File paths and metadata (not full content)
- Search queries (to help improve the system)
- Timestamps for tracking

You can view, edit, or delete log files at any time in the [Logs/](Logs/) folder.

---

## File Format

All notes are stored as markdown files (`.md`) with structured metadata:

```markdown
---
title: Example Note
tags: [tag1, tag2]
date: 2026-06-02
category: people
---

# Example Note

[Content goes here...]

## Related
- Projects: [Link to related project]
- Resources: [Link to related resource]
```

### Templates

Each folder has a template file showing the expected structure:
- [People/template-person.md](People/template-person.md)
- [Projects/template-project.md](Projects/template-project.md)
- [Areas/template-area.md](Areas/template-area.md)
- [Resources/template-resource.md](Resources/template-resource.md)

These templates are used automatically when creating new notes.

---

## Best Practices

### Capture Everything
- Don't overthink where it goes - the AI will figure it out
- It's better to capture and organize later than to forget
- Use Inbox for anything uncertain

### Keep It Simple
- Let the AI do the organizing
- Don't manually reorganize unless necessary
- Focus on capturing and retrieving, not perfecting

### Review Regularly
- **Daily**: Add new information as needed
- **Weekly**: Process Inbox, review active projects
- **Monthly**: Archive completed projects, update areas
- **Quarterly**: Clean up, archive inactive items

### Trust the System
- If you can't remember something, search for it
- The AI can find connections you might not remember
- The more you use it, the more valuable it becomes

---

## Tips & Tricks

**Be specific when adding:**
```
Good: "Sarah Chen, sarah@example.com, lead designer at DesignCo, 
       met at UX conference, interested in collaboration"
       
Better than: "Sarah, email, designer"
```

**Use natural language for search:**
```
"Who do I know in San Francisco?" 
is better than searching for "location: SF"
```

**Link related information:**
When you mention a person in a project note, the AI will automatically suggest cross-references.

**Add context:**
The more context you provide, the better the AI can organize and connect information.

---

## Troubleshooting

**AI puts things in wrong folder?**
- Provide more context when adding
- Manually move the file to correct folder
- The AI learns from existing notes, so it improves over time

**Can't find something?**
- Try broader search terms
- Search for related people or projects
- Check the Inbox folder
- It might not have been added yet

**Inbox filling up?**
- Review items weekly
- Add more context and ask AI to reclassify
- Manually move to appropriate folders
- Delete items that aren't needed

**Want to change how something is organized?**
- Just move files between folders manually
- Update the templates if needed
- The AI adapts to your actual usage patterns

---

## Getting Started

1. **Add your first entry:**
   ```
   @Brain Add: [Your name and contact info]
   ```

2. **Add a current project:**
   ```
   @Brain New project: [Something you're working on]
   ```

3. **Add someone you know:**
   ```
   @Brain Add: [Friend/colleague name and details]
   ```

4. **Try searching:**
   ```
   @Brain Show me everything I've added
   ```

That's it! Start capturing information and let the AI help you stay organized.

---

## Questions?

Talk to the **@Brain** agent naturally. It's designed to be helpful and guide you through the system.

Examples:
```
@Brain How do I add a new area of responsibility?

@Brain Can you explain the difference between Projects and Areas?

@Brain Show me an example of a well-organized note
```

---

## Resetting Your Brain

If you want to start fresh or share this system with someone else, you can reset it to an empty state using the provided reset scripts.

### What Gets Reset

**Removed:**
- All user-created files in People/, Projects/, Areas/, Resources/
- All content in Archives/ and Inbox/ (except README.md files)
- All logged entries from activity.log and searches.log

**Preserved:**
- All template files (template-*.md)
- README.md files in Archives/ and Inbox/
- All agent configuration (.github/)
- Root documentation (README.md, plan.md)
- Log file structure (headers remain)

### How to Reset

**⚠️ WARNING: This operation cannot be undone!**

**Strongly recommended:** Commit your changes to git before resetting!

**On Windows (PowerShell):**
```powershell
.\reset-brain.ps1
```

**On macOS/Linux/WSL (Bash):**
```bash
./reset-brain.sh
```

Both scripts will:
1. Show a clear warning about what will be deleted
2. Ask you to type `RESET` to confirm
3. Remove all user data while preserving system files
4. Display a summary of what was removed

**Safety Features:**
- Confirmation prompt required (no silent deletion)
- Clear summary of what will be removed
- Detailed logging during execution
- Exit codes (0 = success, 1 = errors occurred)

### Use Cases

- **Fresh start** - Clear all data to begin organizing again
- **Share system** - Give someone a clean copy of your setup
- **Testing** - Reset after experimenting with the system
- **Before demos** - Start with clean slate for demonstrations

---

## System Information

- **Version**: 1.0
- **Created**: June 2026
- **Method**: PARA (People, Projects, Areas, Resources, Archives)
- **AI Agents**: Brain, Classifier, Organizer, Search
- **File Format**: Markdown (.md) with YAML frontmatter
- **Agent Configuration**: [.github/agents/](.github/agents/)
- **Shared Context**: [.github/AGENTS.md](.github/AGENTS.md)
- **Logging**: Automatic activity and search tracking to [Logs/](Logs/)
