#!/bin/bash
#SBATCH --job-name=test_ANTs
#SBATCH --partition=normal
#SBATCH --time=02:00:00
#SBATCH --mem=4G
#SBATCH --cpus-per-task=4
#SBATCH --chdir=.
#SBATCH --output=logs/train_%j.log
#SBATCH --error=errors/train_%j.log


module load ANTs

A="/network/lustre/dtlake01/aramis/users/ravi.hassanaly/datasets/mini_adni_bids/sub-ADNI029S1384/ses-M00/pet/sub-ADNI029S1384_ses-M00_task-rest_acq-fdg_pet.nii.gz"
B="/network/lustre/dtlake01/aramis/users/ravi.hassanaly/datasets/mini_adni_bids/sub-ADNI029S1384/ses-M00/anat/sub-ADNI029S1384_ses-M00_T1w.nii.gz"

echo fixed image MRI $B
echo moving image PET $A

antsRegistrationSyNQuick.sh -d 3 -f $B -m $A -o RegA2B 
echo "RegA2B registration done"

antsApplyTransforms -d 3 -i $A -o ADeformed.nii.gz -r $B -t RegA2B1Warp.nii.gz -t RegA2B0GenericAffine.mat
echo "First transformation done"
antsApplyTransforms -d 3 -i $B -o BDeformed.nii.gz -r $A -t [RegA2B0GenericAffine.mat,1] -t RegA2B1InverseWarp.nii.gz
echo "Second transformation done"