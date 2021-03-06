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

DATASET=/network/lustre/dtlake01/aramis/users/ravi.hassanaly/datasets/
PET=${DATASET}mini_adni_bids/sub-ADNI029S1384/ses-M00/pet/sub-ADNI029S1384_ses-M00_task-rest_acq-fdg_pet.nii.gz
MRI=${DATASET}mini_adni_bids/sub-ADNI029S1384/ses-M00/anat/sub-ADNI029S1384_ses-M00_T1w.nii.gz
OUTPUT=RegisteredPET
TRANSFORM=${DATASET}pet-linear/PET2MRI/RegPET2MRI

antsRegistrationSyNQuick.sh -d $dim -t 'r' -f $MRI -m $PET -o $TRANSFORM

antsApplyTransforms -d $dim -i $PET -o ${TRANSFORM}${OUTPUT}.nii.gz -r $MRI -t ${TRANSFORM}Warped.nii.gz ${TRANSFORM}0GenericAffine.mat
