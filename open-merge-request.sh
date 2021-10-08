#!/usr/bin/env bash

# Need all remote branches
git fetch --no-tags

## Debug statement
git show-branch --remote

nearest_parent_branch=$(git show-branch --remote | sed "s/].*//" | grep "++ \[" | head -n1 | sed "s/^.*\[origin\///")

## Debug statement
echo "Nearest parent branch: ${nearest_parent_branch}"

request_body=$(jq -c -r -n --arg title "$(echo $CI_COMMIT_MESSAGE | head -n 1)" '{title: $title}')

## Debug
echo $request_body

created_merge_request_response=$(curl -X POST --header "Authorization:Bearer ${PERSONAL_ACCESS_TOKEN}" --header "Content-Type:application/json" -d "${request_body}" "https://gitlab.com/api/v4/projects/${CI_PROJECT_ID}/merge_requests?source_branch=${CI_COMMIT_BRANCH}&target_branch=${nearest_parent_branch}")

## Debug
echo $created_merge_request_response

merge_request_url=$(echo $created_merge_request_response | tr '\r\n' ' ' | jq '.web_url' | tr -d '"')

echo "Created MR link: ${merge_request_url}"
