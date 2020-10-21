# Introduction.

Minimal Advanced Treatments of Surface Interaction and RunOff (MATSIRO) is a land-surface process parameterization that has been developed to introduce the global climate model CCSR/NIES AGCM and other models. MATSIRO is mainly designed to be used for long-term climate calculations for integration from one month to several hundred years, coupled with atmospheric models with grid scales of several 10 km or more. In the development of the system, we paid attention to the fact that the processes to be taken into account in the water-energy cycle of the atmospheric land system are represented as adequately as possible and are modeled as concisely as possible so that the results can be easily interpreted. The development of MATSIRO was based on the CCSR/NIES AGCM5.4g land surface sub-model, combined with the vegetation canopy parameterization by Watanabe (1994), and at the same time improved the processes of snow accumulation and runoff. Subsequently, the AGCM was modified to correspond to the current AGCM5.6 through the modification of the AGCM structure, including the use of a flux coupler and parallelization. As for the physiological processes of the vegetation, the Farquhar-type photosynthesis scheme, which was initially used as a Jarvis-type function for stomatal resistance, has been transferred from the SiB2 code to the Farquhar-type photosynthesis scheme, which is now used as a quasi-standard scheme due to recent advances in climate-ecosystem interaction research.

# Composition of MATSIRO

## MATSIRO Overall

### Overall Structure.

MATSIRO consists of ,

 - Flux Calculation Unit (LNDFLX)

 - Land Surface Integrator (LNDSTP)

This is similar to the standard land process routine of AGCM5.6. This is the same as the standard land process routine of AGCM5.6.

The flux calculator is called in the time step of the atmospheric model as part of the physical process of the atmospheric model. In contrast, the land surface integrator is called from the coupled model main routine as the land surface model equivalent to the atmospheric and oceanic models. The time step is set independently from the atmospheric model.

The data exchange between the fluxing section and the land surface integrating section is carried out through the flux coupler. The flux calculation section treats snow-covered and snow-free surfaces separately and obtains surface fluxes for each of them. The fluxes are weighted and averaged according to the ratio of the snow-covered and snow-free surfaces, and the fluxes are passed through the flux coupler to the land surface integrating unit. At the same time, the temporal averaging operation is also carried out.

Programmatically, the driver program (matdrv.F) contains an entry for the flux calculation part, LNDFLX, and an entry for the land surface integration part, LNDSTP, from which the subroutines of the necessary processes are called. LNDFLX and LNDSTP share the internal variables of MATSIRO.

### Internal variables of MATSIRO

MATSIRO has the following internal variables.

| Header0 | Header1 | Header2 | Header3 |
| ------- | ------- | ------- | ------- |
| $T_{s(l)}$ | $(l=1,2)$ | surface temperature | \K.L.A.[K.R.I.E.D.] |
| $T_{c(l)}$ | $(l=1,2)$ | Canopy temperature | \K.L.A.[K.R.I.E.D.] |
|  |  |  |  |
| $T_{g(k)}$ | $(k=1,\ldots,K_g)$ | Soil temperature | \K.L.A.[K.R.I.E.D.] |
| $w_{(k)} $ | $(k=1,\ldots,K_g)$ | soil moisture content | \[m$^3$/m$^3$] |
| $w_{i(k)}$ | $(k=1,\ldots,K_g)$ | Frozen soil moisture content | \[m$^3$/m$^3$] |
|  |  |  |  |
| $w_c$ |  | Water content in the canopy | \\0.25\\0.25\0.25\0.25\0.25\0.25\0.25\0.00}. |
|  |  | amount of snowfall | \kosmos[kg/m$^2$] |
| $T_{Sn(k)}$ | $(k=1,\ldots,K_{Sn})$ | snow temperature | \K.L.A.[K.R.I.E.D.] |
| $\alpha_{Sn(b)}$ | $(b=1,2,3)$ | snow albedo | \The state of affairs in the state of affairs of others [$-$] |

where $l=1,2$ are snow-free and snow-covered areas, respectively, $k$ is the vertical layer number of soil and snow cover (top layer is 1 and increases downward), $K_g$ is the number of soil layers, $K_{Sn}$ is the number of snow-covered layers, $b=1,2,3$ are It represents the visible, near-infrared and infrared wavelengths.

In standard practice, there are five layers of soil, with the thicknesses of each layer being 5cm, 20cm, 75cm, 1m, and 2m from the top. The definition points of soil temperature, soil moisture and frozen soil moisture are the same.

The number of layers of the snowpack is variable, and the number of layers increases as the snowpack increases. The standard number of layers is three at most.

The surface temperature and the canopy temperature are so-called skin temperature, which have no heat capacity, but are formally predictive variables (the current calculation method uses the stability evaluated in the previous step, and therefore depends on the value of the previous step. If we evaluate the stability and so on with the updated value and repeat the calculation until the convergence is achieved, then we have a complete diagnostic variable that does not depend on the value of the previous step.) The other variables are all forecast variables that require the values of the previous step.

The surface temperature and the canopy temperature are updated in the flux calculation section. The other variables (the original forecast variables) are all updated in the land surface integration part.

## Flux calculation section

### Structure of the flux calculation section

The flux calculation section proceeds as follows.

1. receive input variables from the coupler.

2. diagnose the snow area ratio of the subgrid.

For the snow-free area ($l=1$) and the snow-covered area ($l=2$), subroutines are called to calculate the fluxes and to update the surface and canopy temperatures. Concretely, the following subroutines are called in sequence.

     MATLAI vegetation shape parameter (LAI, vegetation height)

     2. calculation of MATRAD radiation parameters (albedo, vegetation permeability, etc.)

     MATBLK calculation of turbulent parameters (bulk coefficient) (momentum and heat)

     4. MATRST calculation of stomatal resistance, bare ground evaporation resistance, etc.

     5. MATBLQ calculation of turbulent parameters (bulk coefficient) (water vapor)

     6. calculation of MATFLX surface flux

     7. calculation of MATGHC ground heat transfer

     8. MATSHB Deciphering the energy balance of the ground surface and canopy

4. pass output variables to the coupler.

Register and add history output variables. 5.

(a) to (e) are classified into boundary value submodels and the programs are summarized in matbnd.

(f)-(h) are classified as surface submodels, and the programs are summarized in matsfc.

The photosynthesis scheme MATPHT is called from (d). The photosynthesis scheme is summarized in matpht.

### The input variables in the flux calculation section.

The following variables are entered into the flux calculation section.

| Header0 | Header1 | Header2 | Header3 |
| ------- | ------- | ------- | ------- |
| $u_a$ |  | Atmospheric 1st layer east-west wind | \The "m/score |
| $v_a$ |  | First layer of atmospheric north-south wind | \The "m/score |
| $T_a$ |  | Atmospheric 1st layer temperature | \K.L.A.[K.R.I.E.D.] |
| $q_a$ |  | Specific humidity in the first layer of the atmosphere | [kg/kg\\] |
| $P_a$ |  | Atmospheric 1st layer pressure | \The state of affairs of the city of Los Angeles[Pahren] |
| $P_s$ |  | surface pressure | \The state of affairs of the city of Los Angeles[Pahren] |
|  |  |  |  |
| $R^{\downarrow}_{(d,b)}$ | $(d=1,2;b=1,2,3)$ | Surface downward radiation flux | \W/m$^2$] |
| $\cos\zeta$ |  | cosine of the solar zenith angle | \The state of affairs of the company in the first place is in the form of the following. |

where $d=1,2$ represent the direct line and scattering, respectively, and $b=1,2,3$ represent the visible, near-infrared, and infrared spectral bands, respectively.

### Output variables in the flux calculation section

The following variables are output from the flux calculation section.

| Header0 | Header1 | Header2 | Header3 |
| ------- | ------- | ------- | ------- |
| $\tau_x$ |  | surface-to-west wind stress | \N/m$^2$] |
| $\tau_y$ |  | surface-to-south wind stress | \N/m$^2$45] |
| $H$ |  | surface sensible heat flux | The\\\brahammer\bra_Penny.com[W/m$^2$] |
| $E$ |  | Surface Water Vapor Flux | \[kg/m$^2$/s] |
| $R^{\uparrow}_S$ |  | Upward Bound Shortwave Radiation Flux |  |
| $R^{\uparrow}_L$ |  | Upward Bound Longwave Radiation Flux |  |
| $\alpha_{s(b)}$ | $(b=1,2,3)$ | surface albedo | \The state of affairs of the world[$-$] |
| $T_{sR}$ |  | surface radiation temperature | \K.L.A.[K.R.I.E.D.] |
| $F_{g(1/2)}$ |  | Surface Heat Transfer Flux |  |
| $F_{Sn(1/2)}$ |  | Heat Transfer Flux for Snow Surface | The\\\brax.com[W/m$^2$] |
| $Et_{(i,j)}$ | $(i=1,2;j=1,2,3)$ | Evapotranspiration components | \[kg/m$^2$/s\braham] |
| $\Delta F_{conv}$ |  | surface energy convergence |  |
| $F_{root(k)}$ | $(k=1,\ldots,K_g)$ | Root sucking flux | \[kg/m$^2$/s] |
| $LAI$ |  | leaf area index | \[m$^2$/m$^2$] |
| $A_{Snc}$ |  | Canopy freezing area ratio | \Holy shit...[$-$] |

Here, $i=1,2$ in evapotranspiration represent liquid and solid, respectively, and $j=1,2,3$ represent bare ground (forest floor) evaporation, evaporation and evaporation of water on the canopy, respectively. The other subscripts are the same as those in the previous section.

## Land surface integral part

### Composition of the Land Surface Integrator

The land surface integration section proceeds as follows.

1. receive input variables from the coupler.

The subroutines of each process are called and the land surface forecast variables are updated. Specifically, the following subroutines are called in sequence.

     1. calculation of the water balance of the MATCNW canopy

 Calculation of     MATSNW snowpack, snow temperature and snow albedo

     3. calculation of MATROF runoff

     MATGND Calculation of soil temperature, soil moisture, and frozen ground

3. pass output variables to the coupler.

Register and add history output variables. 4.

Each subroutine called from the main part of the land surface integrator consists of a submodel. The programs of each sub-model are organized in a single file. In concrete terms, each subroutine is described as follows

 - MATCNW (matcnw.F) Canopy water balance sub-model

 - MATSNW (matsnw.F) snow sub-model

 - MATROF (matrof.F) Spillover sub-model

 - MATGND (matgnd.F) Soil sub-model

The submodels are basically executed in this order, but if necessary, subroutines may be called among the submodels in order to refer to the values of the parameters managed by other submodels. Subroutines within the above submodels may also be called by the fluxing part for the same purpose.

### Input variables in the land surface integration section

The following variables are entered into the land surface integrator.

| Header0 | Header1 | Header2 | Header3 |
| ------- | ------- | ------- | ------- |
| $Pr_{c}$ |  | Convective rainfall flux | \[kg/m$^2$/s] |
| $Pr_{l}$ |  | Layered Rainfall Flux | \[kg/m$^2$/s] |
| $P_{Snc}$ |  | Convective snowfall flux | \[kg/m$^2$/s] |
| $P_{Snl}$ |  | Layered Snowfall Flux | \[kg/m$^2$/s] |
| $F_{g(1/2)}$ |  | Surface Heat Transfer Flux | \The "W/m$^2$\ |
| $F_{Sn(1/2)}$ |  | Heat Transfer Flux for Snow Surface | \W/m$^2$8] |
| $Et_{(i,j)}$ | $(i=1,2;j=1,2,3)$ | Evapotranspiration components | \[kg/m$^2$/s] |
| $\Delta F_{conv}$ |  | surface energy convergence |  |
| $F_{root(k)}$ | $(k=1,\ldots,K_g)$ | Root sucking flux | [kg/m$^2$/s\\\blade}] |
| $LAI$ |  | leaf area index | \The state of affairs of the state [m$^2$/m$^2$] |
| $A_{Snc}$ |  | Canopy freezing area ratio | \The state of affairs in the state of affairs of the company [$-$0101] |

### Output variables of the land surface integration section

The land surface integrator outputs the following variables.

| Header0 | Header1 | Header2 | Header3 |
| ------- | ------- | ------- | ------- |
| $Ro$ |  | runoff | [kg/m$^2$/s\\blind} |

The runoff is used as an input variable for the river network model.

## External Parameters.

There are two types of external parameters for executing MATSIRO: one is the parameter values of each grid by the horizontal distribution (map), and the other is the parameter values for each land cover type or soil type by the table. Land cover type and soil type are one of the parameters given by the map, and each parameter given by the table is assigned to each grid. Namely,

$$
 \phi(i,j)
$$
\\.066} or \.066\.066\.

where $(i,j)$ are indices of the horizontal position of the grid, $I_L$ is the land use type, and $I_S$ is the soil type. where $(i,j)$ are the indexes of the horizontal position of the grid, $I_L$ is the land use type, and $I_S$ is the soil type.

### External parameters given by the map

The types of external parameters given by the map are as follows.

| Header0 | Header1 | Header2 | Header3 | Header4 |
| ------- | ------- | ------- | ------- | ------- |
| $I_L$ |  | Land cover type | constant | \\\.com |
| $I_S$ |  | Soil Type | constant | \\\.com |
| $LAI_0$ |  | Leaf Area Index (LAI) | every month | \[m$^2$/m$^2$] |
| $\alpha_{0(b)}$ | $(b=1,2,3)$ | Ground surface (forest floor) albedo | constant | \\\.com |
| $\tan\beta_{s}$ |  | Tangent of the mean surface slope | constant | \\\.com |
| $\sigma_z$ |  | elevation standard deviation | constant | \\0.25\\0.25\0.25\0.25\0.25\0.25\0.25\0.00}. |

### External parameters given by the table for each land cover type

The external parameters given by the table for each land cover type are as follows

| Header0 | Header1 | Header2 | Header3 |
| ------- | ------- | ------- | ------- |
| $h_0$ |  | vegetation height | \\0.25\\0.25\0.25\0.25\0.25\0.25\0.25\0.00}. |
| $h_{B0}$ |  | Height of the bottom of the canopy | \\0.25\\0.25\0.25\0.25\0.25\0.25\0.25\0.00}. |
| $r_{f(b)}$ | ($b$=1,2) | Reflectivity of individual leaves | \\\.com |
| $t_{f(b)}$ | ($b$=1,2) | Transmittance of individual leaves | \\\.com |
| $f_{root(k)}$ | ($k=1,\ldots,K_g$) | Percentage of root presence | \\\.com |
| $c_d$ |  | Momentum exchange coefficient between the individual leaves and the atmosphere | \\\.com |
| $c_h$ |  | Heat Exchange Coefficient between individual leaves and the atmosphere | \\\.com |
| $f_V$ |  | vegetation coverage | \\\.com |
| $V_{\max}$ |  | Rubisco Reaction Capacity | \The "m/score |
| $m$ |  | $A_n$-$g_s$ Slope of the relationship | \\\.com |
| $b$ |  | $A_n$-$g_s$ relationship intercepts | \The "m/score |
| $\epsilon_3$, $\epsilon_4$ |  | Photosynthetic efficiency per photon | \centric[m/s/mol\] |
| $\theta_{ce}$ |  | Coupling factor between     $w_c$ and $w_e$ | \\\.com |
| $\theta_{ps}$ |  | Coupling factor between     $w_p$ and $w_s$ | \\\.com |
| $f_d$ |  | respiratory coefficient | \\\.com |
| $s_2$ |  | Critical temperature of high temperature suppression | \K.L.A.[K.R.I.E.D.] |
| $s_4$ |  | Critical temperature of cryogenic suppression | \K.L.A.[K.R.I.E.D.] |

### External parameters given by the table for each soil type

The external parameters given by the table for each land cover are as follows.

| Header0 | Header1 | Header2 | Header3 |
| ------- | ------- | ------- | ------- |
| $c_{g(k)}$ | ($k=1,\ldots,K_g$) | Specific Heat of Soil | \The "\brahammer"[J/m$^3$147] |
| $k_{g(k)}$ | ($k=1,\ldots,K_g$) | Thermal Conductivity of Soil | \The state of affairs in the event of a race is incompatible with the state of the art. |
| $w_{sat(k)}$ | ($k=1,\ldots,K_g$) | Soil Porosity | \The state of affairs of the company [m$^3$/m$^3$] |
| $K_{s(k)}$ | ($k=1,\ldots,K_g$) | Saturated Permeability of Soil | \The "m/score |
| $\psi_{s(k)}$ | ($k=1,\ldots,K_g$) | Soil Saturation Moisture Potential | \\0.25\\0.25\0.25\0.25\0.25\0.25\0.25\0.00}. |
| $b_{(k)}$ | ($k=1,\ldots,K_g$) | Index of Soil Moisture Potential Curve | \\\.com |

