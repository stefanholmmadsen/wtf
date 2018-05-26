Write-output "branch: ${env:TRAVIS_BRANCH}"
Write-output "pull request: ${env:TRAVIS_PULL_REQUEST}"
Write-output "event type: ${env:TRAVIS_EVENT_TYPE}"
Write-output "commit:  ${env:TRAVIS_COMMIT}"

Write-output "testing current event"

#merge events 
git rev-list --all --min-parents=2

#this will be reported on pull requests
#cde790acd828579e7afdaa05788a7010d55f5816 (HEAD) Merge 22477c9eaad5509b497853928efc620f8ef43c4c into 095bd017427c0ad4d6f08c7a2fdf15944468bfa9
git log -1 --pretty=oneline

#this would be reported on merge after pull requests
#ff19b4328d6fa1164445d9516f98a801c336a2cb (HEAD, origin/master, origin/HEAD, master) Merge pull request #4 from stefanholmmadsen/branchtest
#$a = (git log -l --pretty=oneline | first bit)
$isMergeCommitWith2parents = (git rev-list --all --min-parents=2 | sls $env:TRAVIS_COMMIT | measure).count  # == 1 if its a mergecommit, == 0 if not
if ($isMergeCommitWith2parents){
	Write-output "this is a merge commit with 2 parents"
}
else{
	Write-output "this is not a merge commit with 2 parents"
}

$isMergeCommitWith1parent = (git rev-list --all --min-parents=1 | sls $env:TRAVIS_COMMIT | measure).count  # == 1 if its a mergecommit, == 0 if not
if ($isMergeCommitWith1parent){
	Write-output "this is a merge commit with 1 parent"
}
else{
	Write-output "this is not a merge commit with 1 parent"
}

if($env:TRAVIS_PULL_REQUEST -ne "false"){
	Write-output "this is a pull request, so i'm going to build"
}elseif($env:TRAVIS_EVENT_TYPE -eq "push"){
	if($isMergeCommitWith2parents){
		Write-output "this is a merge confirm request, so i'm not going to build"
	}elseif ($isMergeCommitWith1parent){
		Write-output "this is a single parent commit ? merge?"
	}
}





