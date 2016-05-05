#!/usr/bin/env bash
# Clear out the old values, since we're being crude.
kubectl delete configmap drone 2> /dev/null
if [ $? -eq 1 ]
then
  echo "Before continuing, make sure you have opened drone-configmap.yaml and" \
       "modified the values to suit your environment."
  echo
  read -p "<Press enter once you've made your edits>"
fi
kubectl delete rc drone-server 2> /dev/null
kubectl delete rc drone-proxy 2> /dev/null

kubectl create -f drone-proxy-svc.yaml 2> /dev/null
if [ $? -eq 0 ]
then
  echo "Since this is your first time running this script, we just created a" \
       "front-facing Load Balancer with an external IP. You'll need to wait" \
       "for the LB to initialize and pull an IP address. We'll pause for a" \
       "bit and walk you through this after the break."
  while true; do
    echo "Waiting for 40 seconds for LB creation..."
    sleep 40
    echo "[[ Querying your drone-proxy service to see if it has an IP yet... ]]"
    echo
    kubectl describe svc drone-proxy
    echo "[[ Query complete. ]]"
    read -p "Do you see a value above for 'Loadbalancer Ingress'? (y/n) " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) echo "We'll give it some more time.";;
        * ) echo "No idea what that was, but we'll assume yes!";;
    esac
  done
  echo
  echo "Excellent. Create a DNS (A) Record that matches the value you entered" \
       "for proxy.fqdn in drone-configmap.yaml. It should point at the IP you" \
       "see above next to 'Loadbalancer Ingress'. Once you have configured the" \
       "DNS entry, don't proceed until nslookup is showing the IP you set." \
       "Let's Encrypt needs to be able to resolve and send a request to your " \
       "server in order to verify service and generate the cert."
  read -p "<Press enter to proceed once nslookup is resolving your proxy FQDN>"
fi

kubectl create -f drone-server-svc.yaml 2> /dev/null
kubectl create -f drone-configmap.yaml
kubectl create -f drone-server-rc.yaml
kubectl create -f drone-proxy-rc.yaml
echo
echo "At this point, you should have a running Drone install. Point your" \
echo "browser at https://<your-fqdn-here> and you should see a login page."
