program CoarrayTest
    implicit none

    integer(4) one[*]

    Integer(4) :: i, rank = 0
    Integer(4) :: size = 0

    rank = this_image()
    size = num_images()

    one = rank*10

    if (rank == 1) then
        do i = 1, size
            write(*, '(i4)') one[i]
        end do
    end if

    ! write(*, '(i4)') one

    sync all

    stop
end program CoarrayTest
