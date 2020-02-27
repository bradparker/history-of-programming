      PROGRAM Fibonacci
      INTEGER FIRST, SECOND, TEMP, IX
      FIRST = 0
      SECOND = 1
      WRITE (*,*) FIRST
      WRITE (*,*) SECOND
      DO 10 IX = 1, 5, 1
         TEMP = FIRST + SECOND
         FIRST = SECOND
         SECOND = TEMP
         WRITE (*,*) TEMP
10    CONTINUE
      STOP
      END
