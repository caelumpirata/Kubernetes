# Grafana HTTPS fix
-------------------
clone helm chart of grafna
edit values.yaml 
uncomment *grafana.ini.server.root_url* and set the value as your domain name 
```
grafana.ini:
  paths:
    data: /var/lib/grafana/
    logs: /var/log/grafana
    plugins: /var/lib/grafana/plugins
    provisioning: /etc/grafana/provisioning
  analytics:
    check_for_updates: true
  log:
    mode: console
  grafana_net:
    url: https://grafana.net
  server:
    domain: "{{ if (and .Values.ingress.enabled .Values.ingress.hosts) }}{{ .Values.ingress.hosts | first }}{{ else }}''{{ end }}"
## grafana Authentication can be enabled with the following values on grafana.ini
  server:
      # The full public facing url you use in browser, used for redirects and emails
     root_url: https://<your-domain-name>
```
