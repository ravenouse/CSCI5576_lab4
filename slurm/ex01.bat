#!/bin/bash

# -
# |
# | This is a batch script for running a MPI parallel job on Summit
# |
# | (o) To submit this job, enter:  sbatch --export=CODE='/home/scru5660/HPSC/codes/fd_mpi/src' ex_01.bat 
# |
# | (o) To check the status of this job, enter: squeue -u <username>
# |
# -

# -
# |
# | Part 1: Directives
# |
# -

#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --time=00:05:00
#SBATCH --partition=shas-testing
#SBATCH --output=ex01-%j.out

# -
# |
# | Part 2: Loading software
# |
# -

module purge
module load intel
module load impi 

rm *.pdf
rm tmp*
rm *.plt
rm 0 1 2 3
rm 0.sed 1.sed 2.sed 3.sed
rm vg
rm pc
rm pc_mesh
rm pc_phi
rm pc_ptcl

# -
# |
# | Part 3: User scripting
# |
# -

echo "=="
echo "||"
echo "|| Begin Execution of esPIC in slurm batch script."
echo "||"
echo "=="

mpirun -n 4 /projects/zhwa3087/CSCI5576/lab4/src/esPIC ./esPIC -nPEx 2 -nPEy 2 -nCellx 10 -nCelly 10 -nPtcl 50000 -flux 200 -tEnd 2 -dt 0.01 -tPlot .2 > tty.out

echo "=="
echo "||"
echo "|| Execution of esPIC in slurm batch script complete."
echo "||"
echo "=="

grep 'myPE: 0' tty.out > 0.sed  ; sed s/'myPE: 0'/''/g 0.sed > 0
grep 'myPE: 1' tty.out > 1.sed  ; sed s/'myPE: 1'/''/g 1.sed > 1
grep 'myPE: 2' tty.out > 2.sed  ; sed s/'myPE: 2'/''/g 2.sed > 2
grep 'myPE: 3' tty.out > 3.sed  ; sed s/'myPE: 3'/''/g 3.sed > 3


./writePlotCmd.py








