module integrand
implicit none

     contains

     function f(x)
     implicit none
          
          real(8), intent(in), dimension(:) :: x
          real(8), dimension(size(x)) :: f

          integer(4) :: i ! Вспомогательная переменная
     
          do i = 1, size(x)

               f(i) = (x(i) + 1d0) * dsin(x(i))

          enddo
          
     end function f
     
end module integrand