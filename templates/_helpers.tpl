{{/*

*/}}
{{- define "AppCtx.chartName" -}}
{{- default .Chart.Name | trunc 24 | trimSuffix "-" }}
{{- end }}

{{/*

*/}}
{{- define "AppCtx.chartNameVersion" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*

*/}}
{{- define "AppCtx.name" }}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s" $name | trunc 30 | trimSuffix "-"}}
{{- end }}

{{/*

*/}}
{{- define "AppCtx.apiName" }}
{{- printf "%s-api" (include "AppCtx.name" .) | trunc 63  }}
{{- end }}

{{/*

*/}}
{{- define "AppCtx.frontName" }}
{{- printf "%s-front" (include "AppCtx.name" .) | trunc 63  }}
{{- end }}

{{/*

*/}}
{{- define "AppCtx.dbName" }}
{{- printf "%s-db" (include "AppCtx.name" .) | trunc 63 }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "AppCtx.selectorLabels" -}}
app.kubernetes.io/name: {{ include "AppCtx.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "AppCtx.labels" -}}
helm.sh/chart: {{ include "AppCtx.chartName" . }}
{{ include "AppCtx.selectorLabels" . }}
app.kubernetes.io/part-of: {{ include "AppCtx.chartName" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "AppCtx.apiSelectorLabels" -}}
{{ include "AppCtx.selectorLabels" . }}
app.kubernetes.io/component: api
{{- end }}

{{- define "AppCtx.apiLabels" -}}
{{ include "AppCtx.apiSelectorLabels" . }}
app.kubernetes.io/part-of: {{ include "AppCtx.chartName" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app/language: java
app/version: {{ .Values.api.image.tag }}
{{- end }}


{{- define "AppCtx.frontSelectorLabels" -}}
{{ include "AppCtx.selectorLabels" . }}
app.kubernetes.io/component: front
{{- end }}

{{- define "AppCtx.frontLabels" -}}
{{ include "AppCtx.frontSelectorLabels" . }}
app.kubernetes.io/part-of: {{ include "AppCtx.chartName" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app/language: javascript
app/version: {{ .Values.front.image.tag }}
{{- end }}

{{- define "AppCtx.dbSelectorLabels" -}}
{{ include "AppCtx.selectorLabels" . }}
app.kubernetes.io/component: db
{{- end }}

{{- define "AppCtx.dbLabels" -}}
{{ include "AppCtx.dbSelectorLabels" . }}
app.kubernetes.io/part-of: {{ include "AppCtx.chartName" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app/language: postgresql
app/version: {{ .Values.db.image.tag }}
{{- end }}
