# Study 3 — real-kernel experiment (K1–K3 pre-registered 30 Oct 2026)

Requires root and a cgroup-v1 memory controller. Each run: sync, drop_caches=3, fresh cgroup.

- `replay.c` — two-tenant replay (Zipf tenant on a 128 MiB file; loop or scan tenant), 400,000 requests, 50/50
- `run_kernel.py` (K1 masking), `run_kernel2.py` (K2 validation, overhead, readahead on), `run_kernel3.py` (K3 block tracing)
- `blocklat.bt` — bpftrace script separating queueing from device service time
- `results/` — raw results
- `k4/` — harness + pre-registration template for MGLRU / cgroup v2 / bare-metal NVMe (future work, no results)
- `PREREG_K1.md`, `PREREG_K2.md`, `PREREG_K3.md`
