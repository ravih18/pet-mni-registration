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
MNI=${DATASET}pet-linear/mni-template/mni_icbm152_t1_tal_nlin_sym_09c.nii.gz
MRI=${DATASET}mini_adni_bids/sub-ADNI029S1384/ses-M00/anat/sub-ADNI029S1384_ses-M00_T1w.nii.gz
OUTPUT=${DATASET}pet-linear/MRI2MNI/RegisteredMRI.nii.gz
TRANSFORM=${DATASET}pet-linear/MRI2MNI/RegMRI2MNI

antsRegistrationSyNQuick.sh -d $dim -f $MNI -m $MRI -o $TRANSFORM

antsApplyTransforms -d $dim -i $MRI -o $OUTPUT -r $MNI -t ${TRANSFORM}1Warp.nii.gz -t ${TRANSFORM}0GenericAffine.mat