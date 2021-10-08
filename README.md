# Gitlab CI automated merge request creation

Gitlab CI demo, to automatically create MR when first time pushed to a branch without MR with correct target branch by *some* logic.

## How it works

- Must be pipeline for branches without MR - use `$CI_OPEN_MERGE_REQUESTS == null` condition which is great for that! 
- Determine the nearest parent branch (https://stackoverflow.com/questions/3161204/how-to-find-the-nearest-parent-of-a-git-branch)
- Open merge request using API (https://docs.gitlab.com/ee/api/merge_requests.html#create-mr-pipeline)

## Motivation

When creating merge request, the "default" branch will be set as target. In more complex workflows, for example when there is "development" branch (or "sprint" branch in our case), it is really easy to forget about it and oversee that. This mechanism is here to automatically create MR with correct target branch. 
