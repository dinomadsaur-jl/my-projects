# ============================================
# COMPLETE GITHELPER INSTALLATION
# Fork category first, Basic last (most used)
# ============================================

echo "🗑️ Removing old githelper..."
rm -f ~/githelper.sh
sed -i '/alias githelper/d' ~/.bashrc 2>/dev/null
source ~/.bashrc 2>/dev/null
echo "✅ Old githelper removed"
echo ""

echo "📦 Installing complete githelper with reorganized categories..."
echo ""

# Create the new githelper
cat > ~/githelper.sh << 'EOF'
#!/bin/bash
# 📱 COMPLETE GIT HELPER
# Fork first, Basic last – all features with clear descriptions

# Colors for better visibility
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Your projects folder path
PROJECTS_PATH="/storage/emulated/0/ MyDocuments/Projects"

# Your GitHub info
GITHUB_USER="dinomadsaur-jl"
GITHUB_EMAIL="dinomadsaur@gmail.com"
GITHUB_REPO="Projects"

# ============================================
# UTILITY FUNCTIONS
# ============================================

# Auto-fix remote URL when GitHub repo moves/renames
auto_fix_remote() {
    if [ ! -d ".git" ]; then
        return
    fi
    
    current_remote=$(git remote get-url origin 2>/dev/null)
    [ -z "$current_remote" ] && return
    
    fetch_output=$(git fetch 2>&1)
    if echo "$fetch_output" | grep -q "repository moved"; then
        echo -e "${YELLOW}⚠️ Remote repository has moved!${NC}"
        new_url=$(echo "$fetch_output" | grep "git@github.com:" | head -1 | awk '{print $NF}')
        if [ -n "$new_url" ]; then
            echo -e "${GREEN}✅ Found new URL: $new_url${NC}"
            git remote set-url origin "$new_url"
            echo -e "${GREEN}✅ Remote updated to: $(git remote get-url origin)${NC}"
            
            if [[ "$new_url" =~ github\.com[:/]([^/]+)/(.+)\.git ]]; then
                new_repo="${BASH_REMATCH[2]}"
                if [ -n "$new_repo" ] && [ "$new_repo" != "$GITHUB_REPO" ]; then
                    GITHUB_REPO="$new_repo"
                    echo -e "${GREEN}✅ Repo name updated to: $GITHUB_REPO${NC}"
                    echo -e "${YELLOW}Update githelper.sh permanently? (y/n):${NC}"
                    read update_script
                    if [ "$update_script" = "y" ]; then
                        sed -i "s/GITHUB_REPO=\".*\"/GITHUB_REPO=\"$new_repo\"/" "$0"
                        echo -e "${GREEN}✅ githelper.sh updated permanently${NC}"
                    fi
                fi
            fi
            return 0
        fi
    fi
    return 1
}

draw_line() {
    echo -e "${CYAN}────────────────────────────────────────────────────${NC}"
}

show_header() {
    clear
    echo -e "${CYAN}╔════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║        📱 COMPLETE GIT HELPER         ║${NC}"
    echo -e "${CYAN}╠════════════════════════════════════════╣${NC}"
    echo -e "${CYAN}║${NC}  ${GREEN}$(basename "$PROJECTS_PATH")${NC}                              ${CYAN}║${NC}"
    echo -e "${CYAN}╠════════════════════════════════════════╣${NC}"
    echo -e "${CYAN}║${NC}  ${YELLOW}GitHub:${NC} $GITHUB_USER/$GITHUB_REPO        ${CYAN}║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════╝${NC}"
}

check_folder() {
    if [ ! -d "$PROJECTS_PATH" ]; then
        echo -e "${RED}❌ Projects folder not found at: $PROJECTS_PATH${NC}"
        echo -e "${YELLOW}Please enter the correct path:${NC}"
        read -r new_path
        PROJECTS_PATH="$new_path"
    fi
    cd "$PROJECTS_PATH" 2>/dev/null
    echo -e "${GREEN}✅ In projects folder: $(pwd)${NC}"
    return 0
}

pause() {
    echo -e "\n${BLUE}Press Enter to continue...${NC}"
    read
}

# ============================================
# MENU (Fork first, Basic last)
# ============================================

show_menu() {
    show_header
    echo -e "${CYAN}╔════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║          FORK OPERATIONS (1-3)         ║${NC}"
    echo -e "${CYAN}╠════════════════════════════════════════╣${NC}"
    echo -e "${CYAN}║${NC}  ${BLUE}1)${NC} 🍴 Add Upstream Remote         ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}  ${BLUE}2)${NC} 🔄 Sync Fork with Upstream     ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}  ${BLUE}3)${NC} 📥 Fetch from Upstream         ${CYAN}║${NC}"
    
    echo -e "${CYAN}╠════════════════════════════════════════╣${NC}"
    echo -e "${CYAN}║          CONFIGURATION (4-7)           ║${NC}"
    echo -e "${CYAN}╠════════════════════════════════════════╣${NC}"
    echo -e "${CYAN}║${NC}  ${WHITE}4)${NC} 🔧 Fix Remote URL (Manual)     ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}  ${WHITE}5)${NC} 🔑 SSH Key Management          ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}  ${WHITE}6)${NC} 🆕 Setup Git in This Folder    ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}  ${WHITE}7)${NC} 🤖 Auto-Setup New Device       ${CYAN}║${NC}"
    
    echo -e "${CYAN}╠════════════════════════════════════════╣${NC}"
    echo -e "${CYAN}║         HISTORY & SEARCH (8-13)        ║${NC}"
    echo -e "${CYAN}╠════════════════════════════════════════╣${NC}"
    echo -e "${CYAN}║${NC}  ${GREEN}8)${NC} 📋 View Recent Commits         ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}  ${GREEN}9)${NC} 🔍 View Commit Details         ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}  ${GREEN}10)${NC} 🔎 Search in Commits          ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}  ${GREEN}11)${NC} 📊 Compare Changes            ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}  ${GREEN}12)${NC} ↩️ Undo/Revert Options        ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}  ${GREEN}13)${NC} 📊 Repo Statistics            ${CYAN}║${NC}"
    
    echo -e "${CYAN}╠════════════════════════════════════════╣${NC}"
    echo -e "${CYAN}║          FILE OPERATIONS (14-18)       ║${NC}"
    echo -e "${CYAN}╠════════════════════════════════════════╣${NC}"
    echo -e "${CYAN}║${NC}  ${YELLOW}14)${NC} 📂 List All Files             ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}  ${YELLOW}15)${NC} 📱 File Browser (Acode)       ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}  ${YELLOW}16)${NC} 🧹 Clean Untracked Files      ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}  ${YELLOW}17)${NC} 📦 Stash Changes              ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}  ${YELLOW}18)${NC} ➕ Add Single File            ${CYAN}║${NC}"
    
    echo -e "${CYAN}╠════════════════════════════════════════╣${NC}"
    echo -e "${CYAN}║         BRANCH OPERATIONS (19-24)      ║${NC}"
    echo -e "${CYAN}╠════════════════════════════════════════╣${NC}"
    echo -e "${CYAN}║${NC}  ${PURPLE}19)${NC} 🌿 Create New Branch           ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}  ${PURPLE}20)${NC} 🔀 Switch Branch               ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}  ${PURPLE}21)${NC} 🔗 Merge Branch into Current   ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}  ${PURPLE}22)${NC} 🔀 Merge Current into Main     ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}  ${PURPLE}23)${NC} 🗑️ Delete Branch               ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}  ${PURPLE}24)${NC} 📋 List All Branches           ${CYAN}║${NC}"
    
    echo -e "${CYAN}╠════════════════════════════════════════╣${NC}"
    echo -e "${CYAN}║         BASIC OPERATIONS (25-29)       ║${NC}"
    echo -e "${CYAN}╠════════════════════════════════════════╣${NC}"
    echo -e "${CYAN}║${NC}  ${GREEN}25)${NC} 📊 Git Status                   ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}  ${GREEN}26)${NC} 📦 Full Push (add+commit+push) ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}  ${GREEN}27)${NC} ⚡ Quick Push (auto timestamp)  ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}  ${GREEN}28)${NC} 📥 Pull from GitHub            ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}  ${GREEN}29)${NC} 📡 Fetch Only                  ${CYAN}║${NC}"
    
    echo -e "${CYAN}╠════════════════════════════════════════╣${NC}"
    echo -e "${CYAN}║${NC}  ${RED}0)${NC} 🚪 Exit                          ${CYAN}║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${BLUE}Enter your choice [0-29]: ${NC}"
}

# ============================================
# FORK OPERATIONS (1-3)
# ============================================

do_add_upstream() {
    echo -e "\n${CYAN}🍴 ADD UPSTREAM REMOTE${NC}"
    draw_line
    echo -e "${YELLOW}Description: Add the original repository as 'upstream' for your fork.${NC}"
    echo -e "This allows you to sync changes from the original repo."
    
    [ ! -d ".git" ] && { echo -e "${RED}❌ Not a git repository.${NC}"; return; }
    
    echo -e "${YELLOW}Current remotes:${NC}"
    git remote -v
    echo ""
    echo -e "${YELLOW}Enter upstream URL (e.g., git@github.com:original/repo.git):${NC}"
    read upstream_url
    
    if [ -n "$upstream_url" ]; then
        git remote add upstream "$upstream_url"
        echo -e "${GREEN}✅ Upstream remote added${NC}"
        git remote -v
    else
        echo -e "${YELLOW}Cancelled.${NC}"
    fi
}

do_sync_fork() {
    echo -e "\n${CYAN}🔄 SYNC FORK WITH UPSTREAM${NC}"
    draw_line
    echo -e "${YELLOW}Description: Fetch upstream changes and merge into current branch.${NC}"
    
    [ ! -d ".git" ] && { echo -e "${RED}❌ Not a git repository.${NC}"; return; }
    
    if ! git remote | grep -q "upstream"; then
        echo -e "${RED}❌ No upstream remote. Use option 1 first.${NC}"
        return
    fi
    
    current_branch=$(git branch --show-current)
    echo -e "${YELLOW}Fetching from upstream...${NC}"
    git fetch upstream
    echo -e "${YELLOW}Merging upstream/$current_branch into $current_branch...${NC}"
    git merge upstream/$current_branch
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Sync successful!${NC}"
        echo -e "${YELLOW}Push to origin? (y/n):${NC}"
        read push_updates
        [ "$push_updates" = "y" ] && git push origin $current_branch
    else
        echo -e "${RED}Merge failed. Resolve conflicts manually.${NC}"
    fi
}

do_fetch_upstream() {
    echo -e "\n${CYAN}📥 FETCH FROM UPSTREAM${NC}"
    draw_line
    echo -e "${YELLOW}Description: Download upstream changes without merging.${NC}"
    
    [ ! -d ".git" ] && { echo -e "${RED}❌ Not a git repository.${NC}"; return; }
    
    if ! git remote | grep -q "upstream"; then
        echo -e "${RED}❌ No upstream remote. Use option 1 first.${NC}"
        return
    fi
    
    git fetch upstream
    echo -e "${GREEN}✅ Fetched from upstream. Use option 2 to merge.${NC}"
}

# ============================================
# CONFIGURATION OPERATIONS (4-7)
# ============================================

do_fix_remote() {
    echo -e "\n${CYAN}🔧 MANUAL REMOTE FIX${NC}"
    draw_line
    echo -e "${YELLOW}Description: Manually update the remote URL of your repository.${NC}"
    
    [ ! -d ".git" ] && { echo -e "${RED}❌ Not a git repository.${NC}"; return; }
    
    echo -e "${YELLOW}Current remote:${NC}"
    git remote -v
    echo ""
    echo -e "${YELLOW}Enter new remote URL (or empty to cancel):${NC}"
    read new_url
    [ -n "$new_url" ] && { git remote set-url origin "$new_url"; echo -e "${GREEN}✅ Remote updated!${NC}"; git remote -v; } || echo -e "${YELLOW}Cancelled.${NC}"
}

do_ssh() {
    echo -e "\n${CYAN}🔑 SSH KEY MANAGEMENT${NC}"
    draw_line
    echo -e "${YELLOW}Description: Manage SSH keys for GitHub authentication.${NC}"
    
    while true; do
        echo ""
        echo "1) Show SSH public key"
        echo "2) Create new SSH key"
        echo "3) Test GitHub connection"
        echo "4) Back"
        echo ""
        read ssh_choice
        
        case $ssh_choice in
            1)
                if [ -f ~/.ssh/id_ed25519.pub ]; then
                    cat ~/.ssh/id_ed25519.pub
                else
                    echo -e "${RED}No SSH key found.${NC}"
                fi
                pause
                ;;
            2)
                ssh-keygen -t ed25519 -C "$GITHUB_EMAIL" -f ~/.ssh/id_ed25519 -N ""
                echo -e "${GREEN}✅ SSH key created${NC}"
                cat ~/.ssh/id_ed25519.pub
                pause
                ;;
            3)
                ssh -T git@github.com
                pause
                ;;
            4) break ;;
            *) echo -e "${RED}Invalid choice${NC}"; pause ;;
        esac
    done
}

do_setup() {
    echo -e "\n${CYAN}🆕 SETUP GIT IN THIS FOLDER${NC}"
    draw_line
    echo -e "${YELLOW}Description: Initialize a new Git repository here.${NC}"
    
    if [ -d ".git" ]; then
        echo -e "${YELLOW}Already a git repo. Reinitialize? (y/n):${NC}"
        read reinit
        [ "$reinit" != "y" ] && return
        rm -rf .git
    fi
    
    git init
    git config user.name "$GITHUB_USER"
    git config user.email "$GITHUB_EMAIL"
    
    cat > .gitignore << 'IGNORE'
*.tmp
*.log
*.cache
.DS_Store
Thumbs.db
__pycache__/
*.pyc
IGNORE
    
    echo -e "${GREEN}✅ Git initialized${NC}"
    
    echo -e "${YELLOW}Add remote? (y/n):${NC}"
    read add_remote
    if [ "$add_remote" = "y" ]; then
        git remote add origin "git@github.com:$GITHUB_USER/$GITHUB_REPO.git"
        echo -e "${GREEN}✅ Remote added${NC}"
    fi
    
    echo -e "${YELLOW}Create first commit? (y/n):${NC}"
    read first_commit
    if [ "$first_commit" = "y" ]; then
        git add .
        git commit -m "🎉 Initial commit"
        echo -e "${GREEN}✅ First commit created${NC}"
    fi
}

do_auto_setup() {
    echo -e "\n${CYAN}🤖 AUTO-SETUP NEW DEVICE${NC}"
    draw_line
    echo -e "${YELLOW}Description: Creates a helper script to set up Git on a new device.${NC}"
    
    cat > "$PROJECTS_PATH/setup_new_device.sh" << 'SETUP'
#!/bin/bash
pkg update -y && pkg install -y git openssh
termux-setup-storage
mkdir -p "/storage/emulated/0/MyDocuments/Projects"
ssh-keygen -t ed25519 -C "dinomadsaur@gmail.com" -f ~/.ssh/id_ed25519 -N ""
echo ""
echo "🔑 ADD THIS SSH KEY TO GITHUB:"
cat ~/.ssh/id_ed25519.pub
echo ""
read -p "✅ Added the key? (yes/no): " added
if [ "$added" = "yes" ]; then
    cd "/storage/emulated/0/MyDocuments/Projects" || exit
    git clone git@github.com:dinomadsaur-jl/Projects.git
    echo "✅ Setup complete!"
fi
SETUP

    chmod +x "$PROJECTS_PATH/setup_new_device.sh"
    echo -e "${GREEN}✅ Setup script created at: $PROJECTS_PATH/setup_new_device.sh${NC}"
}

# ============================================
# HISTORY & SEARCH OPERATIONS (8-13)
# ============================================

do_log() {
    echo -e "\n${CYAN}📋 RECENT COMMITS${NC}"
    draw_line
    echo -e "${YELLOW}Description: Show last 20 commits.${NC}"
    [ ! -d ".git" ] && { echo -e "${RED}❌ Not a git repository.${NC}"; return; }
    git log --oneline --decorate -20 --color
}

do_show_commit() {
    echo -e "\n${CYAN}🔍 VIEW COMMIT DETAILS${NC}"
    draw_line
    echo -e "${YELLOW}Description: Show full details of a specific commit.${NC}"
    [ ! -d ".git" ] && { echo -e "${RED}❌ Not a git repository.${NC}"; return; }
    
    git log --oneline -10
    echo ""
    echo -e "${YELLOW}Enter commit hash (or empty to cancel):${NC}"
    read commit_hash
    [ -z "$commit_hash" ] && { echo -e "${YELLOW}Cancelled.${NC}"; return; }
    
    git show --stat "$commit_hash"
    echo -e "\n${YELLOW}Show full diff? (y/n):${NC}"
    read show_diff
    [ "$show_diff" = "y" ] && git show "$commit_hash"
}

do_search() {
    echo -e "\n${CYAN}🔎 SEARCH IN COMMITS${NC}"
    draw_line
    echo -e "${YELLOW}Description: Search for text in messages, code changes, or files.${NC}"
    [ ! -d ".git" ] && { echo -e "${RED}❌ Not a git repository.${NC}"; return; }
    
    echo -e "${YELLOW}Search term:${NC}"
    read search_term
    [ -z "$search_term" ] && { echo -e "${RED}No term entered.${NC}"; return; }
    
    echo -e "\n${CYAN}In commit messages:${NC}"
    git log --oneline --grep="$search_term" --color
    echo -e "\n${CYAN}In code changes:${NC}"
    git log -S"$search_term" --oneline --color
    echo -e "\n${CYAN}In file content (recent):${NC}"
    git grep "$search_term" $(git rev-list --all --max-count=20) 2>/dev/null | head -20
}

do_diff() {
    echo -e "\n${CYAN}📊 COMPARE CHANGES${NC}"
    draw_line
    echo -e "${YELLOW}Description: Show differences between commits, working tree, etc.${NC}"
    [ ! -d ".git" ] && { echo -e "${RED}❌ Not a git repository.${NC}"; return; }
    
    while true; do
        echo ""
        echo "1) Unstaged changes"
        echo "2) Staged changes"
        echo "3) Last commit vs previous"
        echo "4) Two specific commits"
        echo "5) File history"
        echo "6) Back"
        echo ""
        read diff_choice
        
        case $diff_choice in
            1) git diff; pause ;;
            2) git diff --staged; pause ;;
            3) git diff HEAD~1 HEAD; pause ;;
            4)
                echo -e "${YELLOW}First commit:${NC}"; read c1
                echo -e "${YELLOW}Second commit:${NC}"; read c2
                [ -n "$c1" ] && [ -n "$c2" ] && git diff "$c1" "$c2"
                pause
                ;;
            5)
                echo -e "${YELLOW}Filename:${NC}"; read fname
                [ -n "$fname" ] && git log -p -- "$fname"
                pause
                ;;
            6) break ;;
            *) echo -e "${RED}Invalid choice${NC}"; pause ;;
        esac
    done
}

do_undo() {
    echo -e "\n${CYAN}↩️ UNDO/REVERT OPTIONS${NC}"
    draw_line
    echo -e "${YELLOW}Description: Safely undo or revert changes.${NC}"
    [ ! -d ".git" ] && { echo -e "${RED}❌ Not a git repository.${NC}"; return; }
    
    echo -e "${YELLOW}Last 5 commits:${NC}"
    git log --oneline -5
    echo ""
    echo "╔════════════════════════════════════════╗"
    echo "║         UNDO/REVERT OPTIONS            ║"
    echo "╠════════════════════════════════════════╣"
    echo "║ 1) Undo last commit (keep changes)    ║"
    echo "║ 2) Undo last commit (discard changes) ║"
    echo "║ 3) Revert to specific commit (safe)   ║"
    echo "║ 4) View files at commit                ║"
    echo "║ 5) Compare working copy with commit   ║"
    echo "║ 6) Back                                ║"
    echo "╚════════════════════════════════════════╝"
    echo ""
    read undo_choice
    
    case $undo_choice in
        1) git reset --soft HEAD~1; echo -e "${GREEN}✅ Undone (changes staged)${NC}"; git status -s ;;
        2)
            echo -e "${RED}⚠️  Discard all changes? (y/n):${NC}"
            read confirm
            [ "$confirm" = "y" ] && { git reset --hard HEAD~1; echo -e "${GREEN}✅ Discarded${NC}"; }
            ;;
        3)
            echo -e "${YELLOW}Target commit:${NC}"; read target
            [ -z "$target" ] && return
            git show --oneline "$target"
            echo -e "\n${YELLOW}1) Revert (safe)  2) Hard reset (danger)${NC}"
            read revert_type
            case $revert_type in
                1)
                    git revert --no-commit "$target"..HEAD
                    echo -e "${YELLOW}Commit revert? (y/n):${NC}"
                    read cr
                    if [ "$cr" = "y" ]; then
                        git commit -m "Reverted to $target"
                        echo -e "${GREEN}✅ Revert committed${NC}"
                    else
                        git revert --abort
                        echo -e "${YELLOW}Revert aborted${NC}"
                    fi
                    ;;
                2)
                    echo -e "${RED}Type 'YES' to confirm:${NC}"
                    read confirm_reset
                    [ "$confirm_reset" = "YES" ] && { git reset --hard "$target"; echo -e "${GREEN}✅ Reset${NC}"; }
                    ;;
            esac
            ;;
        4)
            echo -e "${YELLOW}Commit hash:${NC}"; read view_commit
            [ -n "$view_commit" ] && git ls-tree --name-only -r "$view_commit"
            ;;
        5)
            echo -e "${YELLOW}Commit hash:${NC}"; read compare_commit
            [ -n "$compare_commit" ] && git diff "$compare_commit" --stat
            ;;
    esac
}

do_stats() {
    echo -e "\n${CYAN}📊 REPOSITORY STATISTICS${NC}"
    draw_line
    echo -e "${YELLOW}Description: Display repository statistics.${NC}"
    [ ! -d ".git" ] && { echo -e "${RED}❌ Not a git repository.${NC}"; return; }
    
    echo -e "${GREEN}Total commits:${NC} $(git rev-list --count HEAD 2>/dev/null || echo "N/A")"
    echo -e "${GREEN}Branches:${NC} $(git branch -a | wc -l)"
    echo -e "${GREEN}Current branch:${NC} $(git branch --show-current)"
    echo -e "${GREEN}Last commit:${NC} $(git log -1 --oneline)"
    echo -e "${GREEN}Tracked files:${NC} $(git ls-files | wc -l)"
    echo -e "\n${GREEN}Top contributors:${NC}"
    git shortlog -sn | head -10
}

# ============================================
# FILE OPERATIONS (14-18)
# ============================================

do_list_files() {
    echo -e "\n${CYAN}📂 PROJECT FILES${NC}"
    draw_line
    echo -e "${YELLOW}Folders:${NC}"
    ls -d */ 2>/dev/null | sed 's/^/  📁 /'
    echo -e "\n${YELLOW}Files:${NC}"
    ls -p | grep -v / | sed 's/^/  📄 /'
    echo ""
    echo -e "${GREEN}Total: $(ls -1 | wc -l) items${NC}"
}

do_file_browser() {
    echo -e "\n${CYAN}📱 FILE BROWSER (Open in Acode)${NC}"
    draw_line
    echo -e "${YELLOW}Files in current folder:${NC}"
    ls -p | grep -v / | nl
    echo ""
    echo -e "${YELLOW}Enter number to open (0 to cancel):${NC}"
    read file_num
    [ "$file_num" = "0" ] && return
    file_to_open=$(ls -p | grep -v / | sed -n "${file_num}p")
    if [ -n "$file_to_open" ]; then
        am start -n com.foxdebug.acode/.MainActivity -d "file://$(pwd)/$file_to_open" 2>/dev/null
        echo -e "${GREEN}Opening $file_to_open${NC}"
    else
        echo -e "${RED}Invalid selection${NC}"
    fi
}

do_clean() {
    echo -e "\n${CYAN}🧹 CLEAN UNTRACKED FILES${NC}"
    draw_line
    echo -e "${YELLOW}Untracked files:${NC}"
    git ls-files --others --exclude-standard
    echo ""
    echo "1) Dry run"
    echo "2) Delete files"
    echo "3) Delete files & directories"
    echo "4) Cancel"
    read clean_choice
    case $clean_choice in
        1) git clean -n ;;
        2) git clean -f; echo -e "${GREEN}✅ Deleted${NC}" ;;
        3) git clean -fd; echo -e "${GREEN}✅ Deleted${NC}" ;;
        *) echo -e "${YELLOW}Cancelled${NC}" ;;
    esac
}

do_stash() {
    echo -e "\n${CYAN}📦 STASH CHANGES${NC}"
    draw_line
    [ ! -d ".git" ] && { echo -e "${RED}❌ Not a git repository.${NC}"; return; }
    
    while true; do
        echo ""
        echo "1) Stash (save)"
        echo "2) List stashes"
        echo "3) Apply stash"
        echo "4) Pop stash"
        echo "5) Drop stash"
        echo "6) Back"
        echo ""
        read stash_choice
        
        case $stash_choice in
            1)
                echo -e "${YELLOW}Message (optional):${NC}"; read msg
                [ -z "$msg" ] && git stash || git stash push -m "$msg"
                echo -e "${GREEN}✅ Stashed${NC}"
                pause
                ;;
            2) git stash list; pause ;;
            3) git stash apply; echo -e "${GREEN}✅ Applied${NC}"; pause ;;
            4) git stash pop; echo -e "${GREEN}✅ Popped${NC}"; pause ;;
            5)
                echo -e "${YELLOW}Stash index (e.g., stash@{0}):${NC}"; read idx
                git stash drop "$idx"
                echo -e "${GREEN}✅ Dropped${NC}"
                pause
                ;;
            6) break ;;
            *) echo -e "${RED}Invalid${NC}"; pause ;;
        esac
    done
}

do_add_single() {
    echo -e "\n${CYAN}➕ ADD SINGLE FILE${NC}"
    draw_line
    [ ! -d ".git" ] && { echo -e "${RED}❌ Not a git repository.${NC}"; return; }
    
    echo -e "${YELLOW}Filename:${NC}"
    read filename
    [ ! -f "$filename" ] && { echo -e "${RED}File not found${NC}"; return; }
    
    git add "$filename"
    echo -e "${GREEN}✅ Added${NC}"
    
    echo -e "\n${YELLOW}Commit now? (y/n):${NC}"
    read commit_now
    if [ "$commit_now" = "y" ]; then
        echo -e "${YELLOW}Commit message:${NC}"
        read commit_msg
        git commit -m "$commit_msg"
        echo -e "${GREEN}✅ Committed${NC}"
        
        echo -e "${YELLOW}Push now? (y/n):${NC}"
        read push_now
        [ "$push_now" = "y" ] && git push
    fi
}

# ============================================
# BRANCH OPERATIONS (19-24)
# ============================================

do_create_branch() {
    echo -e "\n${CYAN}🌿 CREATE NEW BRANCH${NC}"
    draw_line
    [ ! -d ".git" ] && { echo -e "${RED}❌ Not a git repository.${NC}"; return; }
    
    echo -e "${YELLOW}Current branch: $(git branch --show-current)${NC}"
    echo -e "${YELLOW}New branch name:${NC}"
    read branch_name
    [ -z "$branch_name" ] && { echo -e "${YELLOW}Cancelled${NC}"; return; }
    
    git checkout -b "$branch_name"
    echo -e "${GREEN}✅ Created and switched to $branch_name${NC}"
    
    echo -e "${YELLOW}Push to GitHub? (y/n):${NC}"
    read push_branch
    [ "$push_branch" = "y" ] && git push -u origin "$branch_name"
}

do_switch_branch() {
    echo -e "\n${CYAN}🔀 SWITCH BRANCH${NC}"
    draw_line
    [ ! -d ".git" ] && { echo -e "${RED}❌ Not a git repository.${NC}"; return; }
    
    git branch -a
    echo ""
    echo -e "${YELLOW}Branch name:${NC}"
    read branch_name
    [ -z "$branch_name" ] && { echo -e "${YELLOW}Cancelled${NC}"; return; }
    
    git checkout "$branch_name"
    echo -e "${GREEN}✅ Switched to $branch_name${NC}"
}

do_merge_into_current() {
    echo -e "\n${CYAN}🔗 MERGE BRANCH INTO CURRENT${NC}"
    draw_line
    [ ! -d ".git" ] && { echo -e "${RED}❌ Not a git repository.${NC}"; return; }
    
    echo -e "${YELLOW}Current branch: $(git branch --show-current)${NC}"
    git branch
    echo ""
    echo -e "${YELLOW}Enter branch to merge INTO current:${NC}"
    read merge_branch
    [ -z "$merge_branch" ] && { echo -e "${YELLOW}Cancelled${NC}"; return; }
    
    git merge "$merge_branch"
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Merge successful${NC}"
        echo -e "${YELLOW}Push? (y/n):${NC}"
        read push_merge
        [ "$push_merge" = "y" ] && git push
    else
        echo -e "${RED}Merge failed (conflicts).${NC}"
    fi
}

do_merge_current_into_main() {
    echo -e "\n${CYAN}🔀 MERGE CURRENT BRANCH INTO MAIN${NC}"
    draw_line
    [ ! -d ".git" ] && { echo -e "${RED}❌ Not a git repository.${NC}"; return; }
    
    current_branch=$(git branch --show-current)
    if [ "$current_branch" = "main" ] || [ "$current_branch" = "master" ]; then
        echo -e "${YELLOW}You are already on main/master. Use option 21 to merge another branch.${NC}"
        return
    fi
    
    echo -e "${YELLOW}Current branch: $current_branch${NC}"
    echo -e "${YELLOW}This will switch to main, merge $current_branch, then optionally return.${NC}"
    echo -e "${YELLOW}Proceed? (y/n):${NC}"
    read proceed
    [ "$proceed" != "y" ] && return
    
    # Determine main branch name
    if git show-ref --verify --quiet refs/heads/main; then
        main_branch="main"
    elif git show-ref --verify --quiet refs/heads/master; then
        main_branch="master"
    else
        echo -e "${RED}No main/master branch found.${NC}"
        return
    fi
    
    git checkout "$main_branch"
    git pull  # ensure main is up-to-date
    git merge "$current_branch"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Merged $current_branch into $main_branch${NC}"
        echo -e "${YELLOW}Push main? (y/n):${NC}"
        read push_main
        [ "$push_main" = "y" ] && git push
        
        echo -e "${YELLOW}Switch back to $current_branch? (y/n):${NC}"
        read back
        [ "$back" = "y" ] && git checkout "$current_branch"
    else
        echo -e "${RED}Merge conflict. Resolve on main branch.${NC}"
    fi
}

do_delete_branch() {
    echo -e "\n${CYAN}🗑️ DELETE BRANCH${NC}"
    draw_line
    [ ! -d ".git" ] && { echo -e "${RED}❌ Not a git repository.${NC}"; return; }
    
    git branch
    echo ""
    echo -e "${YELLOW}Branch to delete:${NC}"
    read branch_name
    [ -z "$branch_name" ] && { echo -e "${YELLOW}Cancelled${NC}"; return; }
    
    echo -e "${RED}Delete locally? (y/n):${NC}"
    read confirm
    [ "$confirm" = "y" ] && { git branch -d "$branch_name"; echo -e "${GREEN}✅ Deleted locally${NC}"; }
    
    echo -e "${YELLOW}Delete from GitHub? (y/n):${NC}"
    read delete_remote
    [ "$delete_remote" = "y" ] && { git push origin --delete "$branch_name"; echo -e "${GREEN}✅ Deleted remotely${NC}"; }
}

do_list_branches() {
    echo -e "\n${CYAN}📋 LIST ALL BRANCHES${NC}"
    draw_line
    [ ! -d ".git" ] && { echo -e "${RED}❌ Not a git repository.${NC}"; return; }
    
    echo -e "${GREEN}Local:${NC}"
    git branch
    echo -e "\n${GREEN}Remote:${NC}"
    git branch -r
}

# ============================================
# BASIC OPERATIONS (25-29)
# ============================================

do_status() {
    echo -e "\n${CYAN}📊 GIT STATUS${NC}"
    draw_line
    [ ! -d ".git" ] && { echo -e "${RED}❌ Not a git repository. Use option 6.${NC}"; return; }
    auto_fix_remote
    git status -s
    echo ""
    echo -e "${GREEN}Branch: $(git branch --show-current)${NC}"
    echo -e "${GREEN}Remote: $(git remote get-url origin 2>/dev/null || echo 'Not set')${NC}"
}

do_full_push() {
    echo -e "\n${CYAN}📦 FULL PUSH${NC}"
    draw_line
    [ ! -d ".git" ] && { echo -e "${RED}❌ Not a git repository.${NC}"; return; }
    
    auto_fix_remote
    git status -s
    echo ""
    echo -e "${YELLOW}Commit message:${NC}"
    read commit_msg
    [ -z "$commit_msg" ] && commit_msg="Update $(date '+%Y-%m-%d %H:%M')"
    
    git add .
    git commit -m "$commit_msg"
    git push
    echo -e "\n${GREEN}✅ Done${NC}"
}

do_quick_push() {
    echo -e "\n${CYAN}⚡ QUICK PUSH${NC}"
    draw_line
    [ ! -d ".git" ] && { echo -e "${RED}❌ Not a git repository.${NC}"; return; }
    
    auto_fix_remote
    commit_msg="Update $(date '+%Y-%m-%d %H:%M')"
    git add .
    git commit -m "$commit_msg"
    git push
    echo -e "\n${GREEN}✅ Quick push done${NC}"
}

do_pull() {
    echo -e "\n${CYAN}📥 PULL FROM GITHUB${NC}"
    draw_line
    [ ! -d ".git" ] && { echo -e "${RED}❌ Not a git repository.${NC}"; return; }
    
    auto_fix_remote
    echo -e "${YELLOW}Pulling...${NC}"
    git pull
    echo -e "\n${GREEN}✅ Pull complete${NC}"
}

do_fetch() {
    echo -e "\n${CYAN}📡 FETCH ONLY${NC}"
    draw_line
    [ ! -d ".git" ] && { echo -e "${RED}❌ Not a git repository.${NC}"; return; }
    
    auto_fix_remote
    git fetch --all --prune
    echo -e "\n${GREEN}✅ Fetch complete (no merge)${NC}"
}

# ============================================
# MAIN LOOP
# ============================================

while true; do
    check_folder >/dev/null 2>&1
    show_menu
    read choice
    
    case $choice in
        0) echo -e "${GREEN}👋 Goodbye!${NC}"; exit 0 ;;
        # Fork
        1) do_add_upstream ;;
        2) do_sync_fork ;;
        3) do_fetch_upstream ;;
        # Config
        4) do_fix_remote ;;
        5) do_ssh ;;
        6) do_setup ;;
        7) do_auto_setup ;;
        # History
        8) do_log ;;
        9) do_show_commit ;;
        10) do_search ;;
        11) do_diff ;;
        12) do_undo ;;
        13) do_stats ;;
        # File
        14) do_list_files ;;
        15) do_file_browser ;;
        16) do_clean ;;
        17) do_stash ;;
        18) do_add_single ;;
        # Branch
        19) do_create_branch ;;
        20) do_switch_branch ;;
        21) do_merge_into_current ;;
        22) do_merge_current_into_main ;;
        23) do_delete_branch ;;
        24) do_list_branches ;;
        # Basic
        25) do_status ;;
        26) do_full_push ;;
        27) do_quick_push ;;
        28) do_pull ;;
        29) do_fetch ;;
        *) echo -e "${RED}Invalid choice${NC}" ;;
    esac
    
    pause
done
EOF

# Make it executable and add alias
chmod +x ~/githelper.sh
echo "alias githelper='bash ~/githelper.sh'" >> ~/.bashrc
source ~/.bashrc 2>/dev/null

echo ""
echo "✅✅✅ GITHELPER INSTALLED SUCCESSFULLY! ✅✅✅"
echo ""
echo "📱 MENU ORDER:"
echo "   • Fork (1-3)          - Upstream, Sync, Fetch"
echo "   • Configuration (4-7)  - Remote, SSH, Setup, Auto-Device"
echo "   • History & Search (8-13)"
echo "   • File Operations (14-18)"
echo "   • Branch Operations (19-24) - includes Merge Current into Main"
echo "   • Basic Operations (25-29)   - Status, Push, Pull, Fetch (most used at bottom)"
echo ""
echo "📍 Projects folder: $PROJECTS_PATH"
echo "📦 GitHub repo: $GITHUB_USER/$GITHUB_REPO"
echo ""
echo "👉 Type 'githelper' to start!"