# gitlab-metrics

## Requirements
- git
- make
- docker
- docker compose

## Instructions

### Configuration
1. Open the [`docker-compose.yml`](./docker-compose.yml)
1. Un-comment one of the `image:` lines corresponding to which version of GitLab you want
1. There should only be one `image:` definition un-commented, ensure others are commented out
1. (Optional) Add your own version
1. (Optional) Change the initial root password (eg. `date | sha256sum | head -c 32; echo`)

### Starting GitLab + Prometheus
1. Run `make up`
1. Wait for containers to start
1. Login to GitLab via `Username: root` `Password: <initial root password>`

### Stopping GitLab + Prometheus
1. Run `make down`

### Entering GitLab Container
1. Run `make exec`

### Cleanup
This will remove the `gitlab` folder used for mounting directories into the GitLab container
1. Run `make clean`

## Feature Flags

Below is a table from GitLab listing available feature flags
- https://docs.gitlab.com/ee/user/feature_flags.html

Starting steps for working with feature flags:
1. Exec into the container
1. Run `gitlab-rails console`
1. Wait ~20s for the console to come up
1. Use the commands below
1. When finished, `exit`
1. (Optional but probably not needed) `gitlab-ctl reconfigure`

### Checking Status

- Check if flag is enabled: `Feature.enabled?(:<feature flag>)`
- Check if flag is disabled: `Feature.disabled?(:<feature flag>)`

### Enabling

- `Feature.enable(:<feature flag>)`
    - Example: `Feature.enable(:gitlab_ci_builds_queuing_metrics)`

### Disabling

- `Feature.disable(:<feature flag>)`
    - Example: `Feature.disable(:gitlab_ci_builds_queuing_metrics)`

### Listing

- List all enabled feature flags: `Feature.all`
- Above, but cleaner output: `Feature.all.map {|f| [f.name, f.state]}`
