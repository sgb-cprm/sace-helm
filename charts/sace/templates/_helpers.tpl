{{/*
Expand the name of the chart.
*/}}
{{- define "sace.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "sace.fullname" -}}
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
{{- define "sace.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "sace.labels" -}}
helm.sh/chart: {{ include "sace.chart" . }}
{{ include "sace.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "sace.selectorLabels" -}}
app.kubernetes.io/name: {{ include "sace.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "sace.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "sace.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Filter selected configs
*/}}
{{- define "sace.selectedInstances" -}}
{{- $selectedConfigs := .Values.nginx.selectedConfigs -}}
  {{ $newList := list }}
  {{- range .Values.configs }}
  {{- if mustHas .name $selectedConfigs }}
    {{ $newList = append $newList ( dict "name" .name "title" .title "url" .url) }}
  {{- end }}
  {{- end }}
  {{ toJson $newList }}
{{- end }}