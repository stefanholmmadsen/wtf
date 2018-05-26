Write-output $env:TRAVIS_BRANCH
Write-output $env:TRAVIS_PULL_REQUEST
Write-output $env:TRAVIS_EVENT_TYPE

Write-output "testing current event"


#merge events 
git rev-list --all --min-parents=2
git log -1 --pretty=oneline

