# Esruby
------------
This repository provides the basic tools to provision a Elasticsearch Test & Production environment. 

### Testing
In order to create a test Elasticsearch environment for testing, we will need to use vagrant. Go to the [Vagrant Downloads](https://www.vagrantup.com/downloads.html) page to select the correct version and install it.

The other expectation is that you have already installed a version of Ruby Version Manager on your computer. If not enter the following in bash:

```
\curl -sSL https://get.rvm.io | bash -s stable --ruby
```

Following this step, you can then run:

```
./install_local.sh
```

Which will take care of installing everything else for you. After this has completed successfully, you can then log into the vagrant virtual machine using:

```
kitchen login
```

Although this isn't necessary as by default, the cs391 CLI tool is equiped to communicate with your VM from the outside world.

#### For convenience:

Inside of the "cs391" repository, there is a script that ensures that your VM is in a running state automatically for you after you have completed the initial install. You can use this by navigating to the "cs391" repository and running:

```
./start_es.sh
```

### Provisioning A Production Elasticsearch Node

This repository also possesses the tools needed to provision a single node, or a full cluster in production. It is important to note that by default, this cluster will have ports 9200 and 9300 exposed to the outside world. This should probably not be the case if you are planning on storing any confidential information as it will be accessible by anyone smart enough to try the ports.

#### Starting The Installation

The Esruby repository comes with the "install.sh" script which handles all of the details for you. The only two modifications that need to be made inside of the file is changing the "OPTS" parameters to point at your own PEM file for SSHing into your public facing server, and then specifying your own local network nodes that your Public IP can access in the "nodes" parameter.

NOTE: If you do indeed have different local IP addresses for your cluster, you'll also need to modify the "roles/cluster.rb" file for the "discovery.zen.ping.unicast.hosts" attribute with your own IP addresses.

Assuming you have done these things, running:

```
./install.sh -a
```

Will install elasticsearch to all of the machines listed and accessible via the "nodes" parameter in the script.

If you'd like to install to a specific node instead of all of them, you may also run:

```
./install.sh -s <node_index>
```

Where <node_index> is the node in the "nodes" parameter found within the document or in the order it appears via:

```
./install.sh -l
```

#### Changing Cluster Modes

You can also change the mode that your cluster, or your indices are in using the "monitor.sh" script.

By specifying the "-s" flag with the command you will put the cluster into a more search friendly configuration. By using the "-b" flag, the cluster will change into a more bulk loading friendly mode.

NOTE: If you are changing back from a bulk load mode to a search mode, it may take a considerable amount of time for the cluster to finish indexing/merging all of the documents you have just finished loading, so be prepared for fairly extreme throttling in the initial moments following the changes.


