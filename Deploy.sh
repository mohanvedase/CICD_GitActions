#!/bin/bash

# Set the path to your repository
repo_path="/home/ubuntu/CICD_GitActions"

# Set the branches
staging_branch="staging"
main_branch="main"

# Change directory to the repository
cd "$repo_path"

# Pull the latest changes from the staging branch
git pull origin "$staging_branch"

# Check if there are uncommitted changes in the staging branch
if [[ $(git status | grep 'modified:' | wc -l) -ne 0 ]]; then
  # Install or update dependencies (if needed)
  sudo apt update
  sudo apt install -y python3-pip
  sudo pip install -r requirements.txt

  # Optionally, stop the existing application (if running)
  # ...

  # Start your application (e.g., Flask app)
  nohup python app.py &&
  pytest test_app.py

  # Optionally, run additional deployment tasks

  # Stage modified files
  git add .

  # Commit staged changes with a descriptive message
  git commit -m "Code is modified"

  # Push the committed changes to the main branch
  git push origin main

  echo "Changes pushed to $main_branch branch."
else
  echo "No code changes detected. Skipping deployment."
fi
