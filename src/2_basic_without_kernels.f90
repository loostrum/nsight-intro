program main
    implicit none
    integer, allocatable :: a(:), b(:)
    integer, parameter :: N=4096, repeats=1000
    integer :: i, ii

    allocate(a(N), b(N))
    a = 1
    !$acc enter data copyin(a) create(b)

    !$acc parallel loop default(present)
    do i=1,N*repeats
      ii = mod(i-1, N) + 1
      b(ii) = a(ii)
    end do

    !$acc exit data delete(a) copyout(b)

    print*,b(1),b(N)
    

end program main
