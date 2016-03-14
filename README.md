# bosh_deployment_analysis

This is a collection of scripts for analyzing bosh deployment manifests and BOSH releases.
It also support erb sections within yml deployment files.
It can display a release's available job spec properties.

## deployment_analyzer

This script will output job and persistent disk information for the selected deployment.

### Usage

```
./deployment_analyzer <full_path_to_manifest_yml>

# or for details about job templates
./deployment_analyzer <full_path_to_manifest_yml> --details
```

## deployment_property_analyzer

This script will output properties for jobs for the selected deployment.

### Usage

```
./deployment_property_analyzer <full_path_to_manifest_yml> # prints out all properties

# or for details about job templates
./deployment_property_analyzer <full_path_to_manifest_yml> <job_name> # prints out properties for the given job
```

## release_job_property_analyzer

You need to checkout the according release including submodules before executing the release analysis scripts.

This script will analyze a release directory, parsing the job spec files for properties.
It will output all available properties for each job within the release.

```
./release_job_property_analyzer <full_path_to_release_directory>
```

### Example for cf-release

```
export DESTINATION_DIRECTORY=INSERT_DIRECTORY_HERE # adjust
export BOSH_DEPLOYMENT_ANALYSIS_DIRECTORY=INSERT_DIRECTORY_HERE # adjust
export BRANCH_NAME="v230" # adjust as needed

git clone https://github.com/cloudfoundry/cf-release.git $DESTINATION_DIRECTORY
cd $DESTINATION_DIRECTORY
git checkout $BRANCH_NAME
scripts/update
cd $BOSH_DEPLOYMENT_ANALYSIS_DIRECTORY
./release_job_property_analyzer $DESTINATION_DIRECTORY
```
### Example for cf-release version comparison
```
export DESTINATION_DIRECTORY=INSERT_DIRECTORY_HERE # adjust
export BOSH_DEPLOYMENT_ANALYSIS_DIRECTORY=INSERT_DIRECTORY_HERE # adjust
export BRANCH_NAME_1="v230" # adjust as needed
export BRANCH_NAME_2="v231" # adjust as needed

# If not already present clone cf-release
git clone https://github.com/cloudfoundry/cf-release.git $DESTINATION_DIRECTORY

# Branch 1
cd $DESTINATION_DIRECTORY
git checkout $BRANCH_NAME_1
scripts/update
cd $BOSH_DEPLOYMENT_ANALYSIS_DIRECTORY
./release_job_property_analyzer $DESTINATION_DIRECTORY > $BRANCH_NAME_1.txt

# Branch 2
cd $DESTINATION_DIRECTORY
git checkout $BRANCH_NAME_2
scripts/update
cd $BOSH_DEPLOYMENT_ANALYSIS_DIRECTORY
./release_job_property_analyzer $DESTINATION_DIRECTORY > $BRANCH_NAME_2.txt

diff $BRANCH_NAME_1.txt $BRANCH_NAME_2.txt
```
