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

# Check if there are new commits
if git rev-list "$staging_branch" ^"$main_branch" --count; then
    echo "New commits detected in $staging_branch branch."

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

    # Push changes to the main branch
    git push origin "$staging_branch":"$main_branch" --force

    echo "Changes pushed to $main_branch branch."
else
    echo "No new commits in $staging_branch branch. No action needed."
fi
