#!/bin/bash
#SBATCH --job-name=test_ANTs
#SBATCH --partition=normal
#SBATCH --time=01:00:00
#SBATCH --mem=4G
#SBATCH --cpus-per-task=4
#SBATCH --chdir=.
#SBATCH --output=logs/train_%j.log
#SBATCH --error=errors/train_%j.log

module load ANTs

dim=3

PET=/network/lustre/dtlake01/aramis/users/ravi.hassanaly/datasets/pet-linear/RegisteredPET.nii.gz
CAPS=/network/lustre/dtlake01/aramis/users/ravi.hassanaly/datasets/mini-adni-caps/subjects/sub-ADNI029S1384/ses-M00/t1_linear/
MRI=sub-ADNI029S1384_ses-M00_T1w_space-MNI152NLin2009cSym_res-1x1x1_T1w.nii.gz
RPET=/network/lustre/dtlake01/aramis/users/ravi.hassanaly/datasets/pet-linear/RegisteredPETMNI
TRANSFORM=RegPET2MRI

antsApplyTransforms -d 3 -i ${PET}.nii.gz -o ${RPET}.nii.gz -r ${CAPS}${MRI}.nii.gz -t ${CAPS}sub-ADNI029S1384_ses-M00_T1w_space-MNI152NLin2009cSym_res-1x1x1_affine.mat
