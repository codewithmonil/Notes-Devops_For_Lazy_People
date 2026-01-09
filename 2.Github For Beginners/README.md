# Git Command Guide for Beginners

A comprehensive guide to essential Git commands for beginners.

---

## Initial Setup

### `echo "# Github-For-Beginners" >> README.md`
Creates a README.md file with "# Github-For-Beginners" as content

### `git init`
Initializes a new Git repository in the current folder

### `git add .`
Stages all files in the directory for commit

### `git branch -M main`
Renames the current branch to "main"

### `git commit -m "first commit"`
Commits staged files with message "first commit"

### `git remote add origin https://github.com/codewithmonil/Github-For-Beginners.git`
Links local repository to remote GitHub repository

### `git push -u origin main`
Pushes main branch to remote and sets it as default upstream

---

## Working with Branches

### `git status`
Shows current state of working directory and staged files

### `git branch -c developer`
Creates a new branch named "developer"

### `git branch -a`
Lists all branches (local and remote)

### `git checkout developer`
Switches to the developer branch

### `git add .`
Stages all files in the directory for commit

### `git commit -m "Developer commit"`
Commits staged files with message "Developer commit"

### `git push origin developer`
Pushes developer branch to remote repository

### `git checkout main`
Switches back to the main branch

### `git merge developer`
Merges changes from developer branch into main

---

## Resolving Merge Conflicts

### Why Merge Conflicts Arise
Merge conflicts occur when:
- Two branches modify the same line in a file differently
- One branch deletes a file while another branch modifies it
- Multiple developers work on the same code simultaneously
- Git cannot automatically determine which changes to keep

### How to Resolve Merge Conflicts

**Step 1: Identify the conflict**
```
git status
```
Shows files with conflicts marked as "both modified"

**Step 2: Open the conflicted file**
Look for conflict markers:
```
<<<<<< HEAD
Your current branch changes
=======
Incoming branch changes
>>>>>>> developer
```

**Step 3: Resolve the conflict**
- Manually edit the file to keep desired changes
- Remove conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`)
- Combine changes from both branches if needed

**Step 4: Mark as resolved**
```
git add .
```

**Step 5: Complete the merge**
```
git commit -m "Resolved merge conflict"
```

**Step 6: Push changes**
```
git push origin main
```

### Tips to Avoid Conflicts
- Pull latest changes before starting work
- Communicate with team members
- Make small, frequent commits
- Work on different files when possible

---

## Checking Changes

### Add one line in readme and see git diff and then git checkout ./README.md
Add text to README, use `git diff` to see changes, then `git checkout ./README.md` to discard changes

---

## Commit History

### `git logs --oneline`
Shows commit history in compact one-line format

### `git reset 2a744e3`
Moves HEAD to specified commit, keeps changes in working directory

### `git reset --hard 2a744e3`
Moves HEAD to specified commit and discards all changes

---

## For Debugging

### `git log`
Shows detailed commit history

### `git reflog`
Shows history of HEAD movements (useful for recovery)

---

## Syncing with Remote

### `git pull origin main`
Fetches and merges changes from remote main branch

---

## Pull Requests

### Then make change in the developer branch and create a pull request
Switch to developer, make changes, push, then create PR on GitHub

---

## Forking

### First fork a repo on GitHub then clone to the pc using
Click Fork button on GitHub repository

### `git clone git@github.com:username/repository-name.git`
Downloads forked repository to your local machine

---

## Contributing

Feel free to contribute to this guide by creating a pull request!

## License

Open for educational purposes.