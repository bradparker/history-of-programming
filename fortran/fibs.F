      PROGRAM Fibonacci
      INTEGER FIRST, SECOND, TEMP, IX
      FIRST = 0
      SECOND = 1
10    FORMAT (I1)
      WRITE (*,10) FIRST
      WRITE (*,10) SECOND
      DO 20 IX = 1, 5, 1
         TEMP = FIRST + SECOND
         FIRST = SECOND
         SECOND = TEMP
         WRITE (*,10) TEMP
20    CONTINUE
      STOP
      END
