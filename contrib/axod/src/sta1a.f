CSTA1A
C           SUBROUTINE STA1A
      SUBROUTINE STA1A
C
      REAL MFSTOP
      LOGICAL PREVER
      COMMON /SNTCP/G,AJ,PRPC,ICASE,PREVER,MFSTOP,JUMP,LOPIN,ISCASE,
     1 K,GAMF,IP,SCRIT,PTRN,ISECT,KSTG,WTOL,RHOTOL,PRTOL,TRLOOP,LSTG,
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
     5R(6,8),ETAR(6,8),CFR(6,8),TFR(6,8),ANDOR(6,8),OMEGAS(6,8),AS0(6,8)
     6,ASMP0(6,8),ACMN0(6,8),A1(6,8),A2(6,8),A3(6,8),A4(6,8),A5(6,8),A6(
     76,8),OMEGAR(6,8),BSIA(6,8),BSMPIA(6,8),BCMNIA(6,8),B1(6,8),B2(6,8)
     8,B3(6,8),B4(6,8),B5(6,8),B6(6,8),SESTHI(8),RERTHI(8)
     9,fairx(5,8),wairx(5,8),rg1(8),rg1a(8),rg2(8),rg2a(8)
C
      REAL M0
      COMMON /SSTA01/CP0(8),w0(6),               PS0(6,8),V0(6,8),TS0(6,
     18),VU0(6,8),VZ0(6,8),RHOS0(6,8),PS1(6,8),WGT1(8),TA1(8),WG1(6,8),
     2            DPDR1(6,8),SI(6,8),  CP1(8),PHI1(6,8),TS1(6,8),V1(6,8)
     3,RHOS1(6,8),ALF1E(6,8),VU1(6,8),VZ1(6,8),M0(6,8)
      REAL MR1A
      COMMON /SSTA1A/VU1A(6,8),WG1A(6,8),WGT1A(8),VZ1A(6,8),  CP1A(8),
     1PS1A(6,8),RU1A(6,8),R1A(6,8),BET1A(6,8),RI(6,8),TTR1A(6,8),PTR1A(6
     2,8),MR1A(6,8)
      COMMON/RPMCOM/RPMK(8)
      COMMON/DESOPT/RVU1(6,8),RVU2(6,8),WG,EPR
      COMMON/TPT1/PT1(6),TT1(6,8)
      COMMON /TDIL/TWG (6,8),pwg(6,8)
      COMMON/T1A/TT1A(6,8)
C        DETERMINE FLOW CONDITIONS RELATIVE TO ROTOR,  FIND INCIDENCE
C         ANGLE RECOVERY ROTOR INLET STATIONS,  OBTAIN GAS PROPERTIES,
C         ABSOLUTE TANGENTIAL COMPONENT VELOCITY ADJUSTED FOR DIAMETER
C         CHANGE TO CONSERVE ANGULAR MOMENTUM,  AXIAL COMPONENT
C         VELOCITY ADJUSTED FOR WEIGHT FLOW, AREA,, AND DENSITY CHANGE
C         FROM STA  1.
C
C
      TWGF=0.
      IF(TWG(3,K).GT.0.) TWGF=1.
      I=IP
      ID=-1
      TS1A     =TS1(I,K)
C        RATIO OF FLOW CHANGE
      WR=RWG(3,K)/RWG(2,K)
C        TOTAL STATION FLOW
      WGT1A(K)=WR*WGT1(K)
C        ADJUST TANGENTIAL VELOCITY
13    VU1A(I,K)=VU1(I,K)*DP1(I,K)/DP1A(I,K)
      TT1A(I,K)=TT1(I,K)
      if (twgf.gt.0.0) then
        ttm=(tt1(i,k)+(wr-1.)*twg(3,k))/wr
        tpp=(ttm+tt1(i,k))/2.
        tpc=(ttm+twg(3,k))/2.
        call cpa(pt0(i,k),tpc,0.0,0.0,cpc)
        call gama(pt0(i,k),tpp,fairx(2,k),wairx(2,k),gamtpp)
        extpp=gamtpp/(gamtpp-1.)
        cpp=rg1(k)*extpp/aj
        tt1a(i,k)=(cpp*tt1(i,k)+(wr-1.)*cpc*twg(3,k))/(cpp+(wr-1.)*cpc)
      end if
C        ADJUST FLOW
      WG1A(I,K)=WR*WG1(I,K)
      RHOSTR=RHOS1(I,K)
C        ADJUST AXIAL VELOCITY
1     VZ1A(I,K)=WR*VZ1(I,K)*ANN1(I,K)*RHOS1(I,K)/(ANN1A(I,K)
     1*RHOSTR)
      V1A     =SQRT(VU1A(I,K)*VU1A(I,K)+VZ1A(I,K)*VZ1A(I,K))
C     IF(I-IP)2,3,2
C     replaced by
      IF(I.NE.IP) THEN
         GO TO 2                           
      ELSE
         GO TO 3
      ENDIF
2     EX=(GAM(3,K)-1.)/GAM(3,K)
      EXI=1./EX
      GO TO 4
C3     IF(GAMF)12,12,2
C     replaced by
3     IF(GAMF.LE.0.) THEN
         GO TO 12                           
      ELSE
         GO TO 2
      ENDIF
12    TA1A=.5*(TT1A(I,K)+TS1A)
      CALL GAMA(PT0(I,K),TA1A   ,FAIRx(3,k),WAIRx(3,k),GAM(3,K))
      EX=(GAM(3,K)-1.)/GAM(3,K)
      EXI=1./EX
4     CP1A(K)=rg1a(k)*EXI/AJ
      DELTS=(V1(I,K)*V1(I,K)-V1A     *V1A     )/(2.*G*AJ*CP1A(K))
      TS1A=TS1(I,K)+DELTS+TT1A(I,K)-TT1(I,K)
      PS1A(I,K)=PS1(I,K)*(TT1(I,K)*TS1A/TT1A(I,K)/TS1(I,K))**EXI
      RHOS1A     =144.*PS1A(I,K)/(rg1a(k)*TS1A     )
C        DENSITY ERROR
      RHOE=(RHOS1A     -RHOSTR)/RHOS1A
C     IF (ABS(RHOE)-RHOTOL)6,6,5
C     replaced by ...............
      IF((ABS(RHOE)-RHOTOL).LE.0.) THEN
         GO TO 6                         
      ELSE
         GO TO 5
      ENDIF
5     RHOSTR=RHOS1A
      GO TO 1
6     RU1A(I,K)=VU1A(I,K)-U1A(I,K)
      R1A(I,K)=SQRT(RU1A(I,K)*RU1A(I,K)+VZ1A(I,K)*VZ1A(I,K))
      SBET1A     =RU1A(I,K)/R1A(I,K)
      BET1A(I,K)=ATAN2(SBET1A     ,SQRT(1.-SBET1A     *SBET1A     ))
      IF(RVU1(I,K).NE.0.) RADRD(I,K)=BET1A(I,K)
C     IF(OMEGAR(I,K))8,8,7
C     replaced by ...............
      IF(OMEGAR(I,K).LE.0.) THEN
         GO TO 8                   
      ELSE
         GO TO 7
      ENDIF
7     ETARR(I,K)=1.
      EXPRE=0.0
8     MR1A(I,K)=R1A(I,K)/SQRT(GAM(3,K)*G*rg1a(k)*TS1A     )
      TRTS1A     =1.+(GAM(3,K)-1.)*MR1A(I,K)*MR1A(I,K)/2.
      IF(TRTS1A.GT.1.) GO TO 32
      PREVER = .TRUE.
      GO TO 17
32    TTR1A(I,K)=TS1A     *TRTS1A
      RI(I,K)=BET1A(I,K)-RADRD(I,K)
      IF(RI(I,K).GT.1.5707) RI(I,K)=1.5707
      IF(RI(I,K).LT.(-1.5707)) RI(I,K)=(-1.5707)
C     IF(RI(I,K))9,9,10
C     replaced by ...............
      IF(RI(I,K).LE.0.) THEN
         GO TO 9                   
      ELSE
         GO TO 10
      ENDIF
9     EXPR=EXPN
      GO TO 11
10    EXPR=EXPP
11    PRPS1A     =(1.+(TRTS1A     -1.)*ETARR(I,K)*(COS(RI(I,K))**
     1EXPR))**EXI
      PTR1A(I,K)=PS1A(I,K)*PRPS1A
C     IF (ISECT-I)14,16,14
C     replaced by ...............
      IF((ISECT-I).NE.0) THEN
         GO TO 14                  
      ELSE
         GO TO 16
      ENDIF
14    I=I+ID
C     IF (I)15,15,13
C     replaced by ...............
      IF(I.LE.0) THEN
         GO TO 15                  
      ELSE
         GO TO 13
      ENDIF
15    ID=1
      I=IP+ID
      GO TO 13
16    CONTINUE
      j=2
      GO TO (17,18),J
17    CALL DIAGT(3)
18    RETURN
      END
