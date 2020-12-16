## NFS Server

    Docker image Alpine 3.8

### Docker Compose

    version: "3.4"
    services: 

    nfs-server:
        image: wljtcc/nfs-server:latest
        restart: always
        hostname: nfs-server
        privileged: true
        network_mode: host
        volumes: 
        - /opt/storage:/nfsshare

    networks:
      nfs-server:

### Mount Options

    mount.nfs4 IP_HOST:/ /mount_point