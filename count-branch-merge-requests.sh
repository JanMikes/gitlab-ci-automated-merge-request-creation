#!/usr/bin/env bash

merge_requests_response=$(curl --header "Authorization:Bearer $PERSONAL_ACCESS_TOKEN" "https://gitlab.com/api/v4/projects/$CI_PROJECT_ID/merge_requests?state=opened&source_branch=$CI_COMMIT_BRANCH")

echo $merge_requests_response
echo $merge_requests_response | jq 'length'
