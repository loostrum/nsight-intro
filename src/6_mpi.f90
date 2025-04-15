program main
    use mpi
    implicit none
    integer, allocatable :: a(:)
    integer, parameter :: tag=10
    integer, parameter :: N=1024*1024*1024
    integer :: i

    integer :: mpierr, rank, nproc
    integer :: mpistatus(MPI_STATUS_SIZE)

    call MPI_INIT(mpierr)
    call MPI_COMM_RANK(MPI_COMM_WORLD,rank,mpierr)
    call MPI_COMM_SIZE(MPI_COMM_WORLD,nproc,mpierr)
    if (nproc /= 2) then
        if (rank == 0) then
            print*,"This program should be run with exactly 2 MPI ranks"
        end if
        call MPI_FINALIZE(mpierr)
        call exit(1)
    end if

    allocate(a(N))
    !$acc enter data create(a)

    if (rank == 0) then
        !$acc parallel loop default(present)
        do i=1,N
            a(i) = 1
        end do
    end if

    !$acc host_data use_device(a)
    if (rank == 0) then
        call MPI_Send(a, N, MPI_INT, 1, tag, MPI_COMM_WORLD, mpierr)
    else if (rank == 1) then
        call MPI_Recv(a, N, MPI_INT, 0, tag, MPI_COMM_WORLD, mpistatus, mpierr)
    end if
    !$acc end host_data

    !$acc parallel loop default(present)
    do i=1,N
        a(i) = a(i) + rank
    end do

    !$acc exit data copyout(a)
    call MPI_FINALIZE(mpierr)
    

end program main
