#!/bin/bash
cd /home/loostrum3/nsight

nsys profile --trace cuda,openacc,mpi,osrt,ucx -f true -o report6_mpi_remote_rank${SLURM_PROCID} /home/loostrum3/nsight/6_mpi

#export UCX_IB_GPU_DIRECT_RDMA=no
#nsys profile --trace cuda,openacc,mpi,osrt,ucx -f true -o report6_remote_rank${SLURM_PROCID}_nordma /home/loostrum3/nsight/6_mpi

