# Drone on Google Container Engine (minimal example)

This directory contains an example of the simplest viable Drone deployment
on [Google Container Engine](https://cloud.google.com/container-engine/).
We eschew some important things like HTTPS in the name of conciseness.

## Prep work

There are a few things you'll need to do prior to using these manifests.
How to do them is beyond the scope of this example, but here's a rough
run-down (you can do most of this from their web console):

* Create a Container Engine cluster if you don't already have one. You can
  do this via Google Cloud Platform's web console or the `gcloud` command (if
  you have installed the GCP SDK).
* Make sure your ``kubectl`` client is configured correctly to work with
  your cluster. See the
  [GKE docs](https://cloud.google.com/container-engine/docs/before-you-begin)),
  on how to get this set up.
* Create a persistent disk of 10-20 GB in the same availability zone and
  region as your cluster. Name it `drone-server-sqlite-db`.

### Install Dronoe

Finally, run `install-drone.sh` and follow the prompts carefully. At the
end of the installation script, you should be able to point your browser at
`https://drone.your-fqdn.com` and see a Login page.

### Troubleshooting

You can verify that everything is running correctly like this:

```
kubectl get pods
```

You should see several pods in a "Running" state. If there were issues,
note the name of the pod and look at the logs:

```
kubectl logs -f drone-proxy-a123
```

Where ``drone-proxy-a123`` is the pod name.


### Stuck? Need help?

We've glossed over quite a few details, for the sake of brevity. If you
have questions, post them to our [Help!](https://discuss.drone.io/c/help)
category on the Drone Discussion site.
