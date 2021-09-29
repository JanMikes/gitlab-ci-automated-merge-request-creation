# Gitlab CI automated merge request creation

Gitlab CI demo, to automatically create MR when first time pushed to a branch without MR with correct target branch by *some* logic.

## How it works
TBD

## Motivation

When creating merge request, the "default" branch will be set as target. In more complex workflows, for example when there is "development" branch (or "sprint" branch in our case), it is really easy to forget about it and oversee that. This mechanism is here to automatically create MR with correct target branch. 
