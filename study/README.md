# Study 1 — pre-registered simulation (9 Oct 2026)

Own Python simulators: LRU, FIFO, CLOCK, ARC, S3-FIFO, SIEVE, LeCaR, Belady MIN.
Workloads: Zipf α=0.8/20,000 keys, Zipf α=1.2/5,000 keys, scan, 3,000-key loop; caches 500/1,500/4,000; 10 seeds.

Note (paper §6): this S3-FIFO promotes after one re-access; the reference threshold is 2.
Study 2 uses libCacheSim's reference implementation and supersedes these numbers.

Expected files: simulator code, workload generators, run script, raw CSVs, `PREREGISTRATION.md`.
