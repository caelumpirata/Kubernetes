# crunchy postgres cluster restore from pv -  `pg-15`

this is not the backup pv, it's the pv where the replica of my postgres used to store its data.

i followed this and it worked
```bash
https://github.com/CrunchyData/postgres-operator/issues/3084
```

my `pv` was of 1GB and while troubleshooting when i got the space related error, i edited the confing file and changed it to 5GB [after doing this still my data was there]

i had `pv` of my pervious cluster, [means i created one cluster and made the pv persistant `Delete` to `Retain`]

cluster got deleted and my pv remained in the `local storageClass` which is kubernetes default.

i labeled my pv with that this `pgo-postgres-cluster: postgres-operator-hippo`

and this is hte config which i used to create my new cluster restore its data again from old `pv`

```yaml
apiVersion: postgres-operator.crunchydata.com/v1beta1
kind: PostgresCluster
metadata:
  name: master
  namespace: staging
spec:
  # dataSource:
  #   volumes:
  #     pgDataVolume:
  #       pvcName: restored-pvc-1
  service:
    metadata:
      annotations:
        my-annotation: value1
      labels:
        my-label: value2
    type: NodePort
    nodePort: 32432


  # users:
  #   - name: master
  #     databases:
  #       - zoo
  #       - projects
  #       - master
  #       - TerrestrialPlatform
  #       - TagBrowser
  #       - AlarmDB
  #       - edge
  #       - notEdge
  #       - iocl
  #     options: 'SUPERUSER'

  image: registry.developers.crunchydata.com/crunchydata/crunchy-postgres:ubi8-15.3-2
  postgresVersion: 15
  patroni:
    dynamicConfiguration:
      postgresql:
        parameters:
          max_connections: 1000
  instances:
    - name: instance1
      replicas: 2
      # resources:
      #   limits:
      #     cpu: 1.0
      #     memory: 1Gi
      dataVolumeClaimSpec:
        accessModes:
        - "ReadWriteOnce"
        resources:
          requests:
            storage: 5Gi
        selector:
          matchLabels:
            pgo-postgres-cluster: postgres-operator-hippo
      # affinity:
      #   podAntiAffinity:
      #     preferredDuringSchedulingIgnoredDuringExecution:
      #     - weight: 1
      #       podAffinityTerm:
      #         topologyKey: kubernetes.io/hostname
      #         labelSelector:
      #           matchLabels:
      #             postgres-operator.crunchydata.com/cluster: master
      #             postgres-operator.crunchydata.com/instance-set: instance1
  monitoring:
    pgmonitor:
      exporter:
        image: registry.developers.crunchydata.com/crunchydata/crunchy-postgres-exporter:ubi8-5.5.0-0
  userInterface:
    pgAdmin:
      image: registry.developers.crunchydata.com/crunchydata/crunchy-pgadmin4:ubi8-4.30-19
      dataVolumeClaimSpec:
        accessModes:
          - 'ReadWriteOnce'
        resources:
          requests:
            storage: 1Gi
  backups:
    pgbackrest:
      image: registry.developers.crunchydata.com/crunchydata/crunchy-pgbackrest:ubi8-2.45-2
      repos:
      - name: repo1
        volume:
          volumeClaimSpec:
            accessModes:
            - "ReadWriteOnce"
            resources:
              requests:
                storage: 5Gi
      # - name: repo2
      #   volume:
      #     volumeClaimSpec:
      #       accessModes:
      #       - "ReadWriteOnce"
      #       resources:
      #         requests:
      #           storage: 1Gi
  proxy:
    pgBouncer:
      image: registry.developers.crunchydata.com/crunchydata/crunchy-pgbouncer:ubi8-1.19-2

  patroni:
    dynamicConfiguration:
      postgresql:
        parameters:
          shared_preload_libraries: timescaledb 
          # timescaledb.license: timescale
          max_connections: 1000
        pg_hba:
          - host      all  all  0.0.0.0/0   md5

```
