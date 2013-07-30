      SUBROUTINE SQRT_TEST(A, B, N) BIND(c, name='f_sqrt_test_1d')
      USE ISO_C_BINDING, ONLY: C_FLOAT, C_INT
      INTEGER(C_INT), INTENT(IN), VALUE :: N
      REAL(C_FLOAT), INTENT(IN) :: A(N)
      REAL(C_FLOAT), INTENT(OUT) :: B(N)

      B = SQRT(A)

      END SUBROUTINE


      SUBROUTINE SQRT_TEST(A, B, M, N) BIND(c, name='f_sqrt_test_2d')
      USE ISO_C_BINDING, ONLY: C_FLOAT, C_INT
      INTEGER(C_INT), INTENT(IN), VALUE :: M
      INTEGER(C_INT), INTENT(IN), VALUE :: N
      REAL(C_FLOAT), INTENT(IN) :: A(M, N)
      REAL(C_FLOAT), INTENT(OUT) :: B(M, N)

      B = SQRT(A)

      END SUBROUTINE


      SUBROUTINE SQRT_TEST(A, B, K, M, N) BIND(c, name='f_sqrt_test_3d')
      USE ISO_C_BINDING, ONLY: C_FLOAT, C_INT
      INTEGER(C_INT), INTENT(IN), VALUE :: K
      INTEGER(C_INT), INTENT(IN), VALUE :: M
      INTEGER(C_INT), INTENT(IN), VALUE :: N
      REAL(C_FLOAT), INTENT(IN) :: A(K, M, N)
      REAL(C_FLOAT), INTENT(OUT) :: B(K, M, N)

      B = SQRT(A)

      END SUBROUTINE
