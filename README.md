# Kubernetes Day Zero

Kubernetes Day Zero is a platoform based on Kubernetes that creates a setup to run workloads leveraging the provided networking, security, observability, and service mesh stacks. It aims to become a ready to use full stack development platform that can be used to deliver your projects from the beginning of development. Locally, it runs on `minikube` and uses `helmfile` to deploy `helm` charts.

## To Do

* [ ] improve documentation
  * [ ] use github pages for docs
  * [ ] add docs for adding custom dashboards
* [ ] add `istio`
* [ ] add example workloads
* [ ] code to create kubernetes clusters on cloud:
  * [ ] AWS on EKS
  * [ ] Azure on AKS
  * [ ] GCP on GKE
* [ ] list other desired features here

## Setting up the local environment

Most of the tools used for this training lab are available using `asdf`, you can follow the install guide on the [`asdf` website](https://asdf-vm.com/guide/getting-started.html)

Once `asdf` is installed, you can install the remaining tools following these commands:

```bash
## install support tools using asdf
asdf install

## installs cilium cli
curl -L --remote-name-all https://github.com/cilium/cilium-cli/releases/latest/download/cilium-darwin-amd64.tar.gz{,.sha256sum}
sudo tar xzvfC cilium-darwin-amd64.tar.gz /usr/local/bin
rm cilium-darwin-amd64.tar.gz{,.sha256sum}

## install hubble cli
export HUBBLE_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/hubble/master/stable.txt)
curl -L --remote-name-all https://github.com/cilium/hubble/releases/download/$HUBBLE_VERSION/hubble-linux-amd64.tar.gz{,.sha256sum}
sha256sum --check hubble-linux-amd64.tar.gz.sha256sum
sudo tar xzvfC hubble-linux-amd64.tar.gz /usr/local/bin
rm hubble-linux-amd64.tar.gz{,.sha256sum}

## install cilium version of istioctl
## docs: https://docs.cilium.io/en/v1.10/gettingstarted/istio/
curl -L https://github.com/cilium/istio/releases/download/1.10.4/cilium-istioctl-1.10.4-osx.tar.gz | tar xz
```