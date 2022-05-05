# Kubernetes Study Lab

With this project, I attempted to create a lab for studying Kubernetes and its ecosystem of applications and tools. This is just for personal use, it's not intended to be used in production or professional environments.

## ToDo

* [ ] improve documentation
  * [ ] use github pages for docs
  * [ ] add docs for adding custom grafana dashboards
* [ ] add `istio`
* [ ] add example workloads
* [ ] code to create kubernetes clusters on cloud:
  * [ ] AWS on EKS
  * [ ] Azure on AKS
  * [ ] GCP on GKE
* [ ] Investigate grafana operator for enabling dashboards as CRD
* [ ] extend this todo list

## Setting up the local environment

Most of the tools used for this training lab are available using `asdf`, you can follow the install guide on the [`asdf` website](https://asdf-vm.com/guide/getting-started.html)

Once `asdf` is installed, you can install the remaining tools following these commands:

```bash
## install support tools using asdf
asdf install
```

Now let's install `cilium` related tools:

```
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
