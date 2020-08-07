# KUBERNETES
Kubernetes (k8s) is a framework for managing distributed systems. In particular,
k8s is used to manage containerized applications. For example, if a container
fails and goes down, k8s can be used to instantiate and run a replacement.

## BENEFITS OF k8s:
- High availability (no downtime if container(s) go down)
- Scalability (easy to deploy more containers to enhance performance)
- Recovery (I think this is similar to "durability", but not the same...) 

## ARCHITECTURE
- A k8s cluster is comprised of a master node, worker nodes, and a virtual
  network.
- One master node. Runs k8s processes:
  - \* In a production env, you'd actually want >= 2 master nodes. Without the
    master node, the entire cluster can fail, and the app fails with it. 
    Although the master node isn't actually doing the work of creating and
    deploying the app, without it the app can't work. Hence the need for
    redundancy.
  - API Server: the entrypoint to the k8s cluster.
  - Controller manager: what's going on in the cluster? Nodes or containers
    that need to be restarted?
  - Scheduler: determines where new containers will be deployed (e.g. which 
    worker node has sufficient capacity - memory, storage, etc - to support a
    new container.)
  - etcd [key:value] storage: holds current state of k8s cluster, config data,
    status data of each node (helps to do recovery, backup and restore). Holds
    a snapshot of what's going on in the nodes.
- Virtual network: allows the nodes inside of the k8s cluster to talk to each
  other and pool resources of all nodes+containers so they can be used as 
  needed.
- Worker nodes, having Docker containers running on each.
![k8s-architecture](/images/k8s-architecture.png)

## BASIC CONCEPTS

### PODS
- Atomic unit of k8s. Basically a wrapper for a (docker) container. 
- You can have > 1 container per pod, but usually it's 1:1.
  - Typically you'd do 1 pod for a message bus, 1 pod for a database, 1 pod for
    a object storage (like MinIO), 1 pod for a microservice created by some
    source code (e.g. a `main.py`).
- Multiple pods per worker node.
- The k8s cluster's virtual network (recall that this is a component of each
  cluster which allows the nodes to communicate) assigns each pod its own
  internal IP address. So each pod is it's own self-contained server, with pods
  communicating with each other via these internal IP's.
- If pods get restarted or recreated, the replacement gets a new IP address. 
  - Instead of internal IP's, can use a ***Service*** since they persist across
    instances of pods and makes it much easier for pods to talk to and find
    each other. Services sit in front of pods and have permanet IP addresses.
  - Services also act as load-balancers (in addition to aiding communication).

## K8S CONFIGURATION
- All config goes thru the ***API Server*** in the master node (the cluster's
  entrypoint.)
- A k8s client communicates with the master node's API server. These clients
  might include:
  - a UI (a k8s dashboard like Rancher)
  - an API (like a script or `curl` command)
  - a CLI tool (like `kubectl`)
- The k8s client must make the config requests in either `YAML` or `JSON`.
- A ***Deployment*** is a template for creating pods (Deployment is a keyword
  in the k8s config file). You can specify how many replicas, the image upon
  which the pod containers are based, etc.




