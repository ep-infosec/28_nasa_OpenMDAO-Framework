CCPA
C     CALCULATE SPECIFIC HEAT RATIO FOR AIR
      SUBROUTINE CPA(P,T,F,W,CPAX)
      DIMENSION XT(7)
C     IF(T-100.)1,2,2
C     replaced by ..........
      IF(T.LT. 100.) THEN 
        TX = 100.
        GO TO 5
C       GO TO 1
      ELSE
        GO TO 2
      ENDIF
1     TX=100.
      GO TO 5
C 2     IF(6400.-T)3,4,4
C     replaced by ..........
2     IF(T.GT.6400.) THEN
        TX = 6400.
      ELSE
        TX = T
      ENDIF
C
5     XT(1)=TX/1000.
      DO 6 I=2,7
6     XT(I)=XT(I-1)*XT(1)
      CPAX=2.4264907E-01-2.6657395E-02*XT(1)+4.6617756E-02*XT(2)
     1-1.3546542E-02*XT(3)-8.4500931E-04*XT(4)+1.0303393E-03*
     2XT(5)-1.7159795E-04*XT(6)+9.1627911E-06*XT(7)
      RETURN
      END
