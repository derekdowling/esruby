#!/usr/bin/env bash

# This script provides a number of different functionalities for monitoring and
# configuring the

export PROXY="199.116.235.83"
export CHEF="/var/chef/cookbooks/esruby"
export OPTS="-A -t -o User=ubuntu -i /Users/derek/.ssh/391project.pem"
export SUB_OPTS="-A -t -o User=ubuntu"

# Nodes To Run Against
nodes=( 10.1.0.247 10.1.0.249 10.1.1.41 10.1.1.44 )

if [ -z "${1}" ]; then
	cat <<-HELP
		options:
			-l list available nodes
			-s set the cluster to search mode
			-b set the cluster to bulk load mode
			-f flush all node indices
		HELP
fi

# List nodes and exit
if [ "${1}" = "-l" ]; then
	for host in "${nodes[@]}"
	do
		echo ${host}
	done
	exit 0
fi


# Run commands through Public Proxy
if [ "${1}" = "-s" ] || [ "${1}" = "-b" ] || [ "${1}" = "-f" ]; then
	# If targeting only a specific node
	if [ "${1}" = "-n" ]; then
		nodes=( ${2} )
	fi
	for host in "${nodes[@]}"
	do
		if [ "${1}" = "-f" ];
		then
			echo "flushing cluster"
			curl -XPOST "199.116.235.83:9200/transactions/_flush"
			exit 0
		elif [ "${1}" = "-s" ];
		then
			echo "generating:${host}"
			ssh $OPTS $PROXY ssh $SUB_OPTS $host <<-END
				curl -XPUT 'localhost:9200/transactions/_settings' -d '{"index":{"refresh_interval":"1s"}}'
				curl -XPUT 'localhost:9200/transactions/_settings' -d '{"index":{"merge.policy.min_merge_docs":100}}'
				curl -XPUT 'localhost:9200/flat_transactions/_settings' -d '{"index":{"merge.policy.min_merge_docs":100}}'
				curl -XPUT 'localhost:9200/flat_transactions/_settings' -d '{"index":{"refresh_interval":"1s"}}'
				END
		elif [ "${1}" = "-b" ];
		then
			ssh $OPTS $PROXY ssh $SUB_OPTS $host <<-END
				curl -XPUT 'localhost:9200/flat_transactions/_settings' -d '{"index":{"refresh_interval":"30s"}}'
				curl -XPUT 'localhost:9200/flat_transactions/_settings' -d '{"index":{"merge.policy.min_merge_docs":5000}}'
				curl -XPUT 'localhost:9200/transactions/_settings' -d '{"index":{"refresh_interval":"30s"}}'
				curl -XPUT 'localhost:9200/transactions/_settings' -d '{"index":{"merge.policy.min_merge_docs":5000}}'
				END
		else
			echo "Unknown option set"
		fi
	done
	if [ "${1}" = "-s" ];
	then
		ssh $OPTS $PROXY <<-END
			curl -XPUT '199.116.235.83:9200/_cluster/settings' -d '{"transient":{"indices.store.throttle.type":"node"}}'
			curl -XPUT '199.116.235.83:9200/_cluster/settings' -d '{"transient":{"indices.memory.index_buffer_size":"20%"}}'
			curl -XPUT '199.116.235.83:9200/_cluster/settings' -d '{"transient":{"threadpool.search.size":25}}'
			curl -XPUT '199.116.235.83:9200/_cluster/settings' -d '{"transient":{"threadpool.bulk.size":30}}'
			curl -XPUT '199.116.235.83:9200/_cluster/settings' -d '{"transient":{"threadpool.bulk.queue_size":500}}'
			END
	elif [ "${1}" = "-b" ];
	then
		ssh $OPTS $PROXY <<-END
			curl -XPUT '199.116.235.83:9200/_cluster/settings' -d '{"transient":{"indices.store.throttle.type":"none"}}'
			curl -XPUT '199.116.235.83:9200/_cluster/settings' -d '{"transient":{"indices.memory.index_buffer_size":"30%"}}'
			curl -XPUT '199.116.235.83:9200/_cluster/settings' -d '{"transient":{"threadpool.search.size":2}}'
			curl -XPUT '199.116.235.83:9200/_cluster/settings' -d '{"transient":{"threadpool.bulk.size":40}}'
			curl -XPUT '199.116.235.83:9200/_cluster/settings' -d '{"transient":{"threadpool.bulk.queue_size":-1}}'
			END
	fi
fi
