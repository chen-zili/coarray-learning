program CoarrayTest
    implicit none

    integer(4) one[*]               ! co-array数组

    Integer(4) :: i, rank = 0
    Integer(4) :: size = 0

    rank = this_image()             ! image索引
    size = num_images()             ! image数量

    one = rank*10

    if (rank == 1) then             ! IO只在第一个image
        do i = 1, size
            write(*, '(i4)') one[i]
        end do
    end if

    ! write(*, '(i4)') one

    sync all                        ! 可以理解为阻挡物，知道所有image达到这里

    stop
end program CoarrayTest
