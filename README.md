# Getting Started With PostgreSQL

This is a set of hands on labs for getting started with PostgreSQL. These are meant to be proctored classes given in a live, in-person environment. However, I will strive to make the documentation and scripts sufficiently clear that you could walk through the classes on your own. This class will be part one of a what will likely become a multi-part lesson plan that will provide four, two-hour long lessons on PostgreSQL to make sets of stand-alone lessons, or, an all-day hands-on workshop. Each class then will build on the classes that came before it.

The goal for Class #1 is simple, get PostgreSQL up and running in the fastest, easiest way. Then, learn how to work within PostgreSQL to create databases and the objects that live within them. The two easiest ways to get started working in PostgreSQL are to either use containers, or create an account with a cloud provider. In this case, we'll be using containers.

## Requirements

You must be running an operating system capable of running Docker containers. Red Hat and Fedora have Podman built in, so nothing you need to do there. Debian, Ubuntu or Raspbian will require an engine be installed such as Podman or the Docker Engine. For Windows, you will need to make virtualization possible on your latp by first installing wsl. After that, you can install Podman Desktop, Rancher Desktop or Docker Desktop. For a Mac, you have a set of choices, Podman or Podman Desktop, Colima, Docker Desktop for Mac, Rancher Desktop.

You will have to be able to run a docker container to take part in this lesson. This lesson will not include how to set that up. We're going to assume you already have that in place.

During the initial "pull" part of the lessons, we'll also require internet connectivity so that we can retrieve the Docker images.

You can validate that you can run Docker commands by running the following:
`docker info`

If you're running Podman you can substitute `podman` for `docker` and otherwise run all commands the same way. Running Rancher Desktop or Colima, you can either run `docker` commands or you can run `nerdctl` commands, your choice.

If that runs successfully, you can validate internet connectivity by running the following:
`docker run hello-world`

That should pull an image and then create a container that shows "Hello from Docker!" along with some other text, suggestions and alternate commands.

There are no other requirements at this time, in terms of software or hardware. The majority of commands in this lesson will be run from the command line on whatever operating system and hardware you choose to use.

## Class Plan

Each lesson within the class will be placed within a folder, ordered and labeled as follows:

1. Docker Pull
2. Docker Run
3. Docker Command
4. Connecting to PostgreSQL
5. Creating a Role
6. Creating a Database
7. Creating a Schema
8. Creating Tables
9. Adding Data to Tables
10. Querying PostgreSQL

Within each folder will be a markdown file for the lesson itself as well as seperate files for the CLI commands for that lesson, and any SQL commands for that lesson. Later classes and lessons will have additional files within the lesson folders.
