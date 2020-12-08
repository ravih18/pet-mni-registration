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

BIDS=/network/lustre/dtlake01/aramis/users/ravi.hassanaly/datasets/mini_adni_bids/
A=${BIDS}sub-ADNI029S1384/ses-M00/pet/sub-ADNI029S1384_ses-M00_task-rest_acq-fdg_pet.nii.gz
B=${BIDS}sub-ADNI029S1384/ses-M00/anat/sub-ADNI029S1384_ses-M00_T1w.nii.gz
OUTPUT=/network/lustre/dtlake01/aramis/users/ravi.hassanaly/datasets/pet-linear/

echo fixed image MRI $B
echo moving image PET $A

antsRegistrationSyNQuick.sh -d 3 -f $B -m $A -o ${OUTPUT}RegPET2MRI 
echo "RegA2B registration done"

antsApplyTransforms -d 3 -i $A -o ${OUTPUT}normal/PETDeformed.nii.gz -r $B -t ${OUTPUT}normal/RegPET2MRI1Warp.nii.gz -t ${OUTPUT}RegPET2MRI0GenericAffine.mat
echo "First transformation done"
antsApplyTransforms -d 3 -i $B -o ${OUTPUT}inverse/MRIDeformed.nii.gz -r $A -t [${OUTPUT}inverse/RegPET2MRI0GenericAffine.mat,1] -t ${OUTPUT}RegPET2MRI1InverseWarp.nii.gz
echo "Second transformation done"