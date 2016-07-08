# Drone on Kubernetes on AWS

This directory contains various example deployments of Drone on Amazon Web Services.

**Note: While Drone supports a variety of different remotes, this demo assumes
that the projects you'll be building are on GitHub.**

## Prep work

**Before continuing on to one of the example setups below, you'll need to create a Kubernetes cluster**, plus a EBS volume for the DB. Here's a rough run-down of that process:

### Create a Kubernetes cluster

You'll want to follow the [Running Kubernetes on AWS EC2](http://kubernetes.io/docs/getting-started-guides/aws/) guide if you don't already have a cluster.

If you've already got one, make sure your `kubectl` client is pointed at your cluster before continuing.

### Create an EBS volume for your sqlite DB

By default, these manifests will store all Drone state on an EBS volume via sqlite. As a consequence, we need an EBS volume before running the installer.

The easiest way to do this is via the AWS Web Console. It is also possible via the `aws` CLI's `aws ec2 create-volume` command. *Make sure your volume resides in the same AZ+Region as your cluster!* If you aren't sure of what size volume you'll need, 25 GB is a safe bet for most low-to-moderate traffic setups.

Once you have created your volume, look its Volume ID in the Console/CLI. It should look something like `vol-aaaaaa12`. You'll want to edit your sample setup's `drone-server-rc.yaml` file and substitute this for the placeholder value for `volumeID`. **If you don't do this, your Drone Server will never start**.

## Choose an example deploy

At this point you should have a cluster and an EBS volume (both in the same AZ). Time to get to the fun stuff! Here are your options:

* `ece2-with-http` - This is the simplest, fastest way to start playing with Drone. It stands up a fully-functioning cluster served over un-encrypted HTTP. This is *not* what you want in a more permanent, production-grade setup. However, it is a quick and easy way to get playing with Drone with a bare minimum setup process.

## Stuck? Need help?

We've glossed over quite a few details, for the sake of brevity. If you have questions, post them to our [Help!](https://discuss.drone.io/c/help) category on the Drone Discussion site. If you'd like a more realtime option, visit our [Gitter room](https://gitter.im/drone/drone).
