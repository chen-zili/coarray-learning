program main
	implicit none

	! 圆周率估计，测试并行速度
	integer(4) :: counts[*] = 0							! 落在圆内的粒子的数量
	integer(4) :: pointNumber = 2**24					! 单个image中粒子总数
	integer(4) :: time_start, time_end
	integer(4) :: rank = 0, size = 0, i
	real(8) :: Rx = 0.d0, Ry = 0.d0, allcount = 0.d0

    rank = this_image()
    size = num_images()

	if (rank == 1) then									! 计时开始
		call system_clock(time_start)
	end if

	call random_seed ()									! 随机数种子

	do i = 1, pointNumber
		Call random_number(Rx)
		Call random_number(Ry)

		if (Rx**2 + Ry**2 < 1.d0) then					! 随机生成粒子是否落在圆内
			counts = counts + 1
		end if
	end do

	sync all											! 等待所有image运行完

	if (rank == 1) then
		do i = 1, size
			allcount = allcount + dble(counts[i])		! 累积所有image的结果
		end do

		write(*, '(a, f10.4)') "Pi: ", allcount / (dble(pointNumber) * dble(size)) * 4.d0

		call system_clock(time_end)						! 计时结束

		write(*, '(a, f10.4)') "Time (s): ", dble(time_end-time_start) / 1000.d0

	end if

	stop
end program main
