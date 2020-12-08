#!/bin/bash
#SBATCH --job-name=test_ANTs
#SBATCH --partition=normal
#SBATCH --time=02:00:00
#SBATCH --mem=4G
#SBATCH --cpus-per-task=4
#SBATCH --chdir=.
#SBATCH --output=logs/train_%j.log
#SBATCH --error=errors/train_%j.log

module load clinica/aramis

BIDS=/network/lustre/dtlake01/aramis/users/ravi.hassanaly/datasets/mini_adni_bids/
CAPS=/network/lustre/dtlake01/aramis/users/ravi.hassanaly/datasets/mini_adni_caps/

clinica run t1-linear BIDS CAPS