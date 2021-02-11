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

For v0.2.0:
- [ ] Fail when required configs are not provided
- [ ] Embedded mail chart installation option
- [ ] Documentation with links to psono homepage
- [ ] Improve examples
- [ ] Move to env variables instead of settings key
- [ ] Deprecate 

# Configuration



| Path | Type | Default | Description |
| --- | --- | --- | --- |
| host | str |  | URL where the instance is accessed |
| imagePullSecrets | list | [] |
| nameOverride | str | "" | |
| fullnameOverride | str | "" | |
| ingress.enabled | bool | false | Enable or disable the kubernetes ingress |
| ingress.annotations | list | [] | Annotations for the ingress |
| ingress.hosts | list | [] | List of hosts for the ingress |
| ingress.hosts[].host | str | | Host address |
| server.enabled | bool | true | Enable or disable the psono-server instance |
| server.replicas | int | 1 | Number of replicas for the server deployment. Untested with more replicas |
| server.image.repository | str | psono/psono-server | Docker image for the server |
| server.image.tag | str | latest | Tag for the docker image |
| server.image.pullPolicy | str | IfNotPresent | Pull policy for the docker image |
| server.service.type | str | ClusterIP | Type of service for the server |
| server.service.port | int | 10100 | Port exposed by the service serving the server |
| server.serviceAccount.create | bool | true | Enable or disable the creation of a service account to be used by the server |
| server.serviceAccount.name | str | {{ .Release.Name }}-server | Name of the service account to create |
| server.serviceAccount.annotations | map | {} | Annotations given to the service account |
| server.podAnnotations | map | {} | Annotations given to the pods spawned by the server deployment |
| server.podAnnotations | map | {} |  |
| server.podSecurityContext | map | {} |  |
| server.securityContext | map | {} |  |
| server.resources | map | {} |  |
| server.nodeSelector | map | {} |  |
| server.affinity | map | {} |  |
| server.env | map | {} |  |
| server.tolerations | list | [] |  |
| server.extraVolumeMounts | list | [] | Extra volume mounts used by the main container in the server pods |
| server.extraVolumes | list | [] | Extra volumes to be used by the server pods |
| server.extra_settings_files | list | [] | Extra yaml files that are used to configure the server. This is especially useful when passing credentials via files |
| server.databases | map | | Database configurations |
| server.databases.default.name | str | Name of the database |
| server.databases.default.user | str | Name of the user for the database |
| server.databases.default.password | str | "" | Cleartext password for the database. This will be deprecated in the future as it is bad practice |
| server.databases.default.password_file | str | "" | Path to a file containing the password for the database |
| server.databases.default.host | str | {{.Release.Name}}.{{.Release.Namespace}}.svc | Database host |
| server.databases.default.port | int | 5432 | Database port |
| webclient.enabled | bool | true | Enable or disable the psono-webclient instance |
| webclient.replicas | int | 1 | Number of replicas for the webclient deployment. Untested with more replicas |
| webclient.image.repository | str | psono/psono-client | Docker image for the webclient |
| webclient.image.tag | str | latest | Tag for the docker image |
| webclient.image.pullPolicy | str | IfNotPresent | Pull policy for the docker image |
| webclient.service.type | str | ClusterIP | Type of service for the webclient |
| webclient.service.port | int | 10101 | Port exposed by the service serving the webclient |
| webclient.serviceAccount.create | bool | true | Enable or disable the creation of a service account to be used by the webclient |
| webclient.serviceAccount.name | str | {{ .Release.Name }}-webclient | Name of the service account to create |
| webclient.serviceAccount.annotations | map | {} | Annotations given to the service account |
| webclient.podAnnotations | map | {} | Annotations given to the pods spawned by the webclient deployment |
| webclient.podAnnotations | map | {} |  |
| webclient.podSecurityContext | map | {} |  |
| webclient.securityContext | map | {} |  |
| webclient.resources | map | {} |  |
| webclient.nodeSelector | map | {} |  |
| webclient.affinity | map | {} |  |
| webclient.env | map | {} |  |
| webclient.tolerations | list | [] |  |
| webclient.extraVolumeMounts | list | [] | Extra volume mounts used by the main container in the webclient pods |
| webclient.extraVolumes | list | [] | Extra volumes to be used by the webclient pods |
| adminClient.enabled | bool | true | Enable or disable the psono-admin instance |
| adminClient.replicas | int | 1 | Number of replicas for the admin deployment. Untested with more replicas |
| adminClient.image.repository | str | psono/psono-admin-client | Docker image for the adminClient |
| adminClient.image.tag | str | latest | Tag for the docker image |
| adminClient.image.pullPolicy | str | IfNotPresent | Pull policy for the docker image |
| adminClient.service.type | str | ClusterIP | Type of service for the admin |
| adminClient.service.port | int | 10102 | Port exposed by the service serving the admin |
| adminClient.serviceAccount.create | bool | true | Enable or disable the creation of a service account to be used by the admin |
| adminClient.serviceAccount.name | str | {{ .Release.Name }}-admin | Name of the service account to create |
| adminClient.serviceAccount.annotations | map | {} | Annotations given to the service account |
| adminClient.podAnnotations | map | {} | Annotations given to the pods spawned by the adminClient deployment |
| adminClient.podAnnotations | map | {} |  |
| adminClient.podSecurityContext | map | {} |  |
| adminClient.securityContext | map | {} |  |
| adminClient.resources | map | {} |  |
| adminClient.nodeSelector | map | {} |  |
| adminClient.affinity | map | {} |  |
| adminClient.env | map | {} |  |
| adminClient.tolerations | list | [] |  |
| adminClient.extraVolumeMounts | list | [] | Extra volume mounts used by the main container in the adminClient pods |
| adminClient.extraVolumes | list | [] | Extra volumes to be used by the admin pods |
| database.enabled | bool | true | Enable or disable the psono-database instance |
| database.replicas | int | 1 | Number of replicas for the database deployment. When increasing this, you need to deal with managing and configuring the replicated database yourself |
| database.image.repository | str | psono/psono-client | Docker image for the database |
| database.image.tag | str | latest | Tag for the docker image |
| database.image.pullPolicy | str | IfNotPresent | Pull policy for the docker image |
| database.service.type | str | ClusterIP | Type of service for the database |
| database.service.port | int | 5432 | Port exposed by the service serving the database |
| database.serviceAccount.create | bool | true | Enable or disable the creation of a service account to be used by the database |
| database.serviceAccount.name | str | {{ .Release.Name }}-database | Name of the service account to create |
| database.serviceAccount.annotations | map | {} | Annotations given to the service account |
| database.podAnnotations | map | {} | Annotations given to the pods spawned by the database deployment |
| database.podAnnotations | map | {} |  |
| database.podSecurityContext | map | {} |  |
| database.securityContext | map | {} |  |
| database.resources | map | {} |  |
| database.nodeSelector | map | {} |  |
| database.affinity | map | {} |  |
| database.env | map | {} |  |
| database.tolerations | list | [] |  |
| database.extraVolumeMounts | list | [] | Extra volume mounts used by the main container in the database pods |
| database.extraVolumes | list | [] | Extra volumes to be used by the database pods |