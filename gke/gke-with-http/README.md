# Drone on Google Container Engine (minimal example)

This directory contains an example of a simple Drone install on [Google Container Engine](https://cloud.google.com/container-engine/). This partcular example deploy eschews HTTPS in favor of a simplified install. See the `gke-with-https` example setup that is a sibling of this directory.

**Note: While Drone supports a variety of different remotes, this demo assumes that the projects you'll be building are on GitHub.**

## Prep work

**Warning: Before proceeding, you should have followed the directions in the "Prep Work" section in the README.md found in this directory's parent.

## Install Drone

Finally, run `install-drone.sh` and follow the prompts carefully. At the end of the installation script, you should be able to point your browser at `https://drone.your-fqdn.com` and see a Login page.

## Compromises Made

This example setup eschews HTTPS for a simplified setup process. We do not recommend running Drone in a production setup without HTTPS. If you are using this HTTPS-less setup for evaluation, we suggest graduating to the `gke-with-https` example deploy.

This install script installs Drone on the cluster that is currently active in your `kubectl` client, in whatever namespace your current active context specifies (the `default` namespace if you haven't done anything to specifically change it). This is fine if Drone is the only thing running on your cluster, and is often fine even if that is not the case.

If you'd like to further isolate Drone from anything else running on your cluster, see the Kubernetes docs for [Sharing a Cluster with Namespaces](http://kubernetes.io/docs/admin/namespaces/). Before installing Drone, you'd want to create a new namespace, configure your `kubectl` context, set the context as active, *then* run the install script.

## Troubleshooting

You can verify that everything is running correctly like this:

```
kubectl get pods
```

You should see several pods in a "Running" state. If there were issues, note the name of the pod and look at the logs. This is a close approximation of what you'd need to type to check the Drone Server logs:

```
kubectl logs -f drone-server-a123
```

And Drone Agent:

```
kubectl logs -f drone-agent-a345
```

Where ``drone-agent-a123`` is the pod name.


## Stuck? Need help?

We've glossed over quite a few details, for the sake of brevity. If you have questions, post them to our [Help!](https://discuss.drone.io/c/help) category on the Drone Discussion site. If you'd like a more realtime option, visit our [Gitter room](https://gitter.im/drone/drone).
