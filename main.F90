program main
	implicit none

	! 圆周率估计，测试并行速度
	integer(4) :: counts[*] = 0
	integer(4) :: pointNumber = 2**24
	integer(4) :: time_start, time_end
	integer(4) :: rank = 0, size = 0, i
	real(8) :: Rx = 0.d0, Ry = 0.d0, allcount = 0.d0

    rank = this_image()
    size = num_images()

	if (rank == 1) then
		call system_clock(time_start)
	end if

	call random_seed ()

	do i = 1, pointNumber
		Call random_number(Rx)
		Call random_number(Ry)

		if (Rx**2 + Ry**2 < 1.d0) then
			counts = counts + 1
		end if
	end do

	sync all

	if (rank == 1) then
		do i = 1, size
			allcount = allcount + dble(counts[i])
		end do

		write(*, '(a, f10.4)') "Pi: ", allcount / (dble(pointNumber) * dble(size)) * 4.d0

		call system_clock(time_end)

		write(*, '(a, f10.4)') "Time (s): ", dble(time_end-time_start) / 1000.d0

	end if

	stop
end program main
