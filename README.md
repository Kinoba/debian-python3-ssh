debian-ssh
============

Simple Debian docker images with SSH access


Usage
-----

To create the image `debian-ssh` with latest Debian release, 
execute the following commands on the debian-ssh folder:

    git checkout master
    dcoker build -t kinoba/debian-python-ssh

Running debian-ssh
--------------------

To run a container from the image binding it to port 2222 in all interfaces, execute:

	docker run -d -p 2222:22 kinoba/debian-python-ssh

The first time that you run your container, a random password will be generated
for user `root`. To get the password, check the logs of the container by running:

	docker logs <CONTAINER_ID>

You will see an output like the following:

	========================================================================
	You can now connect to this debian-ssh container via SSH using:

	    ssh -p <port> root@<host>
	and enter the root password 'UCr7W3U0iSGV' when prompted

	Please remember to change the above password as soon as possible!
	========================================================================

In this case, `UCr7W3U0iSGV` is the password allocated to the `root` user.

Done!


Setting a specific password for the root account
------------------------------------------------

If you want to use a preset password instead of a random generated one, you can
set the environment variable `ROOT_PASS` to your specific password when running the container:

	docker run -d -p 2222:22 -e ROOT_PASS="password" kinoba/debian-python-ssh


Build
---

### For your current OS

```bash
docker build --tag kinoba/debian-python-ssh .
docker push kinoba/debian-python-ssh
```

### For multiple OSes

```bash
docker buildx create universal-builder
docker buildx use universal-builder
docker buildx build \
	--platform linux/amd64,linux/arm64,linux/arm/v7 \
	--tag kinoba/debian-python-ssh --push \
	.
```