#include "miroc.h"

      SUBROUTINE LAKEPO(
     M                    HX,
     M                    TX,
     O                   HXD,
     I                  TAUX,   TAUY,   PTOP,
     I                    FT,  SWABS,     FS,   TS,
     I                HXMIN, LKFRAC  )

c --- information -----------------------------------------------------
c
c  HISTORY
c     '07.04.04  Tatsuo Suzuki
c
c ---------------------------------------------------------------------
#include        "zcdim.F"                /* # of grid point & wave */
#include        "zpdim.F"                /* physics etc.           */
#include        "zccom.F" /* TMELT */
#include        "zldim.F"                /* # of land grid point   */
*
*
      REAL*8      TX(IJLDIM, NLZDIM, NLTDIM),     HX(IJLDIM)       ! 水温、湖の深さ（水位でないことに注意）
      REAL*8              R(IJLDIM, NLZDIM),    AHV(IJLDIM, NLZDIM)　! 密度、　鉛直拡散系数
      REAL*8    TAUX(IJLDIM),   TAUY(IJLDIM),   PTOP(IJLDIM)        ! 湖面での風応力と気圧　（dummyです。使用していません。）
      REAL*8      FT(IJLDIM, NLTDIM), SWABS(IJLDIM),     FS(IJLDIM)　！一層目の水温時間変化、下向き短波　（１層目の水温変化には、短波の１層目の吸収分が含まれます。）
 ！     湖への正味の熱フラックスは　Ft * cpo + swabs - swabs*r (rは短波が１層目で吸収する割合）　FSは塩分フラックス（dummyです。湖では用いません）
      REAL*8      HXD(IJLDIM)   !! lake water deficiency
      REAL*8      HXMIN         !! lake depth minimum
      REAL*8     GXX(IJLDIM), GYY(IJLDIM)
      REAL*8      GX(IJLDIM, NLZDIM), GY(IJLDIM, NLZDIM)
      REAL*8      XX(IJLDIM, NLZDIM), YY(IJLDIM, NLZDIM)
      REAL*8     TMP(IJLDIM, NLZDIM, NLTDIM)
      REAL*8     HTMP
      REAL*8     TS
      REAL*8     LKFRAC( IJLDIM ) !! surface-type fraction (lake)
      INTEGER    IJ,    K,      N

      DO IJ = 1, IJLDIM
      DO N=1,NLTDIM
      TX(IJ, 1,N)=TX(IJ, KLSTR,N)
      TX(IJ, NLZDIM,N)=TX(IJ, KLEND,N)
      ENDDO
      ENDDO

         CALL VDIFFL (
     M                  AHV,
     I                    R,   TAUX,   TAUY,
     I                   TX,     HX)
         CALL FLXTRCL(
     O                  TMP,     XX,
     I                   TX,     HX,
     I                  AHV )
         CALL SLVTRCL(
     M                   TX,     HX,
     O                  HXD,
     I                  TMP,     XX, HXMIN,
     I                   FT,  SWABS,    FS,    TS, LKFRAC  )
         CALL OVTURNL(
     O                    R,
     M                   TX,
     I                   HX,     TS)
      RETURN
      END
C
      SUBROUTINE VDFSETL
      IMPLICIT NONE

c --- information -----------------------------------------------------
c
c  Setting vertical diffusion and viscosity coefficients
c
c  HISTORY
c    2007.04.04  Tatsuo Suzuki: from Ocean
c
c ---------------------------------------------------------------------
#include        "zcdim.F"                /* # of grid point & wave */
#include        "zpdim.F"                /* physics etc.           */
#include        "zccom.F" /* TMELT */
#include        "zldim.F"                /* # of land grid point   */
*
*
      INTEGER NZ
      PARAMETER( NZ = KLMAX )
      REAL*8       R(IJLDIM, NLZDIM), AHV(IJLDIM, NLZDIM)
      REAL*8    TAUX(IJLDIM),   TAUY(IJLDIM)
      REAL*8      TX(IJLDIM, NLZDIM, NLTDIM), HX(IJLDIM)
      INTEGER     IJ,      K
      INTEGER  IFPAR,  JFPAR

      REAL*8    AHVL0(NZ)
      SAVE      AHVL0
C
      NAMELIST /NMDFVLM/ AHVL0
      DATA AHVL0 / NZ*1.D+0 /　　　　　　　　　　　　　　!鉛直拡散のデフォルト値
C
      CALL REWNML(IFPAR, JFPAR)

      WRITE(JFPAR, *) '*** VDFSETLM ***'
      READ (IFPAR, NMDFVLM, END=97)
 97   WRITE(JFPAR, NMDFVLM)
      CALL REWNML(IFPAR, JFPAR)

      RETURN

c =====================================================================

      ENTRY VDIFFL(
     O               AHV,
     I                 R,   TAUX,   TAUY,
     I                TX,     HX)
      DO IJ = 1, IJLDIM
      DO K = KLSTR, KLEND
         AHV(IJ, K) = AHVL0(K-KLSTR+1)　　　　！湖の鉛直拡散係数です。デフォルト値で動きます
         （風応力や鉛直温度成層には依存に変更可能な余地はありますが現状ではデフォルト値です）
      ENDDO
      ENDDO

      RETURN
      END

      SUBROUTINE FTSETL
      IMPLICIT NONE

c --- information -----------------------------------------------------
c
c  Estimate the advection and diffusion terms of the tracer equations.
c
c  HISTORY
c    2007.04.04  Tatsuo Suzuki: from Ocean
c
c ---------------------------------------------------------------------
#include        "zcdim.F"                /* # of grid point & wave */
#include        "zpdim.F"                /* physics etc.           */
#include        "zccom.F" /* TMELT */
#include        "zldim.F"                /* # of land grid point   */
*
*
      INTEGER NZ
      PARAMETER( NZ = KLMAX )
      REAL*8     ADT(IJLDIM, NLZDIM, NLTDIM)
      REAL*8   DIFFZ(IJLDIM, NLZDIM)
      REAL*8      TX(IJLDIM, NLZDIM, NLTDIM)
      REAL*8      TY(IJLDIM, NLZDIM, NLTDIM)
      REAL*8      HX(IJLDIM)
      REAL*8     AHV(IJLDIM, NLZDIM)
      REAL*8   HZBOT(IJLDIM)

      INTEGER     IJ,      K,      N
      INTEGER  IFPAR,  JFPAR

      REAL*8    DZ(NLZDIM), DS(NLZDIM), DZ1, DS0(NZ-1)
      SAVE      DZ1, DZ, DS
C
      NAMELIST /NMDSL/ DZ1, DS0
      DATA DZ1 / 1.0D2 /                        ! cm
      DATA DS0 / 0.1, 0.1, 0.2, 0.6 /           ! ND　　
！　１層目の厚さが１mでそれ以下は湖の深さをDS0の比としています（これは湖の深さは場所により大きく違うので、
！　１層目の厚さのみ固定しているためです。　）
      
      CALL REWNML(IFPAR, JFPAR)
      WRITE(JFPAR, *) '*** FTSETL ***'
      READ (IFPAR, NMDSL, END=97)
 97   WRITE(JFPAR, NMDSL)
      CALL REWNML(IFPAR, JFPAR)
      DS(KLSTR)=0.0D0
      DO 100 K = KLSTR+1, KLEND
            DS(K) = DS0(K-KLSTR)
  100 CONTINUE
            DZ(KLSTR) = DZ1
      RETURN

c =====================================================================

      ENTRY FLXTRCL(
     O                ADT,  DIFFZ,
     I                 TX,     HX,
     I                AHV)
      DO 130 IJ = 1, IJLDIM
      DO 120 N = 1, NLTDIM　　　　　　　　　　！NLTDIMは湖のトレーサー数、現在のところ１しか使用しない。２より先は塩分などを想定）
         DO 110 K = 1, NLZDIM
               ADT(IJ, K, N) = 0.D0
  110      CONTINUE
  120 CONTINUE
  130 CONTINUE

      DO IJ = 1, IJLDIM
      DO K = 1, NLZDIM
            DIFFZ(IJ, K) = 0.D0
      END DO
      ENDDO

      DO IJ = 1, IJLDIM

      HZBOT(IJ) = HX(IJ) - DZ1
         DZ(KLSTR)=DZ1

      DO K=KLSTR+1, KLEND
         DZ(K)=HZBOT(IJ)*DS(K)
      ENDDO
C
      DO K = KLSTR+1, KLEND
         DIFFZ(IJ, K) = AHV(IJ, K) * 2.0D0 / (DZ(K-1) + DZ(K))
      END DO

      ENDDO


      DO 620 IJ = 1, IJLDIM
      DO 610 N = 1, NLTDIM
         DO 600 K = KLSTR, KLEND
              ADT(IJ, K, N) =
     &         ( DIFFZ(IJ, K  )*(TX(IJ, K-1, N)-TX(IJ, K, N))
     &          -DIFFZ(IJ, K+1)*(TX(IJ, K, N)-TX(IJ, K+1, N)))
C     &          / DZ(K)
！　鉛直拡散による熱変化を計算。
 500          CONTINUE
 600     CONTINUE
 610  CONTINUE
 620  CONTINUE

      RETURN
      END

      SUBROUTINE SVTSETL
      IMPLICIT NONE
c --- information -----------------------------------------------------
c
c  Time integration of the tracer equations.
c
c  HISTORY
c    2002.08.19  H.Hasumi: from COCO3.4
c    2002.09.27  H.Hasumi: for vector machines
c    2003.02.06  T.Suzuki: positive lake salinity
c
c ---------------------------------------------------------------------
#include        "zcdim.F"                /* # of grid point & wave */
#include        "zpdim.F"                /* physics etc.           */
#include        "zccom.F" /* TMELT */
#include        "zldim.F"                /* # of land grid point   */
*
*
      INTEGER NZ
      PARAMETER( NZ = KLMAX )
      REAL*8 rhoo, rhoi, rhos, hfus, emeltl, rrhfus
      PARAMETER ( emeltl = 3.4D+5 )   ! J/kg
      PARAMETER ( rhoo = 1.D0, rhoi = 0.9D0, rhos = 0.33D0 ) !g/cm3
      PARAMETER ( HFUS = emeltl * 1.D+4 )  ! erg/g
      PARAMETER ( RRHFUS = 1.D0 / rhoo / hfus )
      REAL*8 cpo, cpi
      PARAMETER ( cpo  = 3.990D+7, cpi  = 2.093D+7 ) ! erg/g/K
      REAL*8 dtds, dtdz
      PARAMETER ( dtds = -0.0543D0, dtdz = -7.59D-6 )

      REAL*8      TX(IJLDIM, NLZDIM, NLTDIM)
      REAL*8     ADT(IJLDIM, NLZDIM, NLTDIM)
      REAL*8      HX(IJLDIM)
      REAL*8      FT(IJLDIM, NLTDIM)
      REAL*8   SWABS(IJLDIM),     FS(IJLDIM)
      REAL*8   DIFFZ(IJLDIM, NLZDIM)
      REAL*8      TS
      REAL*8      HXD(IJLDIM), HXMIN
      REAL*8    LKFRAC( IJLDIM ) !! surface-type fraction (lake)

      REAL*8  SWCONV(IJLDIM, NLZDIM)
      SAVE SWCONV

      REAL*8      AA(IJLDIM, NLZDIM),     AB(IJLDIM, NLZDIM)
      REAL*8      AC(IJLDIM, NLZDIM)

      REAL*8      DH(IJLDIM),  HZBOT(IJLDIM),  HXBOT(IJLDIM)
      REAL*8     DZB(IJLDIM),    DZT(IJLDIM)
      REAL*8   RADUP,  RADDN,  DEPTH
      REAL*8  SWCNV1(NLZDIM), TSWCNV

      INTEGER     IJ,      K,      N
      INTEGER  IFPAR,  JFPAR

      REAL*8     RRR,  ZETA1,  ZETA2
      NAMELIST /NMSWAB/ RRR, ZETA1, ZETA2
      SAVE     RRR,  ZETA1,  ZETA2

      DATA RRR, ZETA1, ZETA2 / 5.8D-1, 3.5D+1, 2.3D+3 /

      REAL*8    DZ(IJLDIM, NLZDIM), DS(NLZDIM), DZ1, DS0(NZ-1)
      SAVE      DZ1, DZ, DS
C
      NAMELIST /NMDSL/ DZ1, DS0
      DATA DZ1 / 1.0D2 /                        ! cm
      DATA DS0 / 0.1, 0.1, 0.2, 0.6 /           ! ND
C
      CALL REWNML(IFPAR, JFPAR)
      WRITE(JFPAR, *) '*** SVTSETL ***'
      READ (IFPAR, NMSWAB, END=98)
  98  WRITE(JFPAR, NMSWAB)
      CALL REWNML(IFPAR, JFPAR)
      READ (IFPAR, NMDSL, END=97)
  97  WRITE(JFPAR, NMDSL)
      CALL REWNML(IFPAR, JFPAR)
C
      DS(KLSTR)=0.0D0
      DO 200 K = KLSTR+1, KLEND
            DS(K) = DS0(K-KLSTR)
  200 CONTINUE

      DO IJ = 1, IJLDIM
            DZ(IJ, KLSTR) = DZ1
      ENDDO

      RETURN

      RETURN

      ENTRY SETSCNV(HX)

      DO IJ = 1, IJLDIM

      DEPTH = 0.D0
      RADUP = 1.D0
      DZ(IJ, KLSTR) = DZ1
      DO K=KLSTR+1,KLEND
         DZ(IJ, K) = DS(K)*(HX(IJ)-DZ1)
      ENDDO
短波の湖内部への透過を計算するところ
      DO 50 K = KLSTR, KLEND
C         DEPTH = DEPTH + DS(K)*HX(IJ)
         DEPTH = DEPTH + DZ(IJ, K)
         RADDN = RRR * EXP(- DEPTH / ZETA1)
     &         + (1.D0 - RRR) * EXP(- DEPTH / ZETA2)
         SWCNV1(K) = RADUP - RADDN
         RADUP = RADDN
   50 CONTINUE

      DO K = 1, NLZDIM
            SWCONV(IJ, K) = 0.D0
      END DO
C
         TSWCNV = 0.D0
         DO 70 K = KLSTR, KLEND
            SWCONV(IJ, K) = SWCNV1(K)
            TSWCNV = TSWCNV + SWCNV1(K)
   70    CONTINUE
            SWCONV(IJ, KLEND) = 1.D0 - TSWCNV

       ENDDO

      CALL PUTSWCL(
     I            SWCONV(1,KLSTR))

      DO IJ = 1, IJLDIM
         SWCONV(IJ,KLSTR) = 0.D0
      ENDDO

      DO IJ = 1, IJLDIM
      DO K = KLSTR+1, KLEND
            SWCONV(IJ, K) = SWCONV(IJ, K) / rhoo / cpo
      ENDDO
      ENDDO

      RETURN

c =====================================================================

      ENTRY SLVTRCL(
     M                 TX,     HX,
     O                HXD,
     I                ADT,  DIFFZ, HXMIN,
     I                 FT,  SWABS,    FS,   TS, LKFRAC  )

      DO 100 IJ = 1, IJLDIM
      DO 110 K = 1, NLZDIM
            AA(IJ, K) = 0.D0
            AB(IJ, K) = 0.D0
            AC(IJ, K) = 0.D0
  110 CONTINUE
 100  CONTINUE
C　ここより下で　拡散をimplicitで解いています。COCO4の3.２.４章を参考にしてください。
      DO IJ = 1, IJLDIM

      HZBOT(IJ) = HX(IJ) - DZ1

         DZ(IJ, KLSTR)=DZ1
      DO K=KLSTR+1, KLEND
         DZ(IJ, K)=HZBOT(IJ)*DS(K)
      ENDDO

      ENDDO

      DO 800 IJ = 1,  IJLDIM
      DO 810 K = KLSTR, KLEND
CC           AA(IJ, K) = - TS * DIFFZ(IJ, K) / DZ(IJ, K)
CC           AC(IJ, K) = - TS * DIFFZ(IJ, K+1) / DZ(IJ, K)
CC           AB(IJ, K) = (HX(IJ) + ZBOT) / ZBOT - AA(IJ, K) - AC(IJ, K)
            AA(IJ, K) = - TS * DIFFZ(IJ, K)
            AC(IJ, K) = - TS * DIFFZ(IJ, K+1)
C            AB(K) = (HX + ZBOT) * DS(K) - AA(K) - AC(K)
C            AB(K) = HZBOT * DS(K) - AA(K) - AC(K)
            AB(IJ, K) = DZ(IJ, K) - AA(IJ, K) - AC(IJ, K)
  810 CONTINUE
 800  CONTINUE

      CALL THOMASL(
     M               ADT,     AC,
     I                AA,     AB)

      DO 920 N = 1, NLTDIM
         DO 910 K = KLSTR, KLEND
            DO 900 IJ = 1, IJLDIM
               TX(IJ, K, N) = TX(IJ, K, N) + TS * ADT(IJ, K, N)
  900       CONTINUE
  910    CONTINUE
  920 CONTINUE

      DO IJ = 1, IJLDIM
         DH(IJ) = - TS * FT(IJ,2)　　　　　　　　　　　　　　　　　！ここで湖への淡水フラックスを加えています。
         HXD(IJ) = MAX( HXMIN - HX( IJ ) - DH( IJ ), 0.D0 )
     &        * LKFRAC( IJ )
         DH(IJ) = MAX( DH(IJ), HXMIN - HX(IJ) )
         HX(IJ) = HX(IJ) + DH(IJ)
      ENDDO

C         HXBOT = HX
C　　　　　　　　　　ここからあとで水位が上がった分の１層目より下のシグマ層の水温の切り直しをしています。
      DO IJ = 1, IJLDIM
         HXBOT(IJ) = HX(IJ) - DZ1
         IF (DH(IJ) .GE. 0.D0) THEN
            DZB(IJ) = 0.D0
            DZT(IJ) = DH(IJ) * DS(KLEND)
         ELSE
            DZT(IJ) = - DH(IJ)
            DZB(IJ) = - DH(IJ)
         END IF
      ENDDO

      DO IJ = 1, IJLDIM
      DO K = KLEND, KLSTR+1, -1
            IF (DH(IJ) .GE. 0.D0) THEN
               DO N = 1, NLTDIM
                  TX(IJ, K, N) = (  TX(IJ, K  , N) * DS(K) * HZBOT(IJ)
     &                            - TX(IJ, K  , N) * DZB(IJ)
     &                            + TX(IJ, K-1, N) * DZT(IJ))
     &                           / HXBOT(IJ) / DS(K)
               END DO
               DZB(IJ) = DZT(IJ)
               DZT(IJ) = DZB(IJ) + DH(IJ) * DS(K-1)
            END IF
      END DO
      END DO

      DO IJ = 1, IJLDIM
         IF (DH(IJ) .GE. 0.D0) THEN
            TX(IJ, KLSTR, 2) = (  TX(IJ, KLSTR, 2) * DZ(IJ, KLSTR)
     &                         - TX(IJ, KLSTR, 2) * DZB(IJ))
     &                        / DZ(IJ, KLSTR)
            TX(IJ, KLSTR, 1) = (  TX(IJ, KLSTR, 1) * DZ(IJ, KLSTR)
     &                         - TX(IJ, KLSTR, 1) * DZB(IJ)
     &                         + TX(IJ, KLSTR, 1) * DZT(IJ)               ! temp of prec.
     &                         + TS * FT(IJ, 1))
     &                        / DZ(IJ, KLSTR)
         ELSE
            TX(IJ, KLSTR, 2) = (  TX(IJ, KLSTR,   2) * DZ(IJ,KLSTR)
     &                         + TX(IJ, KLSTR+1, 2) * DZB(IJ) )
     &                         / DZ(IJ, KLSTR)
            TX(IJ, KLSTR, 1) = (  TX(IJ, KLSTR, 1) * DZ(IJ, KLSTR)
     &                         + TX(IJ, KLSTR+1, 1) * DZB(IJ)
     &                         - TX(IJ, KLSTR, 1) * DZT(IJ)
     &                         + TS * FT(IJ, 1))
     &                        / DZ(IJ, KLSTR)
        ENDIF
      ENDDO
C
      DO IJ = 1, IJLDIM
      DO K = KLSTR+1, KLEND-1
            IF (DH(IJ) .LT. 0.D0) THEN
               DZT(IJ) = DZB(IJ)
               DZB(IJ) = DZT(IJ) + DH(IJ) * DS(K)
               DO N = 1, NLTDIM
                  TX(IJ, K, N) = (  TX(IJ,  K,  N)*DS(K)*HZBOT(IJ)
     &                            + TX(IJ, K+1, N)*DZB(IJ)
     &                            - TX(IJ, K  , N)*DZT(IJ))
     &                           / HXBOT(IJ) / DS(K)
               END DO
            END IF
      END DO
      END DO

      DO IJ = 1, IJLDIM
      DO K=KLSTR+1, KLEND
         DZ(IJ, K)=HXBOT(IJ)*DS(K)
      ENDDO
      ENDDO
      DO IJ = 1, IJLDIM
      DO K = KLSTR, KLEND
            TX(IJ, K, 1) = TX(IJ, K, 1)
     &                   + TS * SWCONV(IJ, K) * SWABS(IJ)
     &                     / DZ(IJ, K)
      END DO
      END DO

      DO IJ = 1, IJLDIM
         TX(IJ, KLSTR, 2) = TX(IJ, KLSTR, 2)
     &                   - TS * FS(IJ) / DZ(IJ, KLSTR)
* added 08/12/17
C         TX(IJ, KLSTR, 2) = MAX( TX(IJ, KLSTR, 2), 0.D0 )
      ENDDO

      RETURN
      END
C
C     2007.4.4. Tatsuo Suzuki from utrdg.F
C
      SUBROUTINE THOMASL(
     M                 ADT,     AC,
     I                  AA,     AB)
      IMPLICIT NONE
#include        "zcdim.F"                /* # of grid point & wave */
#include        "zpdim.F"                /* physics etc.           */
#include        "zccom.F" /* TMELT */
#include        "zldim.F"                /* # of land grid point   */
*
*
      REAL*8      AA(IJLDIM, NLZDIM),     AB(IJLDIM, NLZDIM)
      REAL*8      AC(IJLDIM, NLZDIM)
      REAL*8     ADT(IJLDIM, NLZDIM, NLTDIM)

      REAL*8      FC
      INTEGER          IJ,       K,       N

      DO IJ = 1, IJLDIM
         AC(IJ, KLSTR) = AC(IJ, KLSTR) / AB(IJ, KLSTR)
      DO N = 1, NLTDIM
            ADT(IJ, KLSTR, N) = ADT(IJ, KLSTR, N) / AB(IJ, KLSTR)
      END DO
      END DO

      DO 210 K = KLSTR+1, KLEND
         DO 200 IJ = 1, IJLDIM
            FC = 1.D0 / (AB(IJ, K) - AA(IJ, K) * AC(IJ, K-1))
            AC(IJ, K) = AC(IJ, K) * FC
            DO N = 1, NLTDIM
               ADT(IJ, K, N) = (  ADT(IJ, K, N)
     &                          - AA(IJ, K) * ADT(IJ, K-1, N)) * FC
            END DO
  200    CONTINUE
  210 CONTINUE

      DO 330 N = 1, NLTDIM
         DO 310 K = KLEND-1, KLSTR, -1
            DO 300 IJ = 1, IJLDIM
               ADT(IJ, K, N) = ADT(IJ, K, N)
     &                       - AC(IJ, K) * ADT(IJ, K+1, N)
  300       CONTINUE
  310    CONTINUE
  330 CONTINUE

      RETURN
      END
C
C
c =====================================================================
      SUBROUTINE OVTSETL

      IMPLICIT NONE

c --- information -----------------------------------------------------
c
c  Convective adjustment for the unstable water column
c
c  HISTORY
c
c
c ---------------------------------------------------------------------
#include        "zcdim.F"                /* # of grid point & wave */
#include        "zpdim.F"                /* physics etc.           */
#include        "zccom.F" /* TMELT */
#include        "zldim.F"                /* # of land grid point   */
#include        "zmtask.F"
*
*
      INTEGER NZ
      PARAMETER( NZ = KLMAX )
      REAL*8       R(IJLDIM, NLZDIM)
      REAL*8       T(IJLDIM, NLZDIM, NLTDIM)
      REAL*8       H(IJLDIM)
      REAL*8      TS
      REAL*8      ZT(IJLDIM, NLZDIM)
      REAL*8   DZSIG(IJLDIM, NLZDIM), TTL(IJLDIM, NLTDIM), W2(IJLDIM)
      INTEGER    LUP(IJLDIM)
      REAL*8      RU, RL
      LOGICAL    LOV(IJLDIM)
      INTEGER    IFPAR, JFPAR,    K,     KK,      N,     IJ
      INTEGER   ISTR, IEND, M
*
*     RHOW: sigma density by UNESCO(1981) Gill p.599-601
*           deg C -> kg m-3
*
      REAL*8   RHOW, X_
      RHOW(X_) = ((((6.536332D-9   * X_
     &           + (-1.120083D-6)) * X_
     &           +   1.001685D-4 ) * X_
     &           + (-9.095290D-3)) * X_
     &           +   6.793952D-2 ) * X_
     &           + 999.842594D0
*
      REAL*8    DZ(IJLDIM, NLZDIM), DS(NLZDIM), DZ1, DS0(NZ-1)
      SAVE      DZ1, DZ, DS
      INTEGER   ISTR2( MAX_MTASK ), IEND2( MAX_MTASK )
      SAVE      ISTR2, IEND2
C
      NAMELIST /NMDSL/ DZ1, DS0
      DATA DZ1 / 1.0D2 /                        ! cm
      DATA DS0 / 0.1, 0.1, 0.2, 0.6 /           ! ND


      CALL REWNML ( IFPAR, JFPAR )
      WRITE ( JFPAR, * ) '*** OVTSETL ***'
      READ  ( IFPAR, NMDSL, END=97 )
   97 WRITE ( JFPAR, NMDSL )
      CALL REWNML ( IFPAR, JFPAR )

      DS( KLSTR ) = 0.0D0
      DO 200 K = KLSTR+1, KLEND
         DS( K ) = DS0( K-KLSTR )
  200 CONTINUE
      DO IJ = 1, IJLDIM
         DZ( IJ, KLSTR ) = DZ1
      ENDDO
      CALL DIV_RANGE( ISTR2, IEND2, 1, IJLDIM, NUM_MTASK )

      RETURN
*=======================================================================
      ENTRY OVTURNL(
     O                  R,
     M                  T,
     I                  H,    TS)

!     PARALLEL_DO private(istr,iend,ru,rl)
！      ここで鉛直対流の計算をします。重い水を混ぜるだけです。
      DO 10000 M = 1, NUM_MTASK
         ISTR = ISTR2( M )
         IEND = IEND2( M )
         DO IJ = ISTR, IEND
            DZSIG( IJ, KLSTR ) = DZ1
            ZT( IJ, KLSTR ) = 0.D0
            LUP( IJ ) = KLSTR
         END DO
         DO K = KLSTR+1, KLEND
            DO IJ = ISTR, IEND
               DZSIG( IJ, K ) = DS( K ) * ( H( IJ ) - DZ1 )
            END DO
         END DO
         DO K = KLSTR, KLEND
            DO IJ = ISTR, IEND
               ZT( IJ, K+1 ) = ZT( IJ, K ) + DZSIG( IJ, K )
            END DO
         END DO
         DO N = 1, NLTDIM
            DO IJ = ISTR, IEND
               TTL( IJ, N ) = T( IJ, KLSTR, N ) * DZSIG( IJ, KLSTR )
            END DO
         END DO

         DO 1000 K = KLSTR+1, KLEND
            DO IJ = ISTR, IEND
               RU = RHOW( T( IJ, K-1, 1 ) )
               RL = RHOW( T( IJ, K  , 1 ) )
               IF ( RU .GT. RL ) THEN
                  LOV( IJ ) = .TRUE.
                  DO N = 1, NLTDIM
                     TTL( IJ, N ) = TTL( IJ, N )
     &                            + T( IJ, K, N ) * DZSIG( IJ, K )
                  END DO
               ELSE
                  LUP( IJ ) = K
                  LOV( IJ ) = .FALSE.
                  DO N = 1, NLTDIM
                     TTL( IJ,N ) = T( IJ,K,N ) * DZSIG( IJ, K )
                  END DO
               END IF
               W2( IJ ) = 1.D0 / ( ZT( IJ, K+1 ) - ZT( IJ, LUP( IJ ) ) )
            END DO

            DO 410 KK = KLSTR, K
               DO IJ = ISTR, IEND
                  IF ( (KK .GE. LUP( IJ )) .AND. LOV( IJ ) ) THEN
                     DO N = 1, NLTDIM
                        T( IJ, KK, N ) = TTL( IJ, N ) * W2( IJ )
                     END DO
                  END IF
               END DO
 410        CONTINUE
 1000    CONTINUE
10000 CONTINUE

      DO 2010 K = KLSTR, KLEND
         DO IJ = 1, IJLDIM
            R( IJ, K ) = RHOW( T( IJ,K,1 ) )
         ENDDO
 2010 CONTINUE

      RETURN
      END

C**********************************************************************
C     for sigma density by UNESCO(1981)              Gill p.599-601   *
C---------------------------------------------------------------------*
C     T : deg C, S : psu, P : bar ---> sigma : kg / m**3              *
C**********************************************************************
*      FUNCTION RHOW(T)
*C
*      REAL*8 RHOW
*      REAL*8 T, T2, T3, T4, T5
*C
*      T2  = T  * T
*      T3  = T2 * T
*      T4  = T2 * T2
*      T5  = T3 * T2
*C
*      RHOW = 999.842594D0     + 6.793952D-2 * T  - 9.095290D-3 * T2
*     &     + 1.001685D-4 * T3 - 1.120083D-6 * T4 + 6.536332D-9 * T5
*
*      RETURN
*      END
