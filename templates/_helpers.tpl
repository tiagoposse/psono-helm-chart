{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "psono.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "psono.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "psono.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "psono.labels" -}}
helm.sh/chart: {{ include "psono.chart" . }}
{{ include "psono.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "psono.selectorLabels" -}}
app.kubernetes.io/name: {{ include "psono.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Server name
*/}}
{{- define "server.fullname" -}}
{{- printf "%s-server" (include "psono.fullname" .) }}
{{- end }}

{{/*
Server labels
*/}}
{{- define "server.labels" -}}
{{- include "psono.labels" . }}
app.kubernetes.io/layer: server
{{- end }}

{{/*
Server selector labels
*/}}
{{- define "server.selectorLabels" -}}
{{- include "psono.selectorLabels" . }}
app.kubernetes.io/layer: server
{{- end }}

{{/*
Create the name of the service account for the server to use
*/}}
{{- define "server.serviceAccountName" -}}
{{- if .Values.server.serviceAccount.create }}
{{- default (include "server.fullname" .) .Values.server.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.server.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Webclient name
*/}}
{{- define "webclient.fullname" -}}
{{- printf "%s-webclient" (include "psono.fullname" .) }}
{{- end }}

{{/*
Webclient labels
*/}}
{{- define "webclient.labels" -}}
{{- include "psono.labels" . }}
app.kubernetes.io/layer: webclient
{{- end }}

{{/*
Webclient selector labels
*/}}
{{- define "webclient.selectorLabels" -}}
{{- include "psono.selectorLabels" . }}
app.kubernetes.io/layer: webclient
{{- end }}

{{/*
Create the name of the service account for the server to use
*/}}
{{- define "webclient.serviceAccountName" -}}
{{- if .Values.webclient.serviceAccount.create }}
{{- default (include "webclient.fullname" .) .Values.webclient.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.webclient.serviceAccount.name }}
{{- end }}
{{- end }}


{{/*
database name
*/}}
{{- define "database.fullname" -}}
{{- printf "%s-database" (include "psono.fullname" .) }}
{{- end }}

{{/*
database labels
*/}}
{{- define "database.labels" -}}
{{- include "psono.labels" . }}
app.kubernetes.io/layer: database
{{- end }}

{{/*
database selector labels
*/}}
{{- define "database.selectorLabels" -}}
{{- include "psono.selectorLabels" . }}
app.kubernetes.io/layer: database
{{- end }}

{{/*
database persistence claim name
*/}}
{{- define "database.persistence.claim" -}}
{{- default (include "database.fullname" .) .Values.database.persistence.existingClaim }}
{{- end }}

{{/*
Create the name of the service account for the database to use
*/}}
{{- define "database.serviceAccountName" -}}
{{- if .Values.database.serviceAccount.create }}
{{- default (include "database.fullname" .) .Values.database.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.database.serviceAccount.name }}
{{- end }}
{{- end }}


{{/*
adminClient name
*/}}
{{- define "adminClient.fullname" -}}
{{- printf "%s-admin" (include "psono.fullname" .) }}
{{- end }}

{{/*
adminClient labels
*/}}
{{- define "adminClient.labels" -}}
{{ include "psono.labels" . }}
app.kubernetes.io/layer: admin
{{- end }}

{{/*
adminClient selector labels
*/}}
{{- define "adminClient.selectorLabels" -}}
{{- include "psono.selectorLabels" . }}
app.kubernetes.io/layer: admin
{{- end }}

{{/*
Create the name of the service account for the admin client to use
*/}}
{{- define "adminClient.serviceAccountName" -}}
{{- if .Values.adminClient.serviceAccount.create }}
{{- default (include "adminClient.fullname" .) .Values.adminClient.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.adminClient.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Backup name
*/}}
{{- define "backup.fullname" -}}
{{- printf "%s-backup" (include "psono.fullname" .) }}
{{- end }}

{{/*
backup labels
*/}}
{{- define "backup.labels" -}}
{{ include "psono.labels" . }}
app.kubernetes.io/layer: admin
{{- end }}

{{/*
Create the name of the service account for the admin client to use
*/}}
{{- define "backup.serviceAccountName" -}}
{{- if .Values.backup.serviceAccount.create }}
{{- default (include "backup.fullname" .) .Values.backup.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.backup.serviceAccount.name }}
{{- end }}
{{- end }}