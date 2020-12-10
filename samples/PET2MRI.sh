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

INPUT=/network/lustre/dtlake01/aramis/users/ravi.hassanaly/datasets/mini_adni_bids/
PET=sub-ADNI029S1384/ses-M00/pet/sub-ADNI029S1384_ses-M00_task-rest_acq-fdg_pet
MRI=sub-ADNI029S1384/ses-M00/anat/sub-ADNI029S1384_ses-M00_T1w
OUTPUT=/network/lustre/dtlake01/aramis/users/ravi.hassanaly/datasets/pet-linear/
RPET=RegisteredPET
TRANSFORM=RegPET2MRI

antsRegistrationSyNQuick.sh -d $dim -t 'r' -f ${INPUT}${MRI}.nii.gz -m ${INPUT}${PET}.nii.gz -o ${OUTPUT}${TRANSFORM}

antsApplyTransforms -d 3 -i ${INPUT}${PET}.nii.gz -o ${OUTPUT}${RPET}.nii.gz -r ${INPUT}${MRI}.nii.gz -t ${OUTPUT}${TRANSFORM}1Warp.ni
