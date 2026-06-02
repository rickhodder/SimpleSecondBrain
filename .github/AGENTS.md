# Second Brain Knowledge Management System

This workspace contains a PARA-based second brain with AI-powered organization and retrieval.

## Shared Context for All Agents

This document provides conventions, standards, and structure that all agents should follow when working with the knowledge base.

---

## Folder Structure

```
SimpleSecondBrain/
├── People/        - Individual contacts, relationships, interaction notes
├── Projects/      - Time-bound initiatives with specific goals and outcomes
├── Areas/         - Ongoing responsibilities, interests, standards to maintain
├── Resources/     - Reference material, articles, tools, external content
├── Archives/      - Completed projects, inactive areas, historical information
├── Inbox/         - Unclassified items pending review (confidence < 70%)
└── Logs/          - Activity logs for debugging and history tracking
```

### Category Definitions

**People** 📇
- Contact information (name, phone, email, location, company)
- Relationship context and interaction history
- Notes about conversations, meetings, collaborations
- Cross-references to related projects, areas, resources

**Projects** 🎯
- Time-bound: Has start/end dates or milestones
- Goal-oriented: Clear outcome or deliverable
- Actionable: Requires active work and attention
- Examples: "Launch podcast by Q3", "Complete certification course", "Organize conference"

**Areas** 🔄
- Ongoing: No end date, continuous maintenance
- Responsibility or interest: Requires standards to uphold
- Encompasses multiple projects or activities
- Examples: "Health & Fitness", "Team Management", "Personal Finance", "Home Maintenance"

**Resources** 📚
- Reference material: For future use or inspiration
- External content: Articles, books, videos, documentation, tools
- Learning resources: Tutorials, courses, guides
- Examples: "Python best practices article", "Design inspiration collection", "API documentation"

**Archives** 📦
- Completed projects (moved from Projects/)
- Inactive areas no longer maintained
- Historical information worth preserving
- People no longer in regular contact

**Inbox** 📥
- Temporary holding for ambiguous content
- Items with low classification confidence (< 70%)
- Pending manual review and organization
- Should be processed regularly (weekly recommended)

**Logs** 📋
- Activity logs tracking all file operations and searches
- `activity.log` contains timestamped entries of file creations/updates
- `searches.log` contains timestamped entries of all search queries
- Used for debugging, analytics, and history tracking
- Automatically maintained by Organizer and Search agents

---

## Activity Logging

The Organizer agent automatically logs all file operations to `Logs/activity.log`.

**Log Entry Format**:
```
YYYY-MM-DD HH:MM:SS | ACTION | path/to/file.md | category | [tag1, tag2]
```

**Example Entries**:
```
2026-06-02 14:35:20 | CREATED | People/rick-hodder.md | people | [contact, connecticut]
2026-06-02 15:42:10 | UPDATED | Projects/podcast.md | projects | [audio, content]
```

**Purpose**:
- Debug issues with file creation/organization
- Track system usage and patterns
- Maintain history of what was added when
- Audit trail for modifications

## Search Logging

The Search agent automatically logs all search queries to `Logs/searches.log`.

**Log Entry Format**:
```
YYYY-MM-DD HH:MM:SS | "query text" | N results | Categories
```

**Example Entries**:
```
2026-06-02 14:35:20 | "Find everyone in New York" | 3 results | People
2026-06-02 15:42:10 | "Show active projects" | 5 results | Projects
2026-06-02 16:05:30 | "What am I working on with Alice?" | 2 results | People, Projects
2026-06-02 16:20:15 | "Find notes about Python" | 0 results | Resources, Projects
```

**Purpose**:
- Track what users are searching for
- Identify patterns in information retrieval
- Debug search functionality
- Understand knowledge base usage
- Analytics on most common queries

---

## Naming Conventions

### File Names
- **Format**: lowercase, hyphen-separated (kebab-case)
- **Examples**: 
  - `rick-hodder.md`
  - `website-redesign.md`
  - `personal-finance.md`
  - `python-tutorial-notes.md`
- **Avoid**: Special characters, spaces, underscores, numbers at start
- **Conflicts**: Append date if duplicate: `rick-hodder-2026-06-02.md`

### Titles (in frontmatter and content)
- **Format**: Title Case or natural capitalization
- **Examples**: "Rick Hodder", "Website Redesign", "Personal Finance"

---

## Frontmatter Schema

All notes must include YAML frontmatter with these fields:

### Required for All Categories
```yaml
---
title: [Note Title]
tags: []
date: YYYY-MM-DD
category: [people|projects|areas|resources]
---
```

### Additional Fields by Category

**People:**
```yaml
company: 
location: 
email: 
phone: 
```

**Projects:**
```yaml
status: [not-started|in-progress|blocked|completed]
start-date: YYYY-MM-DD
due-date: YYYY-MM-DD
progress: [0-100]
```

**Areas:**
```yaml
status: [active|on-hold|inactive]
```

**Resources:**
```yaml
source: [Author/Creator]
source-url: [URL if applicable]
type: [article|book|video|course|documentation|tool]
```

---

## Tagging System

### Guidelines
- Use **flat tags** (no hierarchy): `#meeting`, `#urgent`, `#python`
- Apply **2-5 tags** per note (focused, not exhaustive)
- Be **consistent**: Reuse existing tags when possible
- Tags aid **search and discovery**: Think about how you'll find this later

### Common Tags
```
# Status & Priority
#urgent, #important, #someday, #active, #completed

# Context
#work, #personal, #learning, #reference

# Topics (examples - grow organically)
#python, #javascript, #design, #productivity, #health, #finance

# Interaction Types
#meeting, #email, #call, #conversation

# Content Types
#tutorial, #article, #book, #video, #tool, #template
```

---

## Cross-Linking Conventions

### Internal Links
- Use relative markdown links: `[Link Text](../Projects/project-name.md)`
- Update bi-directional links when creating relationships
- Include cross-references in "Related" sections

### Related Sections
Every note should have a "Related" section listing connections:

```markdown
## Related
- People: [Person Name](../People/person-name.md)
- Projects: [Project Name](../Projects/project-name.md)
- Areas: [Area Name](../Areas/area-name.md)
- Resources: [Resource Name](../Resources/resource-name.md)
```

---

## Content Guidelines

### Writing Style
- **Clear and concise**: Future you should understand quickly
- **Structured**: Use headings, lists, sections
- **Actionable**: Include next steps or key takeaways where relevant
- **Dated**: Include dates for time-sensitive information

### Template Usage
- **Always use templates** as the base structure for new notes
- **Don't remove empty sections**: Leave them blank for future use
- **Customize as needed**: Add sections if required, but keep core structure
- **Templates located**: Each category folder has a `template-*.md` file

---

## Classification Rules

### When to Choose Each Category

**People** if the content is primarily about:
- An individual person
- Contact information
- Relationship or interaction notes

**Projects** if the content:
- Has a specific end goal or deliverable
- Is time-bound (even if date is uncertain)
- Requires multiple steps to complete
- Will eventually be "done"

**Areas** if the content:
- Is ongoing without clear end date
- Represents a responsibility or standard
- Encompasses multiple potential projects
- Requires continuous attention or maintenance

**Resources** if the content:
- Is reference material from external source
- Will be consulted later but not "completed"
- Is for learning or inspiration
- Is a tool or collection of information

**Inbox** if:
- Classification confidence < 70%
- Content is ambiguous or incomplete
- Could fit multiple categories equally
- Needs human review to decide

### Confidence Threshold
- **≥ 70%**: Classify to appropriate category
- **< 70%**: Send to Inbox for manual review
- **Consider context**: Check for similar existing notes

---

## Date Formats

- **Standard**: `YYYY-MM-DD` (e.g., `2026-06-02`)
- **Timestamps**: ISO 8601 if needed: `YYYY-MM-DDTHH:MM:SS`
- **Consistency**: Always use the same format throughout the system

---

## Examples by Category

### People Example
```markdown
---
title: Sarah Chen
tags: [work, colleague, design]
date: 2026-06-02
category: people
email: sarah.chen@example.com
location: San Francisco, CA
---

# Sarah Chen

## Contact
- Email: sarah.chen@example.com
- Phone: (415) 555-0123
- Location: San Francisco, CA
- Company: DesignCo

## Notes
Lead designer at DesignCo. Met at conference in 2025.
Great resource for UX questions. Prefers async communication.

## Interactions
- 2026-05-15: Discussed mobile app redesign project
- 2026-04-10: Coffee chat about design trends

## Related
- Projects: [Mobile App Redesign](../Projects/mobile-app-redesign.md)
- Areas: [Product Design](../Areas/product-design.md)
```

### Project Example
```markdown
---
title: Launch Podcast
tags: [content, audio, marketing]
date: 2026-06-02
category: projects
status: in-progress
start-date: 2026-05-01
due-date: 2026-09-01
progress: 30
---

# Launch Podcast

## Goal
Launch weekly podcast about technology trends by September 2026.
Target: 10 episodes recorded, 1000 subscribers in first month.

## Status
- Current Status: in-progress
- Progress: 30%
- Next Action: Record pilot episode with guest

## Timeline
- Start Date: 2026-05-01
- Due Date: 2026-09-01
- Milestones:
  - ✓ Research format and topics (May)
  - ✓ Purchase equipment (May)
  - → Record 3 pilot episodes (June)
  - Setup hosting and RSS feed (July)
  - Launch marketing campaign (August)
  - Official launch (September 1)

## Notes
Decided on interview format. Equipment arrived. Working on guest list.

## Related
- People: [Sarah Chen](../People/sarah-chen.md) (possible guest)
- Areas: [Content Creation](../Areas/content-creation.md)
- Resources: [Podcast Equipment Guide](../Resources/podcast-equipment-guide.md)
```

---

## Maintenance & Best Practices

### Regular Reviews
- **Inbox**: Process weekly, aim for empty
- **Projects**: Review monthly, archive completed ones
- **Areas**: Review quarterly, ensure still relevant
- **Archives**: Review yearly, delete if truly not needed

### Keep It Simple
- Don't over-organize: Folder structure is enough
- Don't over-tag: 2-5 meaningful tags per note
- Don't over-link: Link only what's genuinely related
- Prefer doing over organizing: Capture first, perfect later

### Growth Pattern
- Start minimal, expand as patterns emerge
- Let taxonomy grow organically
- Don't force rigid structures
- Adapt to your actual usage patterns

---

## Agent Coordination

### Workflow: Adding Information
1. **Admin** receives user input
2. **Admin** → **Classifier**: Analyze and categorize
3. **Classifier** returns: category, filename, tags, confidence
4. **Admin** → **Organizer**: Create file with classification
5. **Organizer** creates file using template
6. **Admin** confirms completion to user

### Workflow: Searching Information
1. **Admin** receives search query
2. **Admin** → **Search**: Find matching information
3. **Search** returns: formatted results with links
4. **Admin** presents results to user

### Shared Understanding
- All agents read this file for consistent behavior
- Templates define structure expectations
- Confidence threshold (70%) determines Inbox usage
- Agents communicate via structured outputs
