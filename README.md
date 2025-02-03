![](./.github/banner.png)

<p align="center">
    A Docker-based environment for building Go projects.
    <br>
    <img alt="GitHub release (latest by date)" src="https://img.shields.io/github/v/release/p0dalirius/docker-build-go-project">
    <a href="https://twitter.com/intent/follow?screen_name=podalirius_" title="Follow"><img src="https://img.shields.io/twitter/follow/podalirius_?label=Podalirius&style=social"></a>
    <a href="https://www.youtube.com/c/Podalirius_?sub_confirmation=1" title="Subscribe"><img alt="YouTube Channel Subscribers" src="https://img.shields.io/youtube/channel/subscribers/UCF_x5O7CSfr82AfNVTKOv_A?style=social"></a>
    <br>
</p>


## Overview

This project offers a Docker-based setup for building Go projects. It comes with a Dockerfile and a Makefile to simplify the setup and compilation process.


## Installation

You need to install [docker](https://docs.docker.com/engine/install/ubuntu/) to use this tool. Once this is done, you can build the container and install the command `build-go-project` by typing `make install` in this repository.

If you are using:
 - **Debian**: https://docs.docker.com/engine/install/debian/
 - **Ubuntu**, **XUbuntu**, **LUbuntu**: https://docs.docker.com/engine/install/ubuntu/
 - **Kali**: It is based on debian so you just need to follow the Debian tutorial https://docs.docker.com/engine/install/debian/.

   The only different step in the tutorial for Kali is the last command of the first step _Add the repository to Apt sources_. Don't use:
    ```sh
    # Add the repository to Apt sources:
    echo \
      "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
      "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    ```
    
    But use instead:
    
    ```sh
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian bookworm stable" > /etc/apt/sources.list.d/docker.list
    ```


## Usage

To use this Docker-based environment for building Go projects, follow these steps:

1. **Build the Docker Image**:
   Run the following command to build the Docker image:
   ```sh
   make build_docker
   ```

2. **Install the Build Script**:
   Install the build script to your local machine by running:
   ```sh
   make install
   ```

3. **Compile Your Go Project**:
   Use the installed build script to compile your Go project. Navigate to your project directory and run:
   ```sh
   build-go-project
   ```
   By default, it will use the current directory as the workspace, and the current OS and architecture.

4. **Specify Custom Parameters (Optional)**:
   You can specify custom workspace, OS, and architecture using the following options:
   ```sh
   build-go-project -w <workspace> -O <os> -a <architecture>
   ```

The compiled binaries will be placed in the `./bin/<os>/<arch>/` directory inside the workspace.


## Contributing

Pull requests are welcome. Feel free to open an issue if you want to add other features.
