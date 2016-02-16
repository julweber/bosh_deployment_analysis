# bosh_deployment_analysis

This is a collection of scripts for analyzing bosh deployment manifests.
It also support erb sections within yml deployment files.

## deployment_analyzer

This script will output job and persistent disk information for the selected deployment.

### Usage

```
./deployment_analyzer <full_path_to_manifest_yml>

# or for details about job templates
./deployment_analyzer <full_path_to_manifest_yml> --details
```
