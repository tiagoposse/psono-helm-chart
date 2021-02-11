# psono-helm-chart

Unofficial helm chart for the [Psono password manager](https://psono.com).

It supports independent installation of the following components:
- [psono-server](https://gitlab.com/psono/psono-server) ([install docs](https://doc.psono.com/admin/installation/install-server-ce.html#installation-with-docker))
- [psono-client](https://gitlab.com/psono/psono-client) ([install docs](https://doc.psono.com/admin/installation/install-webclient.html#installation-with-docker))
- [psono-admin-client](https://gitlab.com/psono/psono-admin-client) ([docs](https://doc.psono.com/admin/installation/install-admin-webclient.html#installation-with-docker))
- psono-database (custom postgresql pod)


## Notes

We highly recommend going through the install docs of psono-server to understand what secrets you need to generate and how to.

Psono requires a mail server. If you don't want to deal with installing one, you can use the default subchart provided here by using --set=mail.enabled=true. This will deploy [bokysan/mail](https://github.com/bokysan/docker-postfix).

## Available examples

A few configuration examples are provided [here](/examples):
- Using [environment vars](/examples/environment.yml)
- Using [kubernetes secrets](/examples/passwords-from-secret.yml)
- Using [environment variable files](/examples/passwords-from-file.yml)

If you don't use a secret management system like Vault, we recommend using secrets. Only use the env variables example for testing, as this is highly insecure and will be deprecated in the future.

## TODO

For v0.2.0 (usable, stable):
- [x] Embedded mail chart installation option
- [x] Documentation with links to psono homepage
- [x] Improve examples
- [x] Move to env variables instead of settings key

For v0.3.0 (tls, more error-proofed):
- [ ] Custom nginx config for client and admin-client
- [ ] Fail when required configs are not provided
- [ ] Deprecate passwords via helm values as it is just bad practices

## Configuration

### Ingress, mail and general configuration
| Parameter | Description | Default |
| --- | --- | --- |
| imagePullSecrets | Docker registry secret names as an array	 | [] (does not add image pull secrets to deployed pods) |
| nameOverride | String to partially override resource names | "" |
| fullnameOverride | String to fully override resource names | "" |
| ingress.enabled | Enable or disable the kubernetes ingress | false |
| ingress.annotations | Annotations for the ingress | [] |
| ingress.hosts | List of hosts for the ingress | [] |
| ingress.hosts[].host | Host address | |
| mail.enabled | Enable or disable the deployment of a subchart for sending emails | false |

### Server configuration

| Parameter | Description | Default |
| --- | --- | --- |
| server.enabled | Enable or disable the psono-server instance | true |
| server.replicas | Number of replicas for the server deployment. Untested with more replicas | 1 |
| server.image.repository | Docker image for the server | psono/psono-server |
| server.image.tag | Tag for the docker image | latest |
| server.image.pullPolicy | Pull policy for the docker image | IfNotPresent |
| server.service.type | Type of service for the server | ClusterIP |
| server.service.port | Port exposed by the service serving the server | 10100 |
| server.serviceAccount.create | Enable or disable the creation of a service account to be used by the server | true |
| server.serviceAccount.name | Name of the service account to create | {{ .Release.Name }}-server |
| server.serviceAccount.annotations | Annotations given to the service account | {} |
| server.podAnnotations | Annotations given to the pods spawned by the server deployment | {} |
| server.podSecurityContext |  | {} |
| server.securityContext |  | {} |
| server.resources | CPU/Memory resource requests/limits for server pods | {} |
| server.nodeSelector | Node labels for server pod assignment | {} |
| server.affinity | Affinity for server pod assignment | {} |
| server.env | Environment variables for the main container in the server pods | {} |
| server.tolerations | Tolerations for server pod assignment | [] |
| server.extraVolumeMounts | Extra volume mounts used by the main container in the server pods | [] |
| server.extraVolumes | Extra volumes to be used by the server pods | [] |
| server.extraSecretEnvironmentVars | List of env vars loaded from secret | [] |
| server.envFiles | Extra files from where to load environment variables. Format of each env file line is "FOO=BAR" | [] |

### Webclient configuration

| Parameter | Description | Default |
| --- | --- | --- |
| webclient.enabled | Enable or disable the psono-webclient instance | true |
| webclient.replicas | Number of replicas for the webclient deployment. Untested with more replicas | 1 |
| webclient.image.repository | Docker image for the webclient | psono/psono-client |
| webclient.image.tag | Tag for the docker image | latest |
| webclient.image.pullPolicy | Pull policy for the docker image | IfNotPresent |
| webclient.service.type | Type of service for the webclient | ClusterIP |
| webclient.service.port | Port exposed by the service serving the webclient | 10101 |
| webclient.serviceAccount.create | Enable or disable the creation of a service account to be used by the webclient | true |
| webclient.serviceAccount.name | Name of the service account to create | {{ .Release.Name }}-webclient |
| webclient.serviceAccount.annotations | Annotations given to the service account | {} |
| webclient.podAnnotations | Annotations given to the pods spawned by the webclient deployment | {} |
| webclient.podSecurityContext |  | {} |
| webclient.securityContext |  | {} |
| webclient.resources | CPU/Memory resource requests/limits for webclient pods | {} |
| webclient.nodeSelector | Node labels for webclient pod assignment | {} |
| webclient.affinity | Affinity for webclient pod assignment | {} |
| webclient.env | Environment variables for the main container in the webclient pods | {} |
| webclient.tolerations | Tolerations for webclient pod assignment | [] |
| webclient.extraVolumeMounts | Extra volume mounts used by the main container in the webclient pods | [] |
| webclient.extraVolumes | Extra volumes to be used by the webclient pods | [] |

### Admin client configuration

| Parameter | Description | Default |
| --- | --- | --- |
| adminClient.enabled | Enable or disable the psono-admin instance | true |
| adminClient.replicas | Number of replicas for the admin deployment. Untested with more replicas | 1 |
| adminClient.image.repository | Docker image for the adminClient | psono/psono-admin-client |
| adminClient.image.tag | Tag for the docker image | latest |
| adminClient.image.pullPolicy | Pull policy for the docker image | IfNotPresent |
| adminClient.service.type | Type of service for the admin | ClusterIP |
| adminClient.service.port | Port exposed by the service serving the admin | 10102 |
| adminClient.serviceAccount.create | Enable or disable the creation of a service account to be used by the admin | true |
| adminClient.serviceAccount.name | Name of the service account to create | {{ .Release.Name }}-admin |
| adminClient.serviceAccount.annotations | Annotations given to the service account | {} |
| adminClient.podAnnotations | Annotations given to the pods spawned by the adminClient deployment | {} |
| adminClient.podSecurityContext |  | {} |
| adminClient.securityContext |  | {} |
| adminClient.resources | CPU/Memory resource requests/limits for adminClient pods | {} |
| adminClient.nodeSelector | Node labels for adminClient pod assignment | {} |
| adminClient.affinity | Affinity for adminClient pod assignment | {} |
| adminClient.env | Environment variables for the main container in the adminClient pods | {} |
| adminClient.tolerations | Tolerations for adminClient pod assignment | [] |
| adminClient.extraVolumeMounts | Extra volume mounts used by the main container in the adminClient pods | [] |
| adminClient.extraVolumes | Extra volumes to be used by the admin pods | [] |

### Database configuration

| Parameter | Description | Default |
| --- | --- | --- |
| database.enabled | Enable or disable the psono-database instance | true |
| database.replicas | Number of replicas for the database deployment. When increasing this, you need to deal with managing and configuring the replicated database yourself | 1 |
| database.image.repository | Docker image for the database | psono/psono-client |
| database.image.tag | Tag for the docker image | latest |
| database.image.pullPolicy | Pull policy for the docker image | IfNotPresent |
| database.service.type | Type of service for the database | ClusterIP |
| database.service.port | Port exposed by the service serving the database | 5432 |
| database.serviceAccount.create | Enable or disable the creation of a service account to be used by the database | true |
| database.serviceAccount.name | Name of the service account to create | {{ .Release.Name }}-database |
| database.serviceAccount.annotations | Annotations given to the service account | {} |
| database.podAnnotations | Annotations given to the pods spawned by the database deployment | {} |
| database.podSecurityContext |  | {} |
| database.securityContext |  | {} |
| database.resources | CPU/Memory resource requests/limits for database pods | {} |
| database.nodeSelector | Node labels for database pod assignment | {} |
| database.affinity | Affinity for database pod assignment | {} |
| database.env | Environment variables for the main container in the database pods | {} |
| database.extraSecretEnvironmentVars | List of env vars loaded from secret | [] |
| database.tolerations | Tolerations for database pod assignment | [] |
| database.extraVolumeMounts | Extra volume mounts used by the main container in the database pods | [] |
| database.extraVolumes | Extra volumes to be used by the database pods | [] |
| database.persistence.enabled | Whether to use a PVC for the database | false |
| database.persistence.storageClass | Storage class used by the PVC | "-" |
| database.persistence.existingClaim | Name of an existing PVC to use. Using this will make .storageClass and .size irrelevant | "" |
| database.persistence.size | Size for the disk used by the database | 10Gi |
