program main
    implicit none
    integer, allocatable :: a(:), b(:)
    integer, parameter :: N=4096, repeats=1000
    integer :: i

    allocate(a(N), b(N))
    a = 1

    !$acc kernels
    do i=1,N*repeats
      b = a
    end do
    !$acc end kernels

    print*,b(1),b(N)
    

end program main
