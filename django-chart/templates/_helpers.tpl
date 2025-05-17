{{/*
Define the fullname template used across the chart.
*/}}
{{- define "django-app.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Define the chart name.
*/}}
{{- define "django-app.name" -}}
{{ .Chart.Name }}
{{- end -}}

{{/*
Define a common labels block.
*/}}
{{- define "django-app.labels" -}}
app.kubernetes.io/name: {{ include "django-app.name" . }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}
