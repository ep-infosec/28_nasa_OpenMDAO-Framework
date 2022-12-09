C     COMPILER (DATA=IBM)
CLOSS1
C
C     CALCULATE EFFICIENCY
      SUBROUTINE LOSS1(I,K,EX)
C
      REAL MFSTOP
      LOGICAL PREVER
      COMMON /SNTCP/G,AJ,PRPC,ICASE,PREVER,MFSTOP,JUMP,LOPIN,ISCASE,
     1KN,GAMF,IP,SCRIT,PTRN,ISECT,KSTG,WTOL,RHOTOL,PRTOL,TRLOOP,LSTG,
     2LBRC,IBRC,ICHOKE,ISORR,CHOKE,PT0PS1(6,8),PTRS2(6,8),TRDIAG,SC,RC,
     3DELPR,PASS,IPC,LOPC,ISS
C
      COMMON /SINIT/H1(6,8),H2(6,8),DP0(6,8),DP1(6,8),DP1A(6,8),DP2(6,8)
     1,DP2A(6,8),CSALF1(6,8),ALF1(6,8),CSBET2(6,8),BET2(6,8),RADSD(6,8),
     2RADRD(6,8),ANN1(6,8),ANN2(6,8),ANN2A(6,8),ANN1A(6,8),U1A(6,8),
     3U2(6,8),ANN0(6,8),PT0(6,8),TT0(6,8),ALPHA0(6,8),PTP(6,8)
C
      COMMON /SINPUT/
     1PTPS,PTIN,TTIN,WAIR,FAIR,DELC,DELL,DELA,AACS,VCTD,STG,SECT,EXPN,
     2EXPP,EXPRE,RG,RPM,PAF,SLI,STGCH,ENDJOB,XNAME(20),TITLE(20),
     3PCNH(6),GAM(6,8),DR(6,8),DT(6,8),RWG(6,8),ALPHAS(6,8),ALPHA1(6,8),
     4ETARS(6,8),ETAS(6,8),CFS(6,8),ANDO(6,8),BETA1(6,8),BETA2(6,8),ETAR
     5R(6,8),ETAR(6,8),CFR(6,8),TFR(6,8),ANDOR(6,8),OMEGAS(6,8),ASO(6,8)
     6,ASMPO(6,8),ACMNO(6,8),A1(6,8),A2(6,8),A3(6,8),A4(6,8),A5(6,8),A6(
     76,8),OMEGAR(6,8),BSIA(6,8),BSMPIA(6,8),BCMNIA(6,8),B1(6,8),B2(6,8)
     8,B3(6,8),B4(6,8),B5(6,8),B6(6,8),SESTHI(8),RERTHI(8)
     9,fairx(5,8),wairx(5,8),rg1(8),rg1a(8),rg2(8),rg2a(8)
C
      REAL M0
      COMMON /SSTA01/CP0(8),w0(6),               PS0(6,8),V0(6,8),TS0(6,
     18),VU0(6,8),VZ0(6,8),RHOS0(6,8),PS1(6,8),WGT1(8),TA1(8),WG1(6,8),
     2            DPDR1(6,8),SI(6,8),  CP1(8),PHI1(6,8),TS1(6,8),V1(6,8)
     3,RHOS1(6,8),ALF1E(6,8),VU1(6,8),VZ1(6,8),M0(6,8)
C
C
      EXPN=0.0
      EXPP=0.0
      ETARS(I,K)=1.0
      SI(I,K)=ALPHA0(I,K)- RADSD(I,K)
C     IF(SI(I,K))5,1,2
C     replaced by ...............
      IF(SI(I,K).LT.0.) THEN 
         GO TO 5
      ELSEIF(SI(I,K).EQ.0.) THEN
         GO TO 1
      ELSEIF(SI(I,K).GT.0.) THEN
         GO TO 2
      ENDIF
1     W01=OMEGAS(I,K)
      GO TO 9
2     AS=A1(I,K)
      AC=A2(I,K)
      AQ=A3(I,K)
C     IF(ASMPO(I,K)-SI(I,K))3,4,4
C     replaced by ...............
      IF((ASMPO(I,K)-SI(I,K)).LT.0.) THEN 
         GO TO 3
      ELSE
         GO TO 4
      ENDIF
3     WMWS=SI(I,K)/ASMPO(I,K)
      AR=ASMPO(I,K)/ASO(I,K)
      GO TO 8
4     WMWS=1.0
      AR=SI(I,K)/ASO(I,K)
      GO TO 8
5     AS=A4(I,K)
      AC=A5(I,K)
      AQ=A6(I,K)
C     IF(SI(I,K)-ACMNO(I,K))6,4,4
C     replaced by ...............
      IF((SI(I,K)-ACMNO(I,K)).LT.0.) THEN 
         GO TO 6
      ELSE
         GO TO 4
      ENDIF
6     WMWS=SI(I,K)/ACMNO(I,K)
      AR=ACMNO(I,K)/ASO(I,K)
8     W01=(1.+AR*AR*(AS+AR*(AC+AR*AQ)))*WMWS*OMEGAS(I,K)
9     ETAS(I,K)=(1.-(1./(PT0PS1(I,K)*(1.-W01)+W01))**EX)*PHI1(I,K)/
     1(PHI1(I,K)-1.)
      j=2
      RETURN
      END
