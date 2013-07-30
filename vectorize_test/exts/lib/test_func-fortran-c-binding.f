      SUBROUTINE SQRT_TEST(A, B, N) BIND(c, name='f_sqrt_test')
      USE ISO_C_BINDING, ONLY: C_FLOAT, C_INT
      INTEGER(C_INT), INTENT(IN), VALUE :: N
      REAL(C_FLOAT), INTENT(IN) :: A(N)
      REAL(C_FLOAT), INTENT(OUT) :: B(N)

      B = SQRT(A)

      END SUBROUTINE
