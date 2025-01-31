helm install crossplane \
    --namespace crossplane-system \
    --create-namespace crossplane-stable/crossplane \
    --set args='{"--enable-environment-configs","--enable-composition-functions", "--enable-usages", "--enable-deployment-runtime-configs","--enable-composition-webhook-schema-validation"}'