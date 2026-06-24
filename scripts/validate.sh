#!/usr/bin/env bash
set -euo pipefail

echo "[1/3] Kyverno unit tests..."
kyverno test tests/networkpolicies --detailed-results

echo "[2/3] Kyverno apply against real NetworkPolicy manifests..."
kyverno apply policies/kyverno \
  --resource apps/online-boutique/networkpolicies \
  --detailed-results

echo "[3/3] Kubernetes client-side dry-run..."
kubectl apply --dry-run=client -f apps/online-boutique/networkpolicies -o yaml >/dev/null

echo "Validation completed successfully."