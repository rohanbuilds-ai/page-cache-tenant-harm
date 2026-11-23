# The Aggregate Miss Ratio Can Hide Tenant Harm

**Reviewing and Testing How Page-Cache Replacement Is Evaluated**

## Authors

- **Dhanush R** (PES1UG24AM427)
- **Thrupthi G D** (PES1UG24AM476)
- **Rohan K** (PES1UG25AM315)
- **Rohan S** (PES1UG25AM318)

*Department of Computer Science and Engineering (AI&ML), PES University, Bengaluru, India — Group 27*  
*Course instructor: Dr. Ravi Gorripati*

---

## Overview & Summary

Linux page caches are shared by many applications, but new cache-replacement policies are usually judged only by their overall (aggregate) miss ratio. We review 39 primary studies and find that software-cache and page-cache eviction research almost never reports per-tenant outcomes. In simulation with 11 libCacheSim reference policies, the aggregate-best policy was not the best for the Zipf tenant in 65 of 100 cells and left it more than 5 pp (up to 14.0 pp) worse off than an equal static partition in 22 cells. In a real Linux kernel with memory cgroups, the pattern appears at a smaller size (3–4 pp) and only with readahead disabled. We propose a seven-item reporting protocol (P1–P7).

This repository contains the full research paper, review materials, simulation harnesses, kernel-experiment harnesses, and figure generation scripts.

---

## Research Paper & Key Materials

- **Research Paper (PDF)**:
  - [`Final_Research_Paper_v5.pdf`](Final_Research_Paper_v5.pdf) (Repository root)
  - [`paper/paper.pdf`](paper/paper.pdf) (Paper directory)
- **Citation Metadata**: [`CITATION.cff`](CITATION.cff)
- **Checklist**: [`CHECKLIST.md`](CHECKLIST.md) / [`CHECKLIST`](CHECKLIST)
- **System Environment**: [`ENVIRONMENT.txt`](ENVIRONMENT.txt) / [`ENVIRONMENT`](ENVIRONMENT)
- **Dependencies**: [`requirements.txt`](requirements.txt)
- **Checksum Utility**: [`make_checksums.sh`](make_checksums.sh)
- **License**: [`LICENSE`](LICENSE)

---

## Repository Layout

| Directory / File | Description |
|---|---|
| [`paper/`](paper/) | Research paper manuscript directory and [`paper.pdf`](paper/paper.pdf) |
| [`review/`](review/) | Literature review materials: search register (T1–T10, A1–A6), 61-record screening register, extraction & appraisal tables, blinded second-screener sheet, Cohen's κ script, and extraction form for [57] |
| [`study/`](study/) | Study 1: Custom Python simulators (LRU, FIFO, CLOCK, ARC, S3-FIFO, SIEVE, LeCaR, Belady MIN) and pre-registration |
| [`study2/`](study2/) | Study 2: libCacheSim configuration (`common.py`), experiment scripts E1–E5, `run_seeds.py`, `analyze2.py`, raw CSVs, and pre-registration |
| [`kernel/`](kernel/) | Study 3: Real Linux kernel harnesses K1–K3 (`run_kernel.py`, `run_kernel2.py`, `run_kernel3.py`), C replay program, `blocklat.bt`, raw results, K4 harness and pre-registration templates |
| [`figures/`](figures/) | Scripts that regenerate every figure in the paper from raw data |

---

## Requirements & Environment

- **Python 3**: Packages listed in [`requirements.txt`](requirements.txt) (`pip install -r requirements.txt`)
- **libCacheSim**: Python bindings `libcachesim==0.3.5` (PyPI); reference C code at commit `40fb623` (<https://github.com/1a1a11a/libCacheSim>)
- **Kernel Studies**: Linux with root access, a **cgroup v1** memory controller, and `bpftrace` for K3. Tested on Linux 6.18.44 (x86-64), 2 vCPUs, 7.8 GiB RAM, ext4 on a virtio disk (mq-deadline), `CONFIG_LRU_GEN` unset. See [`ENVIRONMENT.txt`](ENVIRONMENT.txt) for details.

---

## Reproducing the Results

```bash
# Install dependencies
pip install -r requirements.txt

# Study 2 (Simulation with libCacheSim)
cd study2
python3 e1_crosscheck.py      # E1 cross-check
python3 e2_replicate.py       # E2 replication
python3 e3_sweep.py           # E3 100-cell sweep
python3 e4_oracle.py          # E4 S3-FIFO oracle tuner
python3 e5_real_traces.py     # E5 real traces
python3 run_seeds.py e3 3 10  # uniform n = 10 seeds for E3
python3 run_seeds.py e5 2 10  # uniform n = 10 seeds for E5
python3 analyze2.py
cd ..

# Study 3 (Real kernel experiments; requires root and cgroup v1)
cd kernel
sudo python3 run_kernel.py    # K1 masking
sudo python3 run_kernel2.py   # K2 validation & overhead
sudo python3 run_kernel3.py   # K3 block tracing
cd ..
```

### Real Traces Notice

The two real traces (CloudPhysics block-trace sample and Twitter cluster 52 sample) are **not redistributed** in this repository. They are the samples bundled with libCacheSim at commit `40fb623` (<https://github.com/1a1a11a/libCacheSim>). Place them in `study2/data/` before running E5.

---

## Pre-registrations

Each pre-registration is tracked with its SHA-256 hash matching the values in the manuscript:

| Study | Pre-registration File | Expected SHA-256 (Manuscript) |
|---|---|---|
| Study 1 | `study/PREREGISTRATION.md` | `7f28fcc2...d1eb42` |
| Study 2 | `study2/PREREGISTRATION.md` | `b550821a...4575` |
| K1 | `kernel/PREREG_K1.md` | `ce0311a9...4b32` |
| K2 | `kernel/PREREG_K2.md` | `482bde2f...729e` |
| K3 | `kernel/PREREG_K3.md` | `7cac4710...1f73` |

Verify checksums using `./make_checksums.sh` or `sha256sum -c SHA256SUMS`.

---

## Citation

Please cite this paper using [`CITATION.cff`](CITATION.cff):

```bibtex
@article{dhanush2026aggregatemissratio,
  title   = {The Aggregate Miss Ratio Can Hide Tenant Harm: Reviewing and Testing How Page-Cache Replacement Is Evaluated},
  author  = {Dhanush R and Thrupthi G D and Rohan K and Rohan S},
  journal = {PES University Research},
  year    = {2026},
  url     = {https://github.com/rohanbuilds-ai/page-cache-tenant-harm}
}
```

---

## Use of AI Assistance

An AI assistant (Claude, Anthropic) was used to check references against publisher records, write and run the simulation and kernel-experiment code, draft text, and perform the literature screening and data extraction. The authors reviewed every claim against its source and are responsible for the content.

---

## License

- **Code**: MIT License (see [`LICENSE`](LICENSE)).
- **Manuscript and review data**: Creative Commons Attribution 4.0 International (CC BY 4.0).
