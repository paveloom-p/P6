module solve_bvp_shooting_m ! Модуль, содержащий процедуры, относящиеся
                            ! методу стрельбы для решения краевой задачи
use prec_m, only : RP, & ! Точность вещественных чисел, используемых в программе
                 & IP, & ! Точность целых чисел, используемых в программе
                 & JP    ! Точность целого числа счетчика и индекса
use input_m, only : input_type, & ! Тип входных данных
                  & p, q, f ! Соответствующие функции из условия задачи
use settings_m, only : settings_type ! Тип настроек программы
use result_m, only : result_type ! Тип результата
implicit none
     
     private
     public :: solve_bvp_shooting_choosing ! Процедура для выбора и вызова необходимой варьирующей процедуры
     
     interface
     
          ! Процедура для выбора и вызова необходимой варьирующей процедуры
          module impure subroutine solve_bvp_shooting_choosing(input, settings, LT, RT, result)
          implicit none
          
               type ( input_type ), intent(in) :: input ! Тип входных данных
               type ( settings_type ), intent(in) :: settings ! Тип настроек программы

               integer(IP), intent(in) :: LT ! Род граничного условия на левой границе
               integer(IP), intent(in) :: RT ! Род граничного условия на правой границе

               type ( result_type ), intent(inout) :: result ! Тип результата
          
          end subroutine solve_bvp_shooting_choosing

          ! Процедура для интегрирования задачи Коши 
          ! методом Рунге-Кутты четвёртого порядка
          module impure subroutine runge_kutta(input, result)
          implicit none

               type ( input_type ), intent(in) :: input ! Тип входных данных
               type ( result_type ), intent(inout) :: result ! Тип результата

          end subroutine runge_kutta

          ! Процедура для получение решения краевой задачи
          ! при граничном условии первого рода на левой границе
          ! и при граничном условии первого рода на правой границе
          ! (с дополнительным выводом)
          module impure subroutine solve_bvp_shooting_with_LB1_and_RB1_loud(input, result)
          implicit none

               type ( input_type ), intent(in) :: input ! Тип входных данных
               type ( result_type ), intent(inout) :: result ! Тип результата

          end subroutine solve_bvp_shooting_with_LB1_and_RB1_loud

     end interface
     
end module solve_bvp_shooting_m