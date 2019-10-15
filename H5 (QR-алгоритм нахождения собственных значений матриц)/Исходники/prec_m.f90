module prec_m ! Модуль с параметрами, указывающими точность типов чисел, 
              ! используемых в программе, а также соответствующие форматы
implicit none

     private
     public :: CP, & ! Точность комплексных чисел, используемых в программе
             & RP, & ! Точность вещественных чисел, используемых в программе
             & IP, & ! Точность целых чисел, используемых в программе
             & RF, & ! Формат вывода вещественных чисел
             & SP, & ! Точность целого числа статусной переменной
             & UP, & ! Точность целого числа номера дескриптора файла
             & JP, & ! Точность целого числа счетчика
             & FP, & ! Число байт для хранения вспомогательной строки
             & LP    ! Число байт для хранения логической переменной

     ! Точность комплексных чисел, используемых в программе
     integer(1_1), parameter :: CP = kind(1.d0)

     ! Точность вещественных чисел, используемых в программе
     integer(1_1), parameter :: RP = kind(1.d0)

     ! Точность целых чисел, используемых в программе
     ! (не меньше, чем JP)
     integer(1_1), parameter :: IP = kind(1_4)

     ! Формат вывода вещественных чисел
     character(*), parameter :: RF = 'e22.15e2'

     ! Точность целого числа статусной переменной
     integer(1_1), parameter :: SP = kind(1_1)

     ! Точность целого числа номера дескриптора файла
     integer(1_1), parameter :: UP = kind(1_1)

     ! Точность целого числа счетчика (не рекомендуется к изменению)
     integer(1_1), parameter :: JP = kind(1_4)

     ! Число байт для хранения вспомогательной строки
     integer(1_1), parameter :: FP = 20_1

     ! Число байт для хранения логической переменной
     integer(1_1), parameter :: LP = 1

end module prec_m