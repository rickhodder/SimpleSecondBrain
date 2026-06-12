#!/usr/bin/env bash

#
# reset-brain.sh - Reset the Second Brain to an empty state
#
# This script removes all user-created files from the PARA folders while preserving:
# - Template files (template-*.md)
# - README.md files in Archives and Inbox
# - Agent configuration (.github/)
# - Root documentation (README.md, plan.md)
# - Log file structure (keeps headers, removes entries)
#
# WARNING: This operation cannot be undone!
# It is strongly recommended to commit your changes to git before running this script.
#

set -e  # Exit on error

# Script configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FOLDERS=("People" "Projects" "Areas" "Resources" "Archives" "Inbox")
LOG_FILES=("Logs/activity.log" "Logs/searches.log")

# Statistics
FILES_REMOVED=0
ERRORS=0

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
GRAY='\033[0;90m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Display warning
echo -e "\n${YELLOW}========================================${NC}"
echo -e "${YELLOW}  SECOND BRAIN RESET SCRIPT${NC}"
echo -e "${YELLOW}========================================${NC}\n"

echo -e "${RED}WARNING: This will permanently delete all user-generated content!${NC}"
echo -e "\n${CYAN}This script will remove:${NC}"
echo "  - All non-template files from People/, Projects/, Areas/, Resources/"
echo "  - All content from Archives/ and Inbox/ (except README.md)"
echo "  - All logged entries from activity.log and searches.log"
echo -e "\n${GREEN}This script will preserve:${NC}"
echo "  - All template-*.md files"
echo "  - README.md files in Archives/ and Inbox/"
echo "  - All agent configuration (.github/)"
echo "  - Root documentation (README.md, plan.md)"
echo "  - Log file headers (frontmatter)"

echo -e "\n${MAGENTA}RECOMMENDATION: Commit to git before proceeding!${NC}"
echo ""

# Confirmation prompt
read -p "Type 'RESET' to confirm deletion (or anything else to cancel): " CONFIRMATION

if [ "$CONFIRMATION" != "RESET" ]; then
    echo -e "\n${YELLOW}Operation cancelled. No files were modified.${NC}"
    exit 0
fi

echo -e "\n${GREEN}Starting reset process...${NC}\n"

# Function to safely remove a file
remove_safe_file() {
    local file_path="$1"
    
    if [ -f "$file_path" ]; then
        if rm -f "$file_path" 2>/dev/null; then
            echo -e "  ${GRAY}[REMOVED] ${file_path#$SCRIPT_DIR/}${NC}"
            return 0
        else
            echo -e "  ${RED}[ERROR] Failed to remove $file_path${NC}"
            ((ERRORS++))
            return 1
        fi
    fi
    return 1
}

# 1. Remove user files from PARA folders
echo -e "${CYAN}[1/3] Removing user-generated files from PARA folders...${NC}"

for FOLDER in "${FOLDERS[@]}"; do
    FOLDER_PATH="$SCRIPT_DIR/$FOLDER"
    
    if [ ! -d "$FOLDER_PATH" ]; then
        echo -e "  ${YELLOW}[SKIP] Folder not found: $FOLDER${NC}"
        continue
    fi
    
    echo -e "  ${WHITE}Processing: $FOLDER/${NC}"
    
    # Find all .md files in the folder
    while IFS= read -r -d '' FILE; do
        FILE_NAME=$(basename "$FILE")
        
        # Preserve template files and README.md
        if [[ "$FILE_NAME" == template-*.md ]] || [[ "$FILE_NAME" == "README.md" ]]; then
            echo -e "  ${GREEN}[KEEP] $FOLDER/$FILE_NAME${NC}"
            continue
        fi
        
        # Remove user file
        if remove_safe_file "$FILE"; then
            ((FILES_REMOVED++))
        fi
    done < <(find "$FOLDER_PATH" -maxdepth 1 -name "*.md" -type f -print0)
done

# 2. Truncate log files (keep frontmatter, remove entries)
echo -e "\n${CYAN}[2/3] Truncating log files...${NC}"

for LOG_FILE in "${LOG_FILES[@]}"; do
    LOG_PATH="$SCRIPT_DIR/$LOG_FILE"
    
    if [ ! -f "$LOG_PATH" ]; then
        echo -e "  ${YELLOW}[SKIP] Log file not found: $LOG_FILE${NC}"
        continue
    fi
    
    # Find the line number of "---" (end of frontmatter)
    FRONTMATTER_END=$(grep -n "^---\s*$" "$LOG_PATH" | head -1 | cut -d: -f1)
    
    if [ -n "$FRONTMATTER_END" ]; then
        # Keep only lines up to and including "---"
        head -n "$FRONTMATTER_END" "$LOG_PATH" > "${LOG_PATH}.tmp"
        mv "${LOG_PATH}.tmp" "$LOG_PATH"
        echo -e "  ${GRAY}[TRUNCATED] $LOG_FILE (kept header, removed entries)${NC}"
    else
        echo -e "  ${YELLOW}[SKIP] Could not find frontmatter delimiter in $LOG_FILE${NC}"
    fi
done

# 3. Summary
echo -e "\n${CYAN}[3/3] Reset complete!${NC}\n"

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  RESET SUMMARY${NC}"
echo -e "${GREEN}========================================${NC}"
echo -e "${WHITE}Files removed: $FILES_REMOVED${NC}"
echo -e "${WHITE}Errors: $ERRORS${NC}"

if [ $ERRORS -eq 0 ]; then
    echo -e "\n${GREEN}Your Second Brain has been reset to empty state.${NC}"
    echo -e "${GREEN}Templates and system files have been preserved.${NC}"
    exit 0
else
    echo -e "\n${YELLOW}Reset completed with errors. Please review the messages above.${NC}"
    exit 1
fi
