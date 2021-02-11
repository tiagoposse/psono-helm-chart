# psono-helm-chart

Unofficial helm chart for the [Psono password manager](https://psono.com).

NOTE: It relies on having a pre-installed mail server. This chart will eventually provide an option to install bokysan/mail helm chart as a subchart.

Documentation on this chart is under construction, the main things to consider is the server and database configuration.

Database provided with this chart is postgresql, but this can be changed as the configuration options are quite flexible.

The following components are installed via this chart:
- psono-server
- psono-client
- psono-admin-client
- psono-database

A minimum configuration example can be found [here](/examples/minimum.yml). Be advised you still need to provide the values for the settings.yaml file. More information can be found in the [psono page](https://doc.psono.com/admin/installation/install-server-ce.html#installation-with-docker).
There are configuration examples to define the database password and other credentials via [kubernetes secrets](/examples/passwords-from-secret.yml) and [files](/examples/passwords-from-file.yml). No example on how to use env variables is available yet.

# TODO

- [ ] Fail when required configs are not provided
- [ ] Embedded mail chart installation option
- [ ] Documentation with links to psono homepage
- [ ] Improve examples
