# Every Github Command you Require!

A comprehensive guide to essential Git commands for beginners.

<br>

## Initial Setup

#### Creates a README.md file with "# Github-For-Beginners" as content
```bash
echo "# Github-For-Beginners" >> README.md
```

#### Initializes a new Git repository in the current folder
```bash
git init
```

#### Stages all files in the directory for commit
```bash
git add .
```

#### Renames the current branch to "main"
```bash
git branch -M main
```

#### Commits staged files with message "first commit"
```bash
git commit -m "first commit"
```

#### Links local repository to remote GitHub repository
```bash
git remote add origin https://github.com/codewithmonil/Github-For-Beginners.git
```

#### Pushes main branch to remote and sets it as default upstream
```bash
git push -u origin main
```

#### Shortcut to add and commit at once only (Condition: File should be Tracked once)
```bash
git commit -am "your message"
```
<br>
<br>

## Branches in Github

#### Shows current state of working directory and staged files
```bash
git status
```

#### Creates a new branch named "developer"
```bash
git branch -c developer
```

#### Lists all branches (local and remote)
```bash
git branch -a
```

#### Switches to the developer branch
```bash
git checkout developer
```

#### Stages all files in the directory for commit
```bash
git add .
```

#### Commits staged files with message "Developer commit"
```bash
git commit -m "Developer commit"
```

#### Pushes developer branch to remote repository
```bash
git push origin developer
```

#### Switches back to the main branch
```bash
git checkout main
```

#### Merges changes from developer branch into main
```bash
git merge developer
```

<br>
<br>




## Everyone Makes Mistake! (How to resolve it?)

#### Case-1: You want to rollback before any file is added or committed

#### Add text to README, use git diff to see changes, then discard changes
```bash
# Add one line in README file manually, then:
git diff
```

#### Discard changes in README.md
```bash
git checkout README.md (filename)
```
<br>

#### Case-2: You want to rollback after a file is added or committed

#### Shows commit history in compact one-line format
```bash
git logs --oneline
```

#### Moves HEAD to specified commit, keeps changes in working directory
```bash
git reset 2a744e3
```

#### Moves HEAD to specified commit and discards all changes
```bash
git reset --hard 2a744e3
```

<br>
<br>

## For Debugging

#### Shows detailed commit history
```bash
git log
```

#### Shows history of HEAD movements (useful for recovery)
```bash
git reflog
```
<br>
<br>

## Syncing with Remote

#### Fetches and merges changes from remote main branch
```bash
git pull origin main
```
#### Fetche changes from all branch
```bash
git pull --all
```
<br>
<br>

## Pull Requests

#### Switch to developer branch, make changes,add feature,push, then create PR on GitHub


<br>
<br>

## Resolving Merge Conflicts

#### Why Merge Conflicts Arise
Merge conflicts occur when:
- Two branches modify the same line in a file differently
- One branch deletes a file while another branch modifies it
- Multiple developers work on the same code simultaneously
- Git cannot automatically determine which changes to keep
#### Tips to Avoid Conflicts
- Pull latest changes before starting work
- Communicate with team members
- Make small, frequent commits
- Work on different files when possible
#### How to Resolve Merge Conflicts

**Step 1: Identify the conflict**
```bash
git status
```
Shows files with conflicts marked as "both modified"

**Step 2: Open the conflicted file**
Look for conflict markers:
```
<<<<<<< HEAD
Your current branch changes
=======
Incoming branch changes
>>>>>>> developer
```

**Step 3: Resolve the conflict**
- Manually edit the file to keep desired changes
- Remove conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`)
- Combine changes from both branches if needed

**Step 4: Mark as resolved then add,commit,push**

<br>
<br>

## Forking and Open Source Contribution (The Ocean of Opportunity)

#### Click Fork button on GitHub repository
1. Go to the repository on GitHub
2. Click the "Fork" button in the top-right corner
3. Clone your forked repository to your VS code and ALL SET!:

```bash
git clone git@github.com:username/repository-name.git
```
## For intial configuration
```bash
git config --global user.name "Monil"
```
```bash
git config --global user.email "monil@email.com"
```
