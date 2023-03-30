# Grafana Image Renderer packaged by Bitnami

## What is Grafana Image Renderer?

> The Grafana Image Renderer is a plugin for Grafana that uses headless Chrome to render panels and dashboards as PNG images.

[Overview of Grafana Image Renderer](https://github.com/grafana/grafana-image-renderer)
Trademarks: This software listing is packaged by Bitnami. The respective trademarks mentioned in the offering are owned by the respective companies, and use of them does not imply any affiliation or endorsement.

## TL;DR

```console
docker run --name grafana-image-renderer bitnami/grafana-image-renderer:latest
```

## Why use Bitnami Images?

* Bitnami closely tracks upstream source changes and promptly publishes new versions of this image using our automated systems.
* With Bitnami images the latest bug fixes and features are available as soon as possible.
* Bitnami containers, virtual machines and cloud images use the same components and configuration approach - making it easy to switch between formats based on your project needs.
* All our images are based on [minideb](https://github.com/bitnami/minideb) a minimalist Debian based container image which gives you a small base container image and the familiarity of a leading Linux distribution.
* All Bitnami images available in Docker Hub are signed with [Docker Content Trust (DCT)](https://docs.docker.com/engine/security/trust/content_trust/). You can use `DOCKER_CONTENT_TRUST=1` to verify the integrity of the images.
* Bitnami container images are released on a regular basis with the latest distribution packages available.

## How to deploy Grafana Image Renderer in Kubernetes?

Deploying Bitnami applications as Helm Charts is the easiest way to get started with our applications on Kubernetes. Read more about the installation in the [Bitnami Grafana Chart GitHub repository](https://github.com/bitnami/charts/tree/master/bitnami/grafana).

Bitnami containers can be used with [Kubeapps](https://kubeapps.dev/) for deployment and management of Helm Charts in clusters.

## Why use a non-root container?

Non-root container images add an extra layer of security and are generally recommended for production environments. However, because they run as a non-root user, privileged tasks are typically off-limits. Learn more about non-root containers [in our docs](https://docs.bitnami.com/tutorials/work-with-non-root-containers/).

## Supported tags and respective `Dockerfile` links

Learn more about the Bitnami tagging policy and the difference between rolling tags and immutable tags [in our documentation page](https://docs.bitnami.com/tutorials/understand-rolling-tags-containers/).

You can see the equivalence between the different tags by taking a look at the `tags-info.yaml` file present in the branch folder, i.e `bitnami/ASSET/BRANCH/DISTRO/tags-info.yaml`.

Subscribe to project updates by watching the [bitnami/containers GitHub repo](https://github.com/bitnami/containers).

## Get this image

The recommended way to get the Bitnami Grafana Image Renderer Docker Image is to pull the prebuilt image from the [Docker Hub Registry](https://hub.docker.com/r/bitnami/grafana-image-renderer).

```console
docker pull bitnami/grafana-image-renderer:latest
```

To use a specific version, you can pull a versioned tag. You can view the [list of available versions](https://hub.docker.com/r/bitnami/grafana-image-renderer/tags/) in the Docker Hub Registry.

```console
docker pull bitnami/grafana-image-renderer:[TAG]
```

If you wish, you can also build the image yourself by cloning the repository, changing to the directory containing the Dockerfile and executing the `docker build` command. Remember to replace the `APP`, `VERSION` and `OPERATING-SYSTEM` path placeholders in the example command below with the correct values.

```console
git clone https://github.com/bitnami/containers.git
cd bitnami/APP/VERSION/OPERATING-SYSTEM
docker build -t bitnami/APP:latest .
```

## Connecting to other containers

Using [Docker container networking](https://docs.docker.com/engine/userguide/networking/), a different server running inside a container can easily be accessed by your application containers and vice-versa.

Containers attached to the same network can communicate with each other using the container name as the hostname.

### Using the Command Line

#### Step 1: Create a network

```console
docker network create my-network --driver bridge
```

#### Step 2: Launch the grafana-image-renderer container within your network

Use the `--network <NETWORK>` argument to the `docker run` command to attach the container to the `my-network` network.

```console
docker run -d --name grafana-image-renderer \
    --env HTTP_PORT="8080" \
    --env HTTP_HOST="0.0.0.0" \
    --network my-network \
    bitnami/grafana-image-renderer:latest
```

#### Step 3: Launch a Grafana container within your network that uses grafana-image-renderer as rendering service

Use the `--network <NETWORK>` argument to the `docker run` command to attach the container to the `my-network` network.

```console
docker run -d --name grafana \
    --network my-network \
    --publish 3000:3000 \
    --env GF_RENDERING_SERVER_URL="http://grafana-image-renderer:8080/render" \
    --env GF_RENDERING_CALLBACK_URL="http://grafana:3000" \
    --env GF_LOG_FILTERS="rendering:debug" \
    bitnami/grafana:latest
```

## Configuration

You can customize Grafana Image Renderer settings by replacing the default configuration file with your custom configuration, or using environment variables.

### Configuration file

The image looks for a `config.json` file in `/opt/bitnami/grafana-image-renderer/conf/`. You can mount a volume at `/opt/bitnami/grafana-image-renderer/conf/` and copy/edit the `config.json` file in the `/path/to/grafana-image-renderer-conf/` path. The default configurations will be populated to the `conf/` directory if it's empty.

```console
/path/to/grafana-image-renderer-conf/
└── config.json

0 directories, 1 file
```

#### Step 1: Run the Grafana Image Renderer container

Run the Grafana Image Renderer container, mounting a directory from your host. Using Docker Compose:

```diff
     image: bitnami/grafana-image-renderer:1
     ports:
       - 8080:8080
+    volumes:
+      - /path/to/grafana-image-renderer-conf/:/opt/bitnami/grafana-image-renderer/conf/
     environment:
       HTTP_PORT: "8080"
       HTTP_HOST: "0.0.0.0"
```

#### Step 2: Edit the configuration

Edit the configuration on your host using your favorite editor.

```console
vi /path/to/grafana-image-renderer-conf/config.json
```

#### Step 3: Restart Grafana Image Renderer

After changing the configuration, restart your Grafana Image Renderer container for changes to take effect. Using Docker Compose:

```console
docker-compose restart grafana-image-renderer
```

After that, your configuration will be taken into account in the server's behaviour.

## Logging

The Bitnami Grafana Image Renderer Docker image sends the container logs to the `stdout`. To view the logs:

```console
docker logs grafana-image-renderer
```

You can configure the containers [logging driver](https://docs.docker.com/engine/admin/logging/overview/) using the `--log-driver` option if you wish to consume the container logs differently. In the default configuration docker uses the `json-file` driver.

## Maintenance

### Upgrade this image

Bitnami provides up-to-date versions of Grafana Image Renderer, including security patches, soon after they are made upstream. We recommend that you follow these steps to upgrade your container.

#### Step 1: Get the updated image

```console
docker pull bitnami/grafana-image-renderer:latest
```

#### Step 2: Stop the currently running container

Stop the currently running container using the command

```console
docker stop grafana-image-renderer
```

#### Step 3: Remove the currently running container

```console
docker rm -v grafana-image-renderer
```

#### Step 4: Run the new image

Re-create your container from the new image:

```console
docker run --name grafana-image-renderer bitnami/grafana-image-renderer:latest
```

## Contributing

We'd love for you to contribute to this container. You can request new features by creating an [issue](https://github.com/bitnami/containers/issues) or submitting a [pull request](https://github.com/bitnami/containers/pulls) with your contribution.

## Issues

If you encountered a problem running this container, you can file an [issue](https://github.com/bitnami/containers/issues/new/choose). For us to provide better support, be sure to fill the issue template.

## License

Copyright &copy; 2023 Bitnami

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

<http://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
