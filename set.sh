#!/bin/bash

# Env vars
CA_BUNDLE="${SSL_CERT_FILE}"
UXP_NAMESPACE="crossplane-system"
CA_CM_NAME="ca-bundle-config"
CA_CM_KEY="ca-bundle"

# Validations
if [ -z "$SSL_CERT_FILE" ]; then
  echo "[Error] The environment variable SSL_CERT_FILE is not set."
  exit 1
fi

# Contexts
echo "[INFO] Use kind context"
kubectl config use-context kind-xplane

# Localize setup
echo "[INFO] Helm install crossplane system"
helm install crossplane \
    --namespace $UXP_NAMESPACE \
    --create-namespace crossplane-stable/crossplane \
    --set args='{"--enable-environment-configs","--enable-composition-functions", "--enable-usages", "--enable-deployment-runtime-configs","--enable-composition-webhook-schema-validation"}' \
    --set registryCaBundleConfig.name="$CA_CM_NAME" \
    --set registryCaBundleConfig.key="$CA_CM_KEY"

# CA setup
echo "[INFO] Inject CA bundle"
# Pass the value to another command
kubectl -n $UXP_NAMESPACE create cm $CA_CM_NAME --from-file="$CA_CM_KEY"="$CA_BUNDLE"
