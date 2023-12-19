Beremiz in ubuntu 22.04 novnc container
===================

Build ubuntu 22.04 with LXDE desktop environment and Beremiz OpenPLC automation GUI installed.

Run the Image
---------------------------
```
docker compose -f beremiz-desktop.yaml up -d
```
beremiz-desktop.yaml
```
services:
  beremiz-desktop-2204:
    container_name: beremiz-desktop2204
    image: <imagename>
    stdin_open: true # docker run -i
    tty: true        # docker run -t
    restart: unless-stopped
    privileged: true
    network_mode: host
    volumes:
      - /dev/shm:/dev/shm
      - efi-vol:/efi
    ports:
      - "6080:80"
      - "5900:5900"
    environment:
      - RESOLUTION=1920x1080
    
volumes:
  efi-vol:
```
Access the running container with a VNC client on port 5900.

Inside the Container
---------------------------
MatIEC is installed in during the image build. Other packages such as Modbus and CANFestival by following the instructions here https://github.com/beremiz/beremiz

Launch the Beremiz IDE
---------------------------
First, run a standalone Beremiz runtime using the commands
```
mkdir ~/beremiz_runtime_workdir
~/Beremiz/venv/bin/python ~/Beremiz/beremiz/Beremiz_service.py -p 61194 -i localhost -x 0 -a 1 ~/beremiz_runtime_workdir
```
Launch the Beremiz IDE on a separate command line terminal using the command
```
~/Beremiz/venv/bin/python ~/Beremiz/beremiz/Beremiz.py
```


License
==================

Apache License Version 2.0, January 2004 http://www.apache.org/licenses/LICENSE-2.0

Original work by [Doro Wu](https://github.com/fcwu)

Adapted by [Frédéric Boulanger](https://github.com/Frederic-Boulanger-UPS)

Modified by [Deltaflare](https://github.com/deltaflare)
