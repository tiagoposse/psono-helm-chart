# v0.2.3
- Fixed startup bug of PSONO Server

# v0.2.2
- Add read credentials from secrets for database and the PSONO Server itself
- Add a job that creates all Secret values for the PSONO Server on first install

# v0.2.1
- Update components to new kubernetes to make them rollout again
# v0.2.0

- Install bokysan/mail along with this chart when --set=mail=true. Allows for an easier setup of a mail server to serve register and recovery emails.
- Configuration mainly via PSONO_* environment variables.
- Examples for the 3 different setup use cases, see [examples](/examples)
- Backup cronjob configurable via the chart