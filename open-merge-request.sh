#!/usr/bin/env bash
set -ex

# Need all remote branches
git fetch --no-tags

## Debug statement
git show-branch --remote

nearest_parent_branch=$(git show-branch --remote | sed "s/].*//" | grep "++ \[" | head -n1 | sed "s/^.*\[origin\///")

## Debug statement
echo $nearest_parent_branch

echo $CI_COMMIT_MESSAGE
request_body=jq -c -n --arg title "$CI_COMMIT_MESSAGE" '{title: $title}'
echo $request_body
created_merge_request_response=$(curl -X POST --header "Authorization:Bearer ${PERSONAL_ACCESS_TOKEN}" --header "Content-Type:application/json" -d "$request_body" "https://gitlab.com/api/v4/projects/${CI_PROJECT_ID}/merge_requests?source_branch=${CI_COMMIT_BRANCH}&target_branch=${nearest_parent_branch}")

## Debug statement
echo $created_merge_request_response

merge_request_url=$(echo $created_merge_request_response | jq '.web_url' | tr -d '"')

echo "Created MR link: ${merge_request_url}"
