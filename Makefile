.PHONY: build-images tf-init tf-plan tf-apply helm-install

build-images:
	@echo "Building Docker images for all services..."
	docker build -t amazon-iphone:latest services/iphone
	docker build -t amazon-laptop:latest services/laptop
	docker build -t amazon-cart:latest services/cart
	docker build -t amazon-payment:latest services/payment
	docker build -t amazon-delivery:latest services/delivery


tf-init:
	terraform -chdir=terraform/envs/dev init

tf-plan:
	terraform -chdir=terraform/envs/dev plan

tf-apply:
	terraform -chdir=terraform/envs/dev apply

helm-install:
	helm repo add newrelic https://helm-charts.newrelic.com || true
	helm repo add eks https://aws.github.io/eks-charts || true
	helm repo add jetstack https://charts.jetstack.io || true
	helm repo update
	helm upgrade --install amazon-apps ./helm/amazon --namespace amazon-app --create-namespace -f helm/amazon/values.yaml
	helm upgrade --install amazon-monitoring newrelic/nri-bundle --namespace amazon-monitoring --create-namespace -f helm/monitoring/values.yaml

helm-install-cert-manager:
	helm repo add jetstack https://charts.jetstack.io || true
	helm repo update
	helm dependency update helm/cert-manager
	helm upgrade --install cert-manager ./helm/cert-manager --namespace cert-manager --create-namespace -f helm/cert-manager/values.yaml

helm-install-external-dns:
	helm repo add external-dns https://kubernetes-sigs.github.io/external-dns/ || true
	helm repo update
	helm upgrade --install external-dns ./helm/external-dns --namespace external-dns --create-namespace -f helm/external-dns/values.yaml
