#!/bin/bash
cd /home/loostrum3/nsight

mkdir -p reports
nsys profile --trace cuda,openacc,mpi,osrt,ucx -f true -o reports/report6_mpi_remote_rank${SLURM_PROCID} $PWD/6_mpi

#export UCX_IB_GPU_DIRECT_RDMA=no
#nsys profile --trace cuda,openacc,mpi,osrt,ucx -f true -o reports/report6_mpi_remote_rank${SLURM_PROCID}_nordma $PWD/6_mpi

