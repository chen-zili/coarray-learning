program CoarrayTest
    implicit none

    integer(4), allocatable :: one(:) [:]       ! co-array可以是动态

    Integer(4) :: i, rank = 0
    Integer(4) :: size = 0

    rank = this_image()
    size = num_images()

    if (rank == 1) then                         ! 不同image的尺寸可以不同
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
