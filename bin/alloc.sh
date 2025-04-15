#!/bin/bash
salloc -t 1:00:00 -p gpu_h100 -N 1 --gpus-per-node=1 --tasks-per-node=1 --cpus-per-task=1 
