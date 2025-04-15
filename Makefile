FC := nvfortran
FFLAGS := -Wall -Mfree -acc -Minfo=acc -lnvhpcwrapnvtx -Wl,-znoexecstack

FILES=1_basic 2_basic_without_kernels 3_host_work 4_host_work_async 5_nvtx
FILES_MPI=6_mpi
PROF=$(addprefix prof-, $(FILES))
PROF_MPI=$(addprefix prof-, $(FILES_MPI))
NPROC=2

all: $(FILES) $(FILES_MPI)

$(FILES): %: src/%.f90
	$(FC) $(FFLAGS) $^ -o $@

$(FILES_MPI): %: src/%.f90
	mpif90 $(FFLAGS) $^ -o $@

$(PROF): prof-%: %
	@mkdir -p reports
	nsys profile --trace cuda,openacc,osrt,nvtx -f true -o reports/report$< ./$<

$(PROF_MPI): prof-%: %
	@mkdir -p reports
	nsys profile --trace cuda,openacc,mpi,ucx,osrt,nvtx -f true -o reports/report$< mpirun --oversubscribe -n $(NPROC) bin/mpiwrapper.sh ./$<

prof-all: $(PROF)

clean:
	@rm -f $(FILES) $(FILES_MPI) src/*.o

