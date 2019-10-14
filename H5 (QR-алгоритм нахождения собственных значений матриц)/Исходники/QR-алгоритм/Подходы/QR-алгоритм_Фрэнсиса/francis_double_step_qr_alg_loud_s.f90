submodule ( fqr_m ) francis_double_step_qr_alg_loud_s ! Подмодуль, содержащий процедуру,
                                                      ! реализующую QR-алгоритм Фрэнсиса
                                                      ! с двойным сдвигом
                                                      ! (с дополнительным выводом)
implicit none
     
     contains
     
     ! Процедура, реализующая QR-алгоритм Фрэнсиса с двойным сдвигом
     module procedure francis_double_step_qr_alg_loud

          real(RP), dimension(input%N, input%N) :: rmatrix ! Вещественная копия
                                                           ! матрицы Хессенберга
          
          real(RP), dimension(3_JP, 3_JP) :: PH ! Рефлектор
          real(RP), dimension(2_JP, 2_JP) :: PR ! Матрица вращения

          ! Вещественные части некоторых элементов матрицы
          real(RP) :: mqq, mpp, mpq, mqp, m11, m21, m12, m22, m23

          ! Вспомогательные переменные алгоритма
          integer(JP) :: p, q, k, r 
          real(RP) :: s, t, x, y, z

          real(RP) :: fqr_err ! Значение эпсилон для QR-алгоритма Фрэнсиса
                              ! с двойным сдвигом (условие сходимости)

          ! Вспомогательная строка для автоформатирования
          character(FP) :: f1

          write(*,'(/, 5x, a, /)') 'QR-алгоритм Фрэнсиса с двойным сдвигом'

          fqr_err = settings%get_fqr_err()
          
          associate ( matrix => input%matrix, & ! Матрица объекта
                    &      N => input%N       ) ! Число строк матрицы

               ! Запись числа N в строку
               write(f1, '(i2)') IP
               write(f1,'(i'//f1//')') N

               ! Копирование вещественной части матрицы Хессенберга
               rmatrix = real(matrix, kind = RP)

               ! Вывод матрицы на входе
               write(*,'(5x, a, /)') 'Вещественная часть матрицы Хессенберга:' 
               write(*,'('//f1//'(4x, '//RF//'))') rmatrix
               write(*,'()')

               ! Алгоритм Фрэнсиса по версии из
               ! Peter Arbenz — Lecture Notes on Solving Large Scale Eigenvalue Problems,
               ! стр. 82

               p = int(N, kind = JP)

               do while ( p .gt. 2_JP )

                    q = p - 1_JP

                    m11 = rmatrix(1_JP, 1_JP)
                    m21 = rmatrix(2_JP, 1_JP)
                    m12 = rmatrix(1_JP, 2_JP)
                    m22 = rmatrix(2_JP, 2_JP)
                    m23 = rmatrix(2_JP, 3_JP)

                    mqq = rmatrix(q, q)
                    mpp = rmatrix(p, p)
                    mpq = rmatrix(p, q)
                    mqp = rmatrix(q, p)

                    s = mqq + mpp
                    t = mqq * mpp - mpq * mqp

                    x = m11 ** 2._RP + m21 * m12 - s * m11 + t
                    y = m12 * (m11 + m22 - s)
                    z = m12 * m23

                    do k = 0_JP, p - 3_JP

                         PH = determine_the_reflector([x, y, z])

                         r = max(1_JP, k)

                         rmatrix(r:n, k + 1_JP:k + 3_JP) = matmul(rmatrix(r:n, k + 1_JP:k + 3_JP), transpose(PH))

                         r = min(k + 4_JP, p)

                         rmatrix(k + 1_JP:k + 3_JP, 1_JP:r) = matmul(PH, rmatrix(k + 1_JP:k + 3_JP, 1_JP:r))

                         x = rmatrix(k + 1_JP, k + 2_JP)
                         y = rmatrix(k + 1_JP, k + 3_JP)

                         if ( k .lt. p - 3_JP ) then

                              z = rmatrix(k + 1_JP, k + 4_JP)

                         endif

                    enddo

                    PR = get_givens_rotation_matrix(x, y)

                    rmatrix(p - 2_JP:N, q:p) = matmul( rmatrix(p - 2_JP:N, q:p), transpose(PR) )
                    rmatrix(p - 1_JP:p, 1_JP:p) = matmul( PR, rmatrix(p - 1_JP:p, 1_JP:p) )

                    if ( abs(rmatrix(q, p)) .lt. ( fqr_err * ( abs(rmatrix(q, q)) + abs(rmatrix(p, p)) ) ) ) then

                         rmatrix(q, p) = 0._RP
                         p = p - 1_JP
                         q = p - 1_JP

                    elseif ( abs(rmatrix(q - 1_JP, p - 1_JP)) .lt. fqr_err * ( abs(rmatrix(q - 1_JP, q - 1_JP)) + abs(rmatrix(q, q)) ) ) then

                         rmatrix(q - 1_JP, p - 1_JP) = 0._RP
                         p = p - 2_JP
                         q = p - 1_JP

                    endif

               enddo

               ! Вывод результата
               write(*,'(5x, a, /)') 'Результат выполнения QR-алгоритма Фрэнсиса:' 
               write(*,'('//f1//'(4x, '//RF//'))') rmatrix
               write(*,'()')

               ! Вызов процедуры, выполняющей поиск собственных чисел
               ! и решение блоков в квазитреугольной вещественной матрице
               call solve_blocks_and_find_eigenvalues_loud(rmatrix, result)

          end associate
          
     end procedure francis_double_step_qr_alg_loud
     
end submodule francis_double_step_qr_alg_loud_s