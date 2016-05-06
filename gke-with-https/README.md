# Drone on Google Container Engine (minimal example)

This directory contains an example of a simple but production-ready Drone
install on [Google Container Engine](https://cloud.google.com/container-engine/).
We use [Caddy](https://caddyserver.com/) and
[Let's Encrypt](https://letsencrypt.org/) to automatically generate a matching
SSL cert for you at runtime.

## Prep work

There are a few things you'll need to do prior to using these manifests.
How to do them is beyond the scope of this example, but here's a rough
run-down:

### Create a Container Engine Cluster

You'll need to do this if you don't already have one. There are a few different
ways to do this:

* If you don't have a strong preference, make sure your `gcloud` client is
  pointed at the project you'd like the cluster created within. Then you
  can run the `create-gke-cluster.sh` script in this directory. If you do this,
  you'll end up with a cluster and a persistent disk for your DB.
* The Google Cloud Platform web console makes cluster creation very easy,
  as well. See the
  [GKE docs](https://cloud.google.com/container-engine/docs/before-you-begin)),
  on how to get this set up. If you create it like this, you'll need to manually 
  point your `gcloud` client is pointed at the cluster

### Create a persistent disk for your sqlite DB

By default, these manifests will store all Drone state on a Google Cloud
persistent disk via sqlite. As a consequence, we need an empty persistent
disk before running the installer.

You can either do this in the GCP web console or via the `gcloud` command.
In the case of the latter, you can use our `create-disk.sh` script after you
open it up and verify that the options make sense for you.

In either case, make sure the persistent disk is named `drone-server-sqlite-db`.
Also make sure that it is in the same availability zone as the GKE cluster.

## Install Dronoe

Finally, run `install-drone.sh` and follow the prompts carefully. At the
end of the installation script, you should be able to point your browser at
`https://drone.your-fqdn.com` and see a Login page.

## Troubleshooting

You can verify that everything is running correctly like this:

```
kubectl get pods
```

You should see several pods in a "Running" state. If there were issues,
note the name of the pod and look at the logs. This is a close approximation
of what you'd need to type to check the Caddy proxy logs:

```
kubectl logs -f drone-server-a123 caddy-server
```

Here's a close approximation of what you'd need to check the Drone server logs:

```
kubectl logs -f drone-server-a234 drone-server
```

And agent:

```
kubectl logs -f drone-agent-a345
```

Where ``drone-server-a123`` is the pod name.


## Stuck? Need help?

We've glossed over quite a few details, for the sake of brevity. If you
have questions, post them to our [Help!](https://discuss.drone.io/c/help)
category on the Drone Discussion site. If you'd like a more realtime option,
visit our [Gitter room](https://gitter.im/drone/drone).
