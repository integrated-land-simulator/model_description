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


# 8 Snow

 The snow water equivalent, snow temperature, and snow albedo are calculated here.

## 8.1 Snow cover fraction
(Nitta et al., 2014)

The snow water equivalent (SWE) is calculated as
$$ \frac{d\mathrm{Sn}}{dt} = P\_{\mathrm{Sn}}^{\*} - E\_s^{(\mathrm{Sn})} - M\_{\mathrm{Sn}} + F\_R, $$
where $\mathrm{Sn}$ is the SWE, $P\_{\mathrm{Sn}}^{\*}$ is the snowfall that goes through or drops from the canopy layer, $E\_s^{(\mathrm{Sn})}$ is the snow sublimation, $M\_{\mathrm{Sn}}$ is snowmelt, and $F\_R$ is the refreezing of rainfall and snowmelt.

The snow cover fraction $A\_{\mathrm{Sn}}$ is defined as
$$ A\_{\mathrm{Sn}} = \mathrm{min}\left(\sqrt{\mathrm{Sn} / \mathrm{Sn}\_{\mathrm{max}}}, \; 1\right) \tag{A2}$$
with the threshold value $\mathrm{Sn}\_{\mathrm{max}} = 120 \; \mathrm{kg \; m^{-2}}$ determining when the whole grid cell is covered with snow. The number of snow layers is determined by the SWE, with a maximum of three.

In the accumulation season, snowfall occured uniformly and the snow cover fraction was assumed to be equal unity. During snowmelt, under the assumption of uniform melt depth $D\_m$, the sum of snow-free and snow-covered fraction equals unity:
$$ \int\_0^{D\_m} f(D)dD + \int\_{D\_m}^\infty f(D)dD = 1, \tag{A4} $$
where $D$ is the snow water equivalent depth and $f(D)$ is the probability distribution function (PDF) of snow water equivalent depth within the grid cell. The snow depth distribution within each grid cell was assumed to follow a lognormal distribution:
$$ f(D) = \frac{1}{D\zeta\sqrt{2}} \exp{ \left[ -\frac{1}{2} {\left( \frac{\ln(D)-\lambda}{\zeta} \right)}^2 \right] }, \tag{A5} $$
where
$$ \lambda = \ln(\mu) - \frac{1}{2}\zeta^2 \tag{A6} $$
and
$$ \zeta^2 = \ln(1+\mathrm{CV}). \tag{A7} $$
Here $\mathrm{CV}$ is the coefficient of variation and $\mu$ is the accumulated snowfall.
The snow cover fraction $A\_{\mathrm{Sn}}(D\_m)$ is represented as
$$ A\_{\mathrm{Sn}}(D\_m) = 1 - \int\_0^{D\_m} f(D)dD. \tag{A8} $$
Then, the grid-averaged SWE is represented as
$$ \mathrm{Sn}(D\_m) = \int\_0^{D\_m} 0[f(D)]dD + \int\_{D\_m}^\infty (D-D\_m)[f(D)]dD. \tag{A9} $$
Equations (A8) and (A9) can be solved analytically by deformation.


(Tatebe et al., 2019)

A physically based parameterization of sub-grid snow distribution (SSNOWD; Liston, 2004; Nitta et al., 2014) replaces the simple functional approach of snow water equivalent in calculating sub-grid snow fractions in MIROC5 in order to improve the seasonal cycle of snow cover.

In SSNOWD, the snow cover fraction is formulated for accumulation and ablation seasons separately. For the ablation season, the snow cover fraction decreases based on the sub-grid distribution of the SWE. A lognormal distribution function is assumed and the coefficient of variation category is diagnosed from the standard deviation of the subgrid topography, coldness index, and vegetation type that is a proxy for surface winds. While the cold degree month was adopted for coldness in the original SSNOWD, we decided intead to introduce the annually averaged temperature over tha latest 30 years using the time relaxation method of Krinner et al. (2005), in which the timescale parameter is set to 16 years. The temperature threshold for a category diagnosis is set to 0 and 10 °C. In addition, a scheme representing a snow-fed wetland that takes into consideration sub-grid terrain complexity (Nitta et al., 2017) is incorporated.

(new)

The snow water equivalent (SWE) is calculated as
$$ \frac{d\mathrm{Sn}}{dt} = P\_{\mathrm{Sn}}^{\*} - E\_s^{(\mathrm{Sn})} - M\_{\mathrm{Sn}} + F\_R, $$
where $\mathrm{Sn}$ is the SWE, $P\_{\mathrm{Sn}}^{\*}$ is the snowfall that goes through or drops from the canopy layer, $E\_s^{(\mathrm{Sn})}$ is the snow sublimation, $M\_{\mathrm{Sn}}$ is snowmelt, and $F\_R$ is the refreezing of rainfall and snowmelt.

The snow cover fraction $A\_{\mathrm{Sn}}$ is defined as
$$ A\_{\mathrm{Sn}} = \mathrm{min}\left(\sqrt{\mathrm{Sn} / \mathrm{Sn}\_{\mathrm{max}}}, \; 1\right) \tag{A2}$$
with the threshold value $\mathrm{Sn}\_{\mathrm{max}} = 120 \; \mathrm{kg \; m^{-2}}$ determining when the whole grid cell is covered with snow. The number of snow layers is determined by the SWE, with a maximum of three.

A physically based parameterization of sub-grid snow distribution (SSNOWD; Liston, 2004; Nitta et al., 2014) replaces the simple functional approach of snow water equivalent in calculating sub-grid snow fractions in MIROC5 in order to improve the seasonal cycle of snow cover.

In SSNOWD, the snow cover fraction is formulated for accumulation and ablation seasons separately.
For the accumulation season, snowfall occures uniformly and the snow cover fraction is assumed to be equal in the grid cell.
For the ablation season, the snow cover fraction decreases based on the sub-grid distribution of the SWE. Under the assumption of uniform melt depth $D\_m$, the sum of snow-free and snow-covered fraction equals unity:
$$ \int\_0^{D\_m} f(D)dD + \int\_{D\_m}^\infty f(D)dD = 1, \tag{A4} $$
where $D$ is the SWE depth and $f(D)$ is the probability distribution function (PDF) of SWE depth within the grid cell. The snow depth distribution within each grid cell is assumed to follow a lognormal distribution:
$$ f(D) = \frac{1}{D\zeta\sqrt{2}} \exp{ \left[ -\frac{1}{2} {\left( \frac{\ln(D)-\lambda}{\zeta} \right)}^2 \right] }, \tag{A5} $$
where
$$ \lambda = \ln(\mu) - \frac{1}{2}\zeta^2 \tag{A6} $$
and
$$ \zeta^2 = \ln(1+\mathrm{CV}^2). \tag{A7} $$
Here $\mu$ is the accumulated snowfall and $\mathrm{CV}$ is the coefficient of variation. $\mathrm{CV}$ is diagnosed from the standard deviation of the subgrid topography, coldness index and vegetation type that is a proxy for surface winds. 
The snow cover fraction $A\_{\mathrm{Sn}}(D\_m)$ is represented as 
$$ A\_{\mathrm{Sn}}(D\_m) = 1 - \int\_0^{D\_m} f(D)dD. \tag{A8} $$
Then, the grid-averaged SWE is represented as
$$ \mathrm{Sn}(D\_m) = \int\_0^{D\_m} 0[f(D)]dD + \int\_{D\_m}^\infty (D-D\_m)[f(D)]dD. \tag{A9} $$
Equations (A8) and (A9) can be solved analytically by deformation.

While the cold degree month was adopted for coldness in the original SSNOWD, we decided intead to introduce the annually averaged temperature over tha latest 30 years using the time relaxation method of Krinner et al. (2005), in which the timescale parameter is set to 16 years. The temperature threshold for a category diagnosis is set to 0 and 10 °C. In addition, a scheme representing a snow-fed wetland that takes into consideration sub-grid terrain complexity (Nitta et al., 2017) is incorporated.

Also, the computational flow that diagnoses the snow cover fraction was slightly modified. In the original SSNOWD model, the accumulated melt depth $D\_m$ and the accumulated snowfall $\mu$ are predicted in the host atmospheric or hydrological models by summing the snow accumulation and the snowmelt rates simulated by the host model. However, this produces some differences between the SWE calculated from MATSIRO and SSNOWD, because the original SSNOWD does not account for the amount of snow that completely melts during the time step. Therefore, in the latest version of MATSIRO, $D\_m$ is calculated from Eq.(A9) and $\mathrm{Sn}$ using Newton-Raphson methods. Then, the snow cover fraction is calculated from Eq.(A8) and $D\_m$. This modification was introduced to avoid physical inconsistency between the two methods.

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
 Sn^{\tau+1} = Sn^{\*\*\*} + P_{Sn}^* \Delta t_L
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

## 8.7 [Old] Calculation of snow albedo

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


## 8.7 [New] Snow and ice albedo
(Watanabe et al., 2010)

The effect of snow aging on surface albedo is considered following Yang et al. (1997). Among the three coefficients that affect the increment in the nondimensional age of snow, the one representing the effect of dirt increases according to its concentration in the surface snow layer. This mimics the observed relation between snow albedo and dirt concentration (Aoki et al., 2006). The dirt concentration is calculated from the decomposition fluxes of dust and soot in SPRINTARS. Since the absorption coefficients of dust and soot are very different, the deposition fluxes are multiplied by their relatice weights.

The previous version of MATSIRO assumed constant values for the surface albedo over an ice sheet. This has been changed in the present version following Bougamont et al. (2005), who proposed that the ice sheet albedo be expressed as a function of the water content above the ice. This scheme is applicable for both visible and near infrared radiation, with a fixed value of 0.05 begin used for the infrared band.


(Nitta et al., 2014)

The snow albedo $\alpha_{b}$ is calculated as
$$ \alpha_{b} = \alpha_{b,\mathrm{new}} \frac{A_{g}}{1+A_{g}}(\alpha_{b,\mathrm{new}}-\alpha_{b,\mathrm{old}}), \tag{A3} $$
where $\alpha_{b,\mathrm{new}}$ is the albedo of newly fallen snow for band $b$, $\alpha_{b,\mathrm{old}}$ is the albedo of old snow, and $A_{g}$ is an aging factor from Yang et al. (1997). This factor evolves with time, as a function of snow temperature and the densities of dust and black carbon. We consider the three bands of wavelength, visible (vis), near infrared (nir), and infrared (ifr), and used 0.9, 0.7, 0.01, 0.65, 0.2, and 0.1 for $\alpha_{\mathrm{vis,new}}$, $\alpha_{\mathrm{nir,new}}$, $\alpha_{\mathrm{ifr,new}}$, $\alpha_{\mathrm{vis,old}}$, $\alpha_{\mathrm{nir,old}}$, and $\alpha_{\mathrm{ifr,old}}$, respectively.

