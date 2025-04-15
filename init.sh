module load 2023
module load NVHPC/24.5-CUDA-12.1.1 OpenMPI/4.1.5-NVHPC-24.5-CUDA-12.1.1 Nsight-Systems/2023.3.1 UCX-CUDA/1.14.1-GCCcore-12.3.0-CUDA-12.1.1

export AMRVAC_DIR=$HOME/agile/amrvac
export FC=nvfortran

if [[ "$hostname" == "int3.local.snellius.surf.nl" ]]; then
    MIG=($(nvidia-smi -L | sed -nr "s|^.*UUID:\s*(MIG-[^)]+)\)|\1|p"))
    export CUDA_VISIBLE_DEVICES=${MIG[8]}
fi

