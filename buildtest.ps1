Write-output "branch: "$env:TRAVIS_BRANCH
Write-output "pull request: "$env:TRAVIS_PULL_REQUEST
Write-output "event type: "$env:TRAVIS_EVENT_TYPE
Write-output "commit: " $env:TRAVIS_COMMIT

Write-output "testing current event"

#merge events 
git rev-list --all --min-parents=2
git log -1 --pretty=oneline

