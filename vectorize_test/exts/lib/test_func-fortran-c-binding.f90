      SUBROUTINE SQRT_TEST_1D(A, B, N) BIND(c, name='f_sqrt_test_1d')
      USE ISO_C_BINDING, ONLY: C_FLOAT, C_INT
      INTEGER(C_INT), INTENT(IN), VALUE :: N
      REAL(C_FLOAT), INTENT(IN) :: A(N)
      REAL(C_FLOAT), INTENT(OUT) :: B(N)

      B = SQRT(A)

      END SUBROUTINE


      SUBROUTINE SQRT_TEST_2D(A, B, M, N) BIND(c, name='f_sqrt_test_2d')
      USE ISO_C_BINDING, ONLY: C_FLOAT, C_INT
      INTEGER(C_INT), INTENT(IN), VALUE :: M
      INTEGER(C_INT), INTENT(IN), VALUE :: N
      REAL(C_FLOAT), INTENT(IN) :: A(M, N)
      REAL(C_FLOAT), INTENT(OUT) :: B(M, N)

      B = SQRT(A)

      END SUBROUTINE


      SUBROUTINE SQRT_TEST_3D(A, B, K, M,&
      N) BIND(c, name='f_sqrt_test_3d')
      USE ISO_C_BINDING, ONLY: C_FLOAT, C_INT
      INTEGER(C_INT), INTENT(IN), VALUE :: K
      INTEGER(C_INT), INTENT(IN), VALUE :: M
      INTEGER(C_INT), INTENT(IN), VALUE :: N
      REAL(C_FLOAT), INTENT(IN) :: A(K, M, N)
      REAL(C_FLOAT), INTENT(OUT) :: B(K, M, N)

      B = SQRT(A)

      END SUBROUTINE

      SUBROUTINE STAR_PLUS_FROM_ELEMENTS(NET_BLOCK_COUNTS, &
      NET_ELEMENTS, NET_COSTS, NET_COUNT, BETA) &
      BIND(c, name='f_star_plus_from_elements')
      USE ISO_C_BINDING, ONLY: C_FLOAT, C_INT
      INTEGER(C_INT), INTENT(IN), VALUE :: NET_COUNT
      INTEGER(C_INT), INTENT(IN) :: NET_BLOCK_COUNTS(NET_COUNT)
      REAL(C_FLOAT), INTENT(IN), VALUE :: BETA
      REAL(C_FLOAT), INTENT(IN) :: NET_ELEMENTS(NET_COUNT, 2, 2)
      REAL(C_FLOAT), INTENT(OUT) :: NET_COSTS(NET_COUNT, 2)

      ! Here, `i` is the dimension index.  It is required since
      ! `NET_BLOCK_COUNTS` has one less dimension than the
      ! `NET_ELEMENTS` array.
      DO i=1,2
      NET_COSTS(:, i) = NET_ELEMENTS(:, 2, i) + BETA &
                        - (NET_ELEMENTS(:, 1, i) &
                           * NET_ELEMENTS(:, 1, i)) &
                          / NET_BLOCK_COUNTS
      ENDDO
      END SUBROUTINE

      SUBROUTINE STAR_PLUS_FROM_ELEMENTS_SINGLE_K(NET_BLOCK_COUNT, &
      NET_ELEMENTS, NET_COSTS, NET_COUNT, BETA) &
      BIND(c, name='f_star_plus_from_elements_single_k')
      USE ISO_C_BINDING, ONLY: C_FLOAT, C_INT
      INTEGER(C_INT), INTENT(IN), VALUE :: NET_BLOCK_COUNT
      INTEGER(C_INT), INTENT(IN), VALUE :: NET_COUNT
      REAL(C_FLOAT), INTENT(IN), VALUE :: BETA
      REAL(C_FLOAT), INTENT(IN) :: NET_ELEMENTS(NET_COUNT, 2, 2)
      REAL(C_FLOAT), INTENT(OUT) :: NET_COSTS(NET_COUNT, 2)

      NET_COSTS(:, :) = SQRT(NET_ELEMENTS(:, 2, :) + BETA &
                        - (NET_ELEMENTS(:, 1, :) &
                           * NET_ELEMENTS(:, 1, :)) &
                          / NET_BLOCK_COUNT)
      END SUBROUTINE
