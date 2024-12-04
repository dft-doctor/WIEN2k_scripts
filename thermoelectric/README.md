download from below link
https://owncloud.tuwien.ac.at/index.php/s/s2d55LYlZnioa3s
run following commands on terminal
 tar -xvf BoltzTraP.tar.bz2 (for extract)
 cd boltztrap-1.2.5/src 
 make 
**** before to run make command on terminal make sure to modify your makefile according to your compiler (gfortran or ifort). I have attached both makefiles below. just replace with original Makefile in src folder
** hope so BoltzTrap will be installed successfully 
  
(How to give path to .bashrc file) 
gedit ~/.bashrc
export PATH=$PATH:path_to_boltztrap-1.2.5/src
source ~/.bashrc
*Note: just replace this with your installed boltztrap path) 

(Run BoltzTraP on terminal) 
x_trans BoltzTraP 
x_trans BoltzTraP -dn (spin down)
x_trans BoltzTraP -up (spin up)
 
(scripts) 

trace.sh (for collecting information from trace file)
How to run (terminal) 
chmod +x trace.sh 
./trace.sh file_name

PF_ZT.sh (for power factor and figure of merit) 
How to run (terminal) 
chmod +x PF_ZT.sh 
./PF_ZT.sh file_name

temp.sh (for differnt temperatures)
How to run (terminal) 
chmod +x temp.sh 
./temp.sh file_name

