#!/bin/bash
# Manual script to sync all submodules
# Can be run locally or in CI/CD with proper permissions

set -e

echo "🔄 Hailo AI Demos - Submodule Sync Script"
echo "=========================================="
echo

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to sync all submodules
sync_all() {
    echo -e "${YELLOW}📦 Updating all submodules...${NC}"
    
    # Initialize and update all submodules
    git submodule update --init --recursive
    
    # Update each submodule to latest
    git submodule foreach '
        echo "Updating $name..."
        git fetch origin
        git checkout $(git rev-parse --abbrev-ref HEAD) || git checkout main || git checkout master
        git pull origin $(git rev-parse --abbrev-ref HEAD) || git pull origin main || git pull origin master
    '
    
    echo -e "${GREEN}✅ All submodules updated${NC}"
}

# Function to sync specific submodule
sync_specific() {
    SUBMODULE=$1
    echo -e "${YELLOW}📦 Updating $SUBMODULE...${NC}"
    
    if [ -d "$SUBMODULE" ]; then
        cd "$SUBMODULE"
        git fetch origin
        git checkout $(git rev-parse --abbrev-ref HEAD) || git checkout main || git checkout master
        git pull origin $(git rev-parse --abbrev-ref HEAD) || git pull origin main || git pull origin master
        cd - > /dev/null
        echo -e "${GREEN}✅ $SUBMODULE updated${NC}"
    else
        echo -e "${RED}❌ Submodule $SUBMODULE not found${NC}"
        exit 1
    fi
}

# Function to check for outdated submodules
check_outdated() {
    echo -e "${YELLOW}🔍 Checking for outdated submodules...${NC}"
    echo
    
    OUTDATED_COUNT=0
    
    git submodule foreach '
        LOCAL=$(git rev-parse HEAD)
        git fetch origin --quiet
        REMOTE=$(git rev-parse origin/$(git rev-parse --abbrev-ref HEAD) 2>/dev/null || git rev-parse origin/main 2>/dev/null || git rev-parse origin/master)
        
        if [ "$LOCAL" != "$REMOTE" ]; then
            COMMITS_BEHIND=$(git rev-list --count HEAD..origin/$(git rev-parse --abbrev-ref HEAD) 2>/dev/null || echo "unknown")
            echo "📦 $name is behind by $COMMITS_BEHIND commits"
            OUTDATED_COUNT=$((OUTDATED_COUNT + 1))
        fi
    '
    
    if [ "$OUTDATED_COUNT" -eq 0 ]; then
        echo -e "${GREEN}✅ All submodules are up to date${NC}"
    else
        echo
        echo -e "${YELLOW}⚠️  $OUTDATED_COUNT submodules are outdated${NC}"
        echo "Run '$0 all' to update them"
    fi
}

# Function to show status
show_status() {
    echo -e "${YELLOW}📊 Submodule Status${NC}"
    echo
    git submodule status
    echo
    
    # Count by category
    echo -e "${YELLOW}📁 Repository Count by Category:${NC}"
    for dir in official-repositories yolo-implementations computer-vision community-projects web-apis tools-utilities educational-resources robotics-integration embedded-systems; do
        if [ -d "$dir" ]; then
            COUNT=$(find "$dir" -maxdepth 1 -type d | tail -n +2 | wc -l)
            if [ "$COUNT" -gt 0 ]; then
                echo "  $dir: $COUNT repos"
            fi
        fi
    done
    
    TOTAL=$(git submodule status | wc -l)
    echo
    echo -e "${GREEN}Total: $TOTAL repositories${NC}"
}

# Main script logic
case "$1" in
    all)
        sync_all
        ;;
    check)
        check_outdated
        ;;
    status)
        show_status
        ;;
    "")
        echo "Usage: $0 {all|check|status|<submodule-path>}"
        echo
        echo "Commands:"
        echo "  all              - Sync all submodules to latest"
        echo "  check            - Check for outdated submodules"
        echo "  status           - Show submodule status"
        echo "  <submodule-path> - Sync specific submodule"
        echo
        echo "Examples:"
        echo "  $0 all"
        echo "  $0 check"
        echo "  $0 status"
        echo "  $0 community-projects/frigate-nvr"
        ;;
    *)
        sync_specific "$1"
        ;;
esac