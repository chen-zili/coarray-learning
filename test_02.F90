program CoarrayTest
    implicit none

    integer(4), allocatable :: one(:) [:]

    Integer(4) :: i, rank = 0
    Integer(4) :: size = 0

    rank = this_image()
    size = num_images()

    if (rank == 1) then
        allocate(one(2)[*])
    else
        allocate(one(3)[*])
    end if

    one = rank * 10

    write(*, *) one
    
    deallocate(one)
    sync all

    stop
end program CoarrayTest
