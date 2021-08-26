![example workflow](https://github.com/dalmatialab/homeassistant/actions/workflows/main.yml/badge.svg)

# Supported tags and respective Dockerfile links

 - 1.0-rc-1

# What is HomeAssistant ? 

[HomeAssistant](https://www.home-assistant.io/) is open source home automation that puts local control and privacy first. Powered by a worldwide community of tinkerers and DIY enthusiasts. Perfect to run on a Raspberry Pi or a local server.

<img src="https://github.com/dalmatialab/homeassistant/blob/0004fe9c1cc2949fe8220efb3e749d70e7f89e96/logo.png?raw=true" width="200" height="200">

# How to use this image

## Start HomeAssistant instance

    $ docker run -d --name some-homeassistant-name --privileged --net=some-network -p 8123:8123 -v /sys/fs/cgroup:/sys/fs/cgroup:ro image:tag

Where:

 - `some-homeassistant-name` is name you want to assign to your container
 - `some-network` is network name where container will connect
 - `tag` is Docker image version

## Ports

HomeAssistant exposes user interface at port 8123.

## Volumes

To save HomeAssistant data mount container path `/usr/share/hassio` to host path.  

    $ -v some-host-path:/usr/share/hassio:rw

If Docker on host dont use overlay2 you will have to mount container path `/var/lib/docker` to host path so Docker in Docker can use overlay2 as required.  

    $ -v some-host-path:/var/lib/docker

To use possible Zigbee integration inside HomeAssistant add Zigbee usb module inside container.

    $ --device=<zigbee_usb_module_host_path>

## NOTE

After removing container configuration stays mounted on host (if it was mounted). Just start container again with same mount and all configuration will be back.  It is done by HomeAssistant logic, but they had problem with addons which stayed in installed state (which should mean there is pulled image), but there was no   pulled image because new container is created, so addon could not start. It had to be uninstalled and installed again to pull image. Thats bad because **there are saved configurations and data for plugins**, so to prepull image for installed addons prepull.service with python script is created.  


# License

