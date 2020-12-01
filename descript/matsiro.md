Description of Minimal Advanced Treatments of Surface Interaction and RunOff (MATSIRO) Land Surface Parameterization

November 10, 2001

Seita Emori<sup>1</sup>


Frontier Research System for Global Change

<sup>1</sup> On loan from the National Institute for Environmental Studies

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [1 Introduction](#1-introduction)
- [2 Vegetation type parameters](#2-vegetation-type-parameters)
- [3 Radiation parameters](#3-radiation-parameters)
  - [3.1 Calculation of ground surface (forest floor) albedo](#31-calculation-of-ground-surface-forest-floor-albedo)
  - [3.2 Calculation of canopy albedo and transmissivity](#32-calculation-of-canopy-albedo-and-transmissivity)
  - [3.3 Calculation of surface radiation flux, etc.](#33-calculation-of-surface-radiation-flux-etc)
- [4 Turbulence parameters (bulk coefficient)](#4-turbulence-parameters-bulk-coefficient)
  - [4.1 Calculation of roughness with respect to momentum and heat](#41-calculation-of-roughness-with-respect-to-momentum-and-heat)
  - [4.2 Calculation of bulk coefficient with respect to momentum and heat](#42-calculation-of-bulk-coefficient-with-respect-to-momentum-and-heat)
  - [4.3 Calculation of bulk coefficient with respect to vapor](#43-calculation-of-bulk-coefficient-with-respect-to-vapor)
- [5 Stomatal resistance](#5-stomatal-resistance)
  - [5.1 Calculation of soil moisture stress factor](#51-calculation-of-soil-moisture-stress-factor)
  - [5.2 Calculation of amount of photosynthesis](#52-calculation-of-amount-of-photosynthesis)
  - [5.3 Calculation of stomatal resistance (2)](#53-calculation-of-stomatal-resistance-2)
  - [5.4 Calculation of ground surface evaporation resistance](#54-calculation-of-ground-surface-evaporation-resistance)
- [6 Surface energy balance](#6-surface-energy-balance)
  - [6.1 Calculation of surface turbulent fluxes](#61-calculation-of-surface-turbulent-fluxes)
  - [6.2 Calculation of heat conduction fluxes](#62-calculation-of-heat-conduction-fluxes)
  - [6.3 Solution of energy balance at ground surface and canopy](#63-solution-of-energy-balance-at-ground-surface-and-canopy)
    - [6.3.1 Energy balance at ground surface and canopy](#631-energy-balance-at-ground-surface-and-canopy)
    - [6.3.2 Case 1: When there is no melting at the ground surface](#632-case-1-when-there-is-no-melting-at-the-ground-surface)
    - [6.3.3 Case 2: When there is melting at the ground surface](#633-case-2-when-there-is-melting-at-the-ground-surface)
    - [6.3.4 Conditions for solutions](#634-conditions-for-solutions)
    - [6.3.5 Updating of ground surface and canopy temperatures](#635-updating-of-ground-surface-and-canopy-temperatures)
    - [6.3.6 Updating of flux values](#636-updating-of-flux-values)
- [7 Canopy Water Balance](#7-canopy-water-balance)
  - [7.1 Diagnosis of canopy water phase](#71-diagnosis-of-canopy-water-phase)
  - [7.2 Prognosis of canopy water](#72-prognosis-of-canopy-water)
    - [7.2.1 Evaporation (sublimation) of canopy water](#721-evaporation-sublimation-of-canopy-water)
    - [7.2.2 Interception of precipitation by the canopy](#722-interception-of-precipitation-by-the-canopy)
    - [7.2.3 Dripping of the canopy water](#723-dripping-of-the-canopy-water)
    - [7.2.4 Updating and melting of canopy water](#724-updating-and-melting-of-canopy-water)
  - [7.3 Fluxes given to the soil, snow, and runoff process](#73-fluxes-given-to-the-soil-snow-and-runoff-process)
- [8 Snow](#8-snow)
  - [8.1 Diagnosis of snow-covered ratio](#81-diagnosis-of-snow-covered-ratio)
  - [8.2 Vertical division of snow layers](#82-vertical-division-of-snow-layers)
  - [8.3 Calculation of snow water equivalent](#83-calculation-of-snow-water-equivalent)
    - [8.3.1 Sublimation of snow](#831-sublimation-of-snow)
    - [8.3.2 Snowmelt](#832-snowmelt)
    - [8.3.3 Freeze of snowmelt water and rainfall in snow](#833-freeze-of-snowmelt-water-and-rainfall-in-snow)
    - [8.3.4 Snowfall](#834-snowfall)
    - [8.3.5 Redivision of snow layer and rediagnosis of temperature](#835-redivision-of-snow-layer-and-rediagnosis-of-temperature)
  - [8.4 Calculation of snow heat conduction](#84-calculation-of-snow-heat-conduction)
    - [8.4.1 Snow heat conduction equations](#841-snow-heat-conduction-equations)
    - [8.4.2 Case 1: When snowmelt does not occur in the uppermost layer](#842-case-1-when-snowmelt-does-not-occur-in-the-uppermost-layer)
  - [8.5 Glacier formation](#85-glacier-formation)
  - [8.6 Fluxes given to the soil or the runoff process](#86-fluxes-given-to-the-soil-or-the-runoff-process)
  - [8.7 Calculation of snow albedo](#87-calculation-of-snow-albedo)
- [9 Runoff](#9-runoff)
  - [9.1 Outline of TOPMODEL](#91-outline-of-topmodel)
  - [9.2 Application of TOPMODEL assuming simplified topography](#92-application-of-topmodel-assuming-simplified-topography)
  - [9.3 Calculation of runoff](#93-calculation-of-runoff)
    - [9.3.1 Estimation of mean water table depth](#931-estimation-of-mean-water-table-depth)
    - [9.3.2 Calculation of groundwater runoff](#932-calculation-of-groundwater-runoff)
    - [9.3.3 Calculation of surface runoff](#933-calculation-of-surface-runoff)
  - [9.4 Water flux given to soil](#94-water-flux-given-to-soil)
- [10 Soil](#10-soil)
  - [10.1 Calculation of soil heat conduction](#101-calculation-of-soil-heat-conduction)
    - [10.1.1 Soil heat conduction equations](#1011-soil-heat-conduction-equations)
    - [10.1.2 Solution of heat conduction equations](#1012-solution-of-heat-conduction-equations)
  - [10.2 Calculation of soil moisture movement](#102-calculation-of-soil-moisture-movement)
    - [10.2.1 Soil moisture movement equations](#1021-soil-moisture-movement-equations)
    - [10.2.2 Solution of soil moisture movement equations](#1022-solution-of-soil-moisture-movement-equations)
  - [10.3 Phase change of soil moisture](#103-phase-change-of-soil-moisture)
    - [10.3.1 Ice sheet process](#1031-ice-sheet-process)
- [11 Lake](#11-lake)
- [12 Wetland](#12-wetland)
- [13 Tile scheme](#13-tile-scheme)
- [References](#references)

<!-- /code_chunk_output -->


# 1 Introduction

Minimal Advanced Treatments of Surface Interaction and RunOff (MATSIRO) is a land surface parameterization formulated for application　to the atmospheric general circulation model developed by the Center for Climate System Research at the University of Tokyo and the National Institute for Environmental Studies (CCSR/NIES AGCM), as well as to other global climate models. It has been designed to be primarily used for integral climate calculations such as those involving long time scales from one month to several hundred years coupled with the atmospheric model at grid resolutions of tens of kilometers or more. The main objective in its development was to represent all of the important water and energy circulation processes between land and atmosphere as fully and accurately as possible (i.e., *advanced* treatment) in such time and spatial scales, while modeling them as simply as possible (i.e., *minimal* treatment) so as to allow the results to be easily interpreted.

MATSIRO was developed based on the land surface submodel of CCSR/NIES AGCM5.4g coupled with the parameterization for a vegetated surface (canopy) by Watanabe (1994), while at the same time improving certain processes such as those related to snow and runoff. Subsequently, with modifications in the structure of AGCM, changes were made dealing with flux couplers and parallel processing so as to make it compatible with the current AGCM5.6. With regard to the physiological processes of vegetation, a Jarvis-type function was initially used for stomatal resistance. Later, however, the Farquhar-type photosynthesis scheme, which now serves as a de facto standard in the world due to the progress of studies on climate-ecosystem interactions in recent years, was ported from SiB2 code.

# 2 Vegetation type parameters

The leaf area index (LAI), vegetation height, etc. are set as vegetation type parameters.

Seasonally changing horizontal distributions are loaded as external parameters for LAI, and the values according to land use type are loaded as external parameters for the heights of the canopy top and bottom. When there is snow, only the vegetation above the level of the snow depth is taken into consideration and the type parameters are corrected as follows:

$$
 h = \max( h_0 - D_{Sn}, 0 ) \\
 h_B = \max( h_{B0} - D_{Sn}, 0 ) \\
 LAI = LAI_0 \frac{h-h_B}{h_0-h_{B0}}
$$

where $h$ is the height of the canopy top (vegetation height), $h_B$ is the height of the canopy bottom (height of clear length),  $LAI$ is the leaf area index, and $h_0$, $h_{B0}$, and $LAI_0$ are the respective values when there is no snow. $D_{Sn}$ is the snow depth. LAI is approximated on the assumption that it is uniformly distributed vertically between the canopy top and bottom.

In terms of coding, next the mean values of the snow-free and snow-covered portions are solved by weighting with the snow-covered ratio ($A_{Sn}$), etc., as follows:

$$
	h = A_{Sn}h + (1-A_{Sn})h_0
$$

However, because the snow-free portion and snow-covered portion are respectively calculated, it should be noted that $A_{Sn}$ takes the value of either 0 (snow-free portion) or 1 (snow-covered portion), so no mixing of values occurs (similar cases are also seen later).

# 3 Radiation parameters

Next, the radiation parameters (albedo, vegetation transmissivity , etc.) are calculated.

## 3.1 Calculation of ground surface (forest floor) albedo

The horizontal distributions of the ground surface (forest floor) albedo $b=1,2$ are loaded as external parameters, with $b=1,2$ denoting the wavelength bands of visible and near infrared, respectively. The infrared ground surface albedo ($\alpha_{0(3)}$) is set to a fixed value (horizontal distributions can also be prepared if desired).

With regard to the ice-sheet portion and snow-covered portion, the dependence of the incidence angle of albedo is considered by the following function form:

$$
 \alpha_{0(d,b)} = \hat{\alpha}_{0(b)} + ( 1 - \hat{\alpha}_{0(b)} )
                         \cdot 0.4 ( 1 - \cos \phi_{in(d)} )^5
$$

where $b=1,2$ are wavelength bands; $d=1,2$ are direct and diffuse, respectively; and  $\hat{\alpha}_{0(b)}$ is the value of albedo when the incidence angle is 0 (from directly overhead). The cosine of the incidence angle ! is expressed as

$$
 \cos\psi_{in(1)} = \cos\zeta, \ \ \
 \cos\psi_{in(2)} = \cos 50^{\circ}
$$

for direct insolation and diffuse radiation, respectively, where $\zeta$ is the solar zenith angle.

With regard to regions other than the ice-sheet portion and snow-covered portion, the zenith angle dependence is not taken into consideration for the albedo of the ground surface (forest floor) and the same values are given to direct insolation and diffuse radiation; that is,

$$
 \alpha_{0(d,b)} = \alpha_{0(b)}\ \ \ (d=1,2;\ b=1,2)
$$

Moreover, in the case of the infrared wavelength only diffuse radiation needs to be considered. The value of the infrared albedo for all ground surfaces is given independently of the zenith angle, as follows:

$$
 \alpha_{0(2,3)} = \alpha_{0(3)}
$$


## 3.2 Calculation of canopy albedo and transmissivity

The calculation of canopy albedo and transmissivity is based on the calculation of radiation within a canopy layer proposed by Watanabe and Ohtani (1995).

Considering the canopy as vertically uniform and making use of several assumptions for simplification, the transfer equations of insolation within the canopy and the boundary condition are expressed as


$$
 \frac{dS^{\downarrow}_d}{dL} = -F \sec\zeta S^{\downarrow}_d \\
 \frac{dS^{\downarrow}_r}{dL} = -F (1-t_{f(b)})d_f S^{\downarrow}_r
                                  +F t_{f(b)} \sec\zeta S^{\downarrow}_d
                                  +F r_{f(b)} d_f S^{\uparrow}_r \\
 \frac{dS^{\uparrow}_r}{dL}   =  F (1-t_{f(b)})d_f S^{\uparrow}_r
                                  -F r_{f(b)} ( d_f S^{\downarrow}_r
                                         + \sec\zeta S^{\downarrow}_d ) \\
 S^{\downarrow}_d(0) = S^{top}_d \\
 S^{\downarrow}_r(0) = S^{top}_r \\
 S^{\uparrow}_r(LAI) = \alpha_{0(1,b)}S^{\downarrow}_d(LAI)
                       + \alpha_{0(2,b)}S^{\downarrow}_r(LAI)
$$

where  $S^{\downarrow}_d$ is the downward direct insolation; $S^{\uparrow}_r$ and $S^{\downarrow}_r$ are the upward and downward diffuse radiation, respectively; $L$  is the leaf area cumulatively added downward from the canopy top; $d_f$ is the diffusivity factor ($=\sec 53^{\circ}$), $r_{f(b)}$; $t_{f(b)}$ are the leaf albedo and transmissivity, respectively (the same value is used for diffuse radiation and direct insolation); and $F$  is a factor denoting the direction of the leaves with respect to the radiation. Here, the distribution of the direction of the leaves is assumed to be random ($F=0.5$) for simplicity.

These can be solved analytically, giving the following solutions:

$$
 S^{\downarrow}_d(L) = S^{top}_d \exp(-F\cdot L\cdot \sec\zeta) \\
 S^{\downarrow}_r(L) = C_1 e^{a L} + C_2 e^{-a L} + C_3 S^{\downarrow}_d(L) \\
 S^{\uparrow}_r(L)   = A_1 C_1 e^{a L} + A_2 C_2 e^{-a L} + C_4 S^{\downarrow}_d(L)
$$

where

$$
   a = F d_f [(1-t_{f(b)})^2 - r_{f(b)}^2]^{1/2}  \\
 A_1 = \{ 1 - t_{f(b)} + [(1-t_{f(b)})^2 - r_{f(b)}^2]^{1/2}\} / r_{f(b)} \tag{eq17} \\
 A_2 = \{ 1 - t_{f(b)} - [(1-t_{f(b)})^2 - r_{f(b)}^2]^{1/2}\} / r_{f(b)} \\
 A_3 = (A_1 - \alpha_{0(2,b)}) e^{ a LAI }
        -(A_2 - \alpha_{0(2,b)}) e^{-a LAI } \\
 C_1 = \{ -(A_2 - \alpha_{0(2,b)}) e^{-a LAI} (S^{top}_r - C_3 S^{top}_d)
            +[C_3\alpha_{0(2,b)}+\alpha_{0(1,b)}-C_4]S^{\downarrow}_d(LAI)\} / A_3 \\
 C_2 = \{  (A_1 - \alpha_{0(2,b)}) e^{ a LAI} (S^{top}_r - C_3 S^{top}_d)
            -[C_3\alpha_{0(2,b)}+\alpha_{0(1,b)}-C_4]S^{\downarrow}_d(LAI)\} / A_3 \\
 C_3 = \frac{\sec\zeta[t_{f(b)}\sec\zeta + d_f t_{f(b)}(1-t_{f(b)}) + d_f r_{f(b)}^2]}
              {d_f^2[(1-t_{f(b)})^2-r_{f(b)}^2]-\sec^2\zeta} \\
 C_4 = \frac{r_{f(b)}(d_f - \sec\zeta)\sec\zeta}
              {d_f^2[(1-t_{f(b)})^2-r_{f(b)}^2]-\sec^2\zeta}
$$

Albedo $\alpha_s$ at the canopy top is expressed as

$$
 S^{\uparrow}_r(0) = \alpha_{s(1,b)} S^{\downarrow}_d(0)
                   + \alpha_{s(2,b)} S^{\downarrow}_r(0)
$$

therefore,

$$
 \alpha_{s(2,b)} = \{ A_2 ( A_1 - \alpha_{0(2,b)}) e^{ a LAI }
                      - A_1 ( A_2 - \alpha_{0(2,b)}) e^{-a LAI }
                   \} / A_3 \\
 \alpha_{s(1,b)} = - C_3 \alpha_{s(2,b)} + C_4
                  + ( A_1 - A_2 ) ( C_3 \alpha_{0(2,b)} + \alpha_{0(1,b)} -C_4)
                  e^{- F\cdot LAI\cdot \sec\zeta} / A_3
$$

are obtained.

If the canopy transmissivity (${\mathcal{T}}_c$) (specifically, the ratio of incident insolation absorbed by the forest floor to the incident insolation of the canopy top) is defined by


$$
  {\mathcal{T}}_{c(2,b)}= \{ ( 1 - A_2 )( A_1 - \alpha_{0(2,b)} )
                      - ( 1 - A_1 )( A_2 - \alpha_{0(2,b)} ) \} / A_3 \\
 {\mathcal{T}}_{c(1,b)}= - C_3 {\mathcal{T}}_{c(2,b)}  \\
 +               \{ ( C_3 \alpha_{0(2,b)} + \alpha_{0(1,b)} -C_4 )
                   ( ( 1 - A_1 ) e^{ a LAI }
                   - ( 1 - A_2 ) e^{-a LAI } )  / A_3
                   + C_3 - C_4 +1 \} e^{- F\cdot LAI\cdot \sec\zeta}
 \\
$$

the following are obtained:

$$
 S^{\downarrow}_d(LAI) + S^{\downarrow}_r(LAI) - S^{\uparrow}_r(LAI)
= {\mathcal{T}}_{c(1,b)} S^{\downarrow}_d(0)
+ {\mathcal{T}}_{c(2,b)} S^{\downarrow}_r(0)
$$

The above calculations are performed for $b=1, 2$ (visible and near infrared), respectively.

The leaf albedo $r_f$ and transmissivity $t_f$ are loaded as external parameters for each land cover type; however, the following two modifications are made before these parameters are used in the above calculations.

1. Snow (ice) effect on leaf surface

When the canopy temperature does not exceed 0°C, the canopy water is regarded as snow (ice). In this case, using the snow albedo ($\alpha_{Sn(b)}$) and canopy water ($w_c$), the following assumptions are made:

$$
 r_{f(b)} = ( 1 - f_{cwet} ) r_{f(b)}
         + f_{cwet} \alpha_{Sn(b)} \\
  f_{cwet} = {w_c}/w_{c,cap}
$$


where $w_{c,cap}$ is the canopy water capacity. With regard to transmissivity, the following assumption is made for convenience so that the absorptivity $1-r_f-t_f$) does not take a negative value:

$$
 t_{f(b)} = ( 1 - f_{cwet} ) t_{f(b)}
         + f_{cwet} t_{Sn(b)}, \ \ \
 t_{Sn(b)} = \min( 0.5(1 - \alpha_{Sn(b)}), t_{f(b)} )
$$

When the canopy water is in the liquid state, the resultant change in the leaf radiation parameter is ignored. Moreover, although the cases of snowfall after interception by the canopy (snow cover) and of frozen water in the canopy (ice) can be considered, with each having different radiation characteristics, the same albedo of snow on the forest floor is used for all cases here.

2. Effect considering the directions of reflection and transmission

In solving the above equations, all reflected light is assumed to return in the direction of incidence. However, if, for example, the diffusion of only a portion of the reflected light in the direction of incidence is taken into consideration, the leaf radiation parameters can be replaced as follows (Watanabe, personal communication):

$$
  r_{f(b)} = 0.75 r_{f(b)} + 0.25 t_{f(b)} \\
  t_{f(b)} = 0.75 t_{f(b)} + 0.25 r_{f(b)}
$$


The above calculations are performed for $b=1, 2$ (visible and near infrared), respectively.

In addition, in consideration of the uneven distribution of vegetation (such as savanna) in parts of the grid cells, before calculating the albedo, etc., the LAI (taking the original LAI as the grid mean value) of the vegetation-covered portion is calculated as follows:

$$
  LAI = LAI / f_V
$$

and this is used for the calculation for albedo, etc. mentioned above. ($R^{\downarrow}_{(d,b)}$) is the vegetation-covered ratio in the grid cell. After the albedo, etc. are calculated, the area-weighted mean of the vegetation-covered portion and non- vegetation-covered portion are obtained as

$$
  \alpha_{s(d,b)} = f_V \alpha_{s(d,b)}
                       + ( 1 - f_V ) \alpha_{0(d,b)} \\
  {\mathcal{T}}_{c(d,b)} = f_V {\mathcal{T}}_{c(d,b)}
                       + ( 1 - f_V ) ( 1 - \alpha_{0(d,b)} )
$$

## 3.3 Calculation of surface radiation flux, etc.

Using the surface downward radiation flux  ($R^{\downarrow}_{(d,b)}$) and albedo calculated above, the following radiation fluxes are calculated:

$$
 R^{\downarrow}_S = \sum_{b=1}^2\sum_{d=1}^2 R^{\downarrow}_{(d,b)} \\
 R^{\uparrow}_S = \sum_{b=1}^2\sum_{d=1}^2 \alpha_{s(d,b)} R^{\downarrow}_{(d,b)} \\
 R^{\downarrow}_L = R^{\downarrow}_{(2,3)} \\
 R^{gnd}_S = \sum_{b=1}^2\sum_{d=1}^2 {\mathcal{T}}_{s(d,b)} R^{\downarrow}_{(d,b)} \\
 PAR = \sum_{d=1}^2 R^{\downarrow}_{(d,1)}
$$

where $R^{\downarrow}_S$ and $R^{\uparrow}_S$  are the downward and upward shortwave radiation flux, respectively; $R^{\downarrow}_L$ is the downward longwave flux; $R^{gnd}_S$ is the shortwave flux absorbed by the forest floor; and $PAR$ is the downward photosynthesis active radiation (PAR) flux.

The canopy transmissivity of shortwave and longwave radiation, and the emissivity of longwave radiation, are then calculated as follows:

$$
 {\mathcal{T}}_{cS} = R^{gnd}_S / ( R^{\downarrow}_S - R^{\uparrow}_S ) \\
 {\mathcal{T}}_{cL} = \exp( - F \cdot LAI \cdot d_f ) \\
 \epsilon = 1 - \alpha_{s(2,3)}
$$

# 4 Turbulence parameters (bulk coefficient)

Next, the turbulence parameter (bulk coefficient) is calculated.

## 4.1 Calculation of roughness with respect to momentum and heat

The calculation of roughness is based on Watanabe (1994). In that study, using the results of a multilayer canopy model by Kondo and Watanabe (1992) as a function form for the roughness of a bulk model best fitting those results, Watanabe (1994) proposed the following:

$$
 \left(\ln \frac{h-d}{z_0}\right)^{-1} =
 \left[ 1 - \exp( -A^+) + \left(-\ln \frac{z_{0s}}{h}\right)^{-1/0.45}
  \exp(-2A^+)\right]^{0.45} \\
 \left(\ln \frac{h-d}{z_T^{\dagger}}\right)^{-1} =
 \frac{1}{-\ln(z_{Ts}/h)} \left[ \frac{P_1}{P_1 + A^+ \exp({A^+})}\right] ^{P2} \\
 \left(\ln \frac{h-d}{z_0}\right)^{-1} \left(\ln \frac{h-d}{z_T}\right)^{-1}
 = C_T^{\infty} \left[1-\exp(-P_3 A^+)
  + \left(\frac{C_T^0}{C_T^{\infty}}\right)^{1/0.9} \exp(-P_4 A^+)\right]^{0.9} \\
 h-d = h [1-\exp(-A^+)] / {A^+} \\
 A^+ = \frac{c_d LAI}{2k^2} \\
 \frac1{C_T^0} = \ln \frac{h-d}{z_0} \ln \frac{h-d}{z_T^{\dagger}} \\
 C_T^{\infty} = \frac{-1+(1+8F_T)^{1/2}}{2} \\
 P_1 = 0.0115 \left(\frac{z_{Ts}}{h}\right)^{0.1}
  \exp\left[5 \left(\frac{z_{Ts}}{h}\right)^{0.22}\right] \\
 P_2 = 0.55 \exp\left[-0.58 \left(\frac{z_{Ts}}{h}\right)^{0.35}\right] \\
 P_3 = [F_T + 0.084 \exp(-15 F_T)]^{0.15} \\
 P_4 = 2 F_T^{1.1} \\
 F_T = c_h / c_d
$$


where $z_0$ and $z_T$ are the roughness of the overall canopy with respect to momentum and heat, respectively; $z_0s$ and $z_Ts$ are the roughness of the ground surface (forest floor) with respect to momentum and heat, respectively; $c_d$ and $c_h$ are the exchange coefficient between an individual leaf and the atmosphere with respect to momentum and heat, respectively; $h$ is the vegetation height; $d$ is the zero-plane displacement; and $LAI$ is LAI. $z_T^{\dagger}$ is the roughness with respect to heat when assuming no transfer of heat to or from the leaf surface, and is used when solving the coefficient of heat transfer from the forest floor.

$z_{0s}$ and $z_{Ts}$  are given as external data for each land cover type. Their values ($z_{0s}=0.05$ m, $z_{Ts}=0.005$ m) are fixed as standards. However, the following modifications are made with respect to the snow-covered portion:

$$
 z_{0s} = \max( f_{Sn} z_{0s}, z_{0Sn} ) \\
 z_{Ts} = \max( f_{Sn} z_{0s}, z_{TSn} ) \\
          f_{Sn} = 1 - D_{Sn} / z_{0s}
$$

where $D_{Sn}$, $z_{0Sn}$ and $z_{TSn}$ are the roughness of the snow-covered portion with respect to momentum and heat, respectively.

$c_d$ and $c_h$ are parameters determined by the leaf shape, and are given as external data for each land cover type.

## 4.2 Calculation of bulk coefficient with respect to momentum and heat

After Watanabe (1994), the bulk coefficient is also calculated using Monin-Obukhov similarity as

$$
 C_M = k^2 \left[ \ln \frac{z_a-d}{z_0} + \Psi_m(\zeta) \right]^{-2} \\
 C_H = k^2 \left[ \ln \frac{z_a-d}{z_0} + \Psi_m(\zeta) \right]^{-1}
             \left[ \ln \frac{z_a-d}{z_T} + \Psi_h(\zeta) \right]^{-1} \\
 C_{Hs} = k^2 \left[ \ln \frac{z_a-d}{z_0} + \Psi_m(\zeta_g) \right]^{-1}
             \left[ \ln \frac{z_a-d}{z_T^{\dagger}} + \Psi_h(\zeta_g) \right]^{-1} \\
 C_{Hc} = C_H - C_{Hs}
$$


where $C_M$ and $C_H$ are the bulk coefficients of the overall canopy (leaf surface + forest floor) with respect to momentum and heat, respectively; $C_{Hs}$ is the bulk coefficient of the ground surface (forest floor) flux with respect to heat; $C_{Hc}$ is the bulk coefficient of the canopy (leaf surface) flux with respect to heat; $\Psi_m$ and $\Psi_h$ are Monin-Obukhov shear functions with respect to momentum and heat, respectively; and $z_a$ is the reference height of the atmosphere (height of the troposphere). Using the Monin-Obukhov lengths $\zeta$ and $\zeta_g$ related to the overall canopy and ground surface (forest floor), respectively, $L$ and $L_g$ are respectively expressed as:


$$
 \zeta = \frac{z_a - d}{L} \\
 \zeta_g = \frac{z_a - d}{L_g}
$$

and the Monin-Obukhov lengths are expressed as:

$$
 L = \frac{\Theta_0 C_M^{3/2}|V_a|^2}{kg(C_{Hs}(T_s - T_a) + C_{Hc}(T_c - T_a))} \\
 L_s = \frac{\Theta_0 C_M^{3/2}|V_a|^2}{kg C_{Hs}(T_s - T_a)}
$$


where $\Theta_0$ =300K; $|V_a|$ is the absolute value of the surface wind speed; $k$ is the Karman constant; $g$ is the gravitational acceleration; and $T_a,$T_c$ and $T_s$ are the temperature of the troposphere, canopy (leaf surface), and ground surface (forest floor), respectively.

Since the bulk coefficient is necessary for calculation of the Monin-Obukhov length, and the Monin-Obukhov length is necessary for calculation of the bulk coefficient, the calculation is iterated (twice as a standard) with a neutral bulk coefficient as the initial value.

Prior to this calculation, the snow depth in the snow-covered portion is added to the zero-plane displacement. However, the upper limit is set so that the zero-plane displacement does not exceed the value of $z_a$:


$$
 d = \min( d + D_{Sn} ,\  f_{\max} \cdot z_a )
$$


As a standard, $f_${\max}$ is set at 0.5.

## 4.3 Calculation of bulk coefficient with respect to vapor

This calculation is performed after the calculation of stomatal resistance, described later.

When the stomatal resistance ($r_{st}$)  and ground surface evaporation resistance　($r_{soil}$)  have been solved, the bulk coefficient with respect to vapor is solved as:

$$
 C_{Ec} |V_a| = \left[ (C_{Hc} |V_a|)^{-1} + r_{st} / LAI\right]^{-1} \\
 C_{Es} |V_a| = \left[ (C_{Hs} |V_a|)^{-1} + r_{soil}\right]^{-1}
$$

(Previously, this parameter was solved by converting stomatal resistance, etc. into a decrease of the exchange coefficient via roughness. However, since this approach seems to be problematic, a simpler method had been adopted in its place.)

In addition, when there is no stomatal resistance, etc. (such as evaporation from wet surfaces), the same value as for the bulk coefficient of heat is used for the bulk coefficient of vapor.

# 5 Stomatal resistance

For the calculation of stomatal resistance, a photosynthesis-stomatal model based on Farquhar et al. (1980), Ball (1988), and Collatz et al. (1990, 1991, 1992) is used. The code of SiB2 (Sellers et al., 1996) is used virtually unchanged, with the exception of the method for solving the resistance of the overall canopy. A Jarvis-type empirical equation could be used instead; however, the explanation of this point is omitted here.

## 5.1 Calculation of soil moisture stress factor

Soil moisture stress with respect to transpiration is solved. By solving the soil moisture stress factor in each soil layer, and weighting with the root distribution in each layer, the stress factor of the overall soil is calculated.

Referring to SiB2 (Sellers et al., 1996), the soil moisture stress in each layer is evaluated by the following equation:

$$
 f_{w(k)} = [ 1 + \exp( 0.02 (\psi_{cr} - \psi_{k}) ) ]^{-1}
\ \ \ \ \ (k=1,\ldots,K_g)
$$

The stress factor of the overall soil is then obtained by

$$
 f_w = \sum_{k=1}^{K_g} f_{w(k)} f_{root(k)}
$$

where  $f_{root(k)}$ is the root distribution fraction in each layer, which is an external parameter for each land cover type.  $\sum_{k=1}^{K_g} f_{root(k)}=1$.　

Furthermore, the weight of transpiration distributed to the root uptake flux in each layer is expressed as

$$
 f_{rootup(k)} = f_{w(k)} f_{root(k)} / f_w
\ \ \ \ \ (k=1,\ldots,K_g)
$$

Note that $\sum_{k=1}^{K_g} f_{rootup(k)} = 1$ here.

## 5.2 Calculation of amount of photosynthesis

The amount of photosynthesis is calculated after SiB2 (Sellers et al., 1996).

The amount of photosynthesis is considered to be regulated by the following three upper limits:


$$
 A \leq \min( w_c, w_e, w_s) \tag{eq76}
$$


where $w_c is the upper limit set by the efficiency of photosynthesis enzymes (Rubisco), and $w_e$ is the upper limit set by photosynthetically active radiation. $w_s$ is the upper　limit of the efficiency of use of photosynthate (sink) in the case of C<sub>3</sub> vegetation, or the upper limit set by $\mathrm{CO_2}$  concentration in the case of C<sub>4</sub> vegetation (Collatz et al., 1991, 1992).

The respective magnitudes are estimated as follows:


$$
 w_c = \left\{
\begin{array}{ll}
\displaystyle{
V_m \left[ \frac{c_i - \Gamma^*}{c_i + K_c(1+O_2/K_O)}\right]
}
   \qquad\mathrm{(in case of C_3 vegetation)}\\
 V_m
  \qquad\mathrm{(in case of C_4 vegetation)}
\end{array}
\right. \\
 w_e = \left\{
\begin{array}{ll}
\displaystyle{
PAR\cdot \epsilon_3 \left[ \frac{c_i-\Gamma^* }{c_i+2\Gamma^*}\right]
}
  \qquad\mathrm{(in case of C_3 vegetation)}\\
PAR\cdot \epsilon_4
  \qquad\mathrm{(in case of C_4 vegetation)}
\end{array}
\right. \\
 w_s = \left\{
\begin{array}{ll}
V_m / 2
  \qquad\mathrm{(in case of C_3 vegetation)}\\
V_m c_i/ 5
  \qquad\mathrm{(in case of C_4 vegetation)}
\end{array}
\right.
$$


where $V_m$ is the Rubisco reaction capacity, $c_i$ is the partial pressure of $\mathrm{CO_2}$ in the stoma, $\mathrm{O_2}$ is the partial pressure of oxygen in the stoma, and $PAR$is the photosynthetically active radiation (PAR).  is the $\mathrm{CO_2}$ compensation point, which is expressed by $\Gamma^* $ is the compensation point of $\mathrm{CO_2}$ and is represented by $\Gamma^* = 0.5 O_2 / S$ $K_c$, $K_O$, and $S$ are functions of temperature, whose function form is shown later. $\epsilon_3$ and $\epsilon_4$  are constants determined by the vegetation type.

In order to express a smooth transition between the different upper limits, [Eq. (76)](#eq76) is actually solved as

$$
 \beta_{ce} w_p^2 - w_p(w_c + w_e) + w_c w_e = 0 \\
 \beta_{ps} A^2 - A(w_p + w_s) + w_p w_s = 0
$$

The amount of net photosynthesis $A__n$ can be obtained when solving the two equations in order while selecting the smaller of the two solutions for each equation. $\beta_{ce}, \beta_{ps}$ are constants determined by the vegetation type. Note that when $\beta=1$, coincidence is achieved with a simple minimum-value operation.

When the amount of photosynthesis has been solved, ($A_n$) is solved as

$$
 A_n = A - R_d
$$

where $R_d$ is the amount of respiration, expressed as


$$
 R_d = f_d V_m
$$

Here, $f_d$  is a constant determined by the vegetation type.

$V_m$, etc. depend on the temperature and soil moisture, as follows (note that although the temperature dependence differs according to the term in which $V_m$ appears, the value is expressed by the same $V_m$):

$$
 V_m = V_{\max} f_T(T_c) f_w \\
 K_c = 30 \times 2.1^{Q_T} \\
 K_O = 30000 \times 1.2^{Q_T} \\
 S   = 2600 \times 0.57^{Q_T} \\
 f_T(T_c) = \left\{
\begin{array}{ll}
 2.1^{Q_T}/\{1 + \exp[s_1(T_c-s_2)]\}  (\mathrm{C_3 の w_c, w_e のとき})\\
 1.8^{Q_T}/\{1 + \exp[s_3(s_4-T_c)]\}  (\mathrm{C_3 の w_s のとき}) \\
 2.1^{Q_T}/\{1 + \exp[s_1(T_c-s_2)]\}/\{1 + \exp[s_3(s_4-T_c)]\}
    (\mathrm{C_4 の w_c, w_e のとき})\\
 1.8^{Q_T}   (\mathrm{C_4 の w_s のとき}) \\
 2^{Q_T}/\{1 + \exp[s_5(T_c-s_6)]\}   (\mathrm{R_d のとき})
\end{array}
\right. \\
Q^T = (T_c - 298) / 10
$$


where $V_{\max}$, $s_1, \ldots, s_6$ are constants determined by the vegetation type.

If $V_{\max}$, $PAR$, $c_i$, $T_c$ and $f_w$ are given by the above, the amount of photosynthesis in an individual leaf can be calculated. In reality, these values can be considered to be distributed unevenly even in the same canopy; however, $c_i$, $T_c$, and $f_w$ are approximated here as being the same for all leaves, whereas vertical distribution is taken into consideration in the case of $V_{\max}$ and $PAR$. $PAR$ is greater at the top of the canopy, and the lower the position in the canopy, the more it is attenuated. $V_{\max}$ is also considered to conform with this property of $PAR$ and to have a similar distribution.

The average vertical distribution of$PAR$ (and therefore the vertical distribution of $V_{\max}$) is expressed as

$$
 PAR(L) = PAR^{top} \exp(- f_{atn} a L)
$$

where $L$ is the leaf area added cumulatively from the canopy top, $PAR^{top}$ is $PAR$ at the canopy top, $a$ is the attenuation coefficient defined in [Eq. (17)](#eq17), and $f_{atn}$ is a constant for adjustment. Using this, the factor $f_{avr}$ expressing the average value of $PAR$, is defined as follows:

$$
 f_{avr} = \int_0^{LAI} PAR(L) dL \Bigm / (LAI \cdot PAR^{top})
 = \frac{1 - \exp(- f_{atn} a L)}{f_{atn} a}
$$

Since each of the terms $A_n$ ($w_c, w_s, w_e, R_d$) is proportional to $V_{\max}$ or $PAR$, based on the assumption that the vertical distributions of $V_{\max}$ and $PAR$ are proportional, by multiplying $A_n$, which was solved using the values of $V_{\max}$ and $PAR$ at the top of the canopy, by $f_{avr}$, the average amount of photosynthesis of leaf ($\overline{A_n}$) can be solved:

$$
 \overline{A_n} = f_{avr} A_n
$$

This parameter is expressed as $A_n$ hereafter.

## 5.3 Calculation of stomatal resistance (2)

The net photosynthesis ($A_n$) and stomatal conductance ($g_s$) are related by the semiempirical equation of Ball (1988) as follows:

$$
 g_s = m \frac {A_n}{c_s} h_s + b f_w \tag{eq93}
$$

where  $c_s$ is the molar fraction of $\mathrm{CO_2}$  (number of mol of $\mathrm{CO_2}$  per 1 mol of air) at the leaf surface, $f_w$ is the soil moisture stress factor, and $m$ and $b$ are constants determined by the vegetation type.

$h_s$ is the relative humidity at the leaf surface and is defined as

$$
 h_s = e_s / e_i \tag{eq94}
$$


where $e_s$ is the molar fraction of vapor at the leaf surface, $e_i$ is the molar fraction of vapor in the stoma, and $e_i = e^* (T_c)$ is the mole fraction of water vapor in the stomata. $e^* $ denotes the molar fraction of saturated vapor.

Assuming that the vapor flux from the inside of the stoma to the leaf surface is equal to the vapor flux from the leaf surface to the atmosphere (i.e., that there is no convergence and divergence of vapor at the leaf surface),

$$
 g_s(e_i - e_s) = g_l(e_s - e_a) \tag{eq95}
$$

from which we obtain

$$
 e_s = ( g_l e_a + g_s e_i ) / ( g_l + g_s )\tag{eq96}
$$

where $e_a$ is the molar fraction of vapor in the atmosphere and $g_l$ is the conductance from the leaf surface to the atmosphere. $g_l$ is expressed by $g_l = C_{Hc}|V_a| /
LAI$ using the bulk coefficient.

Similarly, assuming that there is no convergence and divergence of $\mathrm{CO_2}$  at the leaf surface,

$$
 A_n = g_l(c_a - c_s)/1.4
     = g_s(c_s - c_i)/1.6
$$

from which we obtain

$$
 c_s = c_a - 1.4 A_n/g_l \\
 c_i = c_s - 1.6 A_n/g_s \tag{eq99}
$$

where  $c_a$ and $c_i$  are the molar fractions of $\mathrm{CO_2}$  in the atmosphere and in the stoma, respectively. The numerical values 1.4 and 1.6 are constants that appear due to the difference in the diffusion coefficients of vapor and $\mathrm{CO_2}$ .

If we order the equations by substituting [Eq. (94)](#eq94) and [Eq. (96)](#eq96) into [Eq. (93)](#eq93), the following equation is obtained for $g_s$:


$$
 H g_s^2 + ( H g_l - e_i - H b f_w ) g_s - g_l ( H b f_w + e_a ) = 0 \tag{eq100}
$$

However, since

$$
 H = (e_i c_s)/(m A_n)
$$

[Eq. (99)](#eq99) is used for $c_s$.

Among the two solutions of [Eq. (100)](#eq100), the larger one is the significant solution. From the above, if  $A_n$ is known, $g_s$ can be solved; however, when solving $g_s$, $c_i$ is used. $c_i$ can be solved by [Eq. (99)](#eq99) if $g_s$ is solved. That is, $A_n$ is necessary in order to solve $g_s$, whereas $c_i$, namely $g_s$, is necessary in order to solve $A_n$. Iterative calculation is therefore required.

The algorithm for the iterative calculation is ported from SiB2, which uses the method of quickening the convergence by iterating six times and putting the errors in decreasing order to estimate the next solution.

Lastly, using stomatal conductance, the stomatal resistance is expressed as

$$
 r_{st} = 1/g_{st}
$$

## 5.4 Calculation of ground surface evaporation resistance

The ground surface evaporation resistance ($r_{soil}$) and relative humidity of the uppermost soil layer ($h_{soil}$) are calculated as follows:

$$
 r_{soil} = a_1 ( 1 - W_{(1)} ) / ( a_2 + W_{(1)} ) \\
 h_{soil} = \exp \left(\frac{\psi_{(1)} g}{R_{air} T_{g(1)}} \right)
$$

where $W_{(1)} = w_{(1)}/w_{sat(1)}$ is the degree of saturation of the uppermost soil layer, $\psi_{1}$ is the moisture potential of the uppermost soil layer, $g$ is the gravitational acceleration, $R_{air}$ is the gas constant of the air, and $T_{g(1)}$ is the temperature of the uppermost soil layer. $a_1$ and $a_2$ are constants, with $a_1=800$, $a_2=0.2$. as standard values.

# 6 Surface energy balance

## 6.1 Calculation of surface turbulent fluxes

The turbulent fluxes at the ground surface are solved by bulk formulae as follows. Then, by solving the surface energy balance, the ground surface temperature ($T_s$) and canopy temperature ($T_c$) are updated, and the surface flux values with respect to those values are also updated. The solutions obtained here are temporary values. In order to solve the energy balance by linearizing with respect to $T_s$ and $T_c$, the differential with respect to $T_s$ and $T_c$ of each flux is calculated beforehand.

- Momentum flux

$$
 \tau_x = - \rho C_{M}|V_a| u_a \\
 \tau_y = - \rho C_{M}|V_a| v_a
$$


where $\tau_x$ and $\tau_y$  are the momentum fluxes (surface stress) of the zonal and meridional directions, respectively.

- Sensible heat flux

$$
 H_s = c_p \rho C_{Hs}|V_a| (T_s - (P_s/P_a)^{\kappa}T_a) \tag{eq107}
  \\
 H_c = c_p \rho C_{Hc}|V_a| (T_c - (P_s/P_a)^{\kappa}T_a) \\
 \partial H_s/\partial T_s = c_p \rho C_{Hs}|V_a| \\
 \partial H_c/\partial T_c = c_p \rho C_{Hc}|V_a|
$$

where $H_s$ and $H_c$ are the sensible heat flux from the ground surface (forest floor) and canopy (leaf surface), respectively; $\kappa = R_{air} / c_p$ and $R_{air}$are the gas constants of air; and $c_p$ is the specific heat of air.

- Bare soil surface (forest floor) evaporation flux

$$
 Et_{(1,1)} = (1-A_{Sn})(1-f_{ice})\cdot
           \rho \widetilde{C_{Es}}|V_a|(h_{soil}q^*(T_s) - q_a) \\
 Et_{(2,1)} = (1-A_{Sn})f_{ice}\cdot
           \rho \widetilde{C_{Es}}|V_a|(h_{soil}q^*(T_s) - q_a) \\
 \partial Et_{(1,1)}/\partial T_s = (1-A_{Sn})(1-f_{ice})\cdot
           \rho \widetilde{C_{Es}}|V_a|h_{soil}\cdot dq^*/dT |_{T_s} \\
 \partial Et_{(2,1)}/\partial T_s = (1-A_{Sn})f_{ice}\cdot
           \rho \widetilde{C_{Es}}|V_a|h_{soil}\cdot dq^*/dT |_{T_s}
$$

where $Et_{(1,1)}$ and $Et_{(2,1)}$ are the water evaporation and ice sublimation fluxes at the bare soil surface, respectively; $q^*(T_s)$ is the saturation specific humidity at the ground surface temperature; $h_{soil}$ is the relative humidity at the soil surface layer; $A_{Sn}$ is the snow-covered ratio; and $f_{ice}$ is the ratio of ice in the uppermost soil layer, expressed as

$$
  f_{ice} = w_{i(1)}/w_{(1)}
$$

Since the snow-free portion and snow-covered portion are calculated separately, it should be noted that $A_{Sn}$ takes the value of either 0 (snow-free portion) or 1 (snow-covered portion). When the flux is downward (i.e., dew formation), there is no soil moisture resistance; therefore, the bulk coefficient is taken as:

$$
  \widetilde{C_{Es}} = \left\{
  \begin{array}{ll}
   C_{Es} (h_{soil}q^*(T_s) - q_a > 0 {のとき})\\
   C_{Hs} (h_{soil}q^*(T_s) - q_a \leq 0 {のとき})
  \end{array}
  \right.
$$

- Transpiration flux

$$
 Et_{(1,2)} = (1-f_{cwet}) \cdot \rho \widetilde{C_{Ec}}|V_a|(q^*(T_c) - q_a) \\
 Et_{(2,2)} = 0 \\
 \partial Et_{(1,2)}/\partial T_c =
  (1-f_{cwet}) \cdot \rho \widetilde{C_{Ec}}|V_a|\cdot dq^*/dT|_{T_c} \\
 \partial Et_{(2,2)}/\partial T_c = 0
$$

where $Et_{(1,2)}$ and $Et_{(2,2)}$ are transpiration of water and ice, respectively; and $Et_{(2,2)}$ is always 0. $f_{cwet} = w_c / w_{c,cap}$ is the wet fraction of the canopy. When the flux is downward, which is considered to be dew formation on the dry part of the leaf, the bulk coefficient is taken as:

$$
  \widetilde{C_{Ec}} = \left\{
  \begin{array}{ll}
   C_{Ec} (q^*(T_c) - q_a > 0 {のとき})\\
   C_{Hc} (q^*(T_c) - q_a \leq 0 {のとき})
  \end{array}
  \right.
$$

- Canopy evaporation flux

When      $T_c$ $\geq$ 0 $^{\circ}$ C:


$$
 Et_{(1,3)} =
  f_{cwet} \cdot \rho C_{Hc}|V_a|(q^*(T_c) - q_a) \\
 Et_{(2,3)} = 0 \\
 \partial Et_{(1,3)} \partial T_c =
  f_{cwet} \cdot \rho C_{Hc}|V_a|\cdot dq^*/dT|_{T_c} \\
 \partial Et_{(2,3)} \partial T_c = 0
$$

when  $T_c$ $<$ 0 $^{\circ}$ In case of C:

$$
 Et_{(1,3)} = 0 \\
 Et_{(2,3)} =
  f_{cwet} \cdot \rho C_{Hc}|V_a|(q^*(T_c) - q_a) \\
 \partial Et_{(1,3)} \partial T_c = 0 \\
 \partial Et_{(2,3)} \partial T_c =
  f_{cwet} \cdot \rho C_{Hc}|V_a|\cdot dq^*/dT|_{T_c}
$$

where $Et_{(1,3)}$ and $Et_{(2,3)}$ are the evaporation of water and the sublimation of ice at the canopy surface, respectively.

- Snow sublimation flux

$$
 E_{Sn} = A_{Sn}\cdot \rho C_{Hs}|V_a|(q^*(T_s) - q_a) \\
 \partial E_{Sn}/\partial T_s = A_{Sn}\cdot \rho C_{Hs}|V_a|
 \cdot dq^*/dT|_{T_s}
$$

where $E_{Sn}$ is the snow sublimation flux. Since the snow-free portion and snow-covered portion are calculated separately, it should also be noted here that $A_{Sn}$ takes the value of either 0 (snow-free portion) or 1 (snow-covered portion).


## 6.2 Calculation of heat conduction fluxes

The heat conduction fluxes in the snow-free and snow-covered portions are calculated. Similarly to the turbulent fluxes, when the energy balance is solved later and the surface temperature is updated, the heat conduction flux values are updated with respect to that value.

In addition, it should also be noted here that since the snow-free portion and snow-covered portion are calculated separately, $A_{Sn}$ takes the value of either 0 (snow-free portion) or 1 (snow-covered portion).

- Heat conduction flux in the snow-free portion

$$
  F_{g(1/2)} = (1 - A_{Sn}) \cdot k_{g(1/2)} / \Delta z_{g(1/2)} (T_{g(1)} - T_s) \\
  \partial F_{g(1/2)}/\partial T_s =
  - (1 - A_{Sn}) \cdot k_{g(1/2)} / \Delta z_{g(1/2)}
$$
where $F_{g(1/2)}$ is the heat conduction flux, $k_{g(1/2)}$ is the soil heat conductivity, $\Delta z_{g(1/2)}$  is the thickness from the temperature definition point of the uppermost soil layer to the ground surface, and $T_{g(1)}$ is the temperature of the uppermost soil layer.

- Heat conduction flux in the snow-covered portion　

$$
  F_{Sn(1/2)} = A_{Sn} \cdot k_{Sn(1/2)} / \Delta z_{Sn(1/2)} (T_{Sn(1)} - T_s)
 \\
  \partial F_{Sn(1/2)}/\partial T_s =
  - A_{Sn} \cdot k_{Sn(1/2)} / \Delta z_{Sn(1/2)} \tag{eq135}
$$

where $F_{Sn(1/2)}$ is the heat conduction flux, $k_{Sn(1/2)}$ is the snow heat conductivity, $\Delta z_{Sn(1/2)}$ is the thickness from the temperature definition point of the uppermost snow layer to the ground surface, and $T_{Sn(1)}$ is the temperature of the uppermost snow layer.

## 6.3 Solution of energy balance at ground surface and canopy

The energy balance is solved for two cases: (1) when there is no melting at the ground surface, and (2) when there is melting at the ground surface. In case (2), the solution is obtained by fixing the ground surface temperature ($T_s$) at 0°C, and the energy available for use in melting is diagnosed from the energy balance. Snowmelt on vegetation is treated by correction later on; therefore, that case is not solved separately here. Moreover, the case of the snow completely melting within the time steps is also treated by correction later on.

### 6.3.1 Energy balance at ground surface and canopy

The energy divergence at the ground surface (forest floor) is

$$
 \Delta F_s =
  H_s + R^{net}_s + l Et_{(1,1)} + l_s ( Et_{(2,1)} + E_{Sn} )
  - F_{g(1/2)} - F_{Sn(1/2)} \tag{eq136}
$$

where  $l$ and $l_s$  are the latent heat of evaporation and sublimation, respectively; and $R^{net}_s$ is the net radiation divergence at the ground surface, given by

$$
  R^{net}_s = -(R^{\downarrow}_S - R^{\uparrow}_S) {\mathcal{T}}_{cS}
              - \epsilon R^{\downarrow}_L {\mathcal{T}}_{cL}
              + \epsilon \sigma T_s^4
              - \epsilon \sigma T_c^4 (1 - {\mathcal{T}}_{cL})
$$

where $\sigma$ is the Stefan-Boltzmann constant.

The energy divergence at the canopy (leaf surface) is

$$
  \Delta F_c =
  H_c + R^{net}_c + l ( Et_{(1,2)} + Et_{(1,3)} )
  + l_s ( Et_{(2,2)} + Et_{(2,3)} )
$$

where $R^{net}_c$ is the net radiation divergence at the canopy, given by

$$
  R^{net}_c = -(R^{\downarrow}_S - R^{\uparrow}_S) (1-{\mathcal{T}}_{cS})
              - \epsilon R^{\downarrow}_L (1-{\mathcal{T}}_{cL})
              + ( 2 \epsilon \sigma T_c^4
              - \epsilon \sigma T_s^4 ) (1 - {\mathcal{T}}_{cL}) \tag{eq139}
$$


### 6.3.2 Case 1: When there is no melting at the ground surface

When there is no melting at the ground surface, $\Delta F_s=\Delta F_c=0$ are solved so that $T_s$ and $T_c$ holds true for the energy balance at the ground surface and canopy.

The energy balance equation linearizing each term with respect to $T_s$ and $T_c$ can be expressed as


$$
 \left(
\begin{array}{l}
 \Delta F_s \\
 \Delta F_c \\
\end{array}
\right)^{current}
=
\left(
\begin{array}{l}
 \Delta F_s \\
 \Delta F_c \\
\end{array}
\right)^{past}
+
\left(
\begin{array}{ll}
 {\partial \Delta F_s}/{\partial T_s}
 {\partial \Delta F_s}/{\partial T_c} \\
 {\partial \Delta F_c}/{\partial T_s}
 {\partial \Delta F_c}/{\partial T_c} \\
\end{array}
\right)
\left(
\begin{array}{l}
 \Delta T_s \\
 \Delta T_c \\
\end{array}
\right)
=
\left(
\begin{array}{l}
 0 \\
 0 \\
\end{array}
\right) \tag{eq140}
$$

The part with $pst$ on the right-hand side is where the fluxes calculated [Eq. (107)](eq107) to [Eq. (135)](#eq135) are substituted into [Eq. (136)](eq136) to [Eq. (139)](#eq139) using the values of $T_s$ and $T_c$ obtained in the previous step.

The differential terms are as follows:

$$
 \frac{\partial \Delta F_s}{\partial T_s} =
 \frac{\partial H_s}{\partial T_s}
+\frac{\partial R^{net}_s}{\partial T_s}
+l\frac{\partial Et_{(1,1)}}{\partial T_s}
+l_s\left(\frac{\partial Et_{(2,1)}}{\partial T_s}
+    \frac{\partial E_{Sn}}{\partial T_s}\right)
-\frac{\partial F_{g(1/2)}}{\partial T_s}
-\frac{\partial F_{Sn(1/2)}}{\partial T_s} \\
 \frac{\partial \Delta F_s}{\partial T_c} =
 \frac{\partial R^{net}_s}{\partial T_c} \\
 \frac{\partial \Delta F_c}{\partial T_s} =
 \frac{\partial R^{net}_c}{\partial T_s} \\
 \frac{\partial \Delta F_c}{\partial T_c} =
 \frac{\partial H_c}{\partial T_c}
+\frac{\partial R^{net}_c}{\partial T_c}
+l  \left(\frac{\partial Et_{(1,2)}}{\partial T_c}
+         \frac{\partial Et_{(1,3)}}{\partial T_c}\right)
+l_s\left(\frac{\partial Et_{(2,2)}}{\partial T_c}
+         \frac{\partial Et_{(2,3)}}{\partial T_c}\right)
$$

where


$$
 \frac{\partial R^{net}_s}{\partial T_s} =
 \epsilon 4 \sigma T_s^3 \\
 \frac{\partial R^{net}_s}{\partial T_c} =
 - ( 1 - {\mathcal{T}}_{cL} ) \epsilon 4 \sigma T_c^3 \\
 \frac{\partial R^{net}_c}{\partial T_s} =
 - ( 1 - {\mathcal{T}}_{cL} ) \epsilon 4 \sigma T_s^3 \\
 \frac{\partial R^{net}_c}{\partial T_c} =
  2( 1 - {\mathcal{T}}_{cL} ) \epsilon 4 \sigma T_c^3
$$

Using the above equations, [Eq. (140)]($eq140) is solved for $T_s$ and $T_c$.

### 6.3.3 Case 2: When there is melting at the ground surface

When either there is snow on the ground surface or the land cover type is ice sheet, and also the ground surface temperature solved in case 1, $T_s^{current} = T_s^{past}+\Delta T_s$, is higher than 0°C, melting at the ground surface occurs. When there is melting at the ground surface, the ground surface temperature is fixed at 0°C. That is:

$$
 \Delta T_s = \Delta T_s^{melt} = T_{melt} - T_s^{past}
$$

where $T_{melt}$ is the melting point (0°C) of ice.

With $T_c$ known, $\Delta T_s$ is solved by the following equation similarly to [Eq. (140)](#eq140):

$$
 \Delta T_c = \left( - \Delta F_c^{past}
            - \frac{\partial \Delta F_c}{\partial T_s} \Delta T_s^{melt}
              \right) \Bigm/ \frac{\partial \Delta F_c}{\partial T_c}
$$

Thus, $\Delta T_s$ and $\Delta T_c$ are determined, and the energy convergence at the ground surface to be used for melting is solved by the following equation:

$$
 \Delta F_{conv} =
 - \Delta F_s^{current} = - \Delta F_s^{past}
 - \frac{\partial \Delta F_s}{\partial T_s} \Delta T_s^{melt}
 - \frac{\partial \Delta F_s}{\partial T_c} \Delta T_c
$$

### 6.3.4 Conditions for solutions

Several conditions are set for the solution of the ground surface energy balance. After solving the energy balance, if any of the conditions are not followed, the flux that has contravened the conditions is fixed at the limit value that satisfies the conditions, and the energy balance is solved again.

1. Vapor in the troposphere should not be excessively removed.

Due to the instability of temporal calculations, it is possible that large downward latent heat is produced. The conditions are set so that even in such a case, the vapor in the troposphere from the surface is not completely removed; that is,

$$
  Et_{(i,j)}^{current} > - q_a ( P_s - P_a ) / (g \Delta t)
   \ \ \ \ \ (i=1,2 ; j=1,2,3) \\
  E_{Sn}^{current} > - q_a ( P_s - P_a ) / (g \Delta t)
$$


where $g$ is the gravitational acceleration and $\Delta t$ denotes the time steps of the atmospheric model. For the values of $Et$ etc. to be used for judgment, the updated flux values ($current$) with respect to the values of $T_s$ and $T_c$that have been updated so as to satisfy the energy balance are used. The same applies to all of the other conditions listed below. Updating of the flux values is described later.

2. Soil moisture should not take a negative value.

Soil moisture should not take a negative value due to transpiration; that is,

$$
   Et_{(1,2)}^{current} <
     \sum_{k\in rootzone} \rho_w w_{k}\Delta z_{g(k)} /\Delta t_L
$$

where $\rho_w$  is the water density and $\Delta t_L$ denotes the time steps of the land surface model.

3. Canopy water should not take a negative value.

Canopy water should not take a negative value due to evaporation; that is,

$$
   Et_{(i,3)}^{current} < \rho_w w_c /\Delta t_L
   \ \ \ \ \ (i=1,2)
$$

4. The snow water equivalent should not take a negative value.

The snow water equivalent should not take a negative value due to sublimation of snow; that is,

$$
   E_{Sn}^{current} < Sn /\Delta t_L
$$

### 6.3.5 Updating of ground surface and canopy temperatures

The ground surface temperature and canopy temperature are updated as follows:

$$
 T_s^{current} = T_s^{past} + \Delta T_s \\
 T_c^{current} = T_c^{past} + \Delta T_c
$$

Based on the updated canopy temperature, the canopy water is diagnosed in advance as being either liquid or solid. This information is used when treating freezing and melting of the canopy water, as follows:


$$
 A_{Snc} = \left\{
\begin{array}{ll}
 0 (T_c \geq T_{melt})\\
 1 (T_c <    T_{melt})
\end{array}
\right.
$$

where $A_{Snc}$ is the frozen fraction on the canopy.

### 6.3.6 Updating of flux values

The flux values are updated with respect to the updated values of $T_s$ and $T_c$. When $F$ denotes any given flux, updating of the values is performed as follows:

$$
 F^{current} = F^{past} + \frac{\partial F}{\partial T_s} \Delta T_s
                        + \frac{\partial F}{\partial T_c} \Delta T_c
$$

Using the updated flux values, the fluxes output into the atmosphere, etc. are calculated as follows:


$$
 H = H_s + H_c \\
 E = \sum_{j=1}^3 \sum_{i=1}^2 Et_{(i,j)} + E_{Sn} \\
 R^{\uparrow}_L = {\mathcal{T}}_{cL} \epsilon \sigma T_s^4
 + (1 - {\mathcal{T}}_{cL}) \epsilon \sigma T_c^4
 + (1 - \epsilon) R^{\downarrow}_L \\
 T_{sR} = ( R^{\uparrow}_L / \sigma )^{1/4}
$$


where $T_{sR}$ is the radiation temperature at the ground surface.

The root uptake flux in each soil layer is then calculated as follows:

$$
 F_{root(k)} = f_{rootup(k)} Et_{(1,2)} \ \ \ \ (k=1,\ldots,K_g)
$$

where $F_{root(k)}$ is the root uptake flux and  $f_{rootup(k)}$ is the weighting for distribution of the transpiration to the root uptake flux in each layer.

# 7 Canopy Water Balance

The canopy water balance is calculated.

## 7.1 Diagnosis of canopy water phase

With regard to canopy water, the liquid phase (intercepted rainfall, dew formation, and frozen water content that has melted) and solid phase (intercepted snow, icing, and liquid water content that has frozen) are considered separately and the coexistence of the two phases is allowed. The only prognostic variable is the water content ($w_c$) encompassing both the liquid and solid phases, and depending on whether the canopy temperature ($T_c$) is higher or lower than T_{melt} = 0^{\circ}$ C, it is diagnosed as liquid or solid, respectively. The reason why the liquid and solid phases can coexist is that $T_c$ in snow-covered and snow-free portions is calculated separately. That is, the frozen fraction on the canopy ($A_{Snc}$) is defined (in actuality, it is obtained as a result of spatial averaging by the coupler) as follows:

$$
 A_{Snc} = \left\{
\begin{array}{ll}
 0  (T_{c(1)} \geq T_{melt}, \ T_{c(2)} \geq T_{melt} {のとき})\\
 (1-A_{Sn})  (T_{c(1)} < T_{melt}, \ T_{c(2)} \geq T_{melt} {のとき})\\
 A_{Sn}  (T_{c(1)} \geq T_{melt}, \ T_{c(2)} < T_{melt} {のとき})\\
 1  (T_{c(1)} < T_{melt}, \ T_{c(2)} < T_{melt} {のとき})
\end{array}
\right.
$$

where $w_{cl} = w_c ( 1 - A_{Snc})$ and $w_{ci} = w_c A_{Snc}
$ are the liquid and solid water content of the canopy, respectively.

For $A_{Snc}$, the value updated in the flux calculation section $A_{Snc}^{\tau+1}$　is given by the coupler, but the value of the previous step $A_{Snc}^{\tau}$ is stored in MATCNW. $\tau$ denotes the time steps. This is solved from the initial values of $T_c$ and $Sn$ at the time of initiating the calculation, and therefore does not become a new prognostic variable.

## 7.2 Prognosis of canopy water

The prognostic equations for the canopy water in the liquid and solid phases are given respectively as

$$
 \rho_w \frac{w_{cl}^{\tau+1} - w_{cl}^{\tau}}{\Delta t_L}
  = P_{Il} - E_l - D_l + M_c \\
 \rho_w \frac{w_{ci}^{\tau+1} - w_{ci}^{\tau}}{\Delta t_L}
  = P_{Ii} - E_i - D_i - M_c
$$

where $P_{Il}$ and $P_{Ii}$ are the precipitation interception in the respective cases, $E_l$ and $E_i$ are the evaporation (sublimation), $D_l$, $D_i$ are the dripping, and $M_c$ is the melting. Note that here, the values before the updated $w_{cl}^{\tau}$ and $w_{ci}^{\tau}$ are defined using $A_{Snc}^{\tau}$ before it is updated, as follows:

$$
 w_{cl}^{\tau} = w_c^{\tau} ( 1 - A_{Snc}^{\tau}) \\
 w_{ci}^{\tau} = w_c^{\tau} A_{Snc}^{\tau}
$$

### 7.2.1 Evaporation (sublimation) of canopy water

First, by subtracting the evaporation (sublimation), the canopy water is partially updated as follows. The evaporation (sublimation) has already been solved in the flux calculation section.

$$
 w_{cl}^* = w_{cl}^{\tau} - E_l \Delta t_L / \rho_w \\
 w_{ci}^* = w_{ci}^{\tau} - E_i \Delta t_L / \rho_w
$$



$$
 E_l = Et_{(1,3)} \\
 E_i = Et_{(2,3)}
$$

Then, if either $w_{cl}$ or $w_{ci}$ become negative in value, it is supplemented by the other until the value returns to 0, and the melting (negative value in the case of frozen water) that is assumed to be produced is then inserted in $M_c$.

### 7.2.2 Interception of precipitation by the canopy

The precipitation interception and dripping are considered by separating the places of convective precipitation and nonconvective precipitation. The fraction of the convective precipitation area ($A_c$) is assumed to be uniform (0.1 as a standard value). Stratiform precipitation is also assumed to be uniform.

$$
 P_{Il}^{c}  = f_{int} ( Pr_c / A_c + Pr_l ) \\
 P_{Il}^{nc} = f_{int} Pr_l \\
 P_{Ii}^{c}  = f_{int} ( P_{Snc} / A_c + P_{Snl} ) \\
 P_{Ii}^{nc} = f_{int} P_{Snl}
$$

where $P_{Il}^{c}$ and $P_{Ii}^{c}$ denote the interception in the convective precipitation area, and $P_{Il}^{nc}$ and $P_{Ii}^{nc}$ denote the interception in the nonconvective precipitation area. $f_{int}$ is the interception efficiency, and is simply given by

$$
 f_{int} = \left\{
\begin{array}{ll}
 LAI  (LAI < 1 {のとき})\\
 1    (LAI \geq 1 {のとき})
\end{array}
\right.
$$


By adding the intercepted precipitation, the canopy water is further partially updated as follows:

$$
 w_{cl}^{c*} = w_{cl}^*  + P_{Il}^c    \Delta t_L / \rho_w \\
 w_{cl}^{nc*}= w_{cl}^*  + P_{Il}^{nc} \Delta t_L / \rho_w \\
 w_{ci}^{c*} = w_{ci}^*  + P_{Ii}^c    \Delta t_L / \rho_w \\
 w_{ci}^{nc*}= w_{ci}^*  + P_{Ii}^{nc} \Delta t_L / \rho_w
$$

### 7.2.3 Dripping of the canopy water

For dripping, dripping due to the canopy water capacity being exceeded and natural dripping due to gravity are considered, as follows:

$$
 D_l^c     =  \max( w_{cl}^{c*} - w_{c,cap}, 0 ) + D_{g}(w_{cl}^{c*}) \\
 D_l^{nc}  =  \max( w_{cl}^{nc*}- w_{c,cap}, 0 ) + D_{g}(w_{cl}^{nc*}) \\
 D_i^c     =  \max( w_{ci}^{c*} - w_{c,cap}, 0 ) + D_{g}(w_{ci}^{c*}) \\
 D_i^{nc}  =  \max( w_{ci}^{nc*}- w_{c,cap}, 0 ) + D_{g}(w_{ci}^{nc*})
$$

where the canopy water capacity ($w_{c,cap}$) is, from the water capacity per unit leaf area ($w_{c\max}$) and LAI, assumed to be

$$
 W_{c,cap} = W_{c\max} LAI
$$

$W_{c\max}$ is set at 0.2 mm as a standard value, and the same value is used with respect to the liquid and solid phases.

The natural dripping due to gravity $D_g$ is, after Rutter et al. (1975), assumed to be

$$
 D_g(w_c) = D_1 \exp(D_2 w_c)
$$

$D_1=1.14 \times 10 ^{-11}$ and $D_2=3.7 \times$ 10 ^{3}
$ are standard values, and the same values are used with respect to the liquid and solid phases.

By subtracting the dripping, the values are updated as follows:

$$
 w_{cl}^{c**} = w_{cl}^{c*}  - D_{Il}^c    \Delta t_L / \rho_w \\
 w_{cl}^{nc**}= w_{cl}^{nc*} - D_{Il}^{nc} \Delta t_L / \rho_w \\
 w_{ci}^{c**} = w_{ci}^{c*}  - D_{Ii}^c    \Delta t_L / \rho_w \\
 w_{ci}^{nc**}= w_{ci}^{nc*} - D_{Ii}^{nc} \Delta t_L / \rho_w
$$


### 7.2.4 Updating and melting of canopy water

Moreover, by taking the average of the convective precipitation area and nonconvective precipitation area, the canopy water can be updated as follows:

$$
 w_{cl}^{**} = A_c w_{cl}^{c**} + (1-A_c) w_{cl}^{nc**} \\
 w_{ci}^{**} = A_c w_{ci}^{c**} + (1-A_c) w_{ci}^{nc**} \\
 w_c^{\tau+1} = w_{cl}^{**} + w_{ci}^{**}
$$

However, if updating of the frozen fraction ($A_{Snc}$) is considered,


$$
 w_{cl}^{\tau+1} = w_{c}^{\tau+1} (1-A_{Snc}^{\tau+1}) \\
 w_{ci}^{\tau+1} = w_{c}^{\tau+1} A_{Snc}^{\tau+1}
$$


The melting $M_c$ is therefore diagnosed as

$$
 M_c = - \rho_w ( w_{ci}^{\tau+1} - w_{ci}^{**} ) / \Delta t_L
$$

When the melting is produced during evaporation, that portion is added.

Here, the canopy temperature should be changed due to the latent heat of melting; however, it is impossible because we are ignoring the heat capacity of the canopy. Moreover, although it would be advantageous to change the temperature of the surrounding atmosphere, this is also not possible in view of the need for agreement with the calculation in the land surface integration section. Hence, for convenience, in order to conserve the energy of the system, the latent heat of melting is given as the heat flux to the soil (or snow).

## 7.3 Fluxes given to the soil, snow, and runoff process

The water flux $F_w$ given to the snow or the runoff process after interception by the canopy is respectively expressed with respect to the convective precipitation area and nonconvective precipitation area, and the liquid and solid phases, as follows:

$$
 F_{wl}^{c} = (1-f_{int})( Pr_c / A_c + Pr_l ) + D_{l}^{c} \\
 F_{wl}^{nc} =(1-f_{int}) Pr_l + D_{l}^{nc} \\
 F_{wi}^{c} = (1-f_{int})( P_{Snc} / A_c + P_{Snl} ) + D_{i}^{c} \\
 F_{wi}^{nc} =(1-f_{int}) P_{Snl} + D_{i}^{nc}
$$

For the calculation of runoff, convective rainfall and stratiform rainfall are given separately, while snowfall is consolidated because separation is not necessary, as follows:

$$
 Pr_c^* = Ac ( F_{wl}^{c} - F_{wl}^{nc} ) \\
 Pr_l^* = F_{wl}^{nc} \\
 P_{Sn}^* = A_c F_{wl}^{c} + (1-A_c) F_{wl}^{nc}
$$

where $Pr_c^*$, $Pr_l^*$, and $P_{Sn}^*$ are the convective precipitation, the stratiform precipitation, and the snowfall after interception by the canopy, respectively.

The energy flux correction portion for the soil or the snow is

$$
 \Delta F_{c,conv} = - l_m M_c
$$


where $l_m$is the latent heat of melting.

# 8 Snow

 The snow water equivalent, snow temperature, and snow albedo are calculated here.

## 8.1 Diagnosis of snow-covered ratio

When the amount of snow is small, the snow in the subgrid cells is considered. The snow-covered ratio $A_{Sn}$ is given as a unique function of the snow water content ($Sn_c$) by

$$
 A_{Sn} = \min(Sn/Sn_{c}, 1)^{1/2} \tag{eq210}
$$

$Sn_c$= 100 \[kg/m<sup>2</sup>\] is a standard value.

In actuality, various factors can be considered to affect the snow-covered ratio, such as differences in topography, the time of snowfall or snow melting, etc. With regard to this point, introduction the Subgrid Snow Distribution (SSNOWD) model proposed by Liston (personal communication) is being studied.

$A_{Sn}$ is referred to at the beginning of the flux calculation section, and the various fluxes calculated there are used for the area-weighted mean as follows:

$$
 \overline{F} = (1-A_{Sn}) F_{(1)} + A_{Sn} F_{(2)}
$$

where $F_{(1)}$ and $F_{(2)}$  are fluxes at the snow-free portion and snow-covered portion, respectively. In actuality, this operation is performed through the flux coupler.

## 8.2 Vertical division of snow layers

In order to express the vertical distribution of the snow temperature, when the snow water equivalent is large, the snow is divided into multiple layers and the temperature is defined in each layer. The number of snow layers can be varied, with the number of layers increasing as the snow water equivalent becomes larger. A minimum of one layer and a maximum of three layers are set as a standard.

The number of layers and the mass of each layer are determined uniquely by the snow water equivalent. Consequently, the mass of each layer does not become a new prognostic variable.

As a standard, the mass of each layer (\Delta \widetilde{Sn}_{(k)} (k=1,2,3)$) is determined as follows ()$k=1$ is the uppermost layer):

$$
 \Delta \widetilde{Sn}_{(1)} = \left\{
\begin{array}{ll}
 \widetilde{Sn}  (\widetilde{Sn} < 20) \\
 0.5\widetilde{Sn}  (20 \leq \widetilde{Sn} < 40) \\
 20  (\widetilde{Sn} \geq 40)
\end{array} \tag{eq212}
\right. \\
 \Delta \widetilde{Sn}_{(2)} = \left\{
\begin{array}{ll}
 0  (\widetilde{Sn} < 20) \\
 \widetilde{Sn} - \Delta Sn_{(1)}  (20 \leq \widetilde{Sn} < 60)\\
 0.5(\widetilde{Sn}-20)  (60 \leq \widetilde{Sn} < 100) \\
 40  (\widetilde{Sn} \geq 100)
\end{array}
\right.  \\
 \Delta \widetilde{Sn}_{(3)} = \left\{
\begin{array}{ll}
 0  (\widetilde{Sn} < 60) \\
 \widetilde{Sn} - (\Delta Sn_{(1)} + \Delta Sn_{(2)}) (\widetilde{Sn} \geq 60)   
\end{array}
\right.
$$

where

$$
 \widetilde{Sn} =  Sn / A_{Sn}
$$

 $Sn$ is the grid-mean snow water equivalent, and $\widetilde{Sn}$ is the snow water equivalent in the snow-covered portion. Note that the mass of each layer ($\Delta \widetilde{Sn}_{(k)}$) is also the value of the snow-covered portion, not the grid-mean value. The unit is kg/m<sup>2</sup>.

From the above, it can be clearly seen that the number of snow layers ($K_{Sn}$) is as follows, as a standard:

$$
 K_{Sn} = \left\{
\begin{array}{ll}
 0  (\widetilde{Sn} = 0)\\
 1  (0< \widetilde{Sn} < 20)\\
 2  (20 \leq \widetilde{Sn} < 60)\\
 3  (\widetilde{Sn} \geq 60)
\end{array}
\right.
$$

## 8.3 Calculation of snow water equivalent

The prognostic equation of the snow water equivalent is given by

$$
 \frac{Sn^{\tau+1}-Sn^{\tau}}{\Delta t_L} = P_{Sn}^* - E_{Sn} - M_{Sn} + Fr_{Sn}
$$

where $P_{Sn}^*$ is the snowfall flux after interception by the canopy, $E_{Sn}$ is the sublimation flux, $M_{Sn}$ is the snowmelt, and $Fr_{Sn}$ is the refreeze of snowmelt or the freeze of rainfall.

### 8.3.1 Sublimation of snow

First, by subtracting the sublimation, the snow water equivalent is partially updated:

$$
 Sn^* = Sn^{\tau} - E_{Sn} \Delta t_L \\
 \Delta \widetilde{Sn}_{(1)}^* = \Delta \widetilde{Sn}_{(1)}^{\tau} - E_{Sn}/A_{Sn} \Delta t_L
$$

In a case where the sublimation is larger than the snow water equivalent in the uppermost layer, the remaining amount is subtracted from the layer below. If the amount in the second layer is insufficient for such subtraction, the remaining amount is subtracted from the layer below that.

### 8.3.2 Snowmelt

Next, the snow heat conduction is calculated to solve the snowmelt. The method of calculating the snow heat conduction is described later. The updated snow temperature incorporating the heat conduction is assumed to be $T_{Sn(k)}^*$. When the temperature is calculated and the temperature of the uppermost snow layer becomes higher than $T_{melt} = 0^{\circ}$ C, the temperature of the uppermost layer is fixed at $T_{melt}$ and the calculation is performed again. In this case, the energy convergence $\Delta \widetilde{F}_{conv}$ in the uppermost layer is calculated. This is not the grid-mean value but the value of the snow-covered portion. The snowmelt in the uppermost layer is

$$
 \widetilde{M}_{Sn(1)} = \min(\Delta \widetilde{F}_{conv} / l_m, \Delta \widetilde{Sn}_{(1)}^*/\Delta t_L ) \tag{eq220}
$$

With regard to the second layer and below, if the temperature is higher than $T_{melt}$, it is put back to $T_{melt}$ and the internal energy of that temperature change portion is applied to the snowmelt. That is, it is assumed to be

$$
 T_{Sn(k)}^{**} = T_{melt}
$$

$\Delta \widetilde{F}_{conv}$ is newly defined by

$$
 \Delta \widetilde{F}_{conv} = ( T_{Sn(k)}^* - T_{melt} ) c_{pi}\Delta \widetilde{Sn}_{(k)}^*/\Delta t_L
$$

and the snowmelt is solved as in [Eq. (220)](#eq220).

By subtracting the snowmelt, the mass of each layer is updated:

$$
 \Delta \widetilde{Sn}_{(k)}^{**} = \Delta \widetilde{Sn}_{(k)}^{*}
 - \widetilde{M}_{Sn(k)}
$$


During these calculations, when a certain layer is fully melted, the remaining amount of $\Delta \widetilde{F}_{conv}$ is given to the layer below to raise the temperature in that layer; that is,

$$
 \Delta \widetilde{F}_{conv}^* = \Delta \widetilde{F}_{conv} - l_m \widetilde{M}_{Sn(k)}
$$


$$
 T_{Sn(k+1)}^{**} = T_{Sn(k+1)}^{*} + \Delta \widetilde{F}_{conv}^* / (c_{pi} \Delta \widetilde{Sn}_{(k+1)}^*) \Delta t_L
$$

where $c_{pi}$ is the specific heat of snow (ice). When all of the snow is melted, $\Delta \widetilde{F}_{conv}^*$ is given to the soil.

The snowmelt of the overall snow is the sum of the snowmelt in each layer (note, however, that it is the grid-mean value):

$$
 M_{Sn} = \sum_{k=1}^{K_{Sn}} \widetilde{M}_{Sn(k)} A_{Sn}
$$

By subtracting the snowmelt, the snow water equivalent is partially updated:

$$
 Sn^{**} = Sn^{*} - M_{Sn} \Delta t_L
$$

### 8.3.3 Freeze of snowmelt water and rainfall in snow

The freeze of snowmelt water and rainfall in the snow is calculated next. With regard to the snowmelt water, consideration is given to the effect of the liquid water produced by the snowmelt in the upper layer refreezing in the lower layer. The retention of liquid water content in the snow is not considered, and the entire amount is treated whether it has frozen in the snow or percolated under the snow.

The liquid water flux at the snow upper boundary in the snow-covered portion is

$$
 \widetilde{F}_{wSn(1)} = Pr_c^* + Pr_l^* + M_{Sn} / A_{Sn}
$$

Here, the melted portion in the second layer of the snow and below is also assumed to have percolated from the snow upper boundary (in actuality, snowmelt in the second layer or below rarely occurs).

It is reasonable to assume the temperature of the snowmelt water as 0°C, and the temperature of rainfall on the snow is also assumed to be 0°C for convenience. The temperature of the snow increases due to the latent heat of the freezing of water; however, when the temperature of the snow in a certain layer is increased to 0°C, any additional water is assumed to be unable to freeze and to percolate to the layer below. In addition, an upper limit is set on the ratio of water that can be frozen compared with the mass of snow in the layer. The amount of freeze in a given layer$\widetilde{Fr}_{Sn(k)}$ is solved by

$$
 \widetilde{Fr}_{Sn(k)} = \min\left( \widetilde{F}_{wSn(k)}, \
\frac{c_{pi}(T_{melt}-T_{Sn(k)}^{**})}{l_m}
\frac{\Delta \widetilde{Sn}_{(k)}^{**}}{\Delta t_L} , \
f_{Fmax}\frac{\Delta \widetilde{Sn}_{(k)}^{**}}{\Delta t_L} \right)
$$

where  $F_{w_{Sn}(k)}$ is the liquid water flux percolated from the upper boundary of the $k$th layer of the snow. $\widetilde{F} _ { wSn(k) } $ is the liquid water flux flowing from the top of the $k$th layer of snow cover. The standard value of the $f_{Fmax}$ is assumed to be 0.1 as a standard value.

The snow temperature change is updated by

$$
 T_{Sn(k)}^{*** } = \frac{l_m \widetilde{Fr}_{Sn(k)}\Delta t_L
   +c_{pi}(T_{Sn(k)}^{**}\Delta \widetilde{Sn}_{(k)}^{**} + T_{melt} \widetilde{Fr}_{Sn(k)}\Delta t_L ) }
  {c_{pi} (\Delta \widetilde{Sn}_ { (k) }^{** } + \widetilde{Fr}_{Sn(k)}\Delta t_L)}
$$


and the mass is updated as follows:

$$
 \Delta \widetilde{Sn}_ {(k)}^{*** } = \Delta \widetilde{Sn}_{(k)}^{** } + \widetilde{Fr}_{Sn(k)}\Delta t_L
$$


The amount of freeze in the overall snow is the sum of the amounts of freeze in each layer (note, however, that it is the grid-mean value):

$$
 Fr_{Sn} = \sum_{k=1}^{K_{Sn}} \widetilde{Fr}_ {Sn(k)} A_{Sn}
$$


By adding the amount of freeze, the snow water equivalent is partially updated:

$$
 Sn^{*** } = Sn^{**} + Fr_{Sn} \Delta t_L
$$

The liquid water that has percolated from the snow to the lower boundary is given to the soil.

### 8.3.4 Snowfall

Lastly, by adding the snowfall after interception by the canopy, the finally updated snow water equivalent is obtained:

$$
 Sn^{\tau+1} = Sn^{*** } + P_{Sn}^* \Delta t_L
$$

However, when the temperature of the uppermost soil layer is 0°C or more, the snowfall is assumed to melt on the ground. In this case, the energy of the latent heat of melting is taken from the soil.

When snow is produced by snowfall in a grid where no snow was formerly present, the snow-covered ratio ($A_{Sn}$) is newly diagnosed by [Eq. (210)](#eq210) and the snow temperature ($T_{Sn(1)}$) is assumed to be equal to the temperature of the uppermost soil layer.

The snowfall is added to the mass of the uppermost layer:

$$
 \Delta \widetilde{Sn}_{(k)}^{\tau+1} = \Delta \widetilde{Sn}_{(k)}^{ * * * } + P_{Sn}^* \Delta t_L /A_{Sn}
$$

### 8.3.5 Redivision of snow layer and rediagnosis of temperature

When the snow water equivalent is updated, the snow-covered ratio is rediagnosed by [Eq. (210)](#eq210) and the mass of each layer is redivided by [Eq. (212) to (214)](#eq212). The temperature in each redivided layer is rediagnosed so that the energy is conserved, as follows:

$$
 T_{Sn(k)}^{new} = \left(\sum_{l=1}^{K_{Sn}^{old}} f_{(l^{old}\in k^{new})} T_{Sn(l)}^{old} \Delta \widetilde{Sn}_{(l)}^{old} A_{Sn}^{old} \right)
\Bigm/ (\Delta \widetilde{Sn}_{(k)}^{new} A_{Sn}^{new})
$$


It should be noted that the variables with the index *old* and *new* are those before and after redivision, respectively. $f_{(l^{old}\in k^{new})}$ is the ratio of the mass of the $k$th layer after redivision to the mass of the $l$th layer before redivision.

## 8.4 Calculation of snow heat conduction

### 8.4.1 Snow heat conduction equations

The prognostic equation of the snow temperature due to snow heat conduction is as follows:

$$
c_{pi}\Delta \widetilde{Sn}_{(k)} \frac{T_{Sn(k)}^* - T_{Sn(k)}^{\tau}}{\Delta t_L} = \widetilde{F}_{Sn(k+1/2)} - \widetilde{F}_{Sn(k-1/2)}
\qquad (k=1,\ldots,K_{Sn}) \tag{eq237}
$$

with the heat conduction flux $\widetilde{F}_{Sn}$ given by

$$
 \widetilde{F}_{Sn(k+1/2)} =
\left\{
\begin{array}{ll}
( F_{Sn(1/2)} - \Delta F_{conv})/A_{Sn} - \Delta F_{c,conv}
 (k=0)\\
\displaystyle{
k_{Sn(k+1/2)} \frac{T_{Sn(k+1)} - T_{Sn(k)}}{\Delta z_{Sn(k+1/2)}}
}
 (k=1,\ldots,K_{Sn}-1) \\
\displaystyle{
k_{Sn(k+1/2)} \frac{T_{Sn(B)} - T_{Sn(k)}}{\Delta z_{Sn(k+1/2)}}
}
 (k=K_{Sn})
\end{array} \tag{eq238}
\right.
$$

where $k_{Sn(k+1/2)}$  is the snow heat conductivity, assigned the fixed value of 0.3 W/m/K as a standard. $\Delta z_{Sn(k+1/2)}$ is the thickness of each snow layer, defined by

$$
 \Delta z_{Sn(k+1/2)} =
\left\{
\begin{array}{ll}
 0.5 \Delta \widetilde{Sn}_{(1)} / \rho_{Sn}  (k=1)\\
 0.5 (\Delta \widetilde{Sn}_{(k)}+\Delta \widetilde{Sn}_{(k+1)}) / \rho_{Sn}
 (k=2,\ldots,K_{Sn}-1)\\
 0.5 \Delta \widetilde{Sn}_{(K_{Sn})} / \rho_{Sn}  (k=K_{Sn})
\end{array}
\right.
$$

where $\rho_{Sn}$ is the snow density, assigned the fixed value of 300 kg/m<sup>3</sup> as a standard. The snow density and heat conductivity are considered to change with the passage of time due to compaction and changes in properties (aging), but the effect of such changes is not considered here.

In [Eq. (238)](#eq238), the snow upper boundary flux $ \widetilde{F}_ {Sn(1/2)}$ is given using the heat conduction flux from the snow to the ground surface solved in the ground surface energy balance $F_{Sn(1/2)}$, the ground surface energy convergence produced when the ground surface temperature is solved by the snowmelt condition $\Delta
F_{conv}$), and the energy correction produced when a change has occurred in the phase of the canopy water $\Delta F_{c,conv}$. ($\Delta F_{conv}$) is assumed to be given only to the snow-covered portion, while ($\Delta F_{c,conv}$) is given uniformly to the grid cells. Since the sign of the flux is taken as upward positive, the convergence has a negative sign.

In the equation for the snow lower boundary flux ($\widetilde{F}_ {Sn(K_{Sn}+1/2)}$), $T_{Sn(B)}$ is the temperature of the snow lower boundary (the boundary surface of the snow and the soil). However, since the flux from the uppermost soil layer to the snow lower boundary is

$$
\widetilde{F}_ {g(1/2)} = k_{g(1/2)} \frac{T_{g(1)}-T_{Sn(B)}}{\Delta z_{g(1/2)}}
$$

there is assumed to be no convergence at the snow lower boundary, and by putting


$$
\widetilde{F}_{Sn(K_{Sn}+1/2)} =  \widetilde{F}_{g(1/2)}
$$

$T_{Sn(B)}$ is solved. When this is substituted into [Eq. (242)](#eq242), the following is obtained:

$$
\widetilde{F}_{Sn(K_{Sn}+1/2)} =
\left[\frac{\Delta z_{g(1/2)}}{k_{g(1/2)}}
+\frac{\Delta z_{Sn(K_{Sn}+1/2)}}{k_{Sn(K_{Sn}+1/2)}}
\right]^{-1}
(T_{g(1)} - T_{Sn(K_{Sn})}) \tag{eq242}
$$

### 8.4.2 Case 1: When snowmelt does not occur in the uppermost layer

The implicit method is used to treat the temperature from the uppermost snow layer to the lowest snow layer, as follows:


$$
 \widetilde{F}_ {Sn(k+1/2)}^* = \widetilde{F}_{Sn(k+1/2)}^{\tau}
+\frac{\partial \widetilde{F}_ {Sn(k+1/2)}}{\partial T_{Sn(k)}}
 \Delta T_{Sn(k)}
+\frac{\partial \widetilde{F}_ {Sn(k+1/2)}}{\partial T_{Sn(k+1)}}
 \Delta T_{Sn(k+1)}
$$


$$
 \widetilde{F}_{Sn(k+1/2)}^{\tau} =
\left\{
\begin{array}{ll}
( F_{Sn(1/2)} - \Delta F_{conv})/A_{Sn} - \Delta F_{c,conv}
 (k=0)\\
\displaystyle{
\frac{k_{Sn(k+1/2)}}{\Delta z_{Sn(k+1/2)}} (T_{Sn(k+1)}^{\tau} - T_{Sn(k)}^{\tau})
}
 (k=1,\ldots,K_{Sn}-1) \\
\displaystyle{
\left[\frac{\Delta z_{g(1/2)}}{k_{g(1/2)}}
+\frac{\Delta z_{Sn(K_{Sn}+1/2)}}{k_{Sn(K_{Sn}+1/2)}}
\right]^{-1}
(T_{g(1)} - T_{Sn(K_{Sn})}^{\tau})
}
 (k=K_{Sn})
\end{array}
\right.
$$


$$
 \frac{\partial \widetilde{F}_{Sn(k+1/2)}}{\partial T_{Sn(k)}} =
\left\{
\begin{array}{ll}
\displaystyle{
- \frac{k_{Sn(k+1/2)}}{\Delta z_{Sn(k+1/2)}}
}
 (k=1,\ldots,K_{Sn}-1) \\
\displaystyle{
- \left[\frac{\Delta z_{g(1/2)}}{k_{g(1/2)}}
+\frac{\Delta z_{Sn(K_{Sn}+1/2)}}{k_{Sn(K_{Sn}+1/2)}}
\right]^{-1}
}
 (k=K_{Sn})
\end{array}
\right.
$$


$$
 \frac{\partial \widetilde{F}_{Sn(k+1/2)}}{\partial T_{Sn(k+1)}} =
\left\{
\begin{array}{ll}
0  \ \quad \qquad \qquad \qquad \qquad (k=0) \\
\displaystyle{
\frac{k_{Sn(k+1/2)}}{\Delta z_{Sn(k+1/2)}}
}
   \ \quad \qquad \qquad \qquad \qquad (k=1,\ldots,K_{Sn}-1)
\end{array}
\right.
$$


and [Eq. (237)](#eq237) is treated as

$$
c_{pi}\Delta \widetilde{Sn}_{(k)} \frac{\Delta T_{Sn(k)}}{\Delta t_L}
= \widetilde{F}_{Sn(k+1/2)}^* - \widetilde{F}_{Sn(k-1/2)}^*  \\
= \widetilde{F}_{Sn(k+1/2)}^{\tau}
+\frac{\partial \widetilde{F}_{Sn(k+1/2)}}{\partial T_{Sn(k)}}
 \Delta T_{Sn(k)}
+\frac{\partial \widetilde{F}_{Sn(k+1/2)}}{\partial T_{Sn(k+1)}}
 \Delta T_{Sn(k+1)}  \\
- \widetilde{F}_{Sn(k-1/2)}^{\tau}
-\frac{\partial \widetilde{F}_{Sn(k-1/2)}}{\partial T_{Sn(k-1)}}
 \Delta T_{Sn(k-1)}
-\frac{\partial \widetilde{F}_{Sn(k-1/2)}}{\partial T_{Sn(k-1)}}
 \Delta T_{Sn(k)}
$$

and solved by the LU factorization method as $\Delta T_{Sn(k)}\ (k=1,\ldots,K_{Sn})$ simultaneous equations with respect to $K_{Sn}$. At this juncture, it should be noted that the flux at the snow upper boundary is fixed as the boundary condition, the snow lower boundary condition is the temperature in the uppermost soil layer, and the snow lower boundary flux is treated explicitly with regard to the temperature of the uppermost soil layer. The snow temperature is partially updated by


$$
 T_{Sn(k)}^* = T_{Sn(k)}^{\tau} + \Delta T_{Sn(k)}
$$

6.4.3 Case 2: When snowmelt occurs in the uppermost layer

When the temperature of the uppermost snow layer solved in case 1 is higher than 0degC, snowmelt occurs in the uppermost snow layer. In this case, the temperature of the uppermost snow layer is fixed at 0°C. The flux from the second snow layer to the uppermost snow layer is then expressed as

$$
 \widetilde{F}_{3/2}^{*} =
\frac{k_{Sn(3/2)}}{\Delta z_{Sn(3/2)}} (T_{Sn(2)}^{\tau} - T_{melt})
+\frac{\partial \widetilde{F}_{Sn(3/2)}}{\partial T_{Sn(2)}}
 \Delta T_{Sn(2)}
$$

and solved similarly to case 1 (when there is only one snow layer, the snow temperature is similarly fixed in the flux from the soil to the snow).

The energy convergence used for melting in the uppermost snow layer is given by:

$$
 \Delta \widetilde{F}_{conv} = (\widetilde{F}_{3/2}^{*} - \widetilde{F}_{1/2})
  - c_{pi}\Delta \widetilde{Sn}_{(1)} \frac{T_{melt}-T_{Sn(1)}^*}{\Delta t_L}
$$

Even if the temperature of the second snow layer and below is higher than $T_{melt}$, the calculation is not iterated and the snowmelt is corrected accordingly.

## 8.5 Glacier formation

In this case, the maximum value is set for the snow water equivalent, and the portion exceeding the maximum value is considered to become glacier runoff:


$$
 Ro_{gl} = \max( Sn - Sn_{\max} ) / \Delta t_L
$$


$$
 Sn = Sn - Ro_{gl} \Delta t_L \\
 \Delta \widetilde{Sn}_{(K_{Sn})} = \Delta \widetilde{Sn}_{(K_{Sn})}
 - Ro_{gl} / A_{Sn} \Delta t_L
$$

where $Ro_{gl}$ is the glacier runoff. The mass of this portion is subtracted from the lowest snow layer. $Sn_{\max}$ is uniformly assigned the value of 1000 kg/m<sup>2</sup> as a standard.

## 8.6 Fluxes given to the soil or the runoff process

The heat flux given to the soil through the snow process is

$$
\Delta F_{conv}^* = A_{Sn} ( \Delta \widetilde{F}_{conv}^* - \widetilde{F}_{Sn_{K_{Sn}}} ) - l_m P_{Sn,melt}^*
$$

where $\Delta \widetilde{F}_{conv}^*$ is the energy convergence remaining when all of the snow has melted, $\widetilde{F}_{Sn_{K_{Sn}}}$ is the heat conduction flux at the lowest snow layer, and $P_{Sn,melt}^*$ is the snowfall that melts immediately when it reaches the ground.

Since the energy of the snow-free portion is given to the soil as it is, the energy correction term due to the phase change of the canopy water is as follows:

$$
 \Delta F_{c,conv}^* = ( 1 - A_{Sn}) \Delta F_{c,conv}
$$


The water flux given to the runoff process through the snow process is then expressed as

$$
 Pr_c^{**} = ( 1 - A_{Sn} ) Pr_c^{*} \\
 Pr_l^{**} = ( 1 - A_{Sn} ) Pr_l^{*} + A_{Sn} \widetilde{F}_{wSn}^*
 + P_{Sn,melt}^*
$$



where $\widetilde{F}_{wSn}^*$  is the flux of the rainfall or snowmelt water that has percolated through the lowest snow layer.

## 8.7 Calculation of snow albedo

The albedo of the snow is large in fresh snow, but becomes smaller with the passage of time due to compaction and changes in properties as well as soilage. In order to take these effects into consideration, the albedo of the snow is treated as a prognostic variable.

The time development of the age of the snow is, after Wiscombe and Warren (1980), assumed to be given by the following equation:

$$
 \frac {A_{g}^{\tau +1} - A_{g}^{\tau}}{\Delta t_L}
 = \left\{
\exp \left[ f_{ageT} \left( \frac{1}{T_{melt}}-\frac{1}{T_{Sn(1)}}\right) \right]
  + r_{dirt} \right\} \Bigm/ {\tau_{age}}
$$

where $f_{ageT}$ = 5000 and $\tau_{age}$ = 1 x 10<sup>6</sup>. $\tau_{age}$ is a parameter related to soilage which is given the value of 0.01 on the ice sheet and 0.3 elsewhere.

Using this, the albedo of the snow is solved by


$$
 \alpha_{Sn(b)}^{\tau+1} = \alpha_{Sn(b)}^{new} + \frac{A_g^{\tau+1}}{1+A_g^{\tau+1}} (\alpha_{Sn(b)}^{old} - \alpha_{Sn(b)}^{new}) \qquad (b=1,2,3)
$$


where $A_g^{\tau}$ is solved beforehand by calculating back from the prognostic variable $\alpha_{Sn(1)}^{\tau}$ using the same equation.

When snowfall has occurred, the albedo is updated to the value of the fresh snow in accordance with the snowfall:

$$
 \alpha_{Sn(b)}^{\tau+1} = \alpha_{Sn(b)}^{\tau+1}
+ \min\left( \frac{P_{Sn}^* \Delta t_L}{\Delta{Sn_c}}, 1 \right) (\alpha_{Sn(b)}^{new} - \alpha_{Sn(b)}^{\tau+1}) \qquad (b=1,2,3)
$$

$\Delta {Sn_c}$ is the snow water equivalent necessary for the albedo to fully return to the value of the fresh snow.

# 9 Runoff

The surface runoff and groundwater runoff are solved using a simplified TOPMODEL (Beven and Kirkby, 1979).

``` fortran
matrof.F !MATSIRO runoff submodel
```

## 9.1 Outline of TOPMODEL

In TOPMODEL, the horizontal distribution of a water table along the slope in a catchment basin is considered. The downward groundwater flow at a certain point on the slope is assumed to be equal to the accumulated groundwater recharge in the upper part of the slope above that point (quasi-equilibrium assumption). Then, the groundwater flow must be greater in the lower part of the slope. Under another assumption described later, for the groundwater flow to be greater, the water table needs to be shallow. Thus, the distribution is derived such that the lower the slope, the shallower the water table. When the mean water table is shallower than a certain level, the water table rises to the ground surface at an area lower than a certain point in the slope to form a saturated area. In this way, TOPMODEL is characterized by the mean water table, the size of the saturated area, and the groundwater flow velocity, which are important concepts for estimating the runoff, being physically connected in a coherent manner.

TOPMODEL contains the following major assumptions:

1.  The soil saturation hydraulic conductivity is attenuated toward the depth of the soil in the manner of an exponential function.

2.  The gradient of the water table is in close agreement locally with the gradient of the slope.

3.  The downward groundwater flow at a certain point on the slope is equal to the accumulated groundwater recharge in the upper slope above that point.

The usage of the symbols below is in accordance with the usual practice in descriptions of TOPMODEL (Sivapalan et al., 1987; Stieglitz et al., 1997).

Assumption 1 can be expressed as

$$
 K_s(z) = K_0 \exp (-f z)
$$

where $K_s(z)$ is the soil saturation hydraulic conductivity at depth $z$, $K_0$ is the saturation hydraulic conductivity at the ground surface, and  $f$ is the attenuation coefficient.

When the depth of the water table at a certain point ($i$)  is designated as $z_i$, the downward groundwater flux on the slope at that point ($q_i$) is

$$
 q_i = \int_{z_i}^Z K_s(z) dz \cdot \tan\beta
   = \frac{K_0}{f}  \tan\beta [\exp(-f z_i) - \exp(-f Z)] \tag{eq262}
$$


where $\beta$ is the gradient of the slope, and assumption 2 is applied here. $Z$ is the depth of the impervious surface; normally, however, $Z$ is assumed to be sufficiently deep compared with $1/f$, so the term $\exp(-f Z)$ is omitted. Moreover, since the slope direction soil moisture flux in the unsaturated zone above the water table is small, it is ignored.

If the groundwater recharge rate $R$ is assumed to be horizontally uniform, assumption 3 is expressed as

$$
 a R = \frac{K_0}{f} \tan\beta \exp(-f z_i)
$$

where $a$ is the total upstream area (per unit contour line length at point  $i$ with respect to point $i$.

When this is solved for $z_i$, the following is obtained:
$$
 z_i = -\frac{1}{f} \ln \left( \frac{faR}{K_0 \tan \beta}\right)  \tag{eq264}
$$

The averaged water table depth ($\overline{z}$) in domain $A$ is


$$
   \overline{z} = \frac1{A}\int_{A} z_i dA
  = - \Lambda - \frac1{f} \ln R  \tag{eq265}
$$


$$
 \Lambda \equiv
  \frac1{A}\int_{A} \ln \left( \frac{fa}{K_0 \tan \beta}\right) dA  \tag{eq266}
$$


The recharge rate  $R$ can then be expressed as a function of the mean water table depth ($\overline{z}$) as follows:


$$
 R = \exp (-f \overline{z} -\Lambda)  \tag{eq267}
$$

Under assumption 3, this is exclusively the groundwater runoff discharged from domain  $A$.

Next, if $R$ is substituted into Eq. (264), the following relationship of $z_i$ and $\overline{z}$ is obtained:

$$
 z_i = \overline{z} - \frac{1}{f} \left[
\ln \left( \frac{fa}{K_0 \tan \beta}\right) - \Lambda
\right]  \tag{eq268}
$$

The domain that satisfies $z_i \leq 0$ is the surface saturated area.

## 9.2 Application of TOPMODEL assuming simplified topography

Normally, when TOPMODEL is used, detailed topographical data on the target area is required. Here, however, the average shape of the slope in a grid cell is roughly estimated from the data on the average inclination and the standard deviation of the altitude in the grid (this estimation method is temporary at this stage, and further study is required).

The topography in the grid cell is represented by the slope with uniform gradient $\beta_s$ and the distance from the ridge to valley $L_s$.

$L_s$ is estimated using the standard deviation of altitude ($\sigma_z$) as follows:


$$
 L_s = 2\sqrt{3} \sigma_z / \tan\beta_s
$$


where $2\sqrt{3}\sigma_z$ is the altitude difference between the ridge and valley in serrate topography such that the standard deviation of altitude is $\sigma_z$.

The x-axis is taken from the ridge toward the valley on the horizontal surface. Then, the total upstream area at point $x$ is $x$, and Eq. (264) becomes

$$
 z(x) = - \frac{1}{f} \ln \left( \frac{fxR}{K_0 \tan \beta_s}\right)
$$

Using this, from [Eq. (265)](#eq265) the mean water table is

$$
 \overline{z} = \frac 1{L_s}\int_0^{L_s} z(x) dx
 = - \frac1{f}\left[
 \ln \left( \frac{f L_s R}{K_0 \tan\beta_s}\right) -1
\right]
$$


from [Eq. (267)](#eq267) the groundwater recharge rate is

$$
 R = \frac{K_0 \tan\beta_s}{f L_s}\exp(1-f \overline{z}) \tag{eq272}
$$

and from [Eq. (268)](#eq268), the relationship between the water table at point $x$ and the mean water table is

$$
 z(x) = \overline{z} - \frac{1}{f}\left(
\ln \frac{x}{L_s} + 1
\right)
$$


If  $z(x) \leq 0$ is solved for $x$, the following are obtained:

$$
 x \geq x_0
$$


$$
x_0 = L_s \exp(f\overline{z}-1)
$$


Therefore, the fraction of the saturated area is solved as


$$
 A_{sat} = (L_s - x_0)/ L_s = 1 - \exp(f\overline{z}-1) \tag{eq276}
$$


However, $A_{sat} \geq 0$ and $\overline{z} > 1/f$, and when $A_{sat} \geq 0$ and $\overline{z} > 1/f$, no saturated area exists.

## 9.3 Calculation of runoff

Four types of runoff mechanisms are considered, and the total of the runoffs by each mechanism is assumed to be the total runoff from the grid cell:

$$
 Ro = Ro_s + Ro_i + Ro_o + Ro_b
$$

where $Ro_s$ is the saturation excess runoff (Dunne runoff), $Ro_i$ is the infiltration excess runoff (Horton runoff), and $Ro_o$  is the overflow of the uppermost soil layer, these three being classified as the surface runoff; and $Ro_b$  is the groundwater runoff.

### 9.3.1 Estimation of mean water table depth

The soil moisture is examined from the lowest soil layer. When a layer that becomes unsaturated for the first time is assumed to be the $k_{WT}$th layer, the mean water table depth  ($\overline{z}$) is estimated by

$$
 \overline{z} = z_{g(k_{WT}-1/2)} - \psi_{k_{WT}}
$$

This is equivalent to considering the moisture potential on the upper boundary of the unsaturated layer as \psi_{k_{WT}}$, and the soil moisture distribution as being in the equilibrium state underneath (i.e., the state in which gravity and the capillary force are in equilibrium).

When $\overline{z} > z_{g(k_{WT}+1/2)}$ is the lowest layer, the water table is assumed to not exist. When $k_{WT}$  is not the lowest layer, the layer below (the uppermost layer among the saturated layers) is assumed to be $k_{WT}$ and the above equation is applied.

When there is a frozen soil surface in the middle of the soil, estimation of the water table depth is performed from above the frozen soil surface.

### 9.3.2 Calculation of groundwater runoff

From the quasi-equilibrium assumption, the groundwater runoff is equal to the groundwater recharge rate in [Eq. (272)](#eq272); therefore,

$$
 Ro_b = \frac{K_0 \tan\beta_s}{f L_s}\exp(1-f \overline{z})
$$

However, when a frozen soil surface exists under the water table, referring to the case of not omitting the term $\exp(-fZ)$ in [Eq. (262)](#eq262), it is assumed that

$$
 Ro_b = \frac{K_0 \tan\beta_s}{f L_s}
  [ \exp(1-f \overline{z}) - \exp(1-f z_f) ]
$$

where $z_f$  is the depth of the frozen soil surface. Although other relations in TOPMODEL should also be changed in such a case, the other relations are not changed here for the sake of simplification.

When there is an unfrozen layer under the frozen soil surface and a water table exists, the groundwater runoff from there is added by a similar calculation.

The water content from the groundwater runoff is removed from the  $k_{WT}$th soil layer:

$$
 Ro_{(k_{WT})} = Ro_b
$$

where $Ro_{(k)}$ denotes the runoff flux from the $k_{WT}$th soil layer.

### 9.3.3 Calculation of surface runoff

All of the rainfall that falls on the surface saturated area runs off as is (saturation excess runoff):

$$
 Ro_s = (Pr_c^{**} + Pr_l^{**}) A_{sat}
$$

The fraction of the surface saturated area $A_{sat}$ is given by [Eq. (276)](#eq276). Here, the correlation between the rainfall distribution of the subgrid and topography is ignored.

With regard to rainfall that falls on the surface unsaturated area, only the portion that exceeds the soil infiltration capacity runs off (infiltration excess runoff). The soil infiltration capacity is given by the saturation hydraulic conductivity of the uppermost soil layer for simplification. The convective precipitation is considered to fall locally, and the fraction of the precipitation area ($A_c$) is assumed to be uniform (0.1 as a standard value). The stratiform precipitation is also assumed to be uniform.

$$
 Ro_i^c = \max( Pr_c^{**}/A_c + Pr_l^{**} - K_{s(1)}, 0 ) (1 - A_{sat}) \\
 Ro_i^{nc} = \max( Pr_l^{**} - K_{s(1)}, 0 ) (1 - A_{sat})
$$



$$
 Ro_i = A_c Ro_i^c + ( 1 - A_c ) Ro_i^{nc}
$$

where $Ro_i^c$ and $Ro_i^{nc}$ are $Ro_i$in the convective precipitation area and nonconvective precipitation area, respectively; and $K_{s(1)}$is the saturation hydraulic conductivity in the uppermost soil layer.

The overflow of the uppermost soil layer, allowing a small amount of ponding  $w_{str}$ (1 mm as a standard value), is assumed to be

$$
 Ro_o = \max(w_{(1)} - w_{sat(1)} - w_{str}, 0) \rho_w \Delta z_{g(1)} / \Delta t_L
$$

This portion is subtracted from the uppermost soil layer later, and therefore should be remembered as the runoff from the uppermost layer, as follows.

$$
 Ro_{(1)} = Ro_{(1)} + Ro_o
$$

## 9.4 Water flux given to soil

The water flux given to the soil through the runoff process is

$$
 Pr^{*** } = Pr^{**}_c + Pr^{**}_l - Ro_s - Ro_i
$$

# 10 Soil

The soil temperature, the soil moisture, and the frozen soil are calculated next.

## 10.1 Calculation of soil heat conduction

### 10.1.1 Soil heat conduction equations

The prognostic equation for the soil temperature by soil heat conduction is

$$
C_{g(k)} \frac{T_{g(k)}^* - T_{g(k)}^{\tau}}{\Delta t_L} = F_{g(k+1/2)} - F_{g(k-1/2)}
\qquad (k=1,\ldots,K_{g}) \tag{eq289}
$$

with $C_{g(k)}$ , the soil heat capacity, defined by

$$
 C_{g(k)} = ( c_{g(k)} + \rho_w c_{pw} w_{(k)} ) \Delta z_{g(k)}
$$

where $c_{g(k)}$ is the specific heat of the soil, and is given as a parameter for each soil type; $c_{pw}$ is the specific heat of the water; $w_{(k)}$ is the soil moisture (volumetric moisture content); and $\Delta z_{g(k)}$  is the thickness of the $k$ th soil layer. When including the heat capacity of the soil moisture in the soil heat capacity in this way, unless the heat transfer accompanying the soil moisture movement is considered, the energy is not conserved. The heat transfer accompanying the soil moisture movement is not considered in the MATGND soil submodel at present, and its introduction is under study. However, it should be noted that unless the heat capacity of such elements as vapor in the atmosphere, rainfall, etc. is considered, the conservation of energy is disrupted in certain respects.

The heat conduction flux $F_{g}$ is given by


$$
 F_{g(k+1/2)} =
\left\{
\begin{array}{ll}
F_{g(1/2)} - \Delta F_{conv}^* - \Delta F_{c,conv}^*
 (k=0)\\
\displaystyle{
k_{g(k+1/2)} \frac{T_{g(k+1)} - T_{g(k)}}{\Delta z_{g(k+1/2)}}
}
 (k=1,\ldots,K_{g}-1) \\
\displaystyle{
0
}
 (k=K_{g})
\end{array}
\right. \tag{eq291}
$$

with $k_{g(k+1/2)}$, the soil heat conductivity, expressed as

$$
 k_{g(k+1/2)} = k_{g0(k+1/2)} [ 1 + f_{kg} \tanh( w_{(k)}/ w_{kg} ) ]
$$

where $k_{g0(k+1/2)}$ is the heat conductivity when the soil moisture is 0, and $f_{kg}=6$ and $w_{kg}=0.25$  are constants.

$\Delta z_{g(k+1/2)}$ is the thickness between the soil temperature definition points of the $k+1$th layer and the $k+1$th layer (when $k=0$, the thickness between the uppermost layer temperature definition point and the soil upper boundary; when $k=K_g$, the thickness between the lowest layer temperature definition point and the soil lower boundary).

In [Eq. (291)](#eq291), the value given to the soil upper boundary condition ($F_{g(1/2)}$) is the value obtained at the time of solving the ground surface energy balance, with the addition of the energy convergence at the snow lower boundary (including the heat conduction flux at the snow lower boundary) as well as the allotment to the snow-free portion of the energy correction term due to phase change of the canopy water. The flux takes an upward (positive) direction, so when the amount of convergence is added it has a negative sign. The soil lower boundary condition $F_{g(K_g+1/2)}$ is assumed to be zero flux.

### 10.1.2 Solution of heat conduction equations

These equations are solved using the implicit method with regard to the soil temperature from the uppermost layer to the lowest layer. That is, for $k=1,\ldots,K_g-1$, the heat conduction flux is expressed as


$$
  F_{g(k+1/2)}^{*} = F_{g(k+1/2)}^{\tau}
+\frac{\partial {F}_{g(k+1/2)}}{\partial T_{g(k)}}
 \Delta T_{g(k)}
+\frac{\partial {F}_{g(k+1/2)}}{\partial T_{g(k+1)}}
 \Delta T_{g(k+1)}
$$


$$
  F_{g(k+1/2)}^{\tau} =
\frac{k_{g(k+1/2)}}{\Delta z_{g(k+1/2)}}(T_{g(k+1)}^{\tau} - T_{g(k)}^{\tau})
$$


$$
 \frac{\partial {F}_{g(k+1/2)}}{\partial T_{g(k)}} =
- \frac{k_{g(k+1/2)}}{\Delta z_{g(k+1/2)}}
$$


$$
 \frac{\partial {F}_{g(k+1/2)}}{\partial T_{g(k+1)}} =
\frac{k_{g(k+1/2)}}{\Delta z_{g(k+1/2)}}
$$


and [Eq. (289)](#eq289) is treated as


$$
C_{g(k)} \frac{\Delta T_{g(k)}}{\Delta t_L}
= F_{g(k+1/2)}^* - {F}_{g(k-1/2)}^*  \\
= {F}_{g(k+1/2)}^{\tau}
+\frac{\partial F_{g(k+1/2)}}{\partial T_{g(k)}}
 \Delta T_{g(k)}
+\frac{\partial F_{g(k+1/2)}}{\partial T_{g(k+1)}}
 \Delta T_{g(k+1)}  \\
- F_{g(k-1/2)}^{\tau}
-\frac{\partial F_{g(k-1/2)}}{\partial T_{g(k-1)}}
 \Delta T_{g(k-1)}
-\frac{\partial F_{g(k-1/2)}}{\partial T_{g(k-1)}}
 \Delta T_{g(k)}
$$

and solved by the LU factorization method as $K_{g}$  simultaneous equations with respect to $\Delta T_{g(k)}\ (k=1,\ldots,K_{g})$. At this juncture, it should be noted that the equations are solved with the fluxes at the soil upper boundary and lower boundary fixed as the boundary conditions:

$$
 T_{g(k)}^* = T_{g(k)}^{\tau} + \Delta T_{g(k)}
$$

The soil temperature is partially updated by the above equation. By this, as well as through correction of the phase change in the soil moisture mentioned later, the soil temperature is completely updated.

## 10.2 Calculation of soil moisture movement

### 10.2.1 Soil moisture movement equations

The equation for soil moisture movement (Richards equation) is given by

$$
\rho_w \frac{w_{(k)}^{\tau+1} - w_{(k)}^{\tau}}{\Delta t_L} =
\frac{F_{w(k+1/2)} - F_{w(k-1/2)}}{\Delta z_{g(k)}} + S_{w(k)}
\qquad (k=1,\ldots,K_{g}) \tag{eq299}
$$

The soil moisture flux $F_{w}$ is given by


$$
 F_{w(k+1/2)} =
\left\{
\begin{array}{ll}
Pr^{*** } - Et_{(1,1)}
 (k=0)\\
\displaystyle{
K_{(k+1/2)} \left(\frac{\psi_{(k+1)} - \psi_{(k)}}{\Delta z_{g(k+1/2)}} - 1 \right)
}
 (k=1,\ldots,K_{g}-1) \\
\displaystyle{
0
}
 (k=K_{g})
\end{array}
\right. \tag{eq300}
$$

in which $K_{(k+1/2)}$ is the soil hydraulic conductivity that, referring to Clapp and Hornberger (1978), is expressed as

$$
 K_{(k+1/2)} = K_{s(k+1/2)} (\max(W_{(k)},W_{(k+1)}))^{2b(k)+3} f_i
$$

where $K_{s(k+1/2)}$ is the saturation hydraulic conductivity and $b_{(k)}$ is the index of the moisture potential curve, which are given as external parameters for each soil type. $W_{(k)}$ is the degree of saturation considered excluding the frozen soil moisture, given by

$$
 W_{(k)} = \frac{w_{(k)}-w_{i(k)}}{w_{sat(k)}-w_{i(k)}}
$$



where $w_{sat(k)}$  is the porosity of the soil, which is also given as a parameter for each soil type. $f_i$ is a parameter that denotes that soil moisture movement is suppressed by the existence of frozen soil. Although further study of this point is required, at present it is given by

$$
 f_i = \left(1- W_{i(k)}\right)
       \left(1- W_{i(k+1)}\right)
$$

where $W_{i(k)} = w_{i(k)}/(w_{sat(k)}-w_{i(k)})$.

The soil moisture potential $\psi$ is given as follows from Clapp and Hornberger:


$$
 \psi_{(k)} = \psi_{s(k)} W_{(k)}^{-b(k)}
$$

where $\psi_{s(k)}$ is given as an external parameter for each soil type.

In [Eq. (299)](#eq299), $S_{w(k)}$ is a source term which, considering the root uptake and the runoff, is given by

$$
 S_{w(k)} = - F_{root(k)} - Ro_{(k)}
$$


In [Eq. 300](#eq300), the soil upper boundary condition $F_{w(1/2)}$ is the difference between the moisture flux through the runoff process ($P^{*** }$) and　the evaporation flux from the soil ($Et_{(1,1)}$). Separately from this, the sublimation flux portion is subtracted from the frozen soil moisture of the uppermost layer before calculation of the soil moisture movement:

$$
 w_{i(k)}^{\tau} = w_{i(k)}^{\tau} - Et_{(2,1)} \Delta t_L /(\rho \Delta z_{g(1)})\\
 w_{(k)}^{\tau} = w_{(k)}^{\tau} - Et_{(2,1)} \Delta t_L /(\rho \Delta z_{g(1)})
$$

### 10.2.2 Solution of soil moisture movement equations

These equations are solved by using the implicit method for the soil moisture from the uppermost layer to the lowest layer. For $k=1,\ldots,K_g-1$, the soil moisture flux is


$$
  F_{w(k+1/2)}^{\tau+1} = F_{w(k+1/2)}^{\tau}
+\frac{\partial {F}_{w(k+1/2)}}{\partial w_{(k)}}
 \Delta w_{(k)}
+\frac{\partial {F}_{w(k+1/2)}}{\partial w_{(k+1)}}
 \Delta w_{(k+1)}
$$


$$
  F_{w(k+1/2)}^{\tau} =
K_{(k+1/2)} \left(\frac{\psi_{(k+1)}^{\tau} - \psi_{(k)}^{\tau}}{\Delta z_{g(k+1/2)}} - 1 \right)
$$


$$
 \frac{\partial {F}_{w(k+1/2)}}{\partial w_{(k)}} =
- \frac{K_{(k+1/2)}}{\Delta z_{g(k+1/2)}}
\left[
-b_{(k)} \frac{\psi_{s(k)}}{w_{sat(k)}-w_{i(k)}}W_{(k)}^{-b(k)-1}
\right]
$$


$$
 \frac{\partial {F}_{w(k+1/2)}}{\partial w_{(k+1)}} =
 \frac{K_{(k+1/2)}}{\Delta z_{g(k+1/2)}}
\left[
-b_{(k)} \frac{\psi_{s(k+1)}}{w_{sat(k+1)}-w_{i(k+1)}}W_{(k+1)}^{-b(k)-1}
\right]
$$


and [Eq. (299)](#eq299) is treated as


$$
\rho_w \Delta z_{g(k)} \frac{\Delta w_{(k)}}{\Delta t_L}
= F_{w(k+1/2)}^{\tau+1} - {F}_{w(k-1/2)}^{\tau+1} + S_{w(k)} \Delta z_{g(k)}  \\
= {F}_{w(k+1/2)}^{\tau}
+\frac{\partial F_{w(k+1/2)}}{\partial w_{(k)}}
 \Delta w_{(k)}
+\frac{\partial F_{w(k+1/2)}}{\partial w_{(k+1)}}
 \Delta w_{(k+1)}  \\
- F_{w(k-1/2)}^{\tau}
-\frac{\partial F_{w(k-1/2)}}{\partial w_{(k-1)}}
 \Delta w_{(k-1)}
-\frac{\partial F_{w(k-1/2)}}{\partial w_{(k-1)}}
 \Delta w_{(k)} + S_{w(k)} \Delta z_{g(k)}
$$


and solved by the LU factorization method as $K_g$ simultaneous equations with respect to $\Delta T_{g(k)}\ (k=1,\ldots,K_{g})$. At this juncture, it should be noted that the equations are solved with the fluxes at the soil upper boundary and lower boundary fixed as the boundary conditions.

The soil moisture is updated by

$$
 w_{(k)}^{\tau+1} = w_{(k)}^{\tau} + \Delta w_{(k)}
$$

As a result of this calculation, if a part appears where the soil moisture become supersaturated, it is adjusted in the vertical direction to eliminate supersaturation. The reason why such a supersaturated portion is not considered as runoff is that this supersaturation is artificially produced because the vertical movement of the soil moisture is solved without saturation data. First, from the second soil layer downwards, the supersaturated portion of the soil moisture is given to the layer below. Next, from the lowest soil layer upwards, the supersaturated portion of the soil moisture is given to the next layer up. With this operation, when the soil moisture is large enough, a saturated layer around the lowest soil layer is formed and the water table of Eq. (278) can be defined.

## 10.3 Phase change of soil moisture

As a result of calculating the soil heat conductivity, when the temperature in the layer containing liquid water is lower than $T_{melt}=0degC$, or when the temperature in the layer containing solid water is higher than $T_{melt}$, the phase change of the soil moisture is calculated. If the amount of freeze (adjustment portion) of the soil moisture in the $k$th layer is assumed to be $\Delta w_{i(k)}$,

when $T_{g(k)}^*<T_{melt}$ and $w_{(k)}^{\tau+1}-w_{i(k)}^{\tau}>0$ (frozen):

$$
\Delta w_{i(k)} = \min\left(
\frac{C_{g(k)}(T_{melt}-T_{g(k)}^*)}{l_m \rho_w \Delta z_{g(k)}}, \
w_{(k)}^{\tau+1}-w_{i(k)}^{\tau}
\right)
$$

when $T_{g(k)}^*>T_{melt}$ and $w_{i(k)}^{\tau}>0$ (melting):


$$
\Delta w_{i(k)} = \max\left(
\frac{C_{g(k)}(T_{melt}-T_{g(k)}^*)}{l_m \rho_w \Delta z_{g(k)}}, \
-w_{i(k)}^{\tau}
\right)
$$

The frozen soil moisture and the soil moisture are then updated as follows:


$$
w_{i(k)}^{\tau+1} = w_{i(k)}^{\tau} + \Delta w_{i(k)} \\
T_{g(k)}^{\tau+1} = T_{g(k)}^* + l_m \rho_w \Delta z_{g(k)} \Delta w_{i(k)} / C_{g(k)}
$$


### 10.3.1 Ice sheet process

When the land cover type is ice sheet, if the soil temperature exceeds $T_{melt}$, it is returned to $T_{melt}$:


$$
 T_{g(k)}^{\tau+1} = \min( T_{g(k)}^*, \ T_{melt} )
$$


The rate of change of the ice sheet *F<sub>ice</sub>* is then diagnosed as

$$
 F_{ice} = - Et_{(2,1)} - \frac{C_{g(k)}\max(T_{g(k)}^* - T_{melt},\ 0)}{l_m \Delta t_L}
$$

# 11 Lake



# 12 Wetland



# 13 Tile scheme



# References
  -
    Ball, J. T., 1988: An analysis of stomatal conductance. Ph.D. thesis, Stanford University, 89 pp.

  -
    Beven, K. J., and M. J. Kirkby, 1979: A physically based variable contributing area model of basin hydrology, <span>Hydrol. Sci. Bull.</span>, <span>**24**</span>, 43–69.

  -
    Clapp, R. B., and G. M. Hornberger, 1978: Empirical equations for some soil hydraulic properties. <span>Water Resour. Res.</span>, <span>**14**</span>, 601–604.

  -
    Collatz, G. J., J. A. Berry, G. D. Farquhar, and J. Pierce, 1990: The relationship between the Rubisco reaction mechanism and models of leaf photosynthesis. <span>Plant Cell Environ.</span>, <span>**13**</span>, 219–225.

  -
    Collatz, G. J., J. T. Ball, C. Grivet, and J. A. Berry, 1991: Physiological and environmental regulation of stomatal conductance, photosynthesis and transpiration: A model that includes a laminar boundary layer. <span>Agric. For. Meteor.</span>, <span>**54**</span>, 107–136.

  -
    Collatz, G. J., M. Ribas-Carbo, and J. A. Berry, 1992: Coupled Photosynthesis-Stomatal Conductance Model for leaves of TERM00000 plants. <span>Aust. J. Plant. Physiol.</span>, <span>**19**</span>, 519–538.

  -
    Farquhar, G. D., S. von Caemmerer, and J. A. Berry, 1980: A biochemical model of photosynthetic TERM00001 fixation in leaves of TERM00002 species. <span>Planta</span>, <span>**149**</span>, 78–90.

  -
    Kondo, J., and T. Watanabe, 1992: Studies on the bulk transfer coefficients over a vegetated surface with a multilayer energy budget model. <span>J. Atmos. Sci</span>, <span>**49**</span>, 2183–2199.

  -
    Rutter, B., A. J. Morton, and P. C. Robins, 1975: A predictive model of rainfall interception in forests. II. Generalization of the model and comparison with observations in some coniferous and hardwood stands. <span>J. Appl. Ecol.</span>, <span>**12**</span>, 367–380.

  -
    Sellers, P. J., D. A. Randall, G. J. Collatz, J. A. Berry, C. B. Field, D. A. Dazlich, C. Zhang, G. D. Collelo, and L. Bounoua, 1996: A revised land surface parameterization (SiB2) for atmospheric GCMs. Part I: Model formulation. <span>J. Climate</span>, <span>**9**</span>, 676–705.

  -
    Sivapalan, M., K. Beven, and E. F. Wood, 1987: On hydrologic similarity. 2, A scaled model of storm runoff production. <span>Water Resour. Res</span>, <span>**23**</span>, 2266–2278.

  -
    Stieglitz, M., D. Rind, J. Famiglietti, and C. Rosenzweig, 1997: An efficient approach to modeling the topographic control of surface hydrology for regional and global climate modeling. <span>J. Climate</span>, <span>**10**</span>, 118–137.

  -
    Watanabe, T., 1994: Bulk parameterization for a vegetated surface and its application to a simulation of nocturnal drainage flow. <span>Boundary-Layer Met.</span>, <span>**70**</span>, 13–35.

  -
    Wiscombe, W. J., and S. G. Warren, 1980: A model for the spectral albedo of snow. I. Pure snow. <span>J. Atmos. Sci.</span>, <span>**37**</span>, 2712–2733.

  -
    渡辺力・大谷義一, 1995: キャノピー層内の日射量分布の近似計算法. <span>農業気象</span>, <span>**51**</span>, 57–60.
