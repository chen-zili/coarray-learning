# ifort -coarray=distributed -coarray-num-images=3 main.F90 -o main.out

ifort -coarray -coarray-num-images=16 main.F90 -o main.out
