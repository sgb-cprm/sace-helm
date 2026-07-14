{{- $nginx := (include "nginx.fullname" .Subcharts.nginx ) -}}
#!/bin/bash

NGINX_DEFAULT_CONF=/etc/nginx/conf.d/default.conf

# Sed para fazer no default.conf
# listen       {{ .Values.nginx.service.port | default 8080 }};
# server_name  {{ (mustFirst .Values.nginx.ingress.hosts).host }} {{ $nginx }}.{{ .Release.Namespace }}.svc.cluster.local {{ $nginx }};
echo "Setting default port..."
sed -i 's/listen.*/listen {{ .Values.nginx.service.port | default 8080 }}; /g' $NGINX_DEFAULT_CONF

echo "Setting server_name..."
sed -i 's/server_name.*/server_name {{ (mustFirst .Values.nginx.ingress.hosts).host }} {{ $nginx }}.{{ .Release.Namespace }}.svc.cluster.local {{ $nginx }}; /g' $NGINX_DEFAULT_CONF

echo "Setting SACE default includes..."
sed -i 's|^}|\tinclude /etc/nginx/sace/*.conf;\n}|g' $NGINX_DEFAULT_CONF
