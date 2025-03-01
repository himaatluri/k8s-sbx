SHELL=/bin/bash
CLUSTERNAME="xplane"

fullup: cluster_up
	@kubectl apply -f uxp/providers
	@kubectl apply -f uxp/provider-config
	@kubectl apply -f uxp/functions
	@kubectl apply -f uxp/apis/corp-cm

cluster_up:
	echo "Deploying a local kind cluster: $(CLUSTERNAME)"
	@kind create cluster -n $(CLUSTERNAME) --config kind/cluster.yml
	@source set.sh

cleanup:
	@kind delete clusters $(CLUSTERNAME)