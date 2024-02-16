---
bibliography:
        - reference.bib
---

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=true} -->

<!-- code_chunk_output -->

1. [Introduction](#introduction)
    1. [Structure](#structure)
    2. [Prognostic variables](#prognostic-variables)
    3. [Output data](#output-data)
    4. [Input data](#input-data)
    5. [External parameters](#external-parameters)
2. [Vegetation type parameters](#vegetation-type-parameters)
3. [Radiation parameters](#radiation-parameters)
    1. [Calculation of ground surface (forest floor) albedo](#calculation-of-ground-surface-forest-floor-albedo)
    2. [Calculation of canopy albedo and transmissivity](#calculation-of-canopy-albedo-and-transmissivity)
    3. [Calculation of surface radiation flux, etc.](#calculation-of-surface-radiation-flux-etc)
4. [Turbulence parameters (bulk coefficient)](#turbulence-parameters-bulk-coefficient)
    1. [Calculation of roughness with respect to momentum and heat](#calculation-of-roughness-with-respect-to-momentum-and-heat)
    2. [Calculation of bulk coefficient with respect to momentum and heat](#calculation-of-bulk-coefficient-with-respect-to-momentum-and-heat)
    3. [Calculation of bulk coefficient with respect to vapor](#calculation-of-bulk-coefficient-with-respect-to-vapor)
5. [Stomatal resistance](#stomatal-resistance)
    1. [Calculation of soil moisture stress factor](#calculation-of-soil-moisture-stress-factor)
    2. [Calculation of amount of photosynthesis](#calculation-of-amount-of-photosynthesis)
    3. [Calculation of stomatal resistance (2)](#calculation-of-stomatal-resistance-2)
    4. [Calculation of ground surface evaporation resistance](#calculation-of-ground-surface-evaporation-resistance)
6. [Surface energy balance](#surface-energy-balance)
    1. [Calculation of surface turbulent fluxes](#calculation-of-surface-turbulent-fluxes)
    2. [Calculation of heat conduction fluxes](#calculation-of-heat-conduction-fluxes)
    3. [Solution of energy balance at ground surface and canopy](#solution-of-energy-balance-at-ground-surface-and-canopy)
        1. [Energy balance at ground surface and canopy](#energy-balance-at-ground-surface-and-canopy)
        2. [Case 1: When there is no melting at the ground surface](#case-1-when-there-is-no-melting-at-the-ground-surface)
        3. [Case 2: When there is melting at the ground surface](#case-2-when-there-is-melting-at-the-ground-surface)
        4. [Conditions for solutions](#conditions-for-solutions)
        5. [Updating of ground surface and canopy temperatures](#updating-of-ground-surface-and-canopy-temperatures)
        6. [Updating of flux values](#updating-of-flux-values)
7. [Canopy Water Balance](#canopy-water-balance)
    1. [Diagnosis of canopy water phase](#diagnosis-of-canopy-water-phase)
    2. [Prognosis of canopy water](#prognosis-of-canopy-water)
        1. [Evaporation (sublimation) of canopy water](#evaporation-sublimation-of-canopy-water)
        2. [Interception of precipitation by the canopy](#interception-of-precipitation-by-the-canopy)
        3. [Dripping of the canopy water](#dripping-of-the-canopy-water)
        4. [Updating and melting of canopy water](#updating-and-melting-of-canopy-water)
    3. [Fluxes given to the soil, snow, and runoff process](#fluxes-given-to-the-soil-snow-and-runoff-process)
8. [Snow](#snow)
    1. [Diagnosis of snow cover fraction](#diagnosis-of-snow-cover-fraction)
        1. [Case 1: When OPT_SSNOWD is active](#case-1-when-opt_ssnowd-is-active)
        2. [Case 2: When OPT_SSNOWD is inactive](#case-2-when-opt_ssnowd-is-inactive)
    2. [Vertical division of snow layers](#vertical-division-of-snow-layers)
    3. [Calculation of snow water equivalent](#calculation-of-snow-water-equivalent)
        1. [Sublimation of snow](#sublimation-of-snow)
        2. [Snowmelt](#snowmelt)
        3. [Freeze of snowmelt water and rainfall in snow](#freeze-of-snowmelt-water-and-rainfall-in-snow)
        4. [Snowfall](#snowfall)
        5. [Redivision of snow layer and rediagnosis of temperature](#redivision-of-snow-layer-and-rediagnosis-of-temperature)
    4. [Calculation of snow heat conduction](#calculation-of-snow-heat-conduction)
        1. [Snow heat conduction equations](#snow-heat-conduction-equations)
        2. [Case 1: When snowmelt does not occur in the uppermost layer](#case-1-when-snowmelt-does-not-occur-in-the-uppermost-layer)
        3. [Case 2: When snowmelt occurs in the uppermost layer](#case-2-when-snowmelt-occurs-in-the-uppermost-layer)
    5. [Fluxes given to the soil or the runoff process](#fluxes-given-to-the-soil-or-the-runoff-process)
    6. [Glacier formation](#glacier-formation)
    7. [Dust in snow](#dust-in-snow)
        1. [Dust fall on the snow cover](#dust-fall-on-the-snow-cover)
        2. [Redistribution of dust](#redistribution-of-dust)
    8. [Albedo of snow and ice](#albedo-of-snow-and-ice)
        1. [Albedo of snow](#albedo-of-snow)
        2. [Albedo of ice](#albedo-of-ice)
9. [Runoff](#runoff)
    1. [Outline of TOPMODEL](#outline-of-topmodel)
    2. [Application of TOPMODEL assuming simplified topography](#application-of-topmodel-assuming-simplified-topography)
    3. [Calculation of runoff](#calculation-of-runoff)
        1. [Estimation of grid average water table depth](#estimation-of-grid-average-water-table-depth)
        2. [Calculation of groundwater runoff](#calculation-of-groundwater-runoff)
        3. [Calculation of surface runoff](#calculation-of-surface-runoff)
    4. [Water flux given to soil](#water-flux-given-to-soil)
10. [Soil](#soil)
    1. [Calculation of soil heat conduction](#calculation-of-soil-heat-conduction)
        1. [Soil heat conduction equations](#soil-heat-conduction-equations)
        2. [Solution of heat conduction equations](#solution-of-heat-conduction-equations)
    2. [Calculation of soil moisture movement](#calculation-of-soil-moisture-movement)
        1. [Soil moisture movement equations](#soil-moisture-movement-equations)
        2. [Solution of soil moisture movement equations](#solution-of-soil-moisture-movement-equations)
    3. [Phase change of soil moisture](#phase-change-of-soil-moisture)
        1. [Ice sheet process](#ice-sheet-process)
11. [Lake](#lake)
    1. [Calculation of lake surface conditions](#calculation-of-lake-surface-conditions)
        1. [Calculation of lake surface albedo](#calculation-of-lake-surface-albedo)
        2. [Lake surface roughness](#lake-surface-roughness)
    2. [Solution of energy balance at lake surface](#solution-of-energy-balance-at-lake-surface)
    3. [Calculation of lake ice](#calculation-of-lake-ice)
        1. [Calculation of heat flux and growth rate](#calculation-of-heat-flux-and-growth-rate)
        2. [Sublimation and freshwater flux for lake](#sublimation-and-freshwater-flux-for-lake)
        3. [Updating lake ice fraction](#updating-lake-ice-fraction)
        4. [Growth and Melting of lake ice and snow](#growth-and-melting-of-lake-ice-and-snow)
            1. [Freshwater flux to lake ice and snow](#freshwater-flux-to-lake-ice-and-snow)
            2. [Growth of lake snow](#growth-of-lake-snow)
            3. [Growth of lake ice](#growth-of-lake-ice)
            4. [Lake ice flows](#lake-ice-flows)
            5. [Sinking snow](#sinking-snow)
    4. [Physical formulation and process](#physical-formulation-and-process)
        1. [Setting the vertical diffusion coefficients](#setting-the-vertical-diffusion-coefficients)
        2. [Estimate the diffusion terms of the tracer equations](#estimate-the-diffusion-terms-of-the-tracer-equations)
        3. [Time integration of the tracer equations](#time-integration-of-the-tracer-equations)
        4. [The vertical convection](#the-vertical-convection)
    5. [Lake river coupling](#lake-river-coupling)
12. [Wetland](#wetland)
    1. [Outline of wetland scheme](#outline-of-wetland-scheme)
    2. [Inflow and outflow of the wetland](#inflow-and-outflow-of-the-wetland)
    3. [Storage of the surface runoff](#storage-of-the-surface-runoff)
    4. [Water input of soil surface](#water-input-of-soil-surface)
13. [Tile scheme](#tile-scheme)
14. [References](#references)

<!-- /code_chunk_output -->


# Introduction

Minimal Advanced Treatments of Surface Interaction and RunOff (MATSIRO) is a land surface parameterization originally formulated in the early 2000's [@Takata2003-xc] to produce terrestrial boundary condition of the atmospheric general circulation model developed by the Center for Climate System Research at the University of Tokyo and the National Institute for Environmental Studies (CCSR/NIES AGCM), as well as to other global climate models. It was originally designed to be primarily used for integration of climate simulations such as those involving long time scales from one month to several hundred years coupled with the atmospheric model at grid resolutions of tens of kilometers or more. The main objective in its development was to represent all of the important water and energy exchange processes between land and atmosphere as fully and accurately as possible (i.e., advanced treatment) in such time and spatial scales, while modeling them as simply as possible (i.e., minimal treatment) so as to allow the results to be easily interpreted.

At the very early stage (2000's), when the first description was written by Emori [@Emori2001-qr], MATSIRO was developed based on the land surface submodel of CCSR/NIES AGCM5.4g coupled with the parameterization for a vegetated surface (canopy) by [@Watanabe1994-sx], while at the same time improving certain processes such as those related to snow and runoff. Subsequently, with modifications in the structure of AGCM, changes were made dealing with flux couplers and parallel processing so as to make it compatible with AGCM5.6. With regard to the physiological processes of vegetation, a Jarvis-type function was initially used for stomatal resistance. Later, however, the Farquhar-type photosynthesis scheme, which served as a de facto standard in the world due to the progress of studies on climate-ecosystem interactions at that time, was ported from SiB2 code.

Since then, MATSIRO has been used in CCSR/NIES/FRCGC AGCM5.7, which is adopted by an atmosphere-ocean coupled model MIROC3 [@K-1_Model_Developers2004-lg], and MIROC5 [@Watanabe2010-iv] with only minor model updates and bug fixes. Instead, during these times, MATSIRO had been intensively used with so-called offline setting (i.e., without coupling with the atmospheric model, but forced with given surface atmospheric forcings) with original updates and improvements of some processes. Such efforts generate some branches of the model, called MAT-GW [water table depth dynamics; @Koirala2014-lq], HiGW-MAT [coupled with anthropogenic activity and groundwater; @Pokhrel2015-yk], IsoMATSIRO [stable water isotopes included; @Yoshimura2006-ub]. MATSIRO also has been validated and compared with other land surface parameterizations under some international protocols like PILPS, GSWP, and ISIMIP. By these attempts, it was revealed that, apart from its original design, MATSIRO was able to be used for higher resolution (up to about 1 kilometer) and shorter time scales (subdaily), so that MATSIRO is now used for short-term flood prediction over Japan with a new hydro-dynamical model, CaMa-Flood [@Yamazaki2011-gu], for example [@Ma2021-ey].

Here, with development of MIROC6 [@Tatebe2019-ow], MATSIRO adopted significant model updates, so we decided to update its description for the first time since 2001. We named this version of MATSIRO as MATSIRO6. Major and minor updates in this document are as follows:

- Snow cover fraction diagnosis (Chapter 8)
- Runoff representation (Chapter 9)
- Lake process coupled with river (Chapter 11)
- Snow-fed wetland process (Chapter 12)
- Tiling with lake, cropland, and natural vegetation (Chapter 13)

It should be noted that even though river routing process is also implemented in MIROC6 and other versions, this document does not include description of river process.


## Structure

MATSIRO consists of flux calculation section and land integration section. In the flux calculation section, the calculations are conducted separately for snow-covered and snow-free potions. For each snow-free portion ($l=1$) and snow-covered portion ($l=2$), the subroutines for various processes are called, the fluxes are calculated, and the ground surface temperature and canopy temperature are updated. Specifically, the following subroutines are called in the order shown below:

(a) MATLAI: vegetation type parameter (LAI, vegetation height) set
(b) MATRAD: calculation of radiation parameters (albedo, vegetation transmissivity, etc.)
(c) MATBLK: calculation of turbulence parameters (bulk coefficients)
(d) MATRST: calculation of stomatal resistance, bare soil surface evaporation resistance, etc.
(e) MATFLX: calculation of surface flux
(f) MATGHC: calculation of ground heat conduction
(g) MATSHB: solution of surface heat balance

Then, fluxes from lake surface are calculated separately for ice-covered and ice-free portions. The following subroutines are called in the order shown below:

(h) LAKEBC: calculation of lake surface conditions (albedo, roughness, etc.)
(i) SFCFLX: calculation of surface flux
(j) RADSFC: calculation of radiation flux (downward and upward shortwave radiation)
(k) LAKEHB: solution of energy balance at lake surface


In the land integration section, the subroutines for various processes are called and land surface prognostic variables are updated. Specifically, the following subroutines are called in the order shown below:

(l) MATCNW: calculation of canopy water balance
(m) MATSNW: calculation of snow water equivalent, snow temperature, and snow albedo
(n) MATROF: calculation of runoff
(o) MATGND: calculation of soil temperature, soil moisture, and frozen soil

Finally, the lake modules are called and the related prognostic variables are updated.

(p) SETSCNV: calculation of convergence of shortwave radiation
(q) LAKEIC: calculation of lake ice
(r) LAKEPO: calculation of lake water and temperature
(s) PUTDEFF: sending a lake water deficit for the lakes whose water levels are below the lower limit


## Prognostic variables

MATSIRO has the following prognostic variables for each tile:

| Variable                                | Description                                             | Units                |
|:----------------------------------------|:--------------------------------------------------------|:---------------------|
| $T_{s(l)}$        $(l=1,2)$             | Ground surface temperature                              | $\mathrm{[K]}$       |
| $T_{c(l)}$        $(l=1,2)$             | Canopy temperature                                      | $\mathrm{[K]}$       |
| $T_{g(k)}$        $(k=1,\ldots,K_g)$    | Soil temperature                                        | $\mathrm{[K]}$       |
| $w_{(k)}$         $(k=1,\ldots,K_g)$    | Soil moisture content                                   | $\mathrm{[m^3/m^3]}$ |
| $w_{i(k)}$        $(k=1,\ldots,K_g)$    | Frozen soil moisture content                            | $\mathrm{[m^3/m^3]}$ |
| $w_c$                                   | Water content on the canopy                             | $\mathrm{[m]}$       |
| $Sn$                                    | Snow water equivalent                                   | $\mathrm{[kg/m^2]}$  |
| $T_{Sn(k)}$       $(k=1,\ldots,K_{Sn})$ | Snow temperature                                        | $\mathrm{[K]}$       |
| $\alpha_{Sn(b)}$  $(b=1,2,3)$           | Snow albedo                                             | $\mathrm{[-]}$       |
| $A_{Sn}$                                | Snow cover fraction                                     | $\mathrm{[-]}$       |
| $\mu$                                   | Accumulated snowfall                                    | $\mathrm{[kg/m^2]}$  |
| $D_m$                                   | Accumulated snowmelt                                    | $\mathrm{[kg/m^2]}$  |
| $R_{sn}$                                | Reset flag for snow accumulation or ablation season     | $\mathrm{[-]}$       |
| $I_{sn}$                                | Snow index                                              | $\mathrm{[-]}$       |
| $A_{L}$                                 | Land cover fraction                                     | $\mathrm{[-]}$       |
| $T_{hist}$                              | Long-term mean temperature                              | $\mathrm{[K]}$       |
| $\rho_d$                                | Dust density in snow                                    | $\mathrm{[ppmw]}$    |
| $\rho_d$                                | Dust density in snow (mass)                             | $\mathrm{[ppmw]}$    |
| $\alpha_{ice(b)}$                       | Ice albedo                                              | $\mathrm{[-]}$       |
Table: Prognostic variables


where $l=1,2$ denotes snow-free and snow-covered portions, respectively; $k$ is the vertical layer number of the soil or snow (the uppermost layer is 1, with the number increasing as the layer becomes deeper);  $K_g$ is the number of soil layers; $K_{Sn}$ is the number of snow layers; and $b=1,2,3$ denotes the bands of visible, near infrared, and infrared wavelengths, respectively.

As the default setting, the soil has six layers whose thicknesses are defined by the depth boundaries of 5, 20, 75, 100, 200, and 1000 cm from the surface. The definition points of soil temperature, soil moisture, and frozen soil moisture are the same. The maximum number of snow layer is three by default, while the number is diagnosed from snow water equivalent. As the default setting, the maximum number is three layers.

The ground surface temperature and canopy temperature are so-called surface temperatures whose heat capacity is zero; however, they take the form of prognostic variables. (The current calculation method depends on the values of the preceding step because the stability, etc. assessed by the values of the preceding step are used. If the stability, etc. were to be assessed by updated values and calculation iterated to the point of convergence, perfect diagnostic variables would be obtained that would not depend on the values of the preceding step.) The other variables are all prognostic variables that always require the values of the preceding step.

The ground surface temperature and canopy temperature are updated in the flux calculation section. All of the other variables (original prognostic variables) are updated in the land surface integration section.


The lake part has the following prognostic variables:


| Variable   | Description                                             | Units                  |
|:-----------|:--------------------------------------------------------|:-----------------------|
| $T$        | Lake temperature                                        | $\mathrm{[^{\circ}C]}$ |
| $S$        | Lake salinity                                           | $\mathrm{[PSU]}$       |
| $T_I$      | Lake ice surface temperature                            | $\mathrm{[^{\circ}C]}$ |
| $A_I$      | Lake ice concentration                                  | $\mathrm{[-]}$         |
| $h_I$      | Mean lake ice thickness over ice-covered part of a grid | $\mathrm{[cm]}$        |
| $h_S$      | Mean snow depth over lake ice                           | $\mathrm{[cm]}$        |
| $h$        | Lake level                                              | $\mathrm{[cm]}$        |
Table: Prognostic variables for the lake scheme

## Output data

The following variables are output from the flux calculation section:

| Variable                              | Description                           | Units                 |
|:--------------------------------------|:--------------------------------------|:----------------------|
| $\tau_x$                              | Surface eastward wind stress          | $\mathrm{[N/m^2]}$    |
| $\tau_y$                              | Surface northward wind stress         | $\mathrm{[N/m^2]}$    |
| $H$                                   | Sensible heat flux                    | $\mathrm{[W/m^2]}$    |
| $E$                                   | Latent heat flux                      | $\mathrm{[kg/m^2/s]}$ |
| $R^{\uparrow}_S$                      | Upward shortwave radiation flux       | $\mathrm{[W/m^2]}$    |
| $R^{\uparrow}_L$                      | Upward longwave radiation flux        | $\mathrm{[W/m^2]}$    |
| $\alpha_{s(b)}$    $(b=1,2,3)$        | Surface albedo                        | $\mathrm{[-]}$        |
| $T_{sR}$                              | Surface radiation temperature         | [K]                   |
| $F_{g(1/2)}$                          | Surface heat transfer flux            | $\mathrm{[W/m^2]}$    |
| $F_{Sn(1/2)}$                         | Heat transfer flux for snow surface   | $\mathrm{[W/m^2]}$    |
| $Et_{(i,j)}$       $(i=1,2;j=1,2,3)$  | Evapotranspiration                    | $\mathrm{[kg/m^2/s]}$ |
| $\Delta F_{conv}$                     | surface energy convergence            | $\mathrm{[W/m^2]}$    |
| $F_{root(k)}$      $(k=1,\ldots,K_g)$ | Root sucking flux                     | $\mathrm{[kg/m^2/s]}$ |
| $LAI$                                 | leaf area index                       | $\mathrm{[m^2/m^2]}$  |
| $A_{Snc}$                             | Canopy freezing area ratio            | $\mathrm{[-]}$        |
Table: Output data from the flux calculation section

where  $i=1,2$  denotes liquid and solid evapotranspiration, respectively; and $j=1,2,3$ denotes evaporation from the bare soil surface (forest floor), transpiration, and canopy water evaporation, respectively. Other indexes are the same as described earlier.

The following variable is output from the land surface integration section:

| Variable | Description | Units                 |
|:---------|:------------|:----------------------|
| $Ro$     | runoff      | $\mathrm{[kg/m^2/s]}$ |
Table: Output data

Runoff is used as an input variable for the river channel network model.


## Input data

The following variables are input in the flux calculation section:

| Variable                                    | Description                                            | Units              |
|:--------------------------------------------|:-------------------------------------------------------|:-------------------|
| $u_a$                                       | Atmospheric 1st layer eastward wind                    | $\mathrm{[m/s]}$   |
| $v_a$                                       | Atmospheric 1st layer northward wind                   | $\mathrm{[m/s]}$   |
| $T_a$                                       | Atmospheric 1st layer temperature                      | $\mathrm{[K]}$     |
| $q_a$                                       | Atmospheric 1st layer specific humidity                | $\mathrm{[kg/kg]}$ |
| $P_a$                                       | Atmospheric 1st layer pressure                         | $\mathrm{[Pa]}$    |
| $P_s$                                       | Surface pressure                                       | $\mathrm{[Pa]}$    |
| $R^{\downarrow}_{(d,b)}$  $(d=1,2;b=1,2,3)$ | Surface downward radiation flux                        | $\mathrm{[W/m^2]}$ |
Table: Input data for land flux calculation

where $d=1,2$ denotes direct and diffuse, respectively; and $b=1,2,3$ denotes the bands of visible, near infrared, and infrared wavelengths, respectively.

The following variables are input in the land surface integration section:

| Variable                              | Description                         | Units                 |
|:--------------------------------------|:------------------------------------|:----------------------|
| $Pr_{c}$                              | Convective rainfall flux            | $\mathrm{[kg/m^2/s]}$ |
| $Pr_{l}$                              | Large-scale Rainfall flux           | $\mathrm{[kg/m^2/s]}$ |
| $P_{Snc}$                             | Convective snowfall flux            | $\mathrm{[kg/m^2/s]}$ |
| $P_{Snl}$                             | Large-scale snowfall flux           | $\mathrm{[kg/m^2/s]}$ |
| $F_{g(1/2)}$                          | Surface heat transfer flux          | $\mathrm{[W/m^2]}$    |
| $F_{Sn(1/2)}$                         | Heat transfer flux for snow surface | $\mathrm{[W/m^2]}$    |
| $Et_{(i,j)}$       $(i=1,2;j=1,2,3)$  | Evapotranspiration                  | $\mathrm{[kg/m^2/s]}$ |
| $\Delta F_{conv}$                     | Surface energy convergence          | $\mathrm{[W/m^2]}$    |
| $F_{root(k)}$      $(k=1,\ldots,K_g)$ | Root water uptake                   | $\mathrm{[kg/m^2/s]}$ |
| $LAI$                                 | Leaf area index                     | $\mathrm{[m^2/m^2]}$  |
| $A_{Snc}$                             | Canopy freezing area ratio          | $\mathrm{[-]}$        |
| $D_{dust}$                            | Dust deposition flux                | $\mathrm{[kg/m^2/s]}$ |
| $D_{BC}$                              | Black carbon deposition flux        | $\mathrm{[kg/m^2/s]}$ |
Table: Input data for land integration section




## External parameters
The external parameters necessary for the execution of MATSIRO are broadly divided into two types: parameters whose values for each grid cell are given by horizontal distribution (map), and parameters whose values are given by land cover type or soil type tables. The land cover types and soil types are the parameters given by map, and through this, each parameter given by table is allocated to individual grid cells; that is,

parameter given by a map:
$$
 \phi(i,j)
$$

parameter given by a table:
$$
 \psi(I),
$$
$$
 I = I_L (i,j)
$$
or
$$
 I = I_S (i,j)
$$
where $(i,j)$ are indexes of the grid horizontal location, $I_L$ is the land use type, and $I_S$ is the soil type.


The types of external parameters $\phi$ given by map are as follows:

| Variable                     | Description                          | Temporal resolution | Units                |
|:-----------------------------|:-------------------------------------|:--------------------|:---------------------|
| $I_L$                        | Land cover type                      | constant            | $\mathrm{[-]}$       |
| $I_S$                        | Soil Type                            | constant            | $\mathrm{[-]}$       |
| $LAI_0$                      | Leaf Area Index (LAI)                | every month         | $\mathrm{[m^2/m^2]}$ |
| $\alpha_{0(b)}$  $(b=1,2,3)$ | Ground surface (forest floor) albedo | constant            | $\mathrm{[-]}$       |
| $\tan\beta_{s}$              | Tangent of the mean surface slope    | constant            | $\mathrm{[-]}$       |
| $\sigma_z$                   | elevation standard deviation         | constant            | $\mathrm{[m]}$       |
Table: External parameters given by maps


The types of external parameters $\psi$ given by table for each land cover type are as follows:


 <!--beginlandscape-->
| Variable                                | Description                                                                    | Units                 |
|:----------------------------------------|:-------------------------------------------------------------------------------|:----------------------|
| $h_0$                                   | vegetation height                                                              | $\mathrm{[m]}$        |
| $h_{B0}$                                | Height of the bottom of the canopy                                             | $\mathrm{[m]}$        |
| $r_{f(b)}$           ($b$=1,2)          | Leaf albedo                                                                    | $\mathrm{[-]}$        |
| $t_{f(b)}$           ($b$=1,2)          | Leaf transmissivity                                                            | $\mathrm{[-]}$        |
| $f_{root(k)}$        ($k=1,\ldots,K_g$) | Percentage of root presence                                                    | $\mathrm{[-]}$        |
| $c_d$                                   | Momentum exchange coefficient between the individual leaves and the atmosphere | $\mathrm{[-]}$        |
| $c_h$                                   | Heat exchange coefficient between individual leaves and the atmosphere         | $\mathrm{[-]}$        |
| $f_V$                                   | Vegetation coverage                                                            | $\mathrm{[-]}$        |
| $V_{\max}$                              | Rubisco reaction capacity                                                      | $\mathrm{[m/s]}$      |
| $m$                                     | $A_n$-$g_s$ slope of the relationship                                          | $\mathrm{[-]}$        |
| $b$                                     | $A_n$-$g_s$ relationship intercepts                                            | $\mathrm{[m/s]}$      |
| $\epsilon_3$, $\epsilon_4$              | Photosynthetic efficiency per photon                                           | $\mathrm{[m/s/moll]}$ |
| $\theta_{ce}$                           | Coupling factor between     $w_c$ and $w_e$                                    | $\mathrm{[-]}$        |
| $\theta_{ps}$                           | Coupling factor between     $w_p$ and $w_s$                                    | $\mathrm{[-]}$        |
| $f_d$                                   | Respiratory coefficient                                                        | $\mathrm{[-]}$        |
| $s_2$                                   | Critical temperature of high temperature suppression                           | $\mathrm{[K]}$        |
| $s_4$                                   | Critical temperature of cryogenic suppression                                  | $\mathrm{[K]}$        |
Table: External parameters given by tables
<!--endlandscape-->

The types of external parameters $\psi$ given by table for each soil type are as follows:

| Variable                          | Description                            | Units              |
|:----------------------------------|:---------------------------------------|:-------------------|
| $c_{g(k)}$     ($k=1,\ldots,K_g$) | Specific heat of soil                  | $\mathrm{[J/m^3]}$ |
| $k_{g(k)}$     ($k=1,\ldots,K_g$) | Thermal conductivity of soil           | $\mathrm{[W/m/K]}$ |
| $w_{sat(k)}$   ($k=1,\ldots,K_g$) | Soil porosity                          | [m$^3$/m$^3$]      |
| $K_{s(k)}$     ($k=1,\ldots,K_g$) | Saturated permeability of soil         | $\mathrm{[m/s]}$   |
| $\psi_{s(k)}$  ($k=1,\ldots,K_g$) | Soil saturation moisture potential     | $\mathrm{[m]}$     |
| $b_{(k)}$      ($k=1,\ldots,K_g$) | Index of soil moisture potential curve | $\mathrm{[-]}$     |
Table: External parameters given by tables


# Vegetation type parameters

The leaf area index (LAI), vegetation height, etc. are set as vegetation type parameters.

Seasonally changing horizontal distributions are loaded as external parameters for LAI, and the values according to land use type are loaded as external parameters for the heights of the canopy top and bottom. When there is snow, only the vegetation above the level of the snow depth is taken into consideration and the type parameters are corrected as follows:
$$
 h   &=& \max( h_0 - D_{Sn}, 0 ) \\
 h_B &=& \max( h_{B0} - D_{Sn}, 0 ) \\
 LAI &=& LAI_0 \frac{h-h_B}{h_0-h_{B0}}
$$
where $h$ is the height of the canopy top (vegetation height), $h_B$ is the height of the canopy bottom (height of clear length),  $LAI$ is the leaf area index, and $h_0$, $h_{B0}$, and $LAI_0$ are the respective values when there is no snow. $D_{Sn}$ is the snow depth. LAI is approximated on the assumption that it is uniformly distributed vertically between the canopy top and bottom.

In terms of coding, next the mean values of the snow-free and snow-covered portions are solved by weighting with the snow-covered ratio ($A_{Sn}$), etc., as follows:
$$
	h = A_{Sn}h + (1-A_{Sn})h_0
$$

However, because the snow-free portion and snow-covered portion are respectively calculated, it should be noted that $A_{Sn}$ takes the value of either 0 (snow-free portion) or 1 (snow-covered portion), so no mixing of values occurs (similar cases are also seen later).

# Radiation parameters

Next, the radiation parameters (albedo, vegetation transmissivity , etc.) are calculated.

## Calculation of ground surface (forest floor) albedo

The horizontal distributions of the ground surface (forest floor) albedo $b=1,2$ are loaded as external parameters, with $b=1,2$ denoting the wavelength bands of visible and near infrared, respectively. The infrared ground surface albedo ($\alpha_{0(3)}$) is set to a fixed value (horizontal distributions can also be prepared if desired).

With regard to the ice-sheet portion and snow-covered portion, the dependence of the incidence angle of albedo is considered by the following function form:
$$
 \alpha_{0(d,b)} = \hat{\alpha}_{0(b)} + ( 1 - \hat{\alpha}_{0(b)} )
                         \cdot 0.4 ( 1 - \cos \psi_{in(d)} )^5
$$
where $b=1,2$ are wavelength bands; $d=1,2$ are direct and diffuse, respectively; and  $\hat{\alpha}_{0(b)}$ is the value of albedo when the incidence angle is 0 (from directly overhead). The cosine of the incidence angle $\cos\psi_{in(d)}$ is expressed as
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


## Calculation of canopy albedo and transmissivity

The calculation of canopy albedo and transmissivity is based on the calculation of radiation within a canopy layer proposed by @Watanabe1995-je.

Considering the canopy as vertically uniform and making use of several assumptions for simplification, the transfer equations of insolation within the canopy and the boundary condition are expressed as
$$
 \frac{dS^{\downarrow}_d}{dL} &=& -F \sec\zeta S^{\downarrow}_d \\
 \frac{dS^{\downarrow}_r}{dL} &=& -F (1-t_{f(b)})d_f S^{\downarrow}_r
                                  +F t_{f(b)} \sec\zeta S^{\downarrow}_d
                                  +F r_{f(b)} d_f S^{\uparrow}_r \\
 \frac{dS^{\uparrow}_r}{dL}   &=&  F (1-t_{f(b)})d_f S^{\uparrow}_r
                                  -F r_{f(b)} ( d_f S^{\downarrow}_r
                                         + \sec\zeta S^{\downarrow}_d ) \\
 S^{\downarrow}_d(0) &=& S^{top}_d \\
 S^{\downarrow}_r(0) &=& S^{top}_r \\
 S^{\uparrow}_r(LAI) &=& \alpha_{0(1,b)}S^{\downarrow}_d(LAI)
                       + \alpha_{0(2,b)}S^{\downarrow}_r(LAI)
$$
where  $S^{\downarrow}_d$ is the downward direct insolation; $S^{\uparrow}_r$ and $S^{\downarrow}_r$ are the upward and downward diffuse radiation, respectively; $L$  is the leaf area cumulatively added downward from the canopy top; $d_f$ is the diffusivity factor ($=\sec 53^{\circ}$), $r_{f(b)}$; $t_{f(b)}$ are the leaf albedo and transmissivity, respectively (the same value is used for diffuse radiation and direct insolation); and $F$  is a factor denoting the direction of the leaves with respect to the radiation. Here, the distribution of the direction of the leaves is assumed to be random ($F=0.5$) for simplicity.

These can be solved analytically, giving the following solutions:
$$
 S^{\downarrow}_d(L) &=& S^{top}_d \exp(-F\cdot L\cdot \sec\zeta) \\
 S^{\downarrow}_r(L) &=& C_1 e^{a L} + C_2 e^{-a L} + C_3 S^{\downarrow}_d(L) \\
 S^{\uparrow}_r(L)   &=& A_1 C_1 e^{a L} + A_2 C_2 e^{-a L} + C_4 S^{\downarrow}_d(L)
$$
where
$$
   a &=& F d_f [(1-t_{f(b)})^2 - r_{f(b)}^2]^{1/2}  \\
 A_1 &=& \{ 1 - t_{f(b)} + [(1-t_{f(b)})^2 - r_{f(b)}^2]^{1/2}\} / r_{f(b)} \tag{eq17} \\
 A_2 &=& \{ 1 - t_{f(b)} - [(1-t_{f(b)})^2 - r_{f(b)}^2]^{1/2}\} / r_{f(b)} \\
 A_3 &=& (A_1 - \alpha_{0(2,b)}) e^{ a LAI }
        -(A_2 - \alpha_{0(2,b)}) e^{-a LAI } \\
 C_1 &=& \{ -(A_2 - \alpha_{0(2,b)}) e^{-a LAI} (S^{top}_r - C_3 S^{top}_d) \nonumber\\
          &+&   [C_3\alpha_{0(2,b)}+\alpha_{0(1,b)}-C_4]S^{\downarrow}_d(LAI)\} / A_3 \\
 C_2 &=& \{  (A_1 - \alpha_{0(2,b)}) e^{ a LAI} (S^{top}_r - C_3 S^{top}_d) \nonumber\\
          &-&   [C_3\alpha_{0(2,b)}+\alpha_{0(1,b)}-C_4]S^{\downarrow}_d(LAI)\} / A_3 \\
 C_3 &=& \frac{\sec\zeta[t_{f(b)}\sec\zeta + d_f t_{f(b)}(1-t_{f(b)}) + d_f r_{f(b)}^2]}
              {d_f^2[(1-t_{f(b)})^2-r_{f(b)}^2]-\sec^2\zeta} \\
 C_4 &=& \frac{r_{f(b)}(d_f - \sec\zeta)\sec\zeta}
              {d_f^2[(1-t_{f(b)})^2-r_{f(b)}^2]-\sec^2\zeta}
$$

Albedo $\alpha_s$ at the canopy top is expressed as
$$
 S^{\uparrow}_r(0) = \alpha_{s(1,b)} S^{\downarrow}_d(0)
                   + \alpha_{s(2,b)} S^{\downarrow}_r(0)
$$
therefore,
$$
 \alpha_{s(2,b)} &=& \{ A_2 ( A_1 - \alpha_{0(2,b)}) e^{ a LAI }
                      - A_1 ( A_2 - \alpha_{0(2,b)}) e^{-a LAI }
                   \} / A_3 \\
 \alpha_{s(1,b)} &=& - C_3 \alpha_{s(2,b)} + C_4
                  + ( A_1 - A_2 ) ( C_3 \alpha_{0(2,b)} + \alpha_{0(1,b)} -C_4)
                  e^{- F\cdot LAI\cdot \sec\zeta} / A_3
$$
are obtained.

If the canopy transmissivity (${\mathcal{T}}_c$) (specifically, the ratio of incident insolation absorbed by the forest floor to the incident insolation of the canopy top) is defined by
$$
  {\mathcal{T}}_{c(2,b)} &=& \{ ( 1 - A_2 )( A_1 - \alpha_{0(2,b)} )
                      - ( 1 - A_1 )( A_2 - \alpha_{0(2,b)} ) \} / A_3 \\
 {\mathcal{T}}_{c(1,b)} &=& - C_3 {\mathcal{T}}_{c(2,b)}  \nonumber\\
 &+&                   \{ ( C_3 \alpha_{0(2,b)} + \alpha_{0(1,b)} -C_4 )
                   ( ( 1 - A_1 ) e^{ a LAI }
                   - ( 1 - A_2 ) e^{-a LAI } )  / A_3
                   + C_3 - C_4 +1 \} e^{- F\cdot LAI\cdot \sec\zeta} \nonumber\\
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
 r_{f(b)} &=& ( 1 - f_{cwet} ) r_{f(b)}
         + f_{cwet} \alpha_{Sn(b)} \\
  f_{cwet} &=& {w_c}/w_{c,cap}
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
  \alpha_{s(d,b)} &=& f_V \alpha_{s(d,b)}
                       + ( 1 - f_V ) \alpha_{0(d,b)} \\
  {\mathcal{T}}_{c(d,b)} &=& f_V {\mathcal{T}}_{c(d,b)}
                       + ( 1 - f_V ) ( 1 - \alpha_{0(d,b)} )
$$

## Calculation of surface radiation flux, etc.

Using the surface downward radiation flux  ($R^{\downarrow}_{(d,b)}$) and albedo calculated above, the following radiation fluxes are calculated:

$$
 R^{\downarrow}_S &=& \sum_{b=1}^2\sum_{d=1}^2 R^{\downarrow}_{(d,b)} \\
 R^{\uparrow}_S &=& \sum_{b=1}^2\sum_{d=1}^2 \alpha_{s(d,b)} R^{\downarrow}_{(d,b)} \\
 R^{\downarrow}_L &=& R^{\downarrow}_{(2,3)} \\
 R^{gnd}_S &=& \sum_{b=1}^2\sum_{d=1}^2 {\mathcal{T}}_{s(d,b)} R^{\downarrow}_{(d,b)} \\
 PAR &=& \sum_{d=1}^2 R^{\downarrow}_{(d,1)}
$$
where $R^{\downarrow}_S$ and $R^{\uparrow}_S$  are the downward and upward shortwave radiation flux, respectively; $R^{\downarrow}_L$ is the downward longwave flux; $R^{gnd}_S$ is the shortwave flux absorbed by the forest floor; and $PAR$ is the downward photosynthesis active radiation (PAR) flux.

The canopy transmissivity of shortwave and longwave radiation, and the emissivity of longwave radiation, are then calculated as follows:

$$
 {\mathcal{T}}_{cS} &=& R^{gnd}_S / ( R^{\downarrow}_S - R^{\uparrow}_S ) \\
 {\mathcal{T}}_{cL} &=& \exp( - F \cdot LAI \cdot d_f ) \\
 \epsilon &=& 1 - \alpha_{s(2,3)}
$$

# Turbulence parameters (bulk coefficient)

Next, the turbulence parameter (bulk coefficient) is calculated.

## Calculation of roughness with respect to momentum and heat

The calculation of roughness is based on @Watanabe1994-sx. In that study, using the results of a multilayer canopy model by @Kondo1992-ut as a function form for the roughness of a bulk model best fitting those results, @Watanabe1994-sx proposed the following:

$$
 \left(\ln \frac{h-d}{z_0}\right)^{-1} &=&
 \left[ 1 - \exp( -A^+) + \left(-\ln \frac{z_{0s}}{h}\right)^{-1/0.45}
  \exp(-2A^+)\right]^{0.45} \\
 \left(\ln \frac{h-d}{z_T^{\dagger}}\right)^{-1} &=&
 \frac{1}{-\ln(z_{Ts}/h)} \left[ \frac{P_1}{P_1 + A^+ \exp({A^+})}\right] ^{P2} \\
 \left(\ln \frac{h-d}{z_0}\right)^{-1} \left(\ln \frac{h-d}{z_T}\right)^{-1}
 &=& C_T^{\infty} \left[1-\exp(-P_3 A^+)
  + \left(\frac{C_T^0}{C_T^{\infty}}\right)^{1/0.9} \exp(-P_4 A^+)\right]^{0.9} \\
 h-d &=& h [1-\exp(-A^+)] / {A^+} \\
 A^+ &=& \frac{c_d LAI}{2k^2} \\
 \frac1{C_T^0} &=& \ln \frac{h-d}{z_0} \ln \frac{h-d}{z_T^{\dagger}} \\
 C_T^{\infty} &=& \frac{-1+(1+8F_T)^{1/2}}{2} \\
 P_1 &=& 0.0115 \left(\frac{z_{Ts}}{h}\right)^{0.1}
  \exp\left[5 \left(\frac{z_{Ts}}{h}\right)^{0.22}\right] \\
 P_2 &=& 0.55 \exp\left[-0.58 \left(\frac{z_{Ts}}{h}\right)^{0.35}\right] \\
 P_3 &=& [F_T + 0.084 \exp(-15 F_T)]^{0.15} \\
 P_4 &=& 2 F_T^{1.1} \\
 F_T &=& c_h / c_d
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

## Calculation of bulk coefficient with respect to momentum and heat

After @Watanabe1994-sx, the bulk coefficient is also calculated using Monin-Obukhov similarity as

$$
 C_M &=& k^2 \left[ \ln \frac{z_a-d}{z_0} + \Psi_m(\zeta) \right]^{-2} \\
 C_H &=& k^2 \left[ \ln \frac{z_a-d}{z_0} + \Psi_m(\zeta) \right]^{-1}
             \left[ \ln \frac{z_a-d}{z_T} + \Psi_h(\zeta) \right]^{-1} \\
 C_{Hs} &=& k^2 \left[ \ln \frac{z_a-d}{z_0} + \Psi_m(\zeta_g) \right]^{-1}
             \left[ \ln \frac{z_a-d}{z_T^{\dagger}} + \Psi_h(\zeta_g) \right]^{-1} \\
 C_{Hc} &=& C_H - C_{Hs}
$$
where $C_M$ and $C_H$ are the bulk coefficients of the overall canopy (leaf surface + forest floor) with respect to momentum and heat, respectively; $C_{Hs}$ is the bulk coefficient of the ground surface (forest floor) flux with respect to heat; $C_{Hc}$ is the bulk coefficient of the canopy (leaf surface) flux with respect to heat; $\Psi_m$ and $\Psi_h$ are Monin-Obukhov shear functions with respect to momentum and heat, respectively; and $z_a$ is the reference height of the atmosphere (height of the troposphere). Using the Monin-Obukhov lengths $\zeta$ and $\zeta_g$ related to the overall canopy and ground surface (forest floor), respectively, $L$ and $L_g$ are respectively expressed as:
$$
 \zeta = \frac{z_a - d}{L} \\
 \zeta_g = \frac{z_a - d}{L_g}
$$
and the Monin-Obukhov lengths are expressed as:
$$
 L &=& \frac{\Theta_0 C_M^{3/2}|V_a|^2}{kg(C_{Hs}(T_s - T_a) + C_{Hc}(T_c - T_a))} \\
 L_s &=& \frac{\Theta_0 C_M^{3/2}|V_a|^2}{kg C_{Hs}(T_s - T_a)}
$$
where $\Theta_0$ =300K; $|V_a|$ is the absolute value of the surface wind speed; $k$ is the Karman constant; $g$ is the gravitational acceleration; and $T_a,$T_c$ and $T_s$ are the temperature of the troposphere, canopy (leaf surface), and ground surface (forest floor), respectively.

Since the bulk coefficient is necessary for calculation of the Monin-Obukhov length, and the Monin-Obukhov length is necessary for calculation of the bulk coefficient, the calculation is iterated (twice as a standard) with a neutral bulk coefficient as the initial value.

Prior to this calculation, the snow depth in the snow-covered portion is added to the zero-plane displacement. However, the upper limit is set so that the zero-plane displacement does not exceed the value of $z_a$:
$$
 d = \min( d + D_{Sn} ,\  f_{\max} \cdot z_a )
$$


As a standard, $f_{\max}$ is set at 0.5.

## Calculation of bulk coefficient with respect to vapor

This calculation is performed after the calculation of stomatal resistance, described later.

When the stomatal resistance ($r_{st}$)  and ground surface evaporation resistance　($r_{soil}$)  have been solved, the bulk coefficient with respect to vapor is solved as:
$$
 C_{Ec} |V_a| &=& \left[ (C_{Hc} |V_a|)^{-1} + r_{st} / LAI\right]^{-1} \\
 C_{Es} |V_a| &=& \left[ (C_{Hs} |V_a|)^{-1} + r_{soil}\right]^{-1}
$$

(Previously, this parameter was solved by converting stomatal resistance, etc. into a decrease of the exchange coefficient via roughness. However, since this approach seems to be problematic, a simpler method had been adopted in its place.)

In addition, when there is no stomatal resistance, etc. (such as evaporation from wet surfaces), the same value as for the bulk coefficient of heat is used for the bulk coefficient of vapor.

# Stomatal resistance

For the calculation of stomatal resistance, a photosynthesis-stomatal model based on @Farquhar1980-dm, @Ball1988-jh, and Collatz et al. [-@Collatz1990-pw;-@Collatz1991-lz;-@Collatz1992-hc] is used. The code of SiB2 [@Sellers1996-xi] is used virtually unchanged, with the exception of the method for solving the resistance of the overall canopy. A Jarvis-type empirical equation could be used instead; however, the explanation of this point is omitted here.

## Calculation of soil moisture stress factor

Soil moisture stress with respect to transpiration is solved. By solving the soil moisture stress factor in each soil layer, and weighting with the root distribution in each layer, the stress factor of the overall soil is calculated.

Referring to SiB2 [@Sellers1996-xi], the soil moisture stress in each layer is evaluated by the following equation:

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

## Calculation of amount of photosynthesis

The amount of photosynthesis is calculated after SiB2 [@Sellers1996-xi].

The amount of photosynthesis is considered to be regulated by the following three upper limits:


$$
 A \leq \min( w_c, w_e, w_s) \tag{eq76}
$$
where $w_c$ is the upper limit set by the efficiency of photosynthesis enzymes (Rubisco), and $w_e$ is the upper limit set by photosynthetically active radiation. $w_s$ is the upper　limit of the efficiency of use of photosynthate (sink) in the case of C<sub>3</sub> vegetation, or the upper limit set by $\mathrm{CO_2}$  concentration in the case of C<sub>4</sub> vegetation [@Collatz1991-lz;@Collatz1992-hc].

The respective magnitudes are estimated as follows:


$$
 w_c = \left\{
\begin{array}{ll}
\displaystyle{
V_m \left[ \frac{c_i - \Gamma^\ast}{c_i + K_c(1+O_2/K_O)}\right]
}
   & \qquad\text{(in case of $C_3$ vegetation)}\\
 V_m
   & \qquad\text{(in case of $C_4$ vegetation)}
\end{array}
\right. \\
$$

$$
 w_e = \left\{
\begin{array}{ll}
\displaystyle{
PAR\cdot \epsilon_3 \left[ \frac{c_i-\Gamma^\ast }{c_i+2\Gamma^\ast}\right]
}
  & \qquad\text{(in case of $C_3$ vegetation)}\\
PAR\cdot \epsilon_4
  & \qquad\text{(in case of $C_4$ vegetation)}
\end{array}
\right. \\
$$

$$
 w_s = \left\{
\begin{array}{ll}
V_m / 2
  & \qquad\text{(in case of $C_3$ vegetation)}\\
V_m c_i/ 5
  & \qquad\text{(in case of $C_4$ vegetation)}
\end{array}
\right. \\
$$
where $V_m$ is the Rubisco reaction capacity, $c_i$ is the partial pressure of $\mathrm{CO_2}$ in the stoma, $\mathrm{O_2}$ is the partial pressure of oxygen in the stoma, and $PAR$is the photosynthetically active radiation (PAR).  is the $\mathrm{CO_2}$ compensation point, which is expressed by $\Gamma^*$ is the compensation point of $\mathrm{CO_2}$ and is represented by $\Gamma^* = 0.5 O_2 / S$ $K_c$, $K_O$, and $S$ are functions of temperature, whose function form is shown later. $\epsilon_3$ and $\epsilon_4$  are constants determined by the vegetation type.


In order to express a smooth transition between the different upper limits, [Eq. (76)](#eq76) is actually solved as
$$
 \beta_{ce} w_p^2 - w_p(w_c + w_e) + w_c w_e = 0 \\
 \beta_{ps} A^2 - A(w_p + w_s) + w_p w_s = 0
$$

The amount of net photosynthesis $A_n$ can be obtained when solving the two equations in order while selecting the smaller of the two solutions for each equation. $\beta_{ce}, \beta_{ps}$ are constants determined by the vegetation type. Note that when $\beta=1$, coincidence is achieved with a simple minimum-value operation.

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
 V_m &=& V_{\max} f_T(T_c) f_w \\
 K_c &=& 30 \times 2.1^{Q_T} \\
 K_O &=& 30000 \times 1.2^{Q_T} \\
 S   &=& 2600 \times 0.57^{Q_T}
$$

$$
 f_T(T_c) &=& \left\{
\begin{array}{ll}
 2.1^{Q_T}/\{1 + \exp[s_1(T_c-s_2)]\} & (\text{when $w_c$ and $w_e$ for $C_3$})\\
 1.8^{Q_T}/\{1 + \exp[s_3(s_4-T_c)]\} & (\text{when $w_s$ is for $C_3$}) \\
 2.1^{Q_T}/\{1 + \exp[s_1(T_c-s_2)]\}/\{1 + \exp[s_3(s_4-T_c)]\} \\
                 \qquad   (\text{when $w_c$ and $w_e$ are for $C_4$})\\
 1.8^{Q_T}                            & (\text{when $w_s$ is for $C_4$}) \\
 2^{Q_T}/\{1 + \exp[s_5(T_c-s_6)]\}   & (\text{when $R_d$})
\end{array}
\right.
$$

$$
Q^T &=& (T_c - 298) / 10
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

## Calculation of stomatal resistance (2)

The net photosynthesis ($A_n$) and stomatal conductance ($g_s$) are related by the semiempirical equation of @Ball1988-jh as follows:
$$
 g_s = m \frac {A_n}{c_s} h_s + b f_w \tag{eq93}
$$
where  $c_s$ is the molar fraction of $\mathrm{CO_2}$  (number of mol of $\mathrm{CO_2}$  per 1 mol of air) at the leaf surface, $f_w$ is the soil moisture stress factor, and $m$ and $b$ are constants determined by the vegetation type.

$h_s$ is the relative humidity at the leaf surface and is defined as
$$
 h_s = e_s / e_i \tag{eq94}
$$

where $e_s$ is the molar fraction of vapor at the leaf surface, $e_i$ is the molar fraction of vapor in the stoma, and $e_i = e^* (T_c)$ is the mole fraction of water vapor in the stomata. $e^*$ denotes the molar fraction of saturated vapor.

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

Among the two solutions of ([Eq. (100)](#eq100)), the larger one is the significant solution.
From the above, if  $A_n$ is known, $g_s$ can be solved; however, when solving $g_s$, $c_i$ is used.
$c_i$ can be solved by ([Eq. (99)](#eq99)) if $g_s$ is solved. That is, $A_n$ is necessary in order to solve $g_s$, whereas $c_i$, namely $g_s$, is necessary in order to solve $A_n$. Iterative calculation is therefore required.

The algorithm for the iterative calculation is ported from SiB2, which uses the method of quickening the convergence by iterating six times and putting the errors in decreasing order to estimate the next solution.

Lastly, using stomatal conductance, the stomatal resistance is expressed as
$$
 r_{st} = 1/g_{st}
$$

## Calculation of ground surface evaporation resistance

The ground surface evaporation resistance ($r_{soil}$) and relative humidity of the uppermost soil layer ($h_{soil}$) are calculated as follows:

$$
 r_{soil} &=& a_1 ( 1 - W_{(1)} ) / ( a_2 + W_{(1)} ) \\
 h_{soil} &=& \exp \left(\frac{\psi_{(1)} g}{R_{air} T_{g(1)}} \right)
$$
where $W_{(1)} = w_{(1)}/w_{sat(1)}$ is the degree of saturation of the uppermost soil layer, $\psi_{1}$ is the moisture potential of the uppermost soil layer, $g$ is the gravitational acceleration, $R_{air}$ is the gas constant of the air, and $T_{g(1)}$ is the temperature of the uppermost soil layer. $a_1$ and $a_2$ are constants, with $a_1=800$, $a_2=0.2$. as standard values.

# Surface energy balance

## Calculation of surface turbulent fluxes

The turbulent fluxes at the ground surface are solved by bulk formulae as follows. Then, by solving the surface energy balance, the ground surface temperature ($T_s$) and canopy temperature ($T_c$) are updated, and the surface flux values with respect to those values are also updated. The solutions obtained here are temporary values. In order to solve the energy balance by linearizing with respect to $T_s$ and $T_c$, the differential with respect to $T_s$ and $T_c$ of each flux is calculated beforehand.

- Momentum flux

$$
 \tau_x = - \rho C_{M}|V_a| u_a \\
 \tau_y = - \rho C_{M}|V_a| v_a
$$
where $\tau_x$ and $\tau_y$  are the momentum fluxes (surface stress) of the zonal and meridional directions, respectively.

- Sensible heat flux

$$
 H_s &=& c_p \rho C_{Hs}|V_a| (T_s - (P_s/P_a)^{\kappa}T_a) \tag{eq107}
  \\
 H_c &=& c_p \rho C_{Hc}|V_a| (T_c - (P_s/P_a)^{\kappa}T_a) \\
 \partial H_s/\partial T_s &=& c_p \rho C_{Hs}|V_a| \\
 \partial H_c/\partial T_c &=& c_p \rho C_{Hc}|V_a|
$$
where $H_s$ and $H_c$ are the sensible heat flux from the ground surface (forest floor) and canopy (leaf surface), respectively; $\kappa = R_{air} / c_p$ and $R_{air}$are the gas constants of air; and $c_p$ is the specific heat of air.

- Bare soil surface (forest floor) evaporation flux

$$
 Et_{(1,1)} &=& (1-A_{Sn})(1-f_{ice})\cdot
           \rho \widetilde{C_{Es}}|V_a|(h_{soil}q^\ast(T_s) - q_a) \\
 Et_{(2,1)} &=& (1-A_{Sn})f_{ice}\cdot
           \rho \widetilde{C_{Es}}|V_a|(h_{soil}q^\ast(T_s) - q_a) \\
 \partial Et_{(1,1)}/\partial T_s &=& (1-A_{Sn})(1-f_{ice})\cdot
           \rho \widetilde{C_{Es}}|V_a|h_{soil}\cdot dq^\ast/dT |_{T_s} \\
 \partial Et_{(2,1)}/\partial T_s &=& (1-A_{Sn})f_{ice}\cdot
           \rho \widetilde{C_{Es}}|V_a|h_{soil}\cdot dq^\ast/dT |_{T_s}
$$

where $Et_{(1,1)}$ and $Et_{(2,1)}$ are the water evaporation and ice sublimation fluxes at the bare soil surface, respectively; $q^*(T_s)$ is the saturation specific humidity at the ground surface temperature; $h_{soil}$ is the relative humidity at the soil surface layer; $A_{Sn}$ is the snow-covered ratio; and $f_{ice}$ is the ratio of ice in the uppermost soil layer, expressed as

$$
  f_{ice} = w_{i(1)}/w_{(1)}
$$

Since the snow-free portion and snow-covered portion are calculated separately, it should be noted that $A_{Sn}$ takes the value of either 0 (snow-free portion) or 1 (snow-covered portion). When the flux is downward (i.e., dew formation), there is no soil moisture resistance; therefore, the bulk coefficient is taken as:

$$
  \widetilde{C_{Es}} = \left\{
  \begin{array}{ll}
   C_{Es} (h_{soil}q^\ast(T_s) - q_a > 0)\\
   C_{Hs} (h_{soil}q^\ast(T_s) - q_a \leq 0)
  \end{array}
  \right.
$$

- Transpiration flux

$$
 Et_{(1,2)} &=& (1-f_{cwet}) \cdot \rho \widetilde{C_{Ec}}|V_a|(q^\ast(T_c) - q_a) \\
 Et_{(2,2)} &=& 0 \\
 \partial Et_{(1,2)}/\partial T_c &=&
  (1-f_{cwet}) \cdot \rho \widetilde{C_{Ec}}|V_a|\cdot dq^\ast/dT|_{T_c} \\
 \partial Et_{(2,2)}/\partial T_c &=& 0
$$
where $Et_{(1,2)}$ and $Et_{(2,2)}$ are transpiration of water and ice, respectively; and $Et_{(2,2)}$ is always 0. $f_{cwet} = w_c / w_{c,cap}$ is the wet fraction of the canopy. When the flux is downward, which is considered to be dew formation on the dry part of the leaf, the bulk coefficient is taken as:

$$
  \widetilde{C_{Ec}} = \left\{
  \begin{array}{ll}
   C_{Ec} & (q^\ast(T_c) - q_a > 0)\\
   C_{Hc} & (q^\ast(T_c) - q_a \leq 0)
  \end{array}
  \right.
$$

- Canopy evaporation flux

When      $T_c$ $\geq$ 0 $^{\circ}$ C:


$$
 Et_{(1,3)} &=&
  f_{cwet} \cdot \rho C_{Hc}|V_a|(q^\ast(T_c) - q_a) \\
 Et_{(2,3)} &=& 0 \\
 \partial Et_{(1,3)} \partial T_c &=&
  f_{cwet} \cdot \rho C_{Hc}|V_a|\cdot dq^\ast/dT|_{T_c} \\
 \partial Et_{(2,3)} \partial T_c &=& 0
$$

when  $T_c$ $<$ 0 $^{\circ}$ In case of C:

$$
 Et_{(1,3)} &=& 0 \\
 Et_{(2,3)} &=&
  f_{cwet} \cdot \rho C_{Hc}|V_a|(q^\ast(T_c) - q_a) \\
 \partial Et_{(1,3)} \partial T_c &=& 0 \\
 \partial Et_{(2,3)} \partial T_c &=&
  f_{cwet} \cdot \rho C_{Hc}|V_a|\cdot dq^\ast/dT|_{T_c}
$$
where $Et_{(1,3)}$ and $Et_{(2,3)}$ are the evaporation of water and the sublimation of ice at the canopy surface, respectively.

- Snow sublimation flux

$$
 E_{Sn} &=& A_{Sn}\cdot \rho C_{Hs}|V_a|(q^\ast(T_s) - q_a) \\
 \partial E_{Sn}/\partial T_s &=& A_{Sn}\cdot \rho C_{Hs}|V_a|
 \cdot dq^\ast/dT|_{T_s}
$$
where $E_{Sn}$ is the snow sublimation flux. Since the snow-free portion and snow-covered portion are calculated separately, it should also be noted here that $A_{Sn}$ takes the value of either 0 (snow-free portion) or 1 (snow-covered portion).


## Calculation of heat conduction fluxes

The heat conduction fluxes in the snow-free and snow-covered portions are calculated. Similarly to the turbulent fluxes, when the energy balance is solved later and the surface temperature is updated, the heat conduction flux values are updated with respect to that value.

In addition, it should also be noted here that since the snow-free portion and snow-covered portion are calculated separately, $A_{Sn}$ takes the value of either 0 (snow-free portion) or 1 (snow-covered portion).

- Heat conduction flux in the snow-free portion
$$
  F_{g(1/2)} &=& (1 - A_{Sn}) \cdot k_{g(1/2)} / \Delta z_{g(1/2)} (T_{g(1)} - T_s) \\
  \partial F_{g(1/2)}/\partial T_s &=&
  - (1 - A_{Sn}) \cdot k_{g(1/2)} / \Delta z_{g(1/2)}
$$
where $F_{g(1/2)}$ is the heat conduction flux, $k_{g(1/2)}$ is the soil heat conductivity, $\Delta z_{g(1/2)}$  is the thickness from the temperature definition point of the uppermost soil layer to the ground surface, and $T_{g(1)}$ is the temperature of the uppermost soil layer.

- Heat conduction flux in the snow-covered portion　
$$
  F_{Sn(1/2)} &=& A_{Sn} \cdot k_{Sn(1/2)} / \Delta z_{Sn(1/2)} (T_{Sn(1)} - T_s)
 \\
  \partial F_{Sn(1/2)}/\partial T_s &=&
  - A_{Sn} \cdot k_{Sn(1/2)} / \Delta z_{Sn(1/2)} \tag{eq135}
$$
where $F_{Sn(1/2)}$ is the heat conduction flux, $k_{Sn(1/2)}$ is the snow heat conductivity, $\Delta z_{Sn(1/2)}$ is the thickness from the temperature definition point of the uppermost snow layer to the ground surface, and $T_{Sn(1)}$ is the temperature of the uppermost snow layer.

## Solution of energy balance at ground surface and canopy

The energy balance is solved for two cases: (1) when there is no melting at the ground surface, and (2) when there is melting at the ground surface. In case (2), the solution is obtained by fixing the ground surface temperature ($T_s$) at 0°C, and the energy available for use in melting is diagnosed from the energy balance. Snowmelt on vegetation is treated by correction later on; therefore, that case is not solved separately here. Moreover, the case of the snow completely melting within the time steps is also treated by correction later on.

### Energy balance at ground surface and canopy

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


### Case 1: When there is no melting at the ground surface

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
 \frac{\partial \Delta F_s}{\partial T_s} &=&
 \frac{\partial H_s}{\partial T_s}
+\frac{\partial R^{net}_s}{\partial T_s}
+l\frac{\partial Et_{(1,1)}}{\partial T_s}
+l_s\left(\frac{\partial Et_{(2,1)}}{\partial T_s}
+    \frac{\partial E_{Sn}}{\partial T_s}\right)
-\frac{\partial F_{g(1/2)}}{\partial T_s}
-\frac{\partial F_{Sn(1/2)}}{\partial T_s} \\
 \frac{\partial \Delta F_s}{\partial T_c} &=&
 \frac{\partial R^{net}_s}{\partial T_c} \\
 \frac{\partial \Delta F_c}{\partial T_s} &=&
 \frac{\partial R^{net}_c}{\partial T_s} \\
 \frac{\partial \Delta F_c}{\partial T_c} &=&
 \frac{\partial H_c}{\partial T_c}
+\frac{\partial R^{net}_c}{\partial T_c}
+l  \left(\frac{\partial Et_{(1,2)}}{\partial T_c}
+         \frac{\partial Et_{(1,3)}}{\partial T_c}\right)
+l_s\left(\frac{\partial Et_{(2,2)}}{\partial T_c}
+         \frac{\partial Et_{(2,3)}}{\partial T_c}\right)
$$
where


$$
 \frac{\partial R^{net}_s}{\partial T_s} &=&
 \epsilon 4 \sigma T_s^3 \\
 \frac{\partial R^{net}_s}{\partial T_c} &=&
 - ( 1 - {\mathcal{T}}_{cL} ) \epsilon 4 \sigma T_c^3 \\
 \frac{\partial R^{net}_c}{\partial T_s} &=&
 - ( 1 - {\mathcal{T}}_{cL} ) \epsilon 4 \sigma T_s^3 \\
 \frac{\partial R^{net}_c}{\partial T_c} &=&
  2( 1 - {\mathcal{T}}_{cL} ) \epsilon 4 \sigma T_c^3
$$

Using the above equations, [Eq. (140)]($eq140) is solved for $T_s$ and $T_c$.

### Case 2: When there is melting at the ground surface

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

### Conditions for solutions

Several conditions are set for the solution of the ground surface energy balance. After solving the energy balance, if any of the conditions are not followed, the flux that has contravened the conditions is fixed at the limit value that satisfies the conditions, and the energy balance is solved again.

1. Vapor in the troposphere should not be excessively removed.

Due to the instability of temporal calculations, it is possible that large downward latent heat is produced. The conditions are set so that even in such a case, the vapor in the troposphere from the surface is not completely removed; that is,

$$
  Et_{(i,j)}^{current} &>& - q_a ( P_s - P_a ) / (g \Delta t)
   \ \ \ \ \ (i=1,2 ; j=1,2,3) \\
  E_{Sn}^{current} &>& - q_a ( P_s - P_a ) / (g \Delta t)
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

### Updating of ground surface and canopy temperatures

The ground surface temperature and canopy temperature are updated as follows:

$$
 T_s^{current} = T_s^{past} + \Delta T_s \\
 T_c^{current} = T_c^{past} + \Delta T_c
$$

Based on the updated canopy temperature, the canopy water is diagnosed in advance as being either liquid or solid. This information is used when treating freezing and melting of the canopy water, as follows:


$$
 A_{Snc} = \left\{
\begin{array}{ll}
 0 & (T_c \geq T_{melt})\\
 1 & (T_c <    T_{melt})
\end{array}
\right.
$$
where $A_{Snc}$ is the frozen fraction on the canopy.

### Updating of flux values

The flux values are updated with respect to the updated values of $T_s$ and $T_c$. When $F$ denotes any given flux, updating of the values is performed as follows:
$$
 F^{current} = F^{past} + \frac{\partial F}{\partial T_s} \Delta T_s
                        + \frac{\partial F}{\partial T_c} \Delta T_c
$$

Using the updated flux values, the fluxes output into the atmosphere, etc. are calculated as follows:
$$
 H &=& H_s + H_c \\
 E &=& \sum_{j=1}^3 \sum_{i=1}^2 Et_{(i,j)} + E_{Sn} \\
 R^{\uparrow}_L &=& {\mathcal{T}}_{cL} \epsilon \sigma T_s^4
 + (1 - {\mathcal{T}}_{cL}) \epsilon \sigma T_c^4
 + (1 - \epsilon) R^{\downarrow}_L \\
 T_{sR} &=& ( R^{\uparrow}_L / \sigma )^{1/4}
$$
where $T_{sR}$ is the radiation temperature at the ground surface.

The root uptake flux in each soil layer is then calculated as follows:
$$
 F_{root(k)} = f_{rootup(k)} Et_{(1,2)} \ \ \ \ (k=1,\ldots,K_g)
$$
where $F_{root(k)}$ is the root uptake flux and  $f_{rootup(k)}$ is the weighting for distribution of the transpiration to the root uptake flux in each layer.

# Canopy Water Balance

The canopy water balance is calculated.

## Diagnosis of canopy water phase

With regard to canopy water, the liquid phase (intercepted rainfall, dew formation, and frozen water content that has melted) and solid phase (intercepted snow, icing, and liquid water content that has frozen) are considered separately and the coexistence of the two phases is allowed. The only prognostic variable is the water content ($w_c$) encompassing both the liquid and solid phases, and depending on whether the canopy temperature ($T_c$) is higher or lower than $T_{melt} = 0^{\circ}$ C, it is diagnosed as liquid or solid, respectively. The reason why the liquid and solid phases can coexist is that $T_c$ in snow-covered and snow-free portions is calculated separately. That is, the frozen fraction on the canopy ($A_{Snc}$) is defined (in actuality, it is obtained as a result of spatial averaging by the coupler) as follows:
$$
 A_{Snc} = \left\{
\begin{array}{ll}
 0 & (T_{c(1)} \geq T_{melt}, \ T_{c(2)} \geq T_{melt})\\
 (1-A_{Sn}) & (T_{c(1)} < T_{melt}, \ T_{c(2)} \geq T_{melt})\\
 A_{Sn} & (T_{c(1)} \geq T_{melt}, \ T_{c(2)} < T_{melt})\\
 1 & (T_{c(1)} < T_{melt}, \ T_{c(2)} < T_{melt})
\end{array}
\right.
$$
where $w_{cl} = w_c ( 1 - A_{Snc})$ and $w_{ci} = w_c A_{Snc}$ are the liquid and solid water content of the canopy, respectively.

For $A_{Snc}$, the value updated in the flux calculation section $A_{Snc}^{\tau+1}$　is given by the coupler, but the value of the previous step $A_{Snc}^{\tau}$ is stored in MATCNW. $\tau$ denotes the time steps. This is solved from the initial values of $T_c$ and $Sn$ at the time of initiating the calculation, and therefore does not become a new prognostic variable.

## Prognosis of canopy water

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

### Evaporation (sublimation) of canopy water

First, by subtracting the evaporation (sublimation), the canopy water is partially updated as follows. The evaporation (sublimation) has already been solved in the flux calculation section.

$$
 w_{cl}^\ast = w_{cl}^{\tau} - E_l \Delta t_L / \rho_w \\
 w_{ci}^\ast = w_{ci}^{\tau} - E_i \Delta t_L / \rho_w
$$

$$
 E_l = Et_{(1,3)} \\
 E_i = Et_{(2,3)}
$$

Then, if either $w_{cl}$ or $w_{ci}$ become negative in value, it is supplemented by the other until the value returns to 0, and the melting (negative value in the case of frozen water) that is assumed to be produced is then inserted in $M_c$.

### Interception of precipitation by the canopy

The precipitation interception and dripping are considered by separating the places of convective precipitation and nonconvective precipitation. The fraction of the convective precipitation area ($A_c$) is assumed to be uniform (0.1 as a standard value). Stratiform precipitation is also assumed to be uniform.

$$
 P_{Il}^{c}  &=& f_{int} ( Pr_c / A_c + Pr_l ) \\
 P_{Il}^{nc} &=& f_{int} Pr_l \\
 P_{Ii}^{c}  &=& f_{int} ( P_{Snc} / A_c + P_{Snl} ) \\
 P_{Ii}^{nc} &=& f_{int} P_{Snl}
$$
where $P_{Il}^{c}$ and $P_{Ii}^{c}$ denote the interception in the convective precipitation area, and $P_{Il}^{nc}$ and $P_{Ii}^{nc}$ denote the interception in the nonconvective precipitation area. $f_{int}$ is the interception efficiency, and is simply given by

$$
 f_{int} = \left\{
\begin{array}{ll}
 LAI  & (LAI < 1)\\
 1    & (LAI \geq 1)
\end{array}
\right.
$$


By adding the intercepted precipitation, the canopy water is further partially updated as follows:

$$
 w_{cl}^{c*} &=& w_{cl}^\ast  + P_{Il}^c    \Delta t_L / \rho_w \\
 w_{cl}^{nc*}&=& w_{cl}^\ast  + P_{Il}^{nc} \Delta t_L / \rho_w \\
 w_{ci}^{c*} &=& w_{ci}^\ast  + P_{Ii}^c    \Delta t_L / \rho_w \\
 w_{ci}^{nc*}&=& w_{ci}^\ast  + P_{Ii}^{nc} \Delta t_L / \rho_w
$$

### Dripping of the canopy water

For dripping, dripping due to the canopy water capacity being exceeded and natural dripping due to gravity are considered, as follows:

$$
 D_l^c     &=&  \max( w_{cl}^{c*} - w_{c,cap}, 0 ) + D_{g}(w_{cl}^{c*}) \\
 D_l^{nc}  &=&  \max( w_{cl}^{nc*}- w_{c,cap}, 0 ) + D_{g}(w_{cl}^{nc*}) \\
 D_i^c     &=&  \max( w_{ci}^{c*} - w_{c,cap}, 0 ) + D_{g}(w_{ci}^{c*}) \\
 D_i^{nc}  &=&  \max( w_{ci}^{nc*}- w_{c,cap}, 0 ) + D_{g}(w_{ci}^{nc*})
$$
where the canopy water capacity ($w_{c,cap}$) is, from the water capacity per unit leaf area ($w_{c\max}$) and LAI, assumed to be
$$
 W_{c,cap} = W_{c\max} LAI
$$

$W_{c\max}$ is set at 0.2 mm as a standard value, and the same value is used with respect to the liquid and solid phases.

The natural dripping due to gravity $D_g$ is, after @Rutter1975-bg, assumed to be
$$
 D_g(w_c) = D_1 \exp(D_2 w_c)
$$

$D_1=1.14 \times 10 ^{-11}$ and $D_2=3.7 \times 10^{3}$ are standard values, and the same values are used with respect to the liquid and solid phases.

By subtracting the dripping, the values are updated as follows:
$$
 w_{cl}^{c**} &=& w_{cl}^{c*}  - D_{Il}^c    \Delta t_L / \rho_w \\
 w_{cl}^{nc**}&=& w_{cl}^{nc*} - D_{Il}^{nc} \Delta t_L / \rho_w \\
 w_{ci}^{c**} &=& w_{ci}^{c*}  - D_{Ii}^c    \Delta t_L / \rho_w \\
 w_{ci}^{nc**}&=& w_{ci}^{nc*} - D_{Ii}^{nc} \Delta t_L / \rho_w
$$


### Updating and melting of canopy water

Moreover, by taking the average of the convective precipitation area and nonconvective precipitation area, the canopy water can be updated as follows:

$$
 w_{cl}^{\ast\ast} &=& A_c w_{cl}^{c**} + (1-A_c) w_{cl}^{nc**} \\
 w_{ci}^{\ast\ast} &=& A_c w_{ci}^{c**} + (1-A_c) w_{ci}^{nc**} \\
 w_c^{\tau+1} &=& w_{cl}^{\ast\ast} + w_{ci}^{\ast\ast}
$$

However, if updating of the frozen fraction ($A_{Snc}$) is considered,
$$
 w_{cl}^{\tau+1} &=& w_{c}^{\tau+1} (1-A_{Snc}^{\tau+1}) \\
 w_{ci}^{\tau+1} &=& w_{c}^{\tau+1} A_{Snc}^{\tau+1}
$$

The melting $M_c$ is therefore diagnosed as
$$
 M_c = - \rho_w ( w_{ci}^{\tau+1} - w_{ci}^{\ast\ast} ) / \Delta t_L
$$

When the melting is produced during evaporation, that portion is added.

Here, the canopy temperature should be changed due to the latent heat of melting; however, it is impossible because we are ignoring the heat capacity of the canopy. Moreover, although it would be advantageous to change the temperature of the surrounding atmosphere, this is also not possible in view of the need for agreement with the calculation in the land surface integration section. Hence, for convenience, in order to conserve the energy of the system, the latent heat of melting is given as the heat flux to the soil (or snow).

## Fluxes given to the soil, snow, and runoff process

The water flux $F_w$ given to the snow or the runoff process after interception by the canopy is respectively expressed with respect to the convective precipitation area and nonconvective precipitation area, and the liquid and solid phases, as follows:
$$
 F_{wl}^{c} &=& (1-f_{int})( Pr_c / A_c + Pr_l ) + D_{l}^{c} \\
 F_{wl}^{nc} &=&(1-f_{int}) Pr_l + D_{l}^{nc} \\
 F_{wi}^{c} &=& (1-f_{int})( P_{Snc} / A_c + P_{Snl} ) + D_{i}^{c} \\
 F_{wi}^{nc} &=&(1-f_{int}) P_{Snl} + D_{i}^{nc}
$$

For the calculation of runoff, convective rainfall and stratiform rainfall are given separately, while snowfall is consolidated because separation is not necessary, as follows:

$$
 Pr_c^\ast &=& Ac ( F_{wl}^{c} - F_{wl}^{nc} ) \\
 Pr_l^\ast &=& F_{wl}^{nc} \\
 P_{Sn}^\ast &=& A_c F_{wl}^{c} + (1-A_c) F_{wl}^{nc}
$$

where $Pr_c^*$, $Pr_l^*$, and $P_{Sn}^*$ are the convective precipitation, the stratiform precipitation, and the snowfall after interception by the canopy, respectively.

The energy flux correction portion for the soil or the snow is
$$
 \Delta F_{c,conv} = - l_m M_c
$$
where $l_m$is the latent heat of melting.


# Snow

The snow cover fraction, snow water equivalent, snow temperature and snow albedo are calculated here.

Most of the processes are included in SUBROUTINE MATSNW in matsnw.F, but the ice albedo is calculated in SUBROUTINE ICEALB in matice.F.

The following tables present attributions of key variables in SUBROUTINE MATSNW.

<!--beginlandscape-->
| Variable                         | Long name                                        | Unit                | Name in code |
|:---------------------------------|:-------------------------------------------------|:--------------------|:-------------|
| $Sn$                             | Amount of accumulated snow                       | $\mathrm{kg/m^2}$   | GLSNW        |
| $T_{Sn(k)} \;\; (k=1,2,3)$      | Snow temperature of the $k$th layer              | $\mathrm{K}$        | GLTSN        |
| $\alpha_b  \;\; (b=1,2,3)$      | Snow albedo for band $b$                         | -                   | GLASN        |
| $A_{Sn}$                        | Snow fraction                                    | -                   | GLRSN        |
| $W_{Sn}$                        | Accumulated snow                                 | $\mathrm{kg/m^2}$   | GLSDA        |
| $M_{Sn}$                        | Accumulated snowmelt depth                       | $\mathrm{kg/m^2}$   | GLSDM        |
| $P_{r_c}$                      | Water input after canopy interception derived from convective precipitation (input) and input to ground (output) | $\mathrm{kg/m^2/s}$ | WINPC        |
| $P_{r_l}$                      | Water input after canopy interception derived from layered precipitation (input) and input to ground (output)    | $\mathrm{kg/m^2/s}$ | WINPL        |
| $\rho_{d_w(k)} \;\; (k=1,2,3)$ | Density of dust and black carbon in the $k$th snow layer calculated using $D_w$ | $\mathrm{ppmv}$     | CDST         |
| $\rho_{d_m(k)} \;\; (k=1,2,3)$ | Density of dust and black carbon in the $k$th snow layer calculated using $D_m$ | $\mathrm{ppmv}$     | CDSTM        |
Table: Modified
<!--endlandscape-->


| Variable                    | Description                                      | Unit                | Name in code |
|:----------------------------|:-------------------------------------------------|:--------------------|:-------------|
| $Ro_{gl}$                  | Glacier formation                                | $\mathrm{kg/m^2/s}$ | GGLACR       |
Table: Output


| Variable                    | Description                                          | Unit                | Name in code |
|:----------------------------|:-----------------------------------------------------|:--------------------|:-------------|
| $P_{Sn}$                   | Snowfall                                             | $\mathrm{kg/m^2/s}$ | SNFAL        |
| $E_{Sn}$                   | Snow sublimation                                     | $\mathrm{kg/m^2/s}$ | SNSUB        |
| $F_{Sn(1/2)}$              | Snow surface heat flux                               | $\mathrm{W/m^2}$    | SNFLXS       |
| $T_{g(k)}$                 | Soil temperature of the $k$th layer                  | $\mathrm{T}$        | GLG          |
| $w_{g(k)}$                 | Soil moisture                                        | $\mathrm{m^3/m^3}$  | GLW          |
| $w_c$                      | Canopy water                                         | $\mathrm{m}$        | GLWC         |
| $A_{Snc}$                  | Canopy snow ratio                                    | -                   | SNRATC       |
| $D_w$                      | Weighted mean of the fluxes of dust and black carbon | $\mathrm{kg/m^2/s}$ | DSTFAL       |
| $D_m$                      | Flux of dust and black carbon                        | $\mathrm{kg/m^2/s}$ | DSTFLM       |
| $z_{sd}$                   | Standard deviation of topography                     | $\mathrm{m}$        | GRZSD        |
| $T_{hist}$                 | Annual mean temperature over the latest 30 years     | $\mathrm{K}$        | T2HIST       |
| -                           | Index of the surface condition                       | -                   | ILSFC        |
| -                           | Soil type                                            | -                   | ILSOIL       |
Table: Input


## Diagnosis of snow cover fraction

MATSIRO has two ways of calculation of the snow cover fraction, and the user can switch them with the option OPT_SSNOWD.

### Case 1: When OPT_SSNOWD is active

The snow cover fraction is diagnosed in the SUBROUTINE SSNOWD_DRV, a driver of a Subgrid SNOW Distribution (SSNOWD) submodel developed by @Liston2004-kr, with a physically based parameterization of sub-grid snow distribution considering various factors such as differences in topography, the time of snowfall or snow melting, etc [@Nitta2014-ct;@Tatebe2019-ow].

The snow cover fraction is formulated for accumulation and ablation seasons separately.
At the grids where snow does not disappear completely, the flag of transition from ablation season to accumulation season is raised. It occurs at the time step next of 1 August in the northern hemisphere and 1 February in the southern hemisphere. The transition is judged based on the snow amount, accumulated snow, net snow gain and snowfall. This flag is included in the restart variables similarly to the state variables.

For the accumulation season, snowfall occures uniformly and the snow cover fraction is assumed to be unity in the grid cell.
For the ablation season, the snow cover fraction decreases based on the sub-grid distribution of the snow water equivalent. Under the assumption of uniform melt depth ${W_{Sn}}_m$, the sum of snow-free and snow-covered fraction equals unity:

$$
\int_0^{{W_{Sn}}_m} f(W_{Sn})dW_{Sn} + \int_{{W_{Sn}}_m}^\infty f(W_{Sn})dW_{Sn} = 1, \tag{8-1}
$$
where $W_{Sn}$ is the snow water equivalent depth and $f(W_{Sn})$ is the probability distribution function of snow water equivalent depth within the grid cell. The snow depth distribution within each grid cell is assumed to follow a lognormal distribution:

$$
f(W_{Sn}) = \frac{1}{W_{Sn}\zeta\sqrt{2\pi}} \exp{ \left[
 -\frac{1}{2} {\left( \frac{\ln(W_{Sn})-\lambda}{\zeta} \right)}^2
\right] }, \tag{8-2}
$$
where $\lambda = \ln(W_{Sn}) - \frac{1}{2}\zeta^2$ and $\zeta^2 = \ln(1+CV^2)$.

Here $W_{Sn}$ is the accumulated snow and $CV$ is the coefficient of variation. With the default settings, $CV$ is diagnosed from the coldness index $T_{hist}$, standard deviation of the subgrid topography $z_{sd}$ and vegetation type that is a proxy for surface winds.
For $T_{hist}$, the annually averaged temperature over the latest 30 years using the time relaxation method of @Krinner2005-xa, in which the timescale parameter is set to 16 years, is applied. The temperature threshold for a category diagnosis is set to 0 and 10 $^\circ\mathrm{C}$.
When $T_{hist} \ge 10$, $CV$ takes constant value of 0.0.6. In other two cases of $0 \le T_{hist} < 10$ and $T_{hist} < 0$, it is determined from $z_{sd}$ and vegetation type.

The snow amount $Sn$ is given by
$$
Sn({W_{Sn}}_m)
 = \int_0^{{W_{Sn}}_m} 0[f(W_{Sn})]dW_{Sn}
 + \int_{{W_{Sn}}_m}^\infty (W_{Sn}-{W_{Sn}}_m)[f(W_{Sn})]dW_{Sn}, \tag{8-3}
$$
and this equation is rewritten to
$$
Sn({W_{Sn}}_m)
 = \frac{1}{2} \exp{\left( \lambda + \frac{\zeta^2}{2} \right)}
 \mathrm{erfc} \left( \frac{z_{{W_{Sn}}_m}-\xi}{\sqrt{2}} \right)
 - \frac{1}{2} {W_{Sn}}_m \mathrm{erfc} \left( \frac{z_{{W_{Sn}}_m}}{\sqrt{2}} \right), \tag{8-4}
$$
where $\xi = (1-\sqrt{2})z$, $z = \frac{\ln(W_{Sn})-\lambda}{\zeta}$, and $z_{{W_{Sn}}_m}$ is the value of $z$ when $W_{Sn} = {W_{Sn}}_m$ and $\mathrm{erfc}$ is the complementary error function.
${W_{Sn}}_m$ is calculated from this equation and the snow amount $Sn$ using Newton-Raphson methods (in SUBROUTINE SSNOWD_ITR in ssnowd.F).

Then, the snow cover fraction $A_{Sn}({W_{Sn}}_m)$ is calculated by
$$
A_{Sn}({W_{Sn}}_m) = 1 - \int_0^{{W_{Sn}}_m} f(W_{Sn})dD
= \frac{1}{2} \mathrm{erfc} \left( \frac{z_{{W_{Sn}}_m}}{2} \right). \tag{8-5}
$$

### Case 2: When OPT_SSNOWD is inactive

The snow cover fraction is diagnosed in SUBROUTINE SNWRAT. The snow cover fraction is formulated as a function of the snow amount $Sn$:
$$
Sn({W_{Sn}}_m) = \min(\sqrt{Sn/Sn_c},1), \tag{8-6}
$$
where $Sn_c$ is 100 $\mathrm{kg/m^2}$ as a standard.


## Vertical division of snow layers

In order to express the vertical distribution of the snow temperature, when the snow water equivalent is large, the snow is divided into multiple layers and the temperature is defined in each layer. The number of snow layers can be varied, with the number of layers increasing as the snow water equivalent becomes larger. A minimum of one layer and a maximum of three layers are set as a standard.

This process is treated in SUBROUTINE SNWCUT in matsnw.F.

The number of layers and the mass of each layer are determined uniquely by the snow water equivalent. Consequently, the mass of each layer does not become a new prognostic variable.

As a standard, the mass of each layer ($\Delta{\widetilde{Sn}}_{(k)} (k=1,2,3)$) is determined as follows ($k=1$ is the uppermost layer):

$$
\begin{aligned}
\Delta \widetilde{Sn}_{(1)} &= \left\{
\begin{array}{ll}
 \widetilde{Sn} \\
 0.5\widetilde{Sn}  \\
 20
\end{array}
\begin{array}{ll}
 (\widetilde{Sn} < 20) \\
 (20 \leq \widetilde{Sn} < 40) \\
 (\widetilde{Sn} \geq 40)
\end{array}
\right. \\
\Delta \widetilde{Sn}_{(2)} &= \left\{
\begin{array}{ll}
 0 \\
 \widetilde{Sn} - \Delta Sn_{(1)} \\
 0.5(\widetilde{Sn} - 20) \\
 40
\end{array}
\begin{array}{ll}
 (\widetilde{Sn} < 20) \\
 (20 \leq \widetilde{Sn} < 60) \\
 (60 \leq \widetilde{Sn} < 100) \\
 (\widetilde{Sn} \geq 100)
\end{array}
\right. \\
\Delta \widetilde{Sn}_{(3)} &= \left\{
\begin{array}{ll}
 0 \\
 \widetilde{Sn} - (\Delta Sn_{(1)} + \Delta Sn_{(2)})
\end{array}
\begin{array}{ll}
 (\widetilde{Sn} < 60) \\
 (\widetilde{Sn} \geq 60)
\end{array}
\right.
\end{aligned}, \tag{8-7}
$$
where $\widetilde{Sn} =  Sn / A_{Sn}.$

$Sn$ is the grid-mean snow water equivalent, and $\widetilde{Sn}$ is the snow water equivalent in the snow-covered portion. Note that the mass of each layer ($\Delta{\widetilde{Sn}}_{(k)}$) is also the value of the snow-covered portion, not the grid-mean value. The unit is $\mathrm{kg/m^2}$.

From the above, it can be clearly seen that the number of snow layers ($K_{Sn}$) is as follows, as a standard:

$$
 K_{Sn} = \left\{
\begin{array}{ll}
 0 \;\;\; (\widetilde{Sn} = 0)\\
 1 \;\;\; (0< \widetilde{Sn} < 20)\\
 2 \;\;\; (20 \leq \widetilde{Sn} < 60)\\
 3 \;\;\; (\widetilde{Sn} \geq 60)
\end{array}
\right. \tag{8-8}
$$

## Calculation of snow water equivalent

The prognostic equation of the snow water equivalent is given by

$$
 \frac{Sn^{\tau+1}-Sn^{\tau}}{\Delta t_L} = P_{Sn}^{\ast} - E_{Sn} - M_{Sn} + Fr_{Sn} \tag{8-12}
$$

where $P_{Sn}^{\ast}$ is the snowfall flux after interception by the canopy, $E_{Sn}$ is the sublimation flux, $M_{Sn}$ is the snowmelt, and $Fr_{Sn}$ is the refreeze of snowmelt or the freeze of rainfall.

### Sublimation of snow

First, by subtracting the sublimation, the snow water equivalent is updated:
$$
Sn^{\ast} = Sn^{\tau} - E_{Sn} \Delta t, \tag{8-10}
$$
$$
\Delta \widetilde{Sn}_{(1)}^{\ast} = \Delta \widetilde{Sn}_{(1)}^{\tau} - E_{Sn}/A_{Sn} \Delta t_L \tag{8-14}
$$
The asterisk indicates that the variable is under updating in the time step.

In a case where the sublimation is larger than the snow water equivalent in the uppermost snow layer, the remaining amount is subtracted from the layer below. If the amount in the second layer is insufficient for such subtraction, the remaining amount is subtracted from the layer below that.

### Snowmelt

Next, the snow heat conduction is calculated to solve the snowmelt. The method of calculating the snow heat conduction is described later. The updated snow temperature incorporating the heat conduction is assumed to be $T_{Sn(k)}^{\ast}$.
When the snow temperature is calculated and the temperature of the uppermost snow layer becomes higher than $T_{melt} = 0 ^\circ\mathrm{C}$, the calculation of snow heat conduction is performed again with the fixed snow temperature of the uppermost snow layer at $T_{melt}$.
In this case, the energy convergence $\Delta \widetilde{F}_{conv}$ in the uppermost snow layer is calculated. This is not the grid-mean value but the value of the snow-covered portion. The snowmelt in the uppermost snow layer is

$$
\widetilde{M}_{Sn(1)} = \min(\Delta \widetilde{F}_{conv} / l_m, \Delta \widetilde{Sn}_{(1)}^{\ast}/\Delta t ). \tag{8-12}
$$

With regard to the second snow layer and below, if the estimated snow temperature is higher than $T_{melt}$, it is adjusted to $T_{melt}$ and the desidual energy from the adjustment is applied to the snowmelt. That is, it is assumed to be

$$
T_{Sn(k)}^{\ast\ast} = T_{melt}. \tag{8-13}
$$

$\Delta \widetilde{F}_{conv}$ is newly defined by
$$
\Delta \widetilde{F}_{conv} = ( T_{Sn_{(k)}}^{\ast} - T_{melt} ) c_{pi}\Delta\widetilde{Sn}_{(k)}^{\ast}/\Delta t, \tag{8-14}
$$
where $c_{pi}$ is the specific heat of snow (ice), and the snowmelt is solved as in Eq. [8-12](#8-12).

By subtracting the snowmelt, the mass of each layer is updated:
$$
\Delta\widetilde{Sn}_{(k)}^{\ast\ast} = \Delta\widetilde{Sn}_{(k)}^{\ast} - \widetilde{M}_{Sn_{(k)}}. \tag{8-15}
$$

During these calculations, when a certain layer is fully melted, the remaining amount of $\Delta \widetilde{F}_{conv}$ is given to the layer below to raise the temperature in that layer; that is,
$$
\Delta \widetilde{F}_{conv}^{\ast} = \Delta \widetilde{F}_{conv} - l_m \widetilde{M}_{Sn_{(k)}}, \tag{8-16}
$$
$$
T_{Sn_{(k+1)}}^{\ast\ast}
 = T_{Sn_{(k+1)}}^{\ast} + \Delta \widetilde{F}_{conv}^{\ast} / (c_{pi} \Delta\widetilde{Sn}_{(k+1)}^{\ast}) \Delta t. \tag{8-17}
$$

When all of the snow is melted, $\Delta \widetilde{F}_{conv}^{\ast}$ is given to the soil.

The snowmelt of the overall snow is the sum of the snowmelt in each layer (note, however, that it is the grid-mean value):
$$
M_{Sn} = \sum_{k=1}^{K_{Sn}} \widetilde{M}_{Sn(k)} A_{Sn} \tag{8-18}
$$

By subtracting the snowmelt, the snow water equivalent is updated:
$$
Sn^{\ast\ast} = Sn^{\ast} - M_{Sn} \Delta t. \tag{8-19}
$$

### Freeze of snowmelt water and rainfall in snow

The freeze of snowmelt water and rainfall in the snow is calculated next.
With regard to the snowmelt water, consideration is given to the effect of the liquid water produced by the snowmelt in the upper layer refreezing in the lower layer.
The retention of liquid water content in the accumulated snow is not considered, and the entire amount is treated whether it has frozen in the snow or percolated under the snow.

The liquid water flux at the snow upper boundary in the snow-covered portion is
$$
\widetilde{F}_{wSn(1)} = Pr_c^{\ast} + Pr_l^{\ast} + M_{Sn} / A_{Sn}. \tag{8-20}
$$

Here, the melted portion in the second layer of the snow and below is also assumed to have percolated from the snow upper boundary (in actuality, snowmelt in the second layer or below rarely occurs).

It is reasonable to assume the temperature of the snowmelt water as 0 $^\circ\mathrm{C}$, and the temperature of rainfall on the snow is also assumed to be 0 $^\circ\mathrm{C}$ for convenience.
The temperature of the snow increases due to the latent heat of the freezing of water; however, when the temperature of the snow in a certain layer is increased to 0 $^\circ\mathrm{C}$, any additional water is assumed to be unable to freeze and to percolate to the layer below.
In addition, an upper limit is set on the ratio of water that can be frozen compared with the mass of snow in the layer. The amount of freeze in a given layer $\widetilde{Fr}_{Sn(k)}$ is solved by

$$
\widetilde{Fr}_{Sn_{(k)}} = \min\left(
\widetilde{F}_{w_{Sn_{(k)}}}, \
\frac{c_{pi}(T_{melt}-T_{Sn_{(k)}}^{\ast\ast})}{l_m} \
\frac{\Delta\widetilde{Sn}_{(k)}^{\ast\ast}}{\Delta t} , \
f_{Fmax}\frac{\Delta\widetilde{Sn}_{(k)}^{\ast\ast}}{\Delta t} \
\right), \tag{8-21}
$$
where $\widetilde{F}_{w_{Sn_{(k)}}}$ is the liquid water flux flowing from the top of the $k$th layer of snow cover. $f_{Fmax}$ is assumed to be 0.1 as a standard value.

The snow temperature change is updated by
$$
T_{Sn_{(k)}}^{\ast\ast\ast} = \frac{l_m \widetilde{Fr}_{Sn_{(k)}}\Delta t
 + c_{pi}(T_{Sn_{(k)}}^{\ast\ast} \Delta\widetilde{Sn}_{(k)}^{\ast\ast}
 + T_{melt} \widetilde{Fr}_{Sn_{(k)}}\Delta t)}
 {c_{pi}(\Delta\widetilde{Sn}_{(k)}^{\ast\ast} + \widetilde{Fr}_{Sn_{(k)}}\Delta t)}, \tag{8-22}
$$
and the mass is updated as follows:
$$
\Delta\widetilde{Sn}_{(k)}^{\ast\ast\ast} = \Delta\widetilde{Sn}_{(k)}^{\ast\ast} + \widetilde{Fr}_{Sn_{(k)}}\Delta t. \tag{8-23}
$$

The amount of freeze in the overall snow is the sum of the amounts of freeze in each layer (note, however, that it is the grid-mean value):
$$
Fr_{Sn} = \sum_{k=1}^{K_{Sn}} \widetilde{Fr}_{Sn_{(k)}} A_{Sn}. \tag{8-24}
$$

By adding the amount of freeze, the snow water equivalent is partially updated as follows:
$$
Sn^{\ast\ast\ast} = Sn^{\ast\ast} + Fr_{Sn} \Delta t. \tag{8-25}
$$

The liquid water that has percolated from the snow to the lower boundary is given to the soil.

### Snowfall

Lastly, by adding the snowfall after interception by the canopy, the finally updated snow water equivalent is obtained:
$$
Sn^{\tau+1} = Sn^{\ast\ast\ast} + P_{Sn}^{\ast} \Delta t. \tag{8-26}
$$

However, when the temperature of the uppermost soil layer is 0 $^\circ\mathrm{C}$ or more, the snowfall is assumed to melt on the ground. In this case, the energy of the latent heat of melting is taken from the soil.

When snow is produced by snowfall in a grid where no snow was formerly present, the snow-covered ratio ($A_{Sn}$) is newly diagnosed by Eq. [8-5](#8-5) and the snow temperature ($T_{Sn(1)}$) is assumed to be equal to the temperature of the uppermost soil layer.

The snowfall is added to the mass of the uppermost layer:
$$
\Delta\widetilde{Sn}_{(k)}^{\tau+1} = \Delta\widetilde{Sn}_{(k)}^{\ast\ast\ast} + P_{Sn}^{\ast} \Delta t /A_{Sn}. \tag{8-27}
$$

### Redivision of snow layer and rediagnosis of temperature

When the snow water equivalent is updated, the snow-covered ratio is rediagnosed as described in the section 8.1 and the mass of each layer is reallocated as described in the section 8.2. The temperature in each redivided layer is rediagnosed so that the energy is conserved as follows:

$$
T_{Sn_{(k)}}^{\mathrm{new}} = \left(
 \sum_{l=1}^{K_{Sn}^{\mathrm{old}}}
 f_{(l^{\mathrm{old}}\in k^{\mathrm{new}})} T_{Sn(l)}^{\mathrm{old}}
 \Delta\widetilde{Sn}_{(l)}^{\mathrm{old}} A_{Sn}^{\mathrm{old}}
\right) \Bigm/ (\Delta\widetilde{Sn}_{(k)}^{\mathrm{new}} A_{Sn}^{\mathrm{new}}). \tag{8-28}
$$

It should be noted that the variables with the index "old" and "new" are those before and after redivision, respectively. $f_{(l^{\mathrm{old}}\in k^{\mathrm{new}})}$ is the ratio of the mass of the $k$th layer after redivision to the mass of the $l$th layer before redivision.


## Calculation of snow heat conduction

### Snow heat conduction equations

The prognostic equation of the snow temperature due to snow heat conduction is as follows:
$$
c_{pi} \Delta\widetilde{Sn}_{(k)} \frac{T_{Sn(k)}^{\ast} - T_{Sn(k)}^{\tau}}{\Delta t} = \widetilde{F}_{Sn(k+1/2)} - \widetilde{F}_{Sn(k-1/2)}
\qquad (k=1,\ldots,K_{Sn}) \tag{8-29}
$$
with the heat conduction flux $\widetilde{F}_{Sn}$ given by
$$
\widetilde{F}_{Sn(k+1/2)}
 = \left\{
 \begin{aligned}
  & (F_{Sn(1/2)} - \Delta F_{conv(1)}) / A_{Sn} - \Delta F_{c,conv}
  \; &&(k = 0) \\
  & k_{Sn(k+1/2)} \frac{T_{Sn(k+1)}-T_{Sn(k)}}{\Delta z_{Sn(k+1/2)}}
  \; &&(k = 1, ..., K_{Sn}-1) \\
  & k_{Sn(k+1/2)} \frac{T_{Sn(B)}-T_{Sn(k)}}{\Delta z_{Sn(k+1/2)}}
  \; &&(k = K_{Sn})
 \end{aligned}
\right., \tag{8-30}
$$
where $k_{Sn(k+1/2)}$ is the snow heat conductivity, assigned the fixed value of 0.3 W/m/K as a standard. The subscript $k+1/2$ of the flux represents the flux from the $(k+1)$th snow layer to the upper one.
$\Delta z_{Sn(k+1/2)}$ is the thickness of each snow layer, defined by
$$
\Delta z_{Sn(k+1/2)}
 = \left\{
 \begin{aligned}
  & 0.5 \Delta\widetilde{Sn}_{(1)} / \rho_{Sn}
  \; &&(k = 1) \\
  & 0.5 (\Delta\widetilde{Sn}_{(k)} + \Delta\widetilde{Sn}_{(k+1)}) / \rho_{Sn}
  \; &&(k = 2, ..., K_{Sn}-1) \\
  & 0.5 \Delta\widetilde{Sn}_{(K_{Sn})} / \rho_{Sn}
  \; &&(k = K_{Sn})
 \end{aligned}
\right., \tag{8-31}
$$
where $\rho_{Sn}$ is the snow density, assigned the fixed value of $300 \mathrm{kg/m^3}$ as a standard. The snow density and heat conductivity are considered to change over time due to compaction and changes in properties (aging), but the effect of such changes is not considered here.

In Eq. [8-30](#8-30), the snow upper boundary flux $\widetilde{F}_{Sn(1/2)}$ is given using three energy variables: the heat conduction flux from the snow to the ground surface solved in the ground surface energy balance $F_{Sn(1/2)}$, the ground surface energy convergence produced when the ground surface temperature is solved by the snowmelt condition $\Delta F_{conv}$, and the energy correction produced when a change has occurred in the phase of the canopy water $\Delta F_{c,conv}$.
$\Delta F_{conv}$ is assumed to be given only to the snow-covered portion, while $\Delta F_{c,conv}$ is given uniformly to the grid cells. Since the sign of the flux is taken as upward positive, the convergence has a negative sign.

In the equation for the snow lower boundary flux $\widetilde{F}_{Sn_{(K_{Sn}+1/2)}}$, $T_{Sn_{(B)}}$ is the temperature of the snow lower boundary (the boundary surface of the snow and the soil). However, since the flux from the uppermost soil layer to the snow lower boundary is
$$
\widetilde{F}_{g(1/2)} = k_{g(1/2)} \frac{T_{g(1)}-T_{Sn_{(B)}}}{\Delta z_{g(1/2)}}. \tag{8-32}
$$

There is assumed to be no convergence at the snow lower boundary, and $T_{Sn_{(B)}}$ is solved by putting
$$
\widetilde{F}_{Sn_{(K_{Sn}+1/2)}} = \widetilde{F}_{g(1/2)}. \tag{8-33}
$$

When this is substituted into Eq. [8-30](#8-30), the following is obtained:
$$
\widetilde{F}_{Sn_{(K_{Sn}+1/2)}}
 = \left[ \frac{\Delta z_{g(1/2)}}{k_{g(1/2)}}
  +\frac{\Delta z_{Sn_{(K_{Sn}+1/2)}}}{k_{Sn_{(K_{Sn}+1/2)}}}
 \right]^{-1}
 (T_{g(1)} - T_{Sn_{(K_{Sn})}}). \tag{8-34}
$$

### Case 1: When snowmelt does not occur in the uppermost layer

The implicit method is used to treat the temperature from the uppermost snow layer to the lowest snow layer, as follows:

$$
\begin{aligned}
\widetilde{F}_{Sn_{(k+1/2)}}^{\ast}
 &= \widetilde{F}_{Sn_{(k+1/2)}}^{\tau}
 + \frac{\partial \widetilde{F}_{Sn_{(k+1/2)}}}{\partial T_{Sn_{(k)}}} \Delta T_{Sn_{(k)}}
 + \frac{\partial \widetilde{F}_{Sn_{(k+1/2)}}}{\partial T_{Sn_{(k+1)}}} \Delta T_{Sn_{(k+1)}}, \\
\widetilde{F}_{Sn_{(k+1/2)}}^{\tau}
 &= \left\{ \begin{aligned}
 & (F_{Sn_{(1/2)}} - \Delta F_{conv}) / A_{Sn} - \Delta F_{c,conv}
 \; && (k = 0) \\
 & \frac{k_{Sn_{(k+1/2)}}}{\Delta z_{Sn(k+1/2)}} (T_{Sn(k+1)}^\tau - T_{Sn(k)}^\tau)
 \; && (k = 1, ..., K_{Sn}-1) \\
 & \left[
  \frac{\Delta z_{g(1/2)}}{k_{g(1/2)}}
  + \frac{\Delta z_{Sn_{(K_{Sn}+1/2)}}}{k_{Sn_{(K_{Sn}+1/2)}}}
 \right]^{-1} (T_{g(1)} - T_{Sn_{(K_{Sn})}}^\tau)
 \; && (k = K_{Sn})
\end{aligned} \right., \\
\frac{\partial \widetilde{F}_{Sn_{(k+1/2)}}}{\partial T_{Sn_{(k)}}}
 &= \left\{ \begin{aligned}
 & -\frac{k_{Sn_{(k+1/2)}}}{\Delta z_{Sn_{(k+1/2)}}}
 \; &&(k = 1, ..., K_{Sn}-1) \\
 & -\left[ \frac{\Delta z_{g(1/2)}}{k_{g(1/2)}}
  + \frac{\Delta z_{Sn_{(K_{Sn}+1/2)}}}{k_{Sn_{(K_{Sn}+1/2}}}
 \right]^{-1}
 \; &&(k = K_{Sn})
\end{aligned} \right., \\
\frac{\partial\widetilde{F}_{Sn_{(k+1/2)}}}{\partial T_{Sn_{(k+1)}}}
 &= \left\{ \begin{aligned}
 & 0
 \; &&(k = 0) \\
 & \frac{k_{Sn_{(k+1/2)}}}{\Delta z_{Sn_{k+1/2)}}}
 \; &&(k = 1, ..., K_{Sn}-1)
\end{aligned} \right.
\end{aligned} \tag{8-35}
$$

and Eq. [8-29](#8-29) is treated as
$$
\begin{aligned}
 c_{pi}\widetilde{Sn}_{(k)} \frac{\Delta T_{Sn_{(k)}}}{t}
 &= &&\widetilde{F}_{Sn_{(k+1/2)}}^{\ast} - \widetilde{F}_{Sn_{(k-1/2)}}^{\ast} \\
 &= &&\widetilde{F}_{Sn_{(k+1/2)}}^{\tau}
  + \frac{\partial \widetilde{F}_{Sn_{(k+1/2)}}}{\partial T_{Sn_{(k)}}}   \Delta T_{Sn_{(k)}}
  + \frac{\partial \widetilde{F}_{Sn_{(k+1/2)}}}{\partial T_{Sn_{(k+1)}}} \Delta T_{Sn_{(k+1)}} \\
 & &&- \widetilde{F}_{Sn_{(k-1/2)}}^{\tau}
  - \frac{\partial \widetilde{F}_{Sn_{(k-1/2)}}}{\partial T_{Sn_{(k-1)}}} \Delta T_{Sn_{(k-1)}}
  - \frac{\partial \widetilde{F}_{Sn_{(k-1/2)}}}{\partial T_{Sn_{(k)}}}   \Delta T_{Sn_{(k)}}
\end{aligned} \tag{8-36}
$$

and solved by the LU factorization method as $\Delta T_{Sn_{(k)}} (k = 1, ..., K_{Sn})$ simultaneous equations with respect to $K_{Sn}$.
At this juncture, it should be noted that the flux at the snow upper boundary is fixed as the boundary condition, and the snow lower boundary flux is treated explicitly with regard to the temperature of the uppermost soil layer, which is the boundary condition of the snow lower boundary.
The snow temperature is updated by
$$
T_{Sn_{(k)}}^{\ast} = T_{Sn_{(k)}}^{\tau} + \Delta T_{Sn_{(k)}} \tag{8-37}
$$

### Case 2: When snowmelt occurs in the uppermost layer

When the temperature of the uppermost snow layer solved in case 1 is higher than 0 $^\circ\mathrm{C}$, snowmelt occurs in the uppermost snow layer. In this case, the temperature of the uppermost snow layer is fixed at 0 $^\circ\mathrm{C}$. The flux from the second snow layer to the uppermost snow layer is then expressed as
$$
\widetilde{F}_{3/2}^{\ast}
 = \frac{k_{Sn_{(3/2)}}}{\Delta z_{Sn_{(3/2)}}} (T_{Sn_{(2)}}^{\tau} - T_{melt})
 +\frac{\partial \widetilde{F}_{Sn_{(3/2)}}}{\partial T_{Sn_{(2)}}}
 \Delta T_{Sn_{(2)}} \tag{8-38}
$$
and solved similarly to case 1 (when there is only one snow layer, the snow temperature is similarly fixed in the flux from the soil to the snow).

The energy convergence used for melting in the uppermost snow layer is given by:
$$
\Delta \widetilde{F}_{conv}
 = (\widetilde{F}_{3/2}^{\ast} - \widetilde{F}_{1/2})
 - c_{pi}\widetilde{Sn}_{(1)} \frac{T_{melt}-T_{Sn_{(1)}}^{\ast}}{\Delta t}. \tag{8-39}
$$

Even if the temperature of the second snow layer and below is higher than $T_{melt}$, the calculation is not iterated and the snowmelt is corrected accordingly.


## Fluxes given to the soil or the runoff process

The heat flux given to the soil through the snow process is
$$
\Delta F_{conv}^{\ast}
 = A_{Sn} (\Delta\widetilde{F}_{conv}^{\ast} - \widetilde{F}_{Sn_{K_{Sn}}}) - l_m P_{Sn,melt}^{\ast}, \tag{8-40}
$$
where $\Delta\widetilde{F}_{conv}^{\ast}$ is the energy convergence remaining when all of the snow has melted, $\widetilde{F}_{Sn_{K_{Sn}}}$ is the heat conduction flux at the lowest snow layer, and $P_{Sn,melt}^{\ast}$ is the snowfall that melts immediately when it reaches the ground, defined as
$$
P_{Sn,melt}^{\ast} = \left\{ \begin{aligned}
& 0            && (T_{g(1)} \le T_{melt}) \\
& P_{Sn}^{\ast} && (T_{g(1)} > T_{melt})
\end{aligned} \right. \tag{8-41}
$$

Since the energy of the snow-free portion is given to the soil as it is, the energy correction term due to the phase change of the canopy water is as follows:
$$
 \Delta F_{c,conv}^{\ast} = (1 - A_{Sn}) \Delta F_{c,conv}. \tag{8-42}
$$

The water flux given to the runoff process through the snow process is then expressed as
$$
\begin{aligned}
 Pr_c^{\ast\ast} &= ( 1 - A_{Sn} ) Pr_c^{\ast}, \\
 Pr_l^{\ast\ast} &= ( 1 - A_{Sn} ) Pr_l^{\ast} + A_{Sn} \widetilde{F}_{wSn}^{\ast} + P_{Sn,melt}^{\ast},
\end{aligned} \tag{8-43}
$$
where $\widetilde{F}_{wSn}^{\ast}$ is the flux of the rainfall or snowmelt water that has percolated through the lowest snow layer.


## Glacier formation

In this case, the maximum value is set for the snow water equivalent, and the portion exceeding the maximum value is considered to become glacier runoff:
$$
\begin{aligned}
 Ro_{gl} &= \max(Sn - Sn_{\mathrm{max}}, 0) / \Delta t, \\
 Sn &= Sn - Ro_{gl} \Delta t, \\
 \Delta \widetilde{Sn}_{(K_{Sn})} &= \Delta \widetilde{Sn}_{(K_{Sn})} - Ro_{gl} / A_{Sn} \Delta t,
\end{aligned} \tag{8-44}
$$
where $Ro_{gl}$ is the glacier runoff. The mass of this portion is subtracted from the lowest snow layer. $Sn_{\max}$ is uniformly assigned the value of $1000 \mathrm{kg/m^2}$ as a standard.


## Dust in snow

The amount of dust on the snow cover and in the snow layers are calculated in SUBROUTINE DSTCUT in matsnw.F.

### Dust fall on the snow cover

The flux of dust and black carbon (DBC), the light-absorpting particles, is calculated in SUBROUTINE MATSIRO in matdrv.F when the option OPT_SNWALB is active.

Flux of DBC $D_m$ and weighted-mean flux of DBC $D_w$ is obtained by
$$
\begin{aligned}
D_m &= D_{dust} + D_{BC}, \\
D_w &= \frac{\gamma_{dust} D_{dust} + \gamma_{BC} D_{BC}}{\gamma_{dust} + \gamma_{BC}},
\end{aligned} \tag{8-45}
$$
where $D_{dust}$ and $D_{BC}$ is the flux of dust and black carbon, respectively. $\gamma_{c} (c = dust, BC)$ is defined by
$$
\gamma_{c} = \gamma_{c,vis} \omega_{vis} + \gamma_{c,nir} \omega_{nir} + \gamma_{c,ifr} \omega_{ifr}, \tag{8-46}
$$
where $\gamma_{c,b}$ is the absorption coefficient for the band $b$, and $\omega_b$ is the radiation weight of the band $b$. Three bands of wavelength, visible (vis), near infrared (nir) and infrared (ifr) are considered in MATSIRO, and they take the following values as a standard.
$$
\begin{aligned}
\gamma_{dust,vis} &= 6.36777 \times 10^2, &
\gamma_{dust,nir} &= 3.34617 \times 10^2, &
\gamma_{dust,ifr} &= 8.62054 \times 10^2, \\
\gamma_{BC,vis}   &= 7.43200 \times 10^4, &
\gamma_{BC,nir}   &= 2.93200 \times 10^4, &
\gamma_{BC,ifr}   &= 2.47174 \times 10^3, \\
\omega_{vis} &= 0.46, &\omega_{nir} &= 0.36, &\omega_{ifr} &= 0.18
\end{aligned} \tag{8-47}
$$

The amount of DBC on the uppermost snow layer is updated as
$$
\begin{aligned}
M_{d_m(1)}^{\tau+1} &= M_{d_m(1)}^{\tau} + D_m, \\
M_{d_w(1)}^{\tau+1} &= M_{d_w(1)}^{\tau} + D_w,
\end{aligned} \tag{8-48}
$$
where $M_{d_m(k)}$ and $M_{d_w(k)}$ are the amount of DBC on the $k$th snow layer.


### Redistribution of dust

The amount of DBC in each layer is calculated in SUBROUTINE DSTCUT based on the results of snow layer recutting (SUBROUTINE SNWCUT). Note that this subroutine is applied for both $Md_m$ and $Md_w$, so they are represented by $Md$.
Also, in this section, $\rho_{d(k)}$ represents $\rho_{d_m(k)}$ and $\rho_{d_w(k)}$, the density of dust and black carbon calculated using ${M_d}_m$ and ${M_d}_w$, respectively.

The snow mass of $k$th layer after updating of snow mass but before snow layer recutting $\Delta Sn^{\tau+1/2}_{(k)}$ is calculated in
$$
\Delta Sn^{\tau+1/2}_{(k)} = \Delta Sn^{\tau}_{(k)} A_{Sn}^{\tau} / A_{Sn}^{\tau+1} \;\; (k = 1, 2, 3), \tag{8-49}
$$
where $\tau$ and $\tau+1$ represent before updating of snow mass and after recutting of snow layer, respectively.

When $\Delta Sn^{\tau+1}_{(1)} > \Delta Sn^{\tau+1/2}_{(1)}$, the amount of DBC in the 1st layer increases due to increase in the snow mass in this layer. This is calculated as
$$
M_{d(1)}^{\tau+1} - M_{d(1)}^{\tau}
 = \left\{ \begin{aligned}
 & \rho_{d(2)} \Delta Sn^{\tau+1/2}_{(2)}
 + \rho_{d(3)} \left( \Delta Sn^{\tau+1}_{(1)} - \Delta Sn^{\tau+1/2}_{(1)} - \Delta Sn^{\tau+1/2}_{(2)} \right) \\
 & \hspace{36mm}
 \left( \Delta Sn^{\tau+1}_{(1)} - \Delta Sn^{\tau+1/2}_{(1)} > \Delta Sn^{\tau+1/2}_{(2)} \right) \\
 & \rho_{d(2)} \left( \Delta Sn^{\tau+1}_{(1)} - \Delta Sn^{\tau+1/2}_{(1)} \right) \\
 & \hspace{36mm}
 \left( \Delta Sn^{\tau+1}_{(1)} - \Delta Sn^{\tau+1/2}_{(1)} \leq \Delta Sn^{\tau+1/2}_{(2)} \right)
\end{aligned} \right., \tag{8-50}
$$
where $\rho_{d(k)}$ is the density of DBC in the $k$th layer.

When $\Delta Sn^{\tau+1}_{(1)} \leq \Delta Sn^{\tau+1/2}_{(1)}$, the amount of DBC in the 1st layer decreases, and thus
$$
M_{d(1)}^{\tau+1} - M_{d(1)}^{\tau}
 = -\rho_{d(1)} \left( \Delta Sn^{\tau+1/2}_{(1)} - \Delta Sn^{\tau+1}_{(1)} \right). \tag{8-51}
$$

It leads to
$$
M_{d(1)}^{\tau+1} - M_{d(1)}^{\tau} = M_{d(1)}^{+} - M_{d(1)}^{-}, \tag{8-52}
$$
where
$$
\begin{aligned}
M_{d(1)}^{+}
 = &\rho_{d(2)} \min\left( \max\left( Sn^+_{(1)}, 0 \right), Sn_{(2)}^{\tau+1/2} \right) \\
 & + \rho_{d(3)} \max\left( \max\left( Sn^+_{(1)}, 0 \right) - Sn_{(2)}^{\tau+1/2}, 0 \right),
\end{aligned}
\tag{8-53}
$$
$$
M_{d(1)}^{-}
 = \rho_{d(1)} \max\left( -Sn^+_{(1)}, 0 \right),  \tag{8-54}
$$
$$
Sn^+_{(1)}
 = Sn_{(1)}^{\tau+1} - Sn_{(1)}^{\tau+1/2}. \tag{8-55}
$$

The change in the amount of DBC in the 3rd layer is determined similarly, and thus in the 2nd layer it is calculated as follows:
$$
M_{d(2)}^{\tau+1} - M_{d(2)}^{\tau}
 = M_{d(1)}^{-} - M_{d(1)}^{+} + M_{d(3)}^{-} - M_{d(3)}^{+}. \tag{8-56}
$$

Finally, the density of DBC on the $k$th snow layer $\rho_{d(k)}$ is updated by
$$
\rho_{d(k)} = M_{d(k)} / \Delta Sn_{(k)} \times 10^6. \tag{8-57}
$$


## Albedo of snow and ice

### Albedo of snow

The albedo of the snow is calculated in SUBROUTINE SNWALB in matsnw.F.

The albedo of the snow is large in fresh snow, but becomes smaller with the passage of time due to compaction and changes in properties as well as soilage. In order to take these effects into consideration, the albedo of the snow is treated as a prognostic variable.


The nondimensional age of snow at the time step of ${\tau}$, $A_g^{\tau}$, is formulated in

$$
A_g^{\tau} = \frac{f_{alb}}{1-f_{alb}}, \tag{8-58}
$$

where

$$
f_{alb} = \min\left(
 \frac{\alpha_{vis}^{\tau}-\alpha_{vis,new}}{\alpha_{vis,old}-\alpha_{vis,new}}, 0.999
\right). \tag{8-59}
$$

$\alpha_b^{\tau}$ is the albedo of the snow for band $b$ at the time step of $\tau$. Three bands of wavelength, visible (vis), near infrared (nir) and infrared (ifr) are considered in MATSIRO, and here the factors for visible band are used. $\alpha_{b,new}$ is the albedo of newly fallen snow for band $b$ and $\alpha_{b,old}$ is that of old snow. In default, $\alpha_{vis,new}$, $\alpha_{nir,new}$, $\alpha_{ifr,new}$, $\alpha_{vis,old}$, $\alpha_{nir,old}$ and $\alpha_{ifr,old}$ are set to 0.9, 0.7, 0.01, 0.65 (or 0.4 if the options OPT_SNWALB is active), 0.2 and 0.1, respectively.


The age of snow at the next time step ${\tau+1}$ is, after @Yang1997-va, assumed to be given by the following equation:
$$
A_g^{\tau+1} = A_g^{\tau} + (f_{age} + f_{age}^{10} + r_{dirt})\Delta t_L / \tau_{age}, \tag{8-60}
$$
where
$$
\begin{aligned}
f_{age} &= \exp{\left[ f_{ageT} \left( \frac{1}{T_{melt}} - \frac{1}{T_{Sn(1)}} \right) \right]}, \\
f_{ageT} &= 5000, \;\; \tau_{age} = 1 \times 10^6 \;\mathrm{s}, \;\; T_{melt} = 273.15 \;\mathrm{K}.
\end{aligned} \tag{8-61}
$$
$T_{Sn(1)}$ is the temperature of the first layer of snow.

$r_{dirt}$ represents the effect of DBC. When the option OPT_SNWALB is inactive,
$$
r_{dirt} = \left\{ \begin{aligned}
 r_{dirt,c} \;\;& \mathrm{(over \; continental \; ice)} \\
 r_{dirt,0} \;\;& \mathrm{(elsewhere)}
\end{aligned} \right., \tag{8-62}
$$
where $r_{dirt,c} = 0.01$ and $r_{dirt,0} = 0.3$. When this option is active, the density of DBC is considered as
$$
r_{dirt} = \left\{ \begin{aligned}
 \min(r_{dirt,c} + r_{dirt,s}\rho_{d(1)}, 1000) \;\;& \mathrm{(over \; continental \; ice)} \\
 \min(r_{dirt,0} + r_{dirt,s}\rho_{d(1)}, 1000) \;\;& \mathrm{(elsewhere)}
\end{aligned} \right., \tag{8-63}
$$
where $r_{dirt,s}$ is the DBC factor for slope with a constant value of 0.1 and $\rho_{d(1)}$ is the density of weighted DBC on the 1st snow layer.

Using this, the albedo of the snow at the time step of $\tau+1$, $\alpha_b^{\tau+1}$, is solved by
$$
\alpha_b^{\tau+1} = \alpha_{b,new}^{\tau+1} + \frac{A_g^{\tau+1}}{1+A_g^{\tau+1}} (\alpha_{b,old}-\alpha_{b,new}), \tag{8-64}
$$

When snowfall has occurred, the albedo is updated to the value of the fresh snow in accordance with the snowfall:
$$
\alpha_b^{\tau+1} = \alpha_b^{\tau+1} + \min\left( \frac{P_{Sn}^{\ast} \Delta t_L}{\Delta Sn_c}, 1 \right) (\alpha_{b,new} - \alpha_b^{\tau+1}). \tag{8-65}
$$
$\Delta Sn_c$ is the snow water equivalent necessary for the albedo to fully return to the value of the fresh snow.


### Albedo of ice

The albedo of the ice sheet, $\alpha_{b,surf}$, is calculated in ENTRY ICEALB in matice.F.

This is expressed in a following function of the water content above the ice according to @Bougamont2005-pd:
$$
\alpha_{b,surf} = \alpha_{b,wet} - (\alpha_{b,wet}-\alpha_{b,ice}) \exp{\left( -\frac{w_{surf}}{w^{\ast}} \right)}, \tag{8-66}
$$
where $\alpha_{b,ice}$ is the land ice albedo without surface water, $\alpha_{b,wet}$ is the one with surface water, $w_{surf}$ is the thisness of surfice water and $w^{\ast}$ is the characteristic scale for surficial water. $b$ represents the three bands of wavelength, visible (vis), nearinfrared (nir) and infrared (ifr), similar to ice albedo. In default, $\alpha_{vis,ice}$, $\alpha_{nir,ice}$ and $\alpha_{ifr,ice}$ are set to 0.5, 0.3 and 0.05, respectively, and $\alpha_{b,wet}$ is set to 0.15 for all bands.


where $\alpha_{b,ice}$ is the land ice albedo without surface water, $\alpha_{b,wet}$ is the one with surface water, $w_{surf}$ is the thisness of surfice water and $w^{\ast}$ is the characteristic scale for surficial water. $b$ represents the three bands of wavelength, visible (vis), nearinfrared (nir) and infrared (ifr), similar to ice albedo. In default, $\alpha_{vis,ice}$, $\alpha_{nir,ice}$ and $\alpha_{ifr,ice}$ are set to 0.5, 0.3 and 0.05, respectively, and $\alpha_{b,wet}$ is set to 0.15 for all bands.

# Runoff

The surface runoff and groundwater runoff are solved using a simplified TOPMODEL [@Beven1979-ia]. The calculation of runoff are solved in SUBROUTINE: MATROF in matrof.F, and the related variables and parameters are introduced as follows:

- Output variables

| Variable   | Description                                             | Code   | Units      |
| ---------- | ------------------------------------------------------- | ------ | ---------- |
| $Ro$       | Total runoffs                                           | RUNOFF | $kg/m^2/s$ |
| $Ro_{(k)}$ | Runoff flux from the $k$ th soil layer                  | RUNOFL | $kg/m^2/s$ |
| $P_r$      | Water flux given to the soil through the runoff process | WINPT  | $kg/m^2/s$ |

- Input variables

| Variable        | Description            | Code   | Units        |
| --------------- | ---------------------- | ------ | ------------ |
| $Pr_c$          | Convective rainfall    | WINPC  | $kg/m^2/s$   |
| $Pr_l$          | Nonconvective rainfall | WINPL  | $kg/m^2/s$   |
| $M_{sn}$        | Snow melt              | SNMLT  | $(kg/m^2/s)$ |
| $T_{g(k)}$      | Soil temperature       | GLG    | $K$          |
| $w_{(k)}$       | Soil moisture          | GLW    | $m^3/m^3$    |
| $\theta_{i(k)}$ | Soil ice               | GLFRS  | $m^3/m^3$    |
| ($Ro_{gl}$)     | Glacier formation      | GLACR  | $(kg/m^2/s)$ |
| $\Delta t$      | Time step              | DELT   | $s$          |
| $X_s$           | Surface condition      | ILSFC  | -            |
| -               | Soil type              | ILSOIL | -            |

- Internal work variables

| Variable     | Description                                             | Code   | Units      |
| ------------ | ------------------------------------------------------- | ------ | ---------- |
| $Ro_s$       | Saturation excess runoff                                | RUNOFS | $kg/m^2/s$ |
| $Ro_i$       | Infiltration excess runoff                              | RUNOFI | $kg/m^2/s$ |
| $Ro_o$       | Surface storage overflow                                | RUNOFO | $kg/m^2/s$ |
| $Ro_b$       | Base runoff                                             | RUNOFB | $kg/m^2/s$ |
| $R_s$        | Surface runoff (CMIP5)                                  | SRUNOF | $kg/m^2/s$ |
| $w_{sat(k)}$ | Saturated soil moisture                                 | GWS    | $m^3/m^3$  |
| $K_{s(k)}$   | Saturated hydrological conductivity from each layer     | -      | $m/s$      |
| $K_0$        | Saturation hydraulic conductivity at the ground surface | DFWS   | $m/s$      |
| $K_{s0}$     | Saturation hydraulic conductivity at the depth of 2m    | DFWST  | $m/s$      |
| $\psi_{(k)}$ | Matric potential                                        | GPSI   | $m$        |
| -            | d(PSI)/d(W)                                             | DPDW   |            |
| $z(x)$       | Water table depth                                       | WTABD  | $m$        |
| $A_{sat}$    | Surface saturation fraction                             | ASSAT  | -          |
| $z_f$        | Frost table level                                       | KFTAB  | $m$        |
| -            | Water table level                                       | KWTAB  | $m$        |
| -            | Flag for saturation                                     | ISAT   | -          |

- Internal parameters

 <!--beginlandscape-->
| PARAMETER    | Description                                       | Code   | Initial values | Units |
| ------------ | ------------------------------------------------- | ------ | -------------- | ----- |
| $tan\beta_s$ | Tangent of mean surface slope                     | GRTANS | -              | -     |
| $L_s$        | Mean length of surface slope                      | GRLENS | -              | $m$   |
| $\alpha$     | Inflow rate into surface tank                     | FRACSR | -              | -     |
| $\tau$       | Outflow rate from surface tank                    | TAUSS  | -              | -     |
| $\frac1f$    | Critical water table depth                        | WTCRIT | 0.333          | -     |
| $S$          | Surface water storage                             | SFCSTR | 0.001          | -     |
| -            | Maximum water table depth                         | WTBMAX | -              | $m$   |
| -            | Epsilon for soil moisture                         | EPSGW  | 0.001          | -     |
| $A_{cum}$    | Convective storm area for runoff                  | FRACCR | 0.1            | $m^2$ |
| $E_p$        | Effect of macropore on base-runoff                | EFFMP  | 1              | -     |
| $z^"$        | Ground depth for groundwater runoff calculatation | -      | 2              | m     |
 <!--endlandscape-->

## Outline of TOPMODEL

In TOPMODEL, the horizontal distribution of a water table along the slope in a catchment basin is considered. The downward groundwater flow at a certain point on the slope is assumed to be equal to the accumulated groundwater recharge in the upper part of the slope above that point (quasi-equilibrium assumption). Then, the groundwater flow must be greater in the lower part of the slope. Under another assumption described later, for the groundwater flow to be greater, the water table needs to be shallow. Thus, the distribution is derived such that the lower the slope, the shallower the water table. When the mean water table is shallower than a certain level, the water table rises to the ground surface at an area lower than a certain point in the slope to form a saturated area. In this way, TOPMODEL is characterized by the mean water table, the size of the saturated area, and the groundwater flow velocity, which are important concepts for estimating the runoff, being physically connected in a coherent manner.

TOPMODEL contains the following major assumptions:

1.  The soil saturation hydraulic conductivity attenuates exponentially as the soil depth increase;
2.  The gradient of the water table is considered to be locally the same as that of the slope;
3.  The downward groundwater flow at a certain point on the slope is equal to the accumulated groundwater recharge in the upper slope above that point.

The usage of the symbols below is in accordance with the usual practice in descriptions of TOPMODEL [@Sivapalan1987-dq;@Stieglitz1997-sk].

The first assumption can be expressed as

$$
K_s(z) = K_0 \exp (-f z)
\tag{eq261}
$$

where $K_s(z)$ is the soil saturation hydraulic conductivity at depth $z$, $K_0$ is the saturation hydraulic conductivity at the ground surface which differs among different soil types, and $f$ is the attenuation coefficient.

When the depth of the water table at a certain point $i$  is designated as $z_i$, the downward groundwater flux on the slope at that point $q_i$ is
$$
q_i = \int_{z_i}^Z K_s(z) dz \cdot \tan\beta
   = \frac{K_0}{f}  \tan\beta [\exp(-f z_i) - \exp(-f Z)] \tag{eq262}
$$

where $\beta$ is the gradient of the slope because of the second assumption. $Z$ is the depth of the impervious surface. Normally, however, the term $\exp(-f Z)$ can be ignored because $Z$ is assumed to be sufficiently large compared with $\frac1f$. Moreover, the slope direction soil moisture flux in the unsaturated zone above the water table is small and thus also ignored.

If the groundwater recharge rate $R$ is assumed to be horizontally uniform, with the third assumption, the above equation is expressed as:

$$
a R = \frac{K_0}{f} \tan\beta \exp(-f z_i)
\tag{eq263}
$$

where $a$ is the total upstream area (per unit contour line length at point $i$ with respect to point $i$.

When this is solved for $z_i$, the following is obtained:
$$
z_i = -\frac{1}{f} \ln \left( \frac{faR}{K_0 \tan \beta}\right)  \tag{eq264}
$$

The averaged water table depth $\overline{z}$ in domain $A$ is described below, while the grid averaged water table depth will be mentioned in section 9.3.1:


$$
\overline{z} = \frac1{A}\int_{A} z_i dA
  = - \Lambda - \frac1{f} \ln R  \tag{eq265}
$$


$$
\Lambda \equiv
  \frac1{A}\int_{A} \ln \left( \frac{fa}{K_0 \tan \beta}\right) dA  \tag{eq266}
$$


Therefore, the recharge rate $R$ can then be expressed as a function of the mean water table depth $\overline{z}$ as follows:


$$
R = \exp (-f \overline{z} -\Lambda)  \tag{eq267}
$$

Under the third assumption, this is all of the groundwater runoff discharged from domain $A$.

Next, if $R$ is substituted into [Eq. (264)](#eq264) , the following relationship of $z_i$ and $\overline{z}$ is obtained:

$$
 z_i = \overline{z} - \frac{1}{f} \left[
\ln \left( \frac{fa}{K_0 \tan \beta}\right) - \Lambda
\right]  \tag{eq268}
$$

The domain that satisfies $z_i \leq 0$ is the surface saturated area.

## Application of TOPMODEL assuming simplified topography

Normally, when TOPMODEL is used, detailed topographical data on the target area is required. Here, however, the average shape of the slope in a grid cell is roughly estimated from the average inclination and the standard deviation of the altitude in the grid (this estimation method is temporary at this stage, and further study is required).

The topography in the grid cell is represented by the slope with uniform gradient $\beta_s$ and the distance from the ridge to valley $L_s$.

$L_s$ is estimated using the standard deviation of altitude ($\sigma_z$) as follows:


$$
L_s = \frac{2\sqrt{3} \sigma_z}{\tan\beta_s}
\tag{eq269}
$$


where $2\sqrt{3}\sigma_z$ is the altitude difference between the ridge and valley in serrate topography such that the standard deviation of altitude is $\sigma_z$.

The x-axis is taken from the ridge toward the valley on the horizontal surface. Then, the total upstream area at point $x$ is $x$, and [Eq. (264)](#eq264) becomes

$$
z(x) = - \frac{1}{f} \ln \left( \frac{fxR}{K_0 \tan \beta_s}\right)
\tag{eq270}
$$

Using this, from [Eq. (265)](#eq265) the grid average water table depth is

$$
\overline{z} = \frac 1{L_s}\int_0^{L_s} z(x) dx
 = - \frac1{f}\left[
 \ln \left( \frac{f L_s R}{K_0 \tan\beta_s}\right) -1
\right]
\tag{eq271}
$$


from [Eq. (267)](#eq267) the groundwater recharge rate is

$$
R = \frac{K_0 \tan\beta_s}{f L_s}\exp(1-f \overline{z}) \tag{eq272}
$$

and from [Eq. (268)](#eq268), the relationship between the water table depth at point $x$ and the grid average water table depth is

$$
z(x) = \overline{z} - \frac{1}{f}\left(
\ln \frac{x}{L_s} + 1
\right)
\tag{eq273}
$$


If $z(x) \leq 0$ is solved for $x$, the following are obtained:

$$
x \geq x_0
\tag{eq274}
$$


$$
x_0 = L_s \exp(f\overline{z}-1)
\tag{eq275}
$$


Therefore, the fraction of the saturated area is solved as


$$
A_{sat} = \frac{L_s - x_0}{L_s} = 1 - \exp(f\overline{z}-1) \tag{eq276}
$$


However, when $A_{sat} \geq 0$ and $\overline{z} > \frac1f$, no saturated area exists.

## Calculation of runoff

Four types of runoff mechanisms are considered, and the total of the runoffs $Ro$ by each mechanism is assumed to be the total runoff from the grid cell:

$$
Ro = Ro_s + Ro_i + Ro_o + Ro_b
\tag{eq277}
$$

where $Ro_s$ is the saturation excess runoff (Dunne runoff), $Ro_i$ is the infiltration excess runoff (Horton runoff), $Ro_o$ is the overflow of the uppermost soil layer, and $Ro_b$ is the groundwater runoff. The first three types are classified as the surface runoff.

The surface runoff $R_s$ calculated by MATSIRO will be:
$$
Rs=Ro-Ro_b=Ro_s + Ro_i + Ro_o
 \tag{eq289}
$$
However, when taking snow-fed wetland into account [@Nitta2017-hz], part of the surface runoff $R_s$ will be stored in the surface storage and part of runoff to rivers will be delayed, which leads to an increase in land surface wetness and hence evaporation in water-limited regimes. Then surface runoff $R_s$ will become:
$$
Rs=(Ro_s + Ro_i + Ro_o)\alpha
 \tag{eq290}
$$

here $\alpha$ determines the inflow rate into surface tank and is specified in Wetland section. Please refer to Eq.12.3 for more details.

### Estimation of grid average water table depth

The grid average water table is considered to exist in the lowest unsaturated layer, which is expressed as $k_{WT}$. The grid average water table depth ($\overline{z}$) is estimated by:
$$
\overline{z} = z_{g(k_{WT}-\frac1 2)} - \psi_{k_{WT}}
\tag{eq279}
$$

where $\psi_{k_{WT}}$ is the matric potential in the $k_{WT}$th soil layer.

The above equation is equivalent to considering the moisture potential on the upper boundary of the unsaturated layer as $\psi_{k_{WT}}$, which denotes that soil moisture distribution reaches equilibrium state (i.e., the state in which gravity and the capillary force are in equilibrium).

Under unsaturated condition that $-\psi_{k_{WT}}$ exceeds soil layer thickness, water table will generate at the lower boundary of soil layer.

When $\overline{z} > z_{g(k_{WT}+\frac{1}2)}$, i.e., average water table depth is deeper than the lower boundary of $k_{WT}$th layer, in case $k_{WT}$ is the lowest soil layer, the water table is assumed to not exist; when $k_{WT}$ is not the lowest soil layer, the layer below (the uppermost layer among the saturated layers) is assumed to be $k_{WT}$ and water table will generate at $z_{g(k_{WT}+\frac{1}2)}$.

When there is a frozen soil surface in the middle of the soil, estimation of the water table depth is performed from above the frozen soil surface.

### Calculation of groundwater runoff

Because of the quasi-equilibrium assumption, the groundwater runoff is equal to the groundwater recharge rate in [Eq. (272)](#eq272). In MATSIRO6, @Hirabayashi2004-mw changed $K_0$ to $K_{s0}$ in groundwater runoff calculation, which denotes a saturation hydraulic conductivity at depth of 2m:
$$
K_{s0}=\exp (z^"f)K_0 E_p
$$
where $z^"$ is the depth of 2m, $E_p$ denotes the effect of macropore on groundwater runoff. It is also worth noting that the value of $\frac1f$ has changed from 0.6 to 0.33 in MATSIRO6. Therefore, calculation of groundwater runoff will become:
$$
Ro_b = \frac{K_{s0} \tan\beta_s}{f L_s}\exp(1-f \overline{z})
\tag{eq280}
$$

However, when a frozen soil surface exists under the water table, referring to the case with the term $\exp(-fZ)$ in [Eq. (262)](#eq262), it is assumed that

$$
Ro_b = \frac{K_{s0} \tan\beta_s}{f L_s}
  [ \exp(1-f \overline{z}) - \exp(1-f z_f) ]
  \tag{eq281}
$$

where $z_f$ is the depth of frozen soil surface. Although other relations in TOPMODEL should also be changed in such a case, they are not changed here for the sake of simplification.

When there is an unfrozen layer under the frozen soil surface and a water table exists, the groundwater runoff from there is added by a similar calculation.

The water content from the groundwater runoff is removed from the $k_{WT}$th soil layer:

$$
Ro_{(k_{WT})} = Ro_b
\tag{eq282}
$$

where $Ro_{(k)}$ denotes the runoff flux from the $k_{WT}$th soil layer.

### Calculation of surface runoff

All of the rainfall that falls on the surface saturated area runs off as is (saturation excess runoff):

$$
Ro_s = (Pr_c^{\ast\ast} + Pr_l^{\ast\ast}) A_{sat}
\tag{eq283}
$$

The fraction of the surface saturated area $A_{sat}$ is given by [Eq. (276)](#eq276). Here, the correlation between the rainfall distribution of the subgrid and topography is ignored.

With regard to rainfall that falls on the surface unsaturated area, only the portion that exceeds the soil infiltration capacity runs off (infiltration excess runoff). The soil infiltration capacity is given by the saturation hydraulic conductivity of the uppermost soil layer for simplification. The convective precipitation is considered to fall locally, and the fraction of the precipitation area ($A_c$) is assumed to be uniform (0.1 as a standard value). The stratiform precipitation is also assumed to be uniform.

$$
Ro_i^c = \max( \frac{Pr_c^{**}}{A_c} + Pr_l^{**} - K_{s(1)}, 0 ) (1 - A_{sat})
 \tag{eq284}
$$

$$
Ro_i^{nc} = \max( Pr_l^{\ast\ast} - K_{s(1)}, 0 ) (1 - A_{sat})
 \tag{eq285}
$$

$$
Ro_i = A_c Ro_i^c + ( 1 - A_c ) Ro_i^{nc}
 \tag{eq286}
$$

where $Ro_i^c$ and $Ro_i^{nc}$ are $Ro_i$ in the convective precipitation area and nonconvective precipitation area, respectively; and $K_{s(1)}$ is the saturation hydraulic conductivity in the uppermost soil layer.

The overflow of the uppermost soil layer, allowing a small amount of ponding  $w_{str}$ (1 mm as a standard value), is assumed to be

$$
Ro_o = \frac{\max(w_{(1)} - w_{sat(1)} - w_{str}, 0) \rho_w \Delta z_{g(1)}}{\Delta t_L}
 \tag{eq287}
$$

This portion is subtracted from the uppermost soil layer later, and therefore should be remembered as the runoff from the uppermost layer, as follows.

$$
Ro_{(1)} = Ro_{(1)} + Ro_o
 \tag{eq288}
$$

## Water flux given to soil

The water flux given to the soil through the runoff process is

$$
P_r^{\ast\ast\ast} = Pr^{\ast\ast}_c + Pr^{\ast\ast}_l - Ro_s - Ro_i
 \tag{eq293}
$$

If the wetland scheme is active for the grid, the outflow of the wetland should also be added in this equation (see Eq. 12.4).

# Soil

The soil temperature, the soil moisture, and the frozen soil are calculated next.

## Calculation of soil heat conduction

### Soil heat conduction equations

The prognostic equation for the soil temperature by soil heat conduction is
$$
C_{g(k)} \frac{T_{g(k)}^\ast - T_{g(k)}^{\tau}}{\Delta t_L} = F_{g(k+1/2)} - F_{g(k-1/2)}
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
F_{g(1/2)} - \Delta F_{conv}^\ast - \Delta F_{c,conv}^\ast
 & (k=0)\\
\displaystyle{
k_{g(k+1/2)} \frac{T_{g(k+1)} - T_{g(k)}}{\Delta z_{g(k+1/2)}}
}
 & (k=1,\ldots,K_{g}-1) \\
\displaystyle{
0
}
 & (k=K_{g})
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

### Solution of heat conduction equations

These equations are solved using the implicit method with regard to the soil temperature from the uppermost layer to the lowest layer. That is, for $k=1,\ldots,K_g-1$, the heat conduction flux is expressed as
$$
  F_{g(k+1/2)}^{\ast} = F_{g(k+1/2)}^{\tau}
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
&=& F_{g(k+1/2)}^\ast - {F}_{g(k-1/2)}^\ast  \nonumber\\
&=& {F}_{g(k+1/2)}^{\tau}
+\frac{\partial F_{g(k+1/2)}}{\partial T_{g(k)}}
 \Delta T_{g(k)}
+\frac{\partial F_{g(k+1/2)}}{\partial T_{g(k+1)}}
 \Delta T_{g(k+1)}  \nonumber\\
&-& F_{g(k-1/2)}^{\tau}
-\frac{\partial F_{g(k-1/2)}}{\partial T_{g(k-1)}}
 \Delta T_{g(k-1)}
-\frac{\partial F_{g(k-1/2)}}{\partial T_{g(k-1)}}
 \Delta T_{g(k)}
$$
and solved by the LU factorization method as $K_{g}$  simultaneous equations with respect to $\Delta T_{g(k)}\ (k=1,\ldots,K_{g})$. At this juncture, it should be noted that the equations are solved with the fluxes at the soil upper boundary and lower boundary fixed as the boundary conditions:
$$
 T_{g(k)}^\ast = T_{g(k)}^{\tau} + \Delta T_{g(k)}
$$

The soil temperature is partially updated by the above equation. By this, as well as through correction of the phase change in the soil moisture mentioned later, the soil temperature is completely updated.

## Calculation of soil moisture movement

### Soil moisture movement equations

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
 & (k=0)\\
\displaystyle{
K_{(k+1/2)} \left(\frac{\psi_{(k+1)} - \psi_{(k)}}{\Delta z_{g(k+1/2)}} - 1 \right)
}
 & (k=1,\ldots,K_{g}-1) \\
\displaystyle{
0
}
 & (k=K_{g})
\end{array}
\right. \tag{eq300}
$$
in which $K_{(k+1/2)}$ is the soil hydraulic conductivity that, referring to @Clapp1978-vf, is expressed as
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

### Solution of soil moisture movement equations

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
&=& F_{w(k+1/2)}^{\tau+1} - {F}_{w(k-1/2)}^{\tau+1} + S_{w(k)} \Delta z_{g(k)} \nonumber\\
&=& {F}_{w(k+1/2)}^{\tau}
+\frac{\partial F_{w(k+1/2)}}{\partial w_{(k)}}
 \Delta w_{(k)}
+\frac{\partial F_{w(k+1/2)}}{\partial w_{(k+1)}}
 \Delta w_{(k+1)}  \\
&-& F_{w(k-1/2)}^{\tau}
-\frac{\partial F_{w(k-1/2)}}{\partial w_{(k-1)}}
 \Delta w_{(k-1)}
-\frac{\partial F_{w(k-1/2)}}{\partial w_{(k-1)}}
 \Delta w_{(k)} + S_{w(k)} \Delta z_{g(k)}  \nonumber
$$


and solved by the LU factorization method as $K_g$ simultaneous equations with respect to $\Delta T_{g(k)}\ (k=1,\ldots,K_{g})$. At this juncture, it should be noted that the equations are solved with the fluxes at the soil upper boundary and lower boundary fixed as the boundary conditions.

The soil moisture is updated by

$$
 w_{(k)}^{\tau+1} = w_{(k)}^{\tau} + \Delta w_{(k)}
$$

As a result of this calculation, if a part appears where the soil moisture become supersaturated, it is adjusted in the vertical direction to eliminate supersaturation. The reason why such a supersaturated portion is not considered as runoff is that this supersaturation is artificially produced because the vertical movement of the soil moisture is solved without saturation data. First, from the second soil layer downwards, the supersaturated portion of the soil moisture is given to the layer below. Next, from the lowest soil layer upwards, the supersaturated portion of the soil moisture is given to the next layer up. With this operation, when the soil moisture is large enough, a saturated layer around the lowest soil layer is formed and the water table of Eq. (278) can be defined.

## Phase change of soil moisture

As a result of calculating the soil heat conductivity, when the temperature in the layer containing liquid water is lower than $T_{melt}=0 ^{\circ}$C, or when the temperature in the layer containing solid water is higher than $T_{melt}$, the phase change of the soil moisture is calculated. If the amount of freeze (adjustment portion) of the soil moisture in the $k$th layer is assumed to be $\Delta w_{i(k)}$,

when $T_{g(k)}^\ast<T_{melt}$ and $w_{(k)}^{\tau+1}-w_{i(k)}^{\tau}>0$ (frozen):

$$
\Delta w_{i(k)} = \min\left(
\frac{C_{g(k)}(T_{melt}-T_{g(k)}^\ast)}{l_m \rho_w \Delta z_{g(k)}}, \
w_{(k)}^{\tau+1}-w_{i(k)}^{\tau}
\right)
$$

when $T_{g(k)}^\ast>T_{melt}$ and $w_{i(k)}^{\tau}>0$ (melting):


$$
\Delta w_{i(k)} = \max\left(
\frac{C_{g(k)}(T_{melt}-T_{g(k)}^\ast)}{l_m \rho_w \Delta z_{g(k)}}, \
-w_{i(k)}^{\tau}
\right)
$$

The frozen soil moisture and the soil moisture are then updated as follows:


$$
w_{i(k)}^{\tau+1} &=& w_{i(k)}^{\tau} + \Delta w_{i(k)} \\
T_{g(k)}^{\tau+1} &=& T_{g(k)}^\ast + l_m \rho_w \Delta z_{g(k)} \Delta w_{i(k)} / C_{g(k)}
$$


### Ice sheet process

When the land cover type is ice sheet, if the soil temperature exceeds $T_{melt}$, it is returned to $T_{melt}$:


$$
 T_{g(k)}^{\tau+1} = \min( T_{g(k)}^\ast, \ T_{melt} )
$$


The rate of change of the ice sheet *F<sub>ice</sub>* is then diagnosed as

$$
 F_{ice} = - Et_{(2,1)} - \frac{C_{g(k)}\max(T_{g(k)}^\ast - T_{melt},\ 0)}{l_m \Delta t_L}
$$

# Lake
Lake is treated in MATSIRO (lakesf.F, lakeic.F, and lakepo.F), as well as land.

The method for surface flux calculation (section 11.1 and 11.2) is derived from the sea surface scheme of MIROC-AGCM, while the calculation for the processes below the lake ice (section 11.3 and 11.4) is derived from the ocean model COCO (COCO-OGCM). lakeic.F and lakepo.F were based on the COCO-OGCM, and the ENTRY statement are used so as to keep the structure of the original programs. For practical use, note, for example, that the unit of temperature is $\mathrm{K}$ until flux calculation (section 11.1 and 11.2), while it is $\mathrm{^{\circ}C}$ after the ice and inter lake (section 11.3 and [11.4]()). It is also noted that because the second half part of this section is based on the old version of COCO, hence it is slightly different from the MIROC6-AOGCM[@Tatebe2019-ow] and @Hasumi2015-fs.

Dimensions of the lake scheme is defined in include/zkg21c.F. `KLMAX` is the number of vertical layers set to 5 in MIROC6/MATSIRO6. `NLTDIM` is the number of tracers, 1:temperature 2:salt. Since the vertical layers are actually from the first number of vertical layer (`KLSTR=2`) to the last number of vertical layer (`KLEND=KLMAX+1`). `NLZDIM = KLMAX+KLSTR` is also defined for the management.

Lakes have been calculated as one of the tiles in a grid, as described in section 13.1.　As a standard value, minimum depth of lake of $10 \times 10^2 \mathrm{[cm]}$ is given in matdrv.F, hence any lakes cannot disappear even in severe dry conditions.

## Calculation of lake surface conditions

In ENTRY LAKEBC (in SUBROUTINE LSFBCS of lakesf.F) lake surface albedo, roughness, and heat flux are calculated. They are calculated supposing ice-free conditions, then modified to take into account the effects of ice and snow cover. While the albedo of land snow is a prognostic variable, the lake surface albedo considering with ice and snow above is a diagnostic variable. The aging effect of the snow is simply depending on its temperature. These methods are actually same with an old version of COCO-OGCM[@Hasumi2015-fs]. The newest version of COCO, which is going to be coupled to MIROC7-AOGCM, has been applied a melt pond scheme a snow aging scheme which is basically the same with the treatment in the current land surface (Komuro, the GCM meeting on 22nd Feb, 2021).

- Output variables of LAKEBC

| Variable                        | Variable in source code | Longname                   | Unit                 |
|:------------------------------- |:----------------------- |:-------------------------- |:-------------------- |
| $\alpha_{Lk}$                   | GRALB                   | Lake surface albedo        | $\mathrm{[-]}$       |
| $z_{Lk0}$                       | GRZ0                    | Lake surface roughness     | $\mathrm{[m]}$       |
| $G$                             | FOGFLX                  | Heat flux                  | $\mathrm{[W/m^2]}$   |
| $\frac{\partial G}{\partial T}$ | DFGT                    | Heat diffusion coefficient | $\mathrm{[W/m^2/K]}$ |

- Input variables of LAKEBC

| Variable            | Variable in source codes | Longname                               | Unit                |
|:------------------- |:------------------------ |:-------------------------------------- |:------------------- |
| $T_s$               | GRTS                     | Surface temperature                    | $\mathrm{[K]}$      |
| $T_b$               | GRTB                     | Ice base temperature                   | $\mathrm{[K]}$      |
| $Ic$                | GRICE                    | lake ice amount                        | $\mathrm{[kg/m^2]}$ |
| $SnLk$              | GRSNW                    | snow amount                            | $\mathrm{[kg/m^2]}$ |
| $R_{IcLk}$          | GRICR                    | lake ice concentration                 | $\mathrm{[-]}$      |
| $u_a$               | GDUA                     | Atmospheric 1st layer east-west wind   | $\mathrm{[m/s]}$    |
| $v_a$               | GDVA                     | Atmospheric 1st layer north-south wind | $\mathrm{[m/s]}$    |
| $\mathrm{cos}\zeta$ | RCOSZ                    | cos(solar zenith)                      | $\mathrm{[-]}$      |

First, the lake albedo $\alpha_{Lk(d,b)}$ is calculated. $b=1,2,3$ represent the visible, near-infrared, and infrared wavelength bands, respectively. Also, $d=1,2$ represents direct and scattered light, respectively. The albedo for the visible bands are calculated in SUBROUTINE LAKEALB, supposing ice-free conditions. The albedo for near-infrared is set to same as that for the visible bands. The albedo for infrared is uniformly set to a constant value, as mentioned in section 11.1.1.

When lake ice is present, the albedo is modified to take into account the ice cover on lake that can change the albedo.

$$
	{\alpha_{Lk}'} = \alpha_{Lk} + (\alpha_{IcLk}-\alpha_{Lk}) R_{IcLk}
$$

where $\alpha_{IcLk}$ is the lake ice albedo, and $R_{IcLk}$ is the lake ice concentation, respectively. In addition, snow cover on a lake ice that can change the albedo is also considered. Assuming that the snow albedo depends on the surface temperature, we can calculate a function $F$ below.

$$
	F(T_s) = \frac{T_s-T_m^{min}}{T_m^{max}-T_m^{min}} \quad,\quad (0 \le F(T_s)\le 1)
$$

where $T_s$ is the surface temperature, and $T_m^{min}$ and $T_m^{max}$ are the minimum and the minimum temperature for the albedo change, respectively.

Then, the albedo can be modified by

$$
	{\alpha_{Lk}''} = \alpha_{Lk(1,b)} + (\alpha_{SnLk(2,b)}-\alpha_{SnLk(1,b)})F(T_s)
$$

$$
	\alpha_{Lk} = {\alpha_{Lk}'} +(\alpha_{Lk}''-\alpha_{Lk}')R_{SnLk}
$$

where the $\alpha_{SnLk(d,b)}$ is the snow albedo covering the lake, and $R_{SnLk}$ is the snow coverage, respectively.

Second, the lake surface roughness for momentum, heat and vapor are calculated in SUBROUTINE LAKEZ0F, based on @Miller1992-gi, same with COCO-OGCM [@Hasumi2015-fs], supposing the ice-free conditions, then modified to take into account the effects of ice and snow cover.

When lake ice is present, each roughness is modified to take into account the lake ice concentration ($R_{IcLk}$)

$$
	{z_{Lk0}'} = z_{Lk0} + (z_{Lk0,ice} -z_{Lk0}) R_{IcLk}
$$

where $z_{Lk0}$ is surface roughness, and $z_{Lk0,ice}$ is surface roughness for lake ice, respectively.

Then, taking into account the snow coverage ($R_{SnLk})$, we can express it as

$$
	{z_{Lk0}} = {z_{Lk0}'} + (z_{Lk0,ice} - {z_{Lk0}'}) R_{SnLk}
$$

Third, the heat flux is considered with the temperature differences between the snow surface and the ice bottom, because the difference should be zero in the ice-free conditions.

If the lake ice exists, the heat diffusion coefficient is described as

$$
	\Big(\frac{\partial G}{\partial T}\Big) _{ IcLk }  = \frac{ D_{IcLk}}{R_{IcLk}}
$$

where $D_{IcLk}$ is the coefficient of lake ice.

If the snow exists, the heat diffusion coefficient of snow covered area is

$$
	\Big(\frac{\partial G}{\partial T}\Big)_{SnLk}  =  \frac{D_{IcLk}D_{SnLk}}{D_{IcLk}R_{SnLk}+D_{SnLk}R_{IcLk}}
$$

where $D_{SnLk}$ is the coefficient of snow.

Therefore, the net heat diffusion coefficient is finally
$$
	\frac{\partial G}{\partial T} = \Big(\frac{\partial G}{\partial T} \Big)_{IcLk} (1-R_{SnLk}) + \Big(\frac{\partial G}{\partial T}\Big)_{SnLk} R_{SnLk}
$$

The temperature differences between the snow surface ($T_S$) and the ice bottom ($T_B$) is saved as heat flux($G$).

$$
	G = \frac{\partial G}{\partial T} (T_B-T_S)
$$


### Calculation of lake surface albedo

Processes of SUBROUTINE LAKEALB is the same with SUBROUTINE [SEAALB (in p-sfc.F), which is the sea surface flux scheme of MIROC6-AGCM[@Tatebe2019-ow]. For lake surface level albedo $\alpha_{Lk,L(d)}$, $d=1,2$ represents direct and scattered light, respectively.

Using the solar zenith angle $\zeta$ ($\mathrm{cos}\zeta$), the albedo for direct light is presented by

$$
	\alpha_{Lk,L(1)} = e^{(C_3A^\ast + C_2) A^\ast +C_1}
$$

where $A^\ast = \mathrm{min}(\mathrm{max}(\mathrm{cos}\zeta,0.03459),0.961)$, and $C_1, C_2, C_3$ is $-0.7479, -4.677039, 1.583171$ respectively.

On the other hand, the albedo for scattered light is uniformly set to a constant parameter.

$$
	\alpha_{Lk,L(2)} = 0.06
$$

### Lake surface roughness

Contents of SUBROUTINE LAKEZ0F is the same with SUBROUTINE SEAZ0F (of pgocn.F), which is the sea surface scheme of MIROC6-AGCM[@Tatebe2019-ow].

The roughness variation of the lake surface is determined by the friction velocity $u^\star$.

$$
u^{\star} = \sqrt{C_{M_0} ({u_a}^2  +{v_a}^2)}
$$

We perform successive approximation calculation of ${C_{M_0}}$, because the variables of the  atmosphseric first layer ($u_a,v_a,T_a,q_a$) are required.

$$
	z_{Lk0,M} = z_{0,M_0} + z_{0,M_R} + \frac{z_{0,M_R} {u^\star }^2 }{g} + \frac{z_{0,M_S}\nu }{u^\star}
$$

$$
	z_{Lk0,H} = z_{0,H_0} + z_{0,H_R} + \frac{z_{0,H_R} {u^\star }^2 }{g} + \frac{z_{0,H_S}\nu }{u^\star}
$$

$$
	z_{Lk0,E} = z_{0,E_0} + z_{0,E_R} + \frac{z_{0,E_R} {u^\star }^2 }{g} + \frac{z_{0,E_S}\nu }{u^\star}
$$

where, $\nu = 1.5 \times 10^{-5} \mathrm{[m^2/s]}$ is the kinetic viscosity of the atmosphere, $z_{0,M},z_{0,H}$ and $z_{0,E}$ are surface roughness for momentum, heat and vapor ($0.0, 0.018$, and $0.11$ as standard values), and $z_{0,M_0},z_{0,H_0}$ and $z_{0,E_0}$ are base of them ($1.4\times 10^{-5}, 0.0$, and $0.4$ as standard values), and $z_{0,M_R},z_{0,M_R}$ and $z_{0,E_R}$ ($1.3\times10^{-4}, 0.0$, and $0.62$ as standard values) are rough factor for them, and $z_{0,M_S},z_{0,M_S}$ and $z_{0,E_S}$ are smooth factor for them, respectively.

## Solution of energy balance at lake surface

In SUBROUTINE [LAKEHB] (of lakesf.F), the energy balance at lake surface is solved.

- Output variables of LAKEHB

| Variable       | Variable in source code | Longname           | Unit               |
|:-------------- |:----------------------- |:------------------ |:------------------ |
| $W_{free/ice}$ | WFLUXS                  | Surface water flux | $\mathrm{[W/m^2]}$ |
| $LW^\uparrow$  | RFLXLU                  | Upward long wave   | $\mathrm{[W/m^2]}$ |
| $F$            | SFLXBL                  | Flux balance       | $\mathrm{[W/m^2]}$ |

- Input variables of LAKEHB

| Variable                          | Variable in source code | Longname                       | Unit                 |
|:--------------------------------- |:----------------------- |:------------------------------ |:-------------------- |
| $\frac{\partial H}{\partial T_s}$ | DTFDS                   | Sensible heat flux coefficient | $\mathrm{[W/m^2/K]}$ |
| $\frac{\partial E}{\partial T_s}$ | DQFDS                   | Latent heat flux coefficient   | $\mathrm{[W/m^2/K]}$ |
| $\frac{\partial G}{\partial T_s}$ | DGFDS                   | Surface heat flux coefficient  | $\mathrm{[W/m^2/K]}$ |
| $SW^\downarrow$                   | RFLXSD                  | Downward SW radiation          | $\mathrm{[W/m^2]}$   |
| $SW^\uparrow$                     | RFLXLU                  | Upward SW radiation            | $\mathrm{[W/m^2]}$   |
| $LW^\downarrow$                   | RFLXLD                  | Downward LW radiation          | $\mathrm{[W/m^2]}$   |
| $\alpha_{Lk}$                     | GRALBL                  | Lake surface albedo            | $\mathrm{[-]}$       |
| $R_{IcLk}$                        | GRICR                   | Lake ice concentration         | $\mathrm{[-]}$       |

*The comments for some variables say "soil", but this is because the program was adapted from a land surface scheme, and has no particular meaning.*


Downward radiative fluxes are not directly dependent on the condition of the lake surface, and the atmospheric values are simply used in the lake model. Shortwave emission from the lake surface is negligible, so the upward part of the shortwave radiative flux is accounted for solely by reflection of the incoming downward flux. The upward shortwave radiative flux ($SW^\uparrow$) is represented by

$$
	SW^\uparrow = - \alpha_{Lk,SW} SW^\downarrow
$$

where $SW^\downarrow$ is the downward shortwave radiation flux, and $\alpha_{Lk,SW}$ is lake surface albedo for shortwave radiation in the ice-free area, respectively. On the other hand, the upward longwave radiative flux has both reflection of the incoming flux and emission from the lake surface. The upward shortwave radiative flux is represented by

$$
	LW^\uparrow = - \alpha_{Lk} LW^\downarrow + \epsilon \sigma T_s ^4
$$

where $\alpha_{Lk}$ be the lake surface albedo for longwave radiation, $\epsilon$ be emissivity of the lake surface relative to the black body radiation, $\sigma$ is the Stefan-Boltzmann constant, and $T_s$ is surface temprature, respectively. If lake ice exists, snow or lake ice temperature is considered by fractions. When radiative equilibrium is assumed, emissivity becomes identical to co-albedo:

$$
	\epsilon = 1 - \alpha_{Lk}
$$

The net surface flux is presented by

$$
	F^\ast=H + \Big((1-\alpha_{Lk})\sigma T_s^4 + \alpha_{Lk} LW^\downarrow\Big)  - LW^\downarrow +SW^\uparrow - SW^\downarrow		
$$

The heat flux into the lake surface is presented, with the surface heat flux ($G$) calculated in SUBROUTINE [SFCFLX] (in matdrv.F).

$$
	G^\ast = G - F^\ast
$$

where $G^{\ast}$ is the net incoming flux (the opposite direction with $F^{\ast}$).

The temperature derivative term is

$$
	\frac{\partial G^\ast}{\partial T_s} = \frac{\partial G}{\partial T_s}+\frac{\partial H}{\partial T_s}+\frac{\partial R}{\partial T_s}
$$

When the lake ice exists, the sublimation flux ($l_sE$) is considered

$$
	G_{IcLk} = G^\ast - l_s E
$$

The temperature derivative term is

$$
	\frac{\partial G_{IcLk}}{\partial T_s}=\frac{\partial G^\ast}{\partial T_s} + l_s\frac{\partial E}{\partial T_s}
$$

Finally, we can update the surface temperature with the lake ice concentration with $\Delta T_s=G_{IcLk} ( \frac{\partial G_{IcLk}}{\partial T_s})^{-1}$

$$
	T_s = T_s +R_{IcLk} \Delta T_s
$$

Then, the sensible heat flux ($E_{IcLk}$) and latent heat flux ($E_{IcLk}$) on the lake ice is updated.

$$
	E_{IcLk} = E + \frac{\partial E}{\partial T_s}\Delta T_s
$$

$$
	H_{IcLk} = H + \frac{\partial H}{\partial T_s}\Delta T_s
$$

When the lake ice does not existed, otherwise, the evaporation flux ($l_cE$)is added to the net flux.

$$
	G_{freeLk}=F^\ast + l_cE
$$

Finally each flux is updated.

For the sensible heat flux ($H$), the temperature change on the lake ice is considered.

$$
	H=H+ R_{IcLk}  H_{IcLk}
$$

where $H_{IcLk}$ is the sensible heat flux on the lake ice. Then, the heat used for the temperature change is saved as:

$$
	F = R_{IcLk} H_{IcLk}
$$

For the upward longwave radiative flux ($LW^\uparrow$), the temperature change on the lake ice is considered.

$$
	LW^\uparrow=LW^\uparrow +  4\frac{\sigma}{T_s}R_{IcLk}  \Delta T_s
$$

For the surface heat flux, the lake ice concentration is considered.

$$
	G=(1-R_{IcLk})G_{freeLk} + R_{IcLk}G_{IcLk}
$$

For the latent heat flux, the lake ice  concentration is considered.

$$
	E=(1-R_{IcLk})E + R_{IcLk}E_{IcLk}
$$

Each term above are saved as freshwater flux.

$$
	W_{freeLk} = (1-R_{IcLk}) E
$$

$$
	W_{IcLk} = R_{IcLk} E_{IcLk}
$$

## Calculation of lake ice

In this section, the lake ice calculation is described. There are three prognostic variables in the lake ice model described herein: lake ice concentration $A_I$, which is area fraction of a grid covered by lake ice and takes a value between zero and unity; mean lake ice thickness $h_I$ over ice-covered part of a grid; mean snow depth $h_S$ over lake ice. Horizontal flow of ice is not considered in the lake parts, differently from the COCO-OGCM. $A_I$, $h_I$ and $h_S$ are incrementally modified as the prognostic variables. The variables representing the surface state are represented with the subscript $k=2$, since the top of the vertical layers is actually defined as `KLSTR=2`.

The model also calculates temperature at snow top (lake ice top when there is no snow cover) $T_I$, which is a diagnostic variable. Density of lake ice ($\rho_I$) and snow $(\rho_S)$ are assumed to be constant. Lake ice is assumed to have nonzero salinity, and its value $S_I$ is assumed to be a constant parameter.

### Calculation of heat flux and growth rate

In ENTRY FIHEATL (in SUBROUTINE FIHSTL of lakeic.F), heat flux in lake ice and its growth rate is calculated.


- Output variables of FIHEATL

| Variable | Variable in source code | Longname                               | Unit              |
|:-------- |:----------------------- |:-------------------------------------- |:----------------- |
| $W_{AO}$ | WAO                     | growth rate of the lake ice in ice-free area  | $\mathrm{[cm\ w.e./s]}$ |
| $W_{AS}$ | WAS                     | Snow growth rate due to heat imbalance | $\mathrm{[cm\ w.e./s]}$ |
| $W_{IO}$ | WIO                     | Basal growth rate of lake ice          | $\mathrm{[cm\ w.e./s]}$ |

- Input variables of FIHEATL

 <!--beginlandscape-->
| Variable   | Variable in source code | Longname                                                                                           | Unit                                    |
|:---------- |:----------------------- |:-------------------------------------------------------------------------------------------------- |:--------------------------------------- |
| $A_I$      | A                       | Lake ice concentration                                                                             | $\mathrm{[-]}$                          |
| $Q_{AI}$   | QAI                     | Air-ice heat flux multiplied by the factor of lake ice concentration                               | $\mathrm{[-]}$                          |
| $Q_{IO}$   | QIO                     | Vertical heat flux through lake ice and snow                                                       | $\mathrm{[W/m^2]}$                      |
| $SW^A$     | SWABS                   | Shortwave radiation absorbed at ice-free lake surface, with the factor of ice-free area multiplied | $\mathrm{[W/m^2]}$                      |
| $T, S$     | T(NLTDIM)               | Lake temperature / Salinity                                                                       | $\mathrm{[^\circ C/m^2]}$/ $\mathrm{[psu]}$ |
| $\Delta t$ | TS                      | Time step                                                                                          | $\mathrm{[s]}$                          |
 <!--endlandscape-->

- Internal work variables of FIHEATL

| Variable           | Variable in source code | Longname                    | Unit                    |
|:------------------ |:----------------------- |:--------------------------- |:----------------------- |
| $\Delta T_{(k=2)}$ | TDEV                    | Freezing point depression   | $\mathrm{[^\circ C]}$   |
| $W_{FZ}$           | WFRZ                    | growth rate of the lake ice | $\mathrm{[cm\ e.w./s]}$ |

Temperature at lake ice base is taken to be the lake model’s top level temperature $T_{(k=2)}$. In this model, lake ice exists only when and where $T_{(k=2)}$ is at the freezing point $T_f$, which is a decreasing function of salinity ($T_f=-0.0543 S$ is used here, where temperature and salinity are measured by $\mathrm{^\circ C}$ and psu, respectively). In the heat budget calculation for snow and lake ice, only latent heat of melting and sublimation is taken into account, and heat content associated with temperature is neglected. Therefore, temperature inside lake ice and snow are not calculated, and $T_I$ is estimated from surface heat balance.

Nonzero minimum values are prescribed for $A_I$ and $h_I$, which are denoted by $A_I^{min}$ and $h_I^{min}$, which are set to $1.0\times 10^{-6}$ and  $1.0\times 10^1 \mathrm{[cm]}$ as default values, respectively. These parameters define a minimum volume of lake ice in a grid ($V_I^{min}$). If a predicted volume $A_Ih_I$ is less than the minimum volume ($V_I^{min}$), $A_I$ is reset to zero, and $T_{(k=2)}$ is lowered to compensate the corresponding latent heat. In this case, the lake model’s top level is kept at a supercooled state. Such a state continues until the lake is further cooled and the temperature becomes low enough to produce more lake ice than the minimum volume.

Surface heat flux is separately calculated for each of air-lake and air-ice interfaces in one grid. The surface temperature of lake ice $T_I$ is determined such that

$$
	Q_{AI} = Q_{IO}
$$

is satisfied, where $Q_{IO}$ corresponds to $G_{IcLk}$ and $Q_{AI}$ corresponds to $G_{IcLk} - W_{IcLk}$, respectively. (They are calculated in matdrv.F.) However, when the estimated $T_I$ exceeds the melting point of lake ice $T_m$ (which is set to 0 $\mathrm{[^\circ C]}$ for convenience), $T_I$ is reset to $T_m$ and $Q_{AI}$ and $Q_{IO}$ are re-estimated by using it. The heat imbalance between $Q_{AI}$ and $Q_{IO}$ is consumed to melt snow (lake ice when there is no snow cover). This heat imbalance changes the growth rate of lake snow ($W_{AS}$).

$$
	W_{AS} = \frac{Q_{AI}-Q_{IO}}{\rho_O L_f}
$$

where $\rho_O$ is density of water and $L_f$ is the latent heat of melting (the same value is applied to snow and lake ice), respectively. Otherwise, it is zero when $T_I < T_m$ and negative when $T_I = T_m$.

Although it is assumed that $T_{(k=2)} = T_f$ when lake ice exists, $T_{k=2}$ could deviated from $T_f$ due to a change of salinity or other factors. Such deviation should be adjusted by forming or melting lake ice. Under a temperature deviation of the top layer of lake,

$$
	\Delta T_{(k=2)} = T_{(k=2)} - T_f S_{(k=2)}
$$

growth rate of the lake ice necessary to compensate it in the single time step ($W_{FZ}$) is given by

$$
	W_{FZ} = - \frac{C_{po} \Delta T_{(k=2)} \Delta z_1}{L_f \Delta t}
$$

where $C_{po}$ is the heat capacity of lake water and $\Delta z_1=100 \mathrm{cm}$ is the thickness of the lake model's top level (uniformly set to constant in the current lake model.) $W_{FZ}$ is estimated at all grids, irrespective of lake ice existence, for a technical reason. As described below, this growth rate first estimates negative ice volume for ice-free grids, but the same heat flux calculation procedure as for ice-covered grids finally results in the correct heat flux to force the lake. Basal growth rate of lake ice ($_{IO}) is given by

$$
	W_{IO} = A_I W_{FZ} + \frac{Q_{IO}}{\rho_OL_f}
$$

Lake ice formation also occur in the ice-free area. Air-lake heat flux except for shortwave in ice-free area is given by

$$
	Q_{AO} = (1-A_{I}) [Q-(1-\alpha_{Lk,SW})SW^\downarrow]
$$

where $Q$ is air-ice heat flux. Shortwave radiation absorbed at ice-free lake surface in ice-free area ($SW^A$) is represented by

$$
	SW^A = (1-A_I)(1-\alpha_{Lk,SW}) SW^\downarrow
$$

Growth rate of the lake ice in ice-free area ($W_{AO}$) is then calculated by

$$
	W_{AO} = (1-A_I)W_{FZ} + \frac{Q_{AO}+I_{(k=2)} SW^A}{\rho_O L_f}
$$

where $I_{(k=2)}$ denotes the fraction of $SW^A$ absorbed by the lake model's top level, which is calculate in SUBROUTINE [SVTSETL] of lakepo.F, respectively.

Finally, the heat flux for freshwater is

$$
	G_{lake} = \Delta z_1 \frac{\Delta T }{\Delta t}
$$

### Sublimation and freshwater flux for lake

In ENTRY FWATERL (in SUBROUTINE [FWASTL] of lakeic.F), sublimation (freshwater) flux, which is practically come from the land ice runoff, is calculated or prescribed over lake ice cover.

- Output variables (Prognostic variables) of FWATERL

| Variable | Variable | Longname           | Unit            |
|:-------- |:-------- |:------------------ |:--------------- |
| $A_I'$   | AX       | Lake ice fraction  | $\mathrm{[-]}$  |
| $h_I'$   | HIX      | Lake ice thickness | $\mathrm{[cm]}$ |
| $h_S'$   | HSX      | Snow depth         | $\mathrm{[cm]}$ |

- Input variables of FWATERL

| Variable   | Variable | Longname                        | Unit            |
|:---------- |:-------- |:------------------------------- |:--------------- |
| $Fw_{Ev}$ | WEV      | Latent heat flux of evaporation | $\mathrm{cm/s}$ |
| $Fw_{Sb}$ | WSB      | Latent heat flux of sublimation | $\mathrm{cm/s}$ |
| $S_{off}$  | SOFF     | Overflow snow flux              | $\mathrm{cm/s}$ |

- Parameters of the lake ice model

| Variable     | Variable | Longname                      | Unit                | Value            |
|:------------ |:-------- |:----------------------------- |:------------------- |:---------------- |
| $\rho_S$     | rhos     | Density of snow               | $\mathrm{[g/cm^3]}$ | $0.33$           |
| $\rho_I$     | rhoi     | Density of lake ice           | $\mathrm{[g/cm^3]}$ | $0.9$            |
| $R_{\rho_S}$ | rrs      | Ratio of density (ocean/snow) | $\mathrm{[-]}$      | $\rho_O/\rho_s$  |
| $R_{\rho_I}$ | rri      | Ratio of density (ocean/ice)  | $\mathrm{[-]}$      | $\rho_O/\rho_I$  |
| $h_I^{min}$  | himin    | Minimum thickness of ice      | $\mathrm{[cm]}$     | $1.0\times 10^1$ |

The sublimation flux ($Fw_{Sb}$) is first consumed to reduce the depth of lake snow in $n$-th time step ($h_S^n$).

$$
	h_S' = h_S^n -  \frac{\rho_O  Fw_{Sb}\Delta t}{\rho_S A_I^n}
$$

where $h_S'$ is the updated depth of lake snow. If $h_S'$ becomes less than zero, it is reset to zero. The melted snow is added to $Fw_{Sb}$.

$$
	Fw_{Sb}' = Fw_{Sb} + \frac{\rho_S A_I^n (h_S' - h_S^n)}{\rho_O\Delta t}
$$

where $Fw_{Sb}'$ is updated sublimation flux.

When there no remains snow but $Fw_{Sb}'$ is not zero, the remain flux is consumed to reduce the thickness of lake ice ($h_I^n$).

$$
	h_I' = h_I^n - \frac{\rho_O Fw_{Sb}' \Delta t }{\rho_I A_I^n}
$$

where $h_S'$ is the updated thickness of lake ice. If $h_I'$ becomes less than $h_I^{min}$, it is reset to zero. The melted ice is added to $Fw_{Sb}'$.

$$
	Fw_{Sb}'' = Fw_{Sb}' - \frac{\rho_I  A_I^n (h_I^n-h_I')}{\rho_O\Delta t}
$$

where $Fw_{Sb}''$ is updated sublimation flux.

Nonzero $Fw_{Sb}''$ is consumed to reduce lake ice concentration ($A_I^n$).

$$
	A_I' = A_I^n - \frac{\rho_OFw_{Sb}'' \Delta t }{\rho_Ih_I^{min}}
$$

where $A_I'$ is the updated lake ice concentration. If $A_I'$ becomes less then 0, it is set to zero. Even if $A_I'$ becomes less than $A_I^{min}$, on the other hand, it is not adjusted here. because such an adjustment means that the sublimation flux is not used up by eliminating snow and lake ice.

Finally, the evaporation flux $Fw_{Ev}$ is modified so as to reduce the lake water.

$$
	Fw_{Ev}' = Fw_{Ev} + Fw_{Sb}'' + \frac{(A_I'-A_I^n) h_I^{min}}{R_{\rho_I}\Delta t}
$$

where $Fw_{Ev}'$ is updated evaporation flux. When the lake ice does not exist, $Fw_{Ev}'$ is just as

$$
	Fw_{Ev}' = Fw_{Ev} + Fw_{Sb}
$$

The adjusted evaporation flux is saved as $\Delta Fw_{Ev}$.

$$
	\Delta Fw_{Ev} = Fw_{Ev}' -	Fw_{Ev}
$$

When sublimation flux is consumed to the reduce lake ice amount, salt contained in lake ice has to be added to the remaining lake ice or the underlying water in other to conserve total salt of the ice-lake system. Here, it is added to underlying water, and the way of this adjustment is described in setcion 11.3. Such an adjustment is not very unreasonable because the ice tends to gradually drain high salinity water contained in brine pockets in reality. When $A_I'$ is adjusted to zero, on the other hand, the remaining sublimation flux is consumed to reduce lake water. In this case, difference between the latent heat of sublimation and evaporation has to be adjusted, which is also described in section 11.3.

If the ice and/or snow is too thick, they are converted to snow flux. Here, the overflow snow flux $S_{off}$ is added to ${Fw_S}$

$$
	Fw_S' = Fw_S + S_{off}
$$

where $Fw_S'$ is the updated snow flux, and $S_{off}$ is the overflow snow flux, which is actually calculated in SUBROUTINE[MATDRV] (of matdrv.F), then handed to ENTRY FWATER.

### Updating lake ice fraction

- Input variables of PCMCTL

| Variable | Variable in source code | Longname                          | Unit              |
|:-------- |:----------------------- |:--------------------------------- |:----------------- |
| $h_I'$    | HIX                     | Thickness of lake ice             | $\mathrm{[cm]}$   |
| $W_{AO}$ | WAO                     | Snow growth rate in ice-free area | $\mathrm{[cm\ w.e./s]}$ |

In ENTRY PCMPCTL (in SUBROUTINE CMPSTL of lakeic.F), the lake ice fraction is updated, using the lake ice thickness ($h_I'$) and the growth (retreat) rate in ice-free area ($W_{AO}$):

$$
	A_I'' = {A_I'} +\frac{\rho_O }{\rho_I h_I' \phi W_{AO}\Delta t}
$$

where $A_I''$ is the updated lake ice concentration, and  $\phi$ is a factor coefficient, which is set to $4.0$ if $W_{AO}$ is greater than 0, otherwise is set to $0.5$ as a default, respectively. If $A_I''$ becomes greater than 1, it is reset to 1, or if $A_I''$ becomes smaller than zero, it is reset to zero.

### Growth and Melting of lake ice and snow

In ENTRY PTHICKL (in SUBROUTINE OTHKSTL of lakeic.F), the lake ice growth and melting are calculated.

- Variables of PTHICKL

| Variable    | Variable in source code | Longname                                          |
|:----------- |:----------------------- |:------------------------------------------------- |
| $A_I$       | AX/AZ                   | Lake ice fraction                                 |
| $V_I$       | AXHIX                   | Lake ice volume                                   |
| $V_S$       | AXHSX                   | Lake snow volume                                  |
| $V_I^{n+1}$ | AXHIXN                  | Lake ice volume                                   |
| $V_S^{n+1}$ | AXHSXN                  | Lake snow volume                                  |
| $h_I$       | HIX HIZ                 | Lake ice thickness                                |
| $h_S$       | HSX/HSZ                 | Snow depth                                        |
| $W_{AS}$    | WAS                     | snow growth rate due to heat imbalance            |
| $W_{AI}$    | WAI                     | growth rate of the lake ice due to heat imbalance |
| $W_{res}$   | WRES                    | Residual heat flux                                |
| $W_{IO}$    | WIO                     | Basal growth rate of lake ice                     |
| $Fw_S$      | SNOW                    | Snowfall flux                                     |
| $W_{AO}$    | WAO                     | growth rate of the lake ice in ice-free area      |
| $Fw_{Pr}$   | PREC                    | Precipitation flux                                |
| $L_e$       | EVAP                    | Latent heat flux of evaporation                   |
| $Fw_{Sb}$   | SUBI                    | Latent heat flux of sublimation                   |
| $F_W$       | FT                      | Freshwater flux                                   |
| $\Delta t$  | TS                      | Time step                                         |
| $R_{off}$   | ROFF                    | --                                                |
| --          | ADJLAT                  | --                                                |
| $F_S$       | FS                      | Heatflux for lake surface                         |

The initial conditions of lake ice volume ($V_I'$) and snow volume ($V_S'$) in the $n$-th time step are presented by

$$
	V_I' = A_I'' h_I^n
$$

$$
	V_S' = A_I'' h_S^n
$$

Here after, predicted values of $A_I''$, $V_I'$, and $V_S'$ are denoted by $A_I^\ast$, $V_I^\ast$ and $V_S^{\ast}$, respectively.

#### Freshwater flux to lake ice and snow

Contribution of snowfall and freshwater flux to the growth of lake ice and snow volume are considered.

Changes of snow depth due to snow fall (freshwater) flux ($Fw_S$) (expressed by negative values to be consistent with other freshwater flux components) is first taken into account.

When the lake ice does not exist, the amount of snow existed before the growth is added to the snowfall flux ($Fw_S'$).

$$
	Fw_S'' = Fw_S' + \frac{\rho_S V_S'}{\rho_O \Delta t}
$$

where $Fw_S''$ is the updated snowfall flux. In this case, the snow depth and its amount become 0.

$$
h_S^\ast=0
$$

$$
V_S^{\ast\ast} = 0
$$

where $h_S^\ast$ and $V_S^{\ast\ast}$ are the updated depth of lake snow and lake snow amount, respectively.

When the lake ice exists, the snowfall accumulates over the ice covered region. The depth of lake snow ($h_S^n$) is modified by

$$
	h_S^\ast = \frac{V_S^{\ast\ast}}{A_I^\ast} + \frac{\rho_O Fw_S'\Delta t}{\rho_S}
$$

The snow amount ($V_S^\ast$) is also modified by

$$
	V_S^{\ast\ast} = A_I^\ast h_S^\ast
$$

The snowfall flux ($Fw_S'$) is then reduced by $V_S^{\ast\ast}$.

$$
	Fw_S'' = (1-A_I^\ast) Fw_S'
$$

where $Fw_S''$ is the updated snowfall flux. Finally, the snowfall flux ($Fw_S''$) is put together with the precipitation flux.

$$
	Fw_{Pr}' = Fw_{Pr} + Fw_S''
$$

where $Fw_{Pr}'$ is the updated precipitation flux.


#### Growth of lake snow

When the lake ice does not exist ($A_I^\ast=0$), the snow amount ($V_S^{\ast\ast}$) is converted to ice. In this case, flux for lake snow growth ($W_{AS}$) is used for the basal growth of the lake ice.

$$
 W_{IO}^\ast = W_{IO} + W_{AS}
$$

where $W_{IO}^\ast$ are the updated basal growth rate of lake ice.

When the lake ice exists, a residual heat flux ($W_{res}$) is considered.

$$
	W_{res} = \frac{\rho_OV_S^{\ast\ast}}{\rho_S \Delta t}+ W_{AS}
$$

If the residual heat flux is negative ($W_{res}<0$), the snow amount is reduced by

$$
	W_{AS}^\ast = - \frac{\rho_O V_S^{\ast\ast}}{\rho_S \Delta t}
$$

where $W_{AS}^\ast$ is the growth rate of the lake snow. In this case, $W_{res}$ is assumed to reduce the lake ice.

$$
	W_{AI} = W_{res}
$$

where	$W_{AI}$ is a growth rate of the lake ice.

The depth of lake snow ($h_S^{\ast}$) is modified with the accumulation.

$$
  h_S^{\ast\ast} = \frac{V_S^{\ast\ast}+ \rho_O W_{AS}^\ast \Delta t}{\rho_S {A_I^\ast}}
$$

where $h_S^{\ast\ast}$ is the updated depth of lake snow. If $h_S^{\ast\ast}$ is less than 0, it is set to zero. When the residual heat flux is zero or positive ($W_{res}\ge 0$), the growth rate of the lake ice ($W_{AI}$) is temporally set to 0.

The lake snow amount ($V_S^{\ast\ast}$) is modified by

$$
	V_S^{\ast\ast\ast} = A_I^\ast h_S^{\ast\ast}
$$

where $V_S^{\ast\ast\ast}$ is the updated lake snow amount.

#### Growth of lake ice

The residual heat flux is updated ($W_{res}'$) for the lake ice growing.

$$
	W_{res}' = \frac{\rho_OV_I^\ast}{\rho_I \Delta t}+ W_{AI}
$$

When the residual heat flux is negative ($W_{res}'$<0), $W_{res}'$ is handed to the lake surface and deficient flux is used for the lake ice melting.

$$
		W_{IO}^\ast = W_{IO} + W_{res}'
$$

$$
	W_{AI}^\ast = - \frac{\rho_OV_I^{\ast}}{\rho_I \Delta t}
$$

where $W_{IO}^\ast$ is the updated basal growth rate of lake ice, and $W_{AI}^\ast$ is the updated growth rate of lake ice, respectively.


The amount of the lake ice ($V_I^{\ast}$) is modified by

$$
	V_I^{\ast\ast} = V_I^{\ast} + \frac{\rho_O (W_{IO}^\ast+W_{AO})\Delta t}{\rho_I}
$$

where $V_I^{\ast\ast}$ is the updated lake ice amount.
If the lake ice amount becomes equal to or less than zero ($V_I^{\ast\ast}\le0$),

$$
  A_I^{\ast\ast}=0, \quad h_I^{\ast}=h_I^{min}
$$

where $A_I^{\ast\ast}$ and $h_I^\ast$ are the updated lake ice concentration and its thickness.
If the lake ice amount becomes equal to or less than zero ($V_I^{\ast\ast}>0$),

$$
  A_I^{\ast\ast}=A_I^\ast, \quad h_I^{\ast}=\frac{V_{I}^{\ast\ast}}{A_I^{\ast}}
$$

However, if $h_I^{\ast}$ becomes less than $h_I^{min}$, they are redefined by

$$
  A_I^{\ast\ast}=\frac{V_I^{\ast\ast}}{h_I^{min}},\quad h_I^{\ast} = h_I^{min}
$$

It is noted that the snow thickness ($h_I^{\ast}$) is not modified even the $A_I^{\ast\ast}$ is modified, so snow on the disappearing ice is regarded as falling onto the created ice-free lake surface.

$A_I^{\ast\ast}$ is set to be zero when it is less than $A_I^{min}$.

#### Lake ice flows

The lake ice is supposed to flow to cover the lake. A simple method that does not deal with dynamical deformation as in the sea ice model[@Hasumi2015-fs] is used.

First, a case of the lake ice does not flow because the lake ice amount is small enough is considered. Ice volume assuming maximum and minimum extent with the minimum thickness of lake ice ($h_I^{min}$) are defined.

$$
  V_I^{max} = h_I^{min}A_I^{max}, \quad V_I^{min} = h_I^{min}A_I^{min}
$$

where $A_I^{max}$ and $A_I^{min}$ are maximum and minimum lake ice concentration, which are set to $1$ and $1.0\times 10^{-6}$ as default values. When $V_I^{\ast\ast} \le (V_I^{max}-V_I^{min})$, the lake ice does not flow. Otherwise, the thickness of lake ice ($h_I^{\ast}$) is modified so as that the lake ice fully covers the lake.

$$
  h_I^{\ast\ast} = \frac{(V_I^{max}-V_I^{min})+A_I^{\ast\ast}h_I^{\ast}}{A_I^{max}}
$$

where $h_I^{\ast\ast}$ is the updated depth of lake snow. The depth of lake snow and the lake ice concentration are also updated.

$$
\begin{array}{rl}
  h_S^{\ast\ast\ast} &= \frac{A_I^{\ast\ast}h_S^{\ast\ast}}{A_I^{max}-(V_I^{max}-V_I^{min})/h_I^{\ast\ast}}\\
  A_I^{n+1} &= A_I^{max} - \frac{V_I^{max}-V_I^{min}}{h_I^{\ast\ast}}
\end{array}
$$

where $h_S^{\ast\ast\ast}$ is the updated depth of lake snow and the lake ice concentration, and $A_I^{n+1}$ is the lake ice concentration in the new time step, respectively.

Freshwater and sublimation fluxes affect on salinity ($F_{W(NLTDIM=2)}$) are

$$
\begin{array}{rl}
	F_{W(NLTDIM=2)} &=Fw_{Ev} - Fw_{Pr}' - R_{off} + W_{S(2)} + W_{I(2)} \\
	F_S &= S_I(W_{I(2)}-Fw_{Sb}'')
\end{array}
$$

where $W_{I(2)}$ and $W_{S(2)}$ are the growth rate of the lake ice snow below.

$$
\begin{array}{rl}
	W_{I(2)} &= \frac{\rho_S A_I^{n+1} h_I^{\ast\ast} - V_I^{\ast}}{\rho_I \Delta t}\\
	W_{S(2)} &=  \frac{\rho_S A_I^{n+1} h_S^{\ast\ast\ast} - V_S^{\ast\ast}}{\rho_S \Delta t}
\end{array}
$$

#### Sinking snow

If there is a large amount of snow and the lake ice surface is below the lake surface, the sinking snow is converted to the lake ice. The depth of lake snow is updated to take buoyancy into account.

$$
	h_S^{n+1} = \mathrm{min}(h_S^{\ast\ast\ast}, \frac{\rho_O-\rho_I}{\rho_S}h_I^{\ast\ast})
$$

The ice thickness is also updated.

$$
	h_I^{n+1} = h_I^{\ast\ast} + \frac{\rho_S}{\rho_I} (h_S^{\ast\ast\ast}-h_S^{n+1})
$$

The heat flux affects on the lake water temperature ($F_{W(NLTDIM=1)}$) is

$$
	F_{W(NLTDIM=1)} = - F_{W(NLTDIM=1)} + \frac{L_f}{C_p} \Big(W_{I(1)}+W_{S(1)}-Sn + \Delta Fw_{Ev}\Big)
$$

where $W_{I(1)}$ and $W_{S(1)}$ are the growth rate of the lake ice snow below.

$$
\begin{array}{rl}
	W_{I(1)} &= \frac{\rho_S A_I^{n+1} h_I^{\ast\ast} - V_I^{\ast\ast}}{\rho_I \Delta t} \\
  W_{S(1)} &= \frac{\rho_S A_I^{n+1} h_S^{\ast\ast\ast} - V_S^{\ast\ast}}{\rho_S \Delta t}
\end{array}
$$

## Physical formulation and process

This sub-section [lakepo.F] introduces the vertical heat and salinity diffusion and convection of the lake water.

### Setting the vertical diffusion coefficients

**Input**

| Meaning                                             | Character | In code | Unit |
| --------------------------------------------------- | --------- | ------- | ---- |
| The default value of vertical diffusion coefficient | $K_{V0}$  | AHVL0   | -    |

**Output**

| Meaning                        | Character | In code | Unit |
| ------------------------------ | --------- | ------- | ---- |
| Vertical diffusion coefficient | $K_{V}$   | AHVL    | -    |

In this part, the vertical diffusion coefficients are first determined for each lake layer, and the source code is included in ENTRY [VDIFFL] (in SUBROUTINE: [LAKEPO] of lakepo.F).

In the current version of MATSIRO 6, the diffusive flux of tracer follows Fick’s law. In Fick’s first law, the vertical diffusive tracer flux $J$ of unit time is:
$$
J=K_{V}\frac{\partial T}{\partial z}
$$
where $T$ represents temperature (temperature is used as an example here, this equation applies to salinity as well), $K_{V}$ represents the diffusion coefficient, and $z$ represents the vertical distance. The vertical diffusion coefficients for all lake layers are set as the default value, which is $K_{V0}$=1. Therefore, the vertical diffusion coefficient $K_{V0}$ of each layer is simply set as:
$$
K_{V}(k)=K_{V0}
$$
It is known that the surface wind and vertical temperature stratification will also influence the vertical diffusion coefficients, and they will be considered and added in the future version.

### Estimate the diffusion terms of the tracer equations

**Input**

| Meaning                        | Character | In code | Unit    |
| ------------------------------ | --------- | ------- | ------- |
| Vertical diffusion coefficient | $K_{V}$   | AHVL    | -       |
| Water temperature              | $T$       | TX(1)   | $^{o}C$ |
| Water depth                    | $h$       | HX      | m       |

**Output**

| Meaning                                         | Character | In code | Unit      |
| ----------------------------------------------- | --------- | ------- | --------- |
| The vertical component of diffusive tracer flux | $F_{D}$   | ADT     | $^{o}C$/s |

**Internal variables**

| Meaning                                   | Character | In code | Unit |
| ----------------------------------------- | --------- | ------- | ---- |
| The water depth excluding the first layer | $h'$      | HZBOT   | m    |
| Depth of each lake layer                  | $D$       | DZ      | cm   |

This part introduces the calculation of the vertical diffusive tracer flux, and the source code is included in ENTRY [FLXTRCL] (in SUBROUTINE: [LAKEPO] of lakepo.F). Temperature is shown here as an example, and the tracer equation of salinity is identical.

The thickness of each lake layer is first calculated. The water column is divided into 5 layers (k=2, 3, 4, 5, 6) in the current version, and the k=1 and k=7 represent the top surface and the bottom surface of the water column, respectively. The layer of the water column is shown in Fig. 11-1.

![The layer of the water column](https://github.com/integrated-land-simulator/model_description/blob/7fde1cde17a72c5782fb2e94605290e8da290063/descript/Lake_11-1.pdf)

Firstly, the thickness of the first layer (k=2) is fixed and represented as $D_{1}$, and $D_{1}$ is set to 100 cm. Therefore, the thickness of the first layer can be described as:
$$
D(2)=D_{1}
$$
The thicknesses of the other layers (k=3, 4, 5, 6) are calculated based on the ratio of the remaining thickness of the water column. Using $h$ to represent the total depth of the water column, and the thickness of the remaining water column ($h'$) excluding the top layer is presented by:
$$
h'=h-D_{1}
$$
and thickness ($D(k)$) of the remaining layer (k=3, 4, 5, 6) can be represented as:
$$
D(k)=S(k)h'
$$
The ratio ($S(k)$) of layer 3 to 6 are 0.1, 0.1. 0.2, and 0.6, respectively. Therefore, the thermal change of the k-th layer by vertical diffusion can be represented as the flux difference between upper layer $J_{k-1, k}$ and lower layer $J_{k, k+1}$:
$$
F_{D}(k)=J_{k-1,k}-J_{k,k+1}=K_{V}(k)\frac{T(k-1)-T(k)}{\frac{D(k-1)+D(k)}{2}}-K_{V}(k+1)\frac{T(k)-T(k+1)}{\frac{D(k)+D(k+1)}{2}}
$$


The above equations apply to salinity as well.

### Time integration of the tracer equations

**Input**

| Meaning                                          | Character  | In code | Unit      |
| ------------------------------------------------ | ---------- | ------- | --------- |
| The vertical component of  diffusive tracer flux | $F_{D}$    | ADT     | $^{o}C$/s |
| Minimum depth of the lake                        | $h_{min}$  | HXMIN   | m         |
| Heat flux                                        | $F_{T}$    | FT (1)  | $^{o}C$/s |
| Freshwater flux                                  | $F_{W}$    | FT(2)   | cm/s      |
| Absorbed shortwave solar radiation               | $S_{r}$    | SWABS   |           |
| Salt flux                                        | $F_{S}$    | FS      |           |
| Timestep                                         | $\Delta t$ | TS      | s         |
| Surface-type fraction (lake)                     | $R_{lake}$ | LKFRAC  | -         |

**Output**

| Meaning               | Character | In code | Unit |
| --------------------- | --------- | ------- | ---- |
| Lake water deficiency | $V_{D}$   | XHD     | cm   |

This part introduces the update of water temperature and salinity of each layer due to the diffusion, freshwater flux, and absorption of solar radiation. The source code is included in ENTRY [SLVTRCL] (in SUBROUTINE: [LAKEPO] of lakepo.F).

Heat diffusion is first considered. According to Fick’s second law, the temperature (salinity as well) change of k-th layer follows:
$$
\frac{\partial T}{\partial t}=K_{V}(k)\frac{\partial^2 T}{\partial z^2}
$$
where $z$ is the vertical distance. The equation is implicitly (backward-in-time) integrated, and obtains:
$$
\frac{T^{n+1}(k)-T^{n}(k)}{\Delta t}=\frac{K_{V}(k)\frac{T^{n+1}(k-1)-T^{n+1}(k)}{\frac{D(k-1)+D(k)}{2}}-K_{V}(k+1)\frac{T^{n+1}(k)-T^{n+1}(k+1)}{\frac{D(k)+D(k+1)}{2}}}{D(k)}
$$
The Tridiagonal Matrix Algorithm (also known as the Thomas Algorithm) is used to solve the equation, the following equation is constructed:
$$
A_{A}(k)F_{D}(k-1)+A_{B}(k)F_{D}(k)+A_{C}(k)F_{D}(k+1)=F_{D}(k)
$$
where
$$
A_{A}(k)=-\frac{K_{V}(k)}{\frac{D(k-1)+D(k)}{2}}\Delta t
$$

$$
A_{C}(k)=-\frac{K_{V}(k+1)}{\frac{D(k)+D(k+1)}{2}}\Delta t
$$

$$
A_{B}(k)=D(k)-A_{A}(k)-A_{C}(k)
$$

Then, the new coefficient of the Tridiagonal Matrix Algorithm can be constructed:
$$
A_{c}'(k)=\left\{\begin{matrix}
\frac{A_{C}}{A_{B}},&k=&2\\\frac{A_{C}}{A_{B}-A_{A}(k)A_{C}'(k-1)}, &k=&3, 4, 5, 6
\end{matrix}\right.
$$

$$
A_{D}'(k)=\left\{\begin{matrix}
\frac{F_{D}(k)}{A_{B}(k)}, &k=&2\\\frac{F_{D}(k)-A_{A}(k)A_{D}'(k-1)}{A_{B}-A_{A}(k)A_{C}'(k-1)}, &k=&3, 4, 5, 6
\end{matrix}\right.
$$

Then, the vertical diffusion term can be obtained:
$$
F_{D}(k)=\left\{\begin{matrix}
A_{D}'(k), &k=&6\\A_{D}'(k)-A_{C}'(k)F_{D}(k+1), &k=&2, 3, 4, 5
\end{matrix}\right.
$$


The water temperature of each layer is updated as:
$$
T_{k}=T(k)+F_{D}(k)\Delta t
$$
After solving diffusive changes of tracers, the effect of heat, salinity, and freshwater fluxes at the lake surface is taken into account. Since the height of the water column changes with the freshwater flux, tracers at each layer should be re-estimated. It worth noting that a minimum depth threshold $h_{min}$ is set, which means the lake depth can not be lower than this value. When surface freshwater flux $F_{W}$ (positive upward, i.e., the lake level is lowered when $F_{W}$ > 0) is imposed, and the change of the water column for each time step can be represented as:
$$
h_{D}=-F_{W}\Delta t
$$
and the lake water deficiency (when lake depth $h$ is smaller than the minimum threshold $h_{min}$) can be represented as:
$$
V_{D}=max(h_{min}-h-h_{D}, 0)\times R_{lake}
$$
where $R_{lake}$ is the lake fraction of the grid. Therefore, the change of the lake depth is finalized as:
$$
h_{D}=max(h_{D}, h_{min}-h)
$$
and the lake depth is updated:
$$
h=h+h_{D}
$$


Due to the added freshwater, the depth of each lake layer has been changed, so the water temperature of each layer is updated as well. The update of depth and water temperature starts from the bottom layer. When $h_{D}$ > 0, the bottom of the k-th layer in the z coordinate is raised by:
$$
\Delta z_{B}^{k}=(1-\sum_{l=2}^{k}S(k))h_{D}
$$
where $S(k)$ is the vertical depth proportion of the k-th layer, and its top is raised by:
$$
\Delta z_{T}^{k}=(1-\sum_{l=2}^{k-1}S(k))h_{D}
$$
where the following equation holds:
$$
\Delta z_{k}^{T}=\Delta z_{k-1}^{B}
$$
Therefore, the temperature of the k-th (k=3, 4, 5, 6) layer becomes:
$$
T(k)=\frac{T(k)D(k)-T(k)\Delta z_{k}^{B}+T(k-1)\Delta z_{k}^{T}}{D(k)}
$$
The temperature of the first layer (k=2) becomes:
$$
T(2)=\frac{T(2)D(2)-T(2)\Delta z_{2}^{B}+T(2)\Delta z_{2}^{T}+F_{T}\Delta t}{D(2)}
$$
where $F_{T}$ is the heat flux of the freshwater added to the lake, and for salinity, the salinity flux is $F_{S}$.

When $h_{D}$ < 0, on the other hand, the bottom of the k-th level is lowered by $\Delta z_{k}^{B}$, and its top is lowered by $\Delta z_{k}^{T}$. In this case, the above tracer equations for the k-th layer (k=3, 4, 5, 6) and the first layer (k=2) become:
$$
T(k)=\frac{T(k)D(k)-T(k)\Delta z_{k}^{T}+T(k+1)\Delta z_{k}^{B}}{D(k)}
$$


and
$$
T(2)=\frac{T(2)D(2)-T(2)\Delta z_{2}^{T}+T(3)\Delta z_{2}^{B}+F_{T}\Delta t}{D(2)}
$$
Finally, the absorption of solar radiation is considered. The temperature of each layer is updated as:
$$
T(k)=T(k)+\frac{S_{r}\times C_{sr}(k)}{D(k)\rho _{0}C_{P0}}\Delta t
$$
where $S_{r}$ represents the solar radiation, and $C_{sr}$ represents the absorption proportion of each layer. $\rho_{0}$ and $C_{p0}$ are density and specific heat capacity of water, and their values are set as 1 g/cm3 and 3.99×107 erg/g/K, respectively. $C_{sr}$ is calculated based on the depth of each layer, the transitivity $T_{rs}(k)$ at depth $D_{t}(k)$ can be represented as:
$$
T_{rs}=R_{r}\times e^{-\frac{D_{t}(k)}{z_{1}}}+(1-R_{r})\times e^{-\frac{D_{t}(k)}{z_{2}}}
$$
where $R_{r}$, $z_{1}$, and $z_{2}$ are three parameters, and their values are 0.58, 35, and 2300, respectively.

$D_{t}(k)$ represent the total depth of the bottom of k-th layer:
$$
D_{t}(k)=\sum_{l=2}^{k}D(k)
$$
Therefore, $C_{sr}$ can be represented as:
$$
C_{sr}(k)=\left\{\begin{matrix}
1-T_{rs}(k), &k=&2\\T_{rs}(k-1)-T_{rs}(k), &k=&3, 4, 5
\\ 1-\sum_{l=2}^{5}C_{sr}(k), &k=&6
\end{matrix}\right.
$$


### The vertical convection

This part introduced the vertical convection of the water between different layers, and the source code is included in ENTRY [OVTURNL] (in SUBROUTINE: [LAKEPO] of lakepo.F).

A classical, still widely used method-convective adjustment, which unstable water column is artificially homogenized with conserving heat and salt. MATSIRO 6 employs the convective adjustment for the standard choice, but its algorithm is not the pairwise adjustment. It is summarized as follows:

(1)  Set the index $K_{s}$=2 (the first layer), indicating the start level of the convective adjustment, and set the index $K_{e}$=3 (the second layer), indicating the level where instability is currently judged.

(2)  Compare potential density ($\rho$) of the ($K_{e}$-1)-th and $K_{e}$-th layers. If instability ($\rho_{Ke-1}$> $\rho_{Ke}$) is found, go to step 3, and if instability is not found, go to step 4.

(3)  Mix the water column between the $K_{s}$-th layer and $K_{e}$-th layer. Increase $K_{e}$ by 1, and if the (new) $K_{e}$ is greater than 6 (the bottom layer), the convection procedure ends. If not, go back to step 2 with the new $K_{e}$.

(4)  Set $K_{s}$=$K_{e}$, and increase $K_{e}$ by 1.  Increase $K_{e}$by 1, and if the (new) $K_{e}$ is greater than 6 (the bottom layer), the convection procedure ends. If not, go back to step 2 with new $K_{s}$ and $K_{e}$.

The water density is calculated by:
$$
\rho =999.842594+6.793952\times 10^{-2}\times T-9.095290\times 10^{-3}\times T^{2}+1.001685\times
      10^{-4}\times T^{3}\\ -1.120083\times 10^{-6}\times T^{4}+6.536332\times 10^{-9}\times T^{5}
$$


where $T$ represents temperature. When instability happens, the water column between the $Ks$ layer and $K_{e}$ will convect and mix, and the water temperature of these layers will be identical and are updated as:
$$
T(K_{s}, ..., K_{e})=\frac{\sum_{k=K_{s}}^{K_{e}}D(k)T(k)}{\sum_{k=K_{s}}^{K_{e}}D(k)}
$$

## Lake river coupling

The inflow rate from the river to the lake, $R_{in}$ $[cm/s]$, is calculated as follws.

$$
	R_{in} = H_{riv} / (\tau_{riv} * 86400)
$$

where $H_{riv}$ $[cm]$ is grid average river water depth, $\tau_{riv}$ is a time constant, and 86400 is a unit conversion coefficient. $\tau_{riv}$ is set to 1 day by default. $H_{riv}$ is derived the following equation.

$$
	H_{riv} = w_{riv} / \rho_w * 100
$$

where $w_{riv}$ is the river water volume $[kg/m^2]$, $\rho_w$ is the density of water, and 100 is the coefficient for unit conversion.

When water depth $H [cm]$ of a lake becomes deeper than the upper limit $H_{max}$, water outflows into river channel. The outflow rate to the river, $R_{out} [cm/s]$, is diagnosed as follows.

$$
	R_{out} = (H - H_{max}) / ( \tau_{lake} * 86400 )
$$

The $H_{max} [cm]$ is, by default, the climatology of lake depth + 10 m. $\tau_{lake}$ is a time constant, which is also set to 1 day.

Finally, $R_{out}$ is added to runoff from land and given to the river.

# Wetland

## Outline of wetland scheme

A snow-fed wetland scheme, in which snowmelt can be stored with consideration of sub-grid terrain complexity, is incorporated as a sub-module of TOPMODEL (when # ifdef OPT_SW_STORAGE in SUBROUTINE: [MATROF] in matrof.F is active) in MATSIRO 6 to represent the wetland-related process in the middle and high latitudes grid with snowmelt [@Nitta2015-ob;@Nitta2017-hz, Fig. 12-1]. The wetland scheme has two major effects: 1) the storage of part of the surface water and delay of runoff to rivers, 2) an increase in land surface wetness thus enhancing the evaporation in water-limited regimes.

With the wetland scheme, when snowmelt occurs, instead of all the generated surface runoff flows directly to the rivers, only a part of the surface runoff flows into the rivers and the remaining part of the surface runoff is stored by the added tank (also known as the snow-fed wetland). Then, the stored water in the wetland is then re-added to the water input of soil combining with other kinds of water inputs (Fig. 12-1). In the current version, only snow-fed wetlands are considered, and more types of wetland schemes will be added in the future version.

![Flowchart of the wetland scheme in the MATSIRO 6](https://github.com/integrated-land-simulator/model_description/blob/7fde1cde17a72c5782fb2e94605290e8da290063/descript/Wetland_12-1.pdf)

## Inflow and outflow of the wetland

The inflow of the wetland comes from the fraction of the surface runoff, and its amount is determined by the  tunable parameter $\alpha$. The outflow from the wetland is calculated using a time constant $\beta$ and the wetland storage $S$, consequently flowing into the soil surface. Therefore, the update of the wetland storage $S$ at each time step can be represented as:

$$
\frac{S^{\tau +1}-S^{\tau }}{\Delta t}=-\frac{S}{\beta}+(1-\alpha )R_{s}
$$

where $R_{s}$ is surface runoff calculated as a total of $Ro_{s}$ (saturation excess runoff), $Ro_{i}$ (infiltration excess runoff), and $Ro_{o}$ (overflow of the uppermost soil layer); $\tau$ is time; and $\alpha$ and $\beta$ are parameters related to the inflow and outflow of the wetland storage, respectively.

$\beta$ is a spatially dependent time constant, and can be calculated using a function of the standard deviation of elevation above sea level:

$$
\beta =max(\beta_{0}(1-min(\sigma_{z}(x),\sigma_{z max})/\sigma_{z max}), \Delta t)
$$

where $\beta_{0}$ is the maximum of the time constant, $\sigma_{z}$ is the standard deviation of elevation above sea level within each grid at point $x$, and $\Delta t$ is the time step of the model.  The parameter $\sigma_{z}$ is a physical parameter calculated by the topography dataset, with a higher spatial resolution than the simulation, and $\beta_{0}$, $\sigma_{zmax}$, and $\alpha$ are tunable parameters. These parameter values were determined based on sensitivity simulations using an offline land model with perturbed parameters; 1 month, 200m, and 0.1 were chosen as the most appropriate values for $\beta_{0}$, $\sigma _{zmax}$, and $\alpha$, respectively [@Nitta2015-ob].

## Storage of the surface runoff

The ratio of total surface runoff that flows directly to the rivers is controlled by parameter $\alpha$. Therefore, the actual runoff flows into rivers $Ro$ changes to:

$$
Ro=(Ro_{s}+Ro_{i}+Ro_{o})\times \alpha + Ro_{b}
$$

where $\alpha$ is the inflow parameter (see 12.1); $Ro_{s}$ is the saturation excess runoff (Dunne runoff), $Ro_{i}$ is the infiltration excess runoff (Horton runoff), and $Ro_{o}$ is the overflow of the uppermost soil layer, and all these three kinds of runoff make up the total surface runoff, and $Ro_{b}$ is the groundwater runoff (section 7.3).

## Water input of soil surface

The outflow from the wetland storage is re-added to the water input of the soil surface, combining with the original water input (e.g. precipitation that passes through canopy gaps, water drops from the canopy, and snowmelt water). Therefore, the updated soil water input $WI_{soil,total}$ of each time step can be represented as:

$$
WI_{soil,total}=Pr_{c}^{**}+Pr_{l}^{**}-Ro_{s}-Ro_{i}+\frac{S}{\beta }\Delta t
$$

where $Pr_{c}^{**}$ represents the convective rainfall, $Pr_{l}^{**}$ represents the non-convective rainfall, $S$ represents the wetland storage, $\beta$ represents the outflow parameter of the wetland, and $\Delta t$ is the time step.


# Tile scheme

MATSIRO employs a tile treatment of the land surface to represent the subgrid land surface types, so as to partially mimic the behavior at a higher resolution. The tile scheme is demonstrated in ENTRY:[LNDFLX] and [LNDSTP] (in SUBUROUTINE: [MATSIRO] of matdrv.F), and the variables and parameters are introduced as follows:

- Output variables

| Variable     | Description                                                  | Code   | Units |
| ------------ | ------------------------------------------------------------ | ------ | ----- |
| $F$          | Fluxes at the land surface                                   | MATFLX | -     |
| $F_{lake}$   | Fluxes at the land surface of lake                           | -      | -     |
| $F_i(i=1,2)$ | Fluxes at the land surface of potential vegetation and cropland | -      | -     |

- Parameters

 <!--beginlandscape-->
| PARAMETER      | Description                                                  | Code    | Units |
| -------------- | ------------------------------------------------------------ | ------- | ----- |
| $f_{lake}$     | Fractional weight of lake in grid                            | LKFRAC  | -     |
| $f_i(i=1,2)$   | Fractional weight of potential vegetation and cropland in grid | SFFRAC  | -     |
| $f_i^"(i=1,2)$ | Sub-fractional weight of potential vegetation and cropland on land | SFFRAC1 | -     |
 <!--endlandscape-->

Basically, one land surface grid is divided into three tiles in the control run — lake, potential vegetation and cropland:

1. There are both snow-covered and snow-free fractions in each tile;
2. The surface heat and water fluxes over lakes have been calculated as one of the tiles in a grid;
3. Both potential vegetation and cropland tiles consist of six soil layers, up to three snow layers, and a single canopy layer, driving predictions of the temperature and amount of water in the canopy, soil, and snow;
4. Potential vegetation is defined according to the vegetation types of the Simple Biosphere Model 2 [@Sellers1996-ye] scheme and has 10 categories including land ice. There is no wetland category for land cover in the original SiB2 vegetation types or soil types.

All the prognostic and diagnostic variables are calculated in each tile, and the fluxes at the land surface $F$ are averaged:
$$
F=F_{lake}f_{lake}+\sum_{i=1}^nF_if_i
$$

$$
f_i=f_i^"(1-f_{lake})
$$

$$
\sum_{i=1}^nf_i^"=1
$$

where n is 2, $F_{lake}$, $F_1$ and $F_2$ denote fluxes at the land surface of lake, potential vegetation and cropland, $f_{lake}$, $f_1$ and $f_2$ denote their corresponding fractional weights (the sum of $f_{lake}$, $f_1$ and $f_2$ always equals 1), $f_1^"$ and $f_2^"$ denote the sub-fractional weights of potential vegetation and cropland on land (note that $f_1^"$ and $f_2^"$ have been utilized as boundary condition data in MATSIRO6), respectively.

By default, tile scheme is applied in land surface type, but it can be used for multiple purposes.

# References
