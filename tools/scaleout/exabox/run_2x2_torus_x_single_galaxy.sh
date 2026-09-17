#!/usr/bin/env bash
# Single-galaxy 2x2 Torus-X fabric test for #56298.
#
# Runs test_tt_fabric on ONE BlackHole galaxy with the 2x2 RING/LINE 4-stage ring MGD (four 2x2
# stages, ring-connected), every mesh opening with the SAME config FABRIC_2D_TORUS_X (no mixed
# configs). Drives inter/intra-mesh neighbor exchange to check the torus fabric does not hang.
#
# Prereq: recovered galaxy, `source env.sh`, and a dir where `mpirun -> mpirun-ulfm` first on PATH.
# Usage: ./run_2x2_torus_x_single_galaxy.sh [host]   (default: first local BH galaxy)
set -eo pipefail
HOST="${1:-$(hostname)}"
MGD="tests/tt_metal/tt_fabric/custom_mesh_descriptors/single_galaxy_2x2_z_ring_4stage_ring_mesh_graph_descriptor.textproto"
YAML="tests/tt_metal/tt_fabric/test_infra/test_yamls/test_fabric_2x2_torus_x.yaml"

echo "### 2x2 Torus-X (uniform FABRIC_2D_TORUS_X) on a single galaxy: $HOST"
./tools/scaleout/exabox/run_fabric_tests.sh \
  --hosts "$HOST" --image none --mpi-if none \
  --mesh-graph-desc-path "$MGD" \
  --test-config "$YAML" \
  --filter "name.TorusX*"
