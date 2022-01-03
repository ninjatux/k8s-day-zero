GREEN = \033[1;32m
RESET = \033[0m
WHITE = \033[1;38;5;231m

## Makefile help screen
help:
	@echo "${GREEN}Available targets:${RESET}\n"
	@awk '/^[a-zA-Z\-\_0-9%:\\]+/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
			if (helpMessage) { \
				helpCommand = $$1; \
				helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
				gsub("\\\\", "", helpCommand); \
				gsub(":+$$", "", helpCommand); \
				printf "  \x1b[32;01m%-35s\x1b[0m %s\n", helpCommand, helpMessage; \
			} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)
	@printf "\n"

## Starts a local minikube cluster
minikube-start:
	@echo "${GREEN}[#] Starting minikube lab${RESET}"
	@minikube config set driver virtualbox
	@minikube config set WantVirtualBoxDriverWarning false
	@minikube start --network-plugin=cni --memory=5120 --cpus=4 --disk-size 32g --vm=true --cni=false
	@minikube ssh -- sudo mount bpffs -t bpf /sys/fs/bpf

## Adds a node to the local minikube cluster
minikube-add-node:
	@echo "${GREEN}[#] Add extra node to minikube cluster${RESET}"
	@minikube node add

## Delete the local minikube cluster
minikube-delete:
	@echo "${GREEN}[#] Deleting minkube lab${RESET}"
	@minikube delete

## Diff cilium release
cilium-diff:
	@echo "${GREEN}[#] Check cilium cni install diff${RESET}"
	@helmfile -f releases/cilium/helmfile.yaml -e local diff

## Sync cilium release
cilium-sync:
	@echo "${GREEN}[#] Installing cilium cni${RESET}"
	@helmfile -f releases/cilium/helmfile.yaml -e local sync

## Check cilium status
cilium-status:
	@echo "${GREEN}[#] Check cilium cni status${RESET}"
	@cilium status --wait

## Diff metrics-server
metrics-server-diff:
	@echo "${GREEN}[#] Check metrics-server install diff${RESET}"
	@helmfile -f releases/metrics-server/helmfile.yaml -e local diff

## Sync metrics-server
metrics-server-sync:
	@echo "${GREEN}[#] Installing metrics-server${RESET}"
	@helmfile -f releases/metrics-server/helmfile.yaml -e local sync

## Instals the complete monitoring setup
monitoring-all: metrics-server-sync prometheus-stack-sync loki-stack-sync grafana-dashboards-sync

## Diff kube-prometheus-stack
prometheus-stack-diff:
	@echo "${GREEN}[#] Check promethues stack install diff${RESET}"
	@helmfile -f releases/monitoring/kube-prometheus-stack/helmfile.yaml -e local diff

## Sync kube-prometheus-stack
prometheus-stack-sync:
	@echo "${GREEN}[#] Installing promethues stack${RESET}"
	@helmfile -f releases/monitoring/kube-prometheus-stack/helmfile.yaml -e local sync

## Diff grafana-dashboards
grafana-dashboards-diff:
	@echo "${GREEN}[#] Check grafana-dashboards diff${RESET}"
	@helmfile -f releases/monitoring/grafana-dashboards/helmfile.yaml -e local diff

## Sync grafana-dashboards
grafana-dashboards-sync:
	@echo "${GREEN}[#] Installing grafana dashboards${RESET}"
	@helmfile -f releases/monitoring/grafana-dashboards/helmfile.yaml -e local sync

## Diff loki-stack
loki-stack-diff:
	@echo "${GREEN}[#] Check loki stack install diff${RESET}"
	@helmfile -f releases/monitoring/loki-stack/helmfile.yaml -e local diff

## Sync loki-stack
loki-stack-sync:
	@echo "${GREEN}[#] Installing loki stack${RESET}"
	@helmfile -f releases/monitoring/loki-stack/helmfile.yaml -e local sync

## istio
istio-install:
	@./cilium-istioctl install -y

## lab quickstart
lab-quickstart: minikube-start cilium-sync minikube-add-node cilium-status metrics-server-sync monitoring-all