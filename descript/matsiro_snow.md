<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

# 8. Snow

The snow cover fraction, snow water equivalent, snow temperature and snow albedo are calculated here.

Most of the processes are included in SUBROUTINE MATSNW in matsnw.F, but the ice albedo is calculated in SUBROUTINE ICEALB in matice.F.


## 8.1 Diagnosis of snow cover fraction

MATSIRO has two ways of calculation of the snow cover fraction, and the user can switch them with the option OPT\_SSNOWD.

### 8.1.1 Case 1: When OPT\_SSNOWD is active

The snow cover fraction is diagnosed in the SUBROUTINE SSNOWD\_DRV, a driver of a Subgrid SNOW Distribution (SSNOWD) submodel developed by Liston (2004), with a physically based parameterization of sub-grid snow distribution considering various factors such as differences in topography, the time of snowfall or snow melting, etc (Tatebe et al., 2019).

The snow cover fraction is formulated for accumulation and ablation seasons separately. 
For the accumulation season, snowfall occures uniformly and the snow cover fraction is assumed to be equal in the grid cell.
For the ablation season, the snow cover fraction decreases based on the sub-grid distribution of the snow water equivalent. Under the assumption of uniform melt depth $D\_m$, the sum of snow-free and snow-covered fraction equals unity:

$$
\int\_0^{D\_m} f(D)dD + \int\_{D\_m}^\infty f(D)dD = 1,
$$

where $D$ is the snow water equivalent depth and $f(D)$ is the probability distribution function (PDF) of snow water equivalent depth within the grid cell. The snow depth distribution within each grid cell is assumed to follow a lognormal distribution:

$$
f(D) = \frac{1}{D\zeta\sqrt{2\pi}} \exp{ \left[ 
 -\frac{1}{2} {\left( \frac{\ln(D)-\lambda}{\zeta} \right)}^2 
\right] }, \tag{A5}
$$

where

$$
\lambda = \ln(\mu) - \frac{1}{2}\zeta^2
$$

and

$$
\zeta^2 = \ln(1+CV^2). \tag{A7}
$$

Here $\mu$ is the accumulated snowfall and $CV$ is the coefficient of variation. $CV$ is diagnosed from the standard deviation of the subgrid topography, coldness index and vegetation type that is a proxy for surface winds. For coldness index, the annually averaged temperature over the latest 30 years using the time relaxation method of Krinner et al. (2005), in which the timescale parameter is set to 16 years. The temperature threshold for a category diagnosis is set to 0 and 10 $^\circ\mathrm{C}$. 

The snow amount $Sn$ is given by 

$$
Sn(D\_m) = \int\_0^{D\_m} 0[f(D)]dD + \int\_{D\_m}^\infty (D-D\_m)[f(D)]dD,
$$

and this equation is rewritten to

$$
Sn(D\_m) 
 = \frac{1}{2} \exp{\left( \lambda + \frac{\zeta^2}{2} \right)}
 \mathrm{erfc} \left( \frac{z\_{D\_m}-\xi}{\sqrt{2}} \right)
 \- \frac{1}{2} D\_m \mathrm{erfc} \left( \frac{z\_{D\_m}}{\sqrt{2}} \right),
$$

where $\xi = (1-\sqrt{2})z$, $z = \frac{\ln(D)-\lambda}{\zeta}$, $z\_{D\_m}$ is the value of $z$ when $D = D\_m$ and $\mathrm{erfc}$ is the complementary error function.

$D\_m$ is calculated from this equation and the snow amount $Sn$ using Newton-Raphson methods (in SUBROUTINE SSNOWD\_ITR in ssnowd.F).

Then, the snow cover fraction $A\_{Sn}(D\_m)$ is calculated by

$$
A\_{Sn}(D\_m) = 1 - \int\_0^{D\_m} f(D)dD = \frac{1}{2} \mathrm{erfc} \left( \frac{z\_{D\_m}}{2} \right).
$$

### 8.1.2 Case 2: When OPT\_SSNOWD is inactive

The snow cover fraction is diagnosed in SUBROUTINE SNWRAT. The snow cover fraction is formulated as a function of the snow amount $Sn$:

$$
Sn(D\_m) = \min(\sqrt{Sn/Sn\_c}),
$$

where $Sn\_c$ is 100 $\mathrm{kg/m^2}$.


## 8.2 Vertical division of snow layers

In order to express the vertical distribution of the snow temperature, when the snow water equivalent is large, the snow is divided into multiple layers and the temperature is defined in each layer. The number of snow layers can be varied, with the number of layers increasing as the snow water equivalent becomes larger. A minimum of one layer and a maximum of three layers are set as a standard.

The number of layers and the mass of each layer are determined uniquely by the snow water equivalent. Consequently, the mass of each layer does not become a new prognostic variable.

As a standard, the mass of each layer ($\Delta {\widetilde{Sn}}\_{(k)} (k=1,2,3)$) is determined as follows ($k=1$ is the uppermost layer):

$$
\begin{aligned}
\widetilde{Sn}\_{(1)} &= \left\\{
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
\widetilde{Sn}\_{(2)} &= \left\\{
\begin{array}{ll}
 0 \\
 \widetilde{Sn} - \Delta Sn\_{(1)} \\
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
\widetilde{Sn}\_{(3)} &= \left\\{
\begin{array}{ll}
 0 \\
 \widetilde{Sn} - (\Delta Sn\_{(1)} + \Delta Sn\_{(2)})
\end{array}
\begin{array}{ll}
 (\widetilde{Sn} < 60) \\
 (\widetilde{Sn} \geq 60)
\end{array}
\right.
\end{aligned}
$$

where

$$
 \widetilde{Sn} =  Sn / A\_{Sn}
$$

 $Sn$ is the grid-mean snow water equivalent, and $\widetilde{Sn}$ is the snow water equivalent in the snow-covered portion. Note that the mass of each layer ($\Delta {\widetilde{Sn}}\_{(k)}$) is also the value of the snow-covered portion, not the grid-mean value. The unit is kg/m^2^.

From the above, it can be clearly seen that the number of snow layers ($K\_{Sn}$) is as follows, as a standard:

$$
 K\_{Sn} = \left\\{
\begin{array}{ll}
 0 \;\; (\widetilde{Sn} = 0)\\
 1 \;\; (0< \widetilde{Sn} < 20)\\
 2 \;\; (20 \leq \widetilde{Sn} < 60)\\
 3 \;\; (\widetilde{Sn} \geq 60)
\end{array}
\right.
$$

## 8.3 Calculation of snow water equivalent

The prognostic equation of the snow water equivalent is given by

$$
 \frac{Sn^{\tau+1}-Sn^{\tau}}{\Delta t\_L} = P\_{Sn}^{\*} - E\_{Sn} - M\_{Sn} + Fr\_{Sn}
$$

where $P\_{Sn}^{\*}$ is the snowfall flux after interception by the canopy, $E\_{Sn}$ is the sublimation flux, $M\_{Sn}$ is the snowmelt, and $Fr\_{Sn}$ is the refreeze of snowmelt or the freeze of rainfall.

### 8.3.1 Sublimation of snow

First, by subtracting the sublimation, the snow water equivalent is partially updated:

$$
 Sn^{\*} = Sn^{\tau} - E\_{Sn} \Delta t\_L \\
 \Delta \widetilde{Sn}\_{(1)}^{\*} = \Delta \widetilde{Sn}\_{(1)}^{\tau} - E\_{Sn}/A\_{Sn} \Delta t\_L
$$

In a case where the sublimation is larger than the snow water equivalent in the uppermost layer, the remaining amount is subtracted from the layer below. If the amount in the second layer is insufficient for such subtraction, the remaining amount is subtracted from the layer below that.

### 8.3.2 Snowmelt

Next, the snow heat conduction is calculated to solve the snowmelt. The method of calculating the snow heat conduction is described later. The updated snow temperature incorporating the heat conduction is assumed to be $T\_{Sn(k)}^{\*}$. When the temperature is calculated and the temperature of the uppermost snow layer becomes higher than $T\_{melt} = 0 ^\circ\mathrm{C}$, the temperature of the uppermost layer is fixed at $T\_{melt}$ and the calculation is performed again. In this case, the energy convergence $\Delta \widetilde{F}\_{conv}$ in the uppermost layer is calculated. This is not the grid-mean value but the value of the snow-covered portion. The snowmelt in the uppermost layer is

$$
 \widetilde{M}\_{Sn(1)} = \min(\Delta \widetilde{F}\_{conv} / l\_m, \Delta \widetilde{Sn}\_{(1)}^{\*}/\Delta t\_L ) \tag{eq220}
$$

With regard to the second layer and below, if the temperature is higher than $T\_{melt}$, it is put back to $T\_{melt}$ and the internal energy of that temperature change portion is applied to the snowmelt. That is, it is assumed to be

$$
T\_{Sn(k)}^{\*\*} = T\_{melt}
$$

$\Delta \widetilde{F}\_{conv}$ is newly defined by

$$
\Delta \widetilde{F}\_{conv} = ( T\_{Sn\_{(k)}}^{\*} - T\_{melt} ) c\_{pi}\Delta \widetilde{Sn}\_{(k)}^{\*}/\Delta t\_L
$$

and the snowmelt is solved as in [Eq. (220)](#eq220).

By subtracting the snowmelt, the mass of each layer is updated:

$$
\Delta \widetilde{Sn}\_{(k)}^{\*\*} = \Delta \widetilde{Sn}\_{(k)}^{\*} - \widetilde{M}\_{Sn\_{(k)}}
$$


During these calculations, when a certain layer is fully melted, the remaining amount of $\Delta \widetilde{F}\_{conv}$ is given to the layer below to raise the temperature in that layer; that is,

$$
\Delta \widetilde{F}\_{conv}^{\*} = \Delta \widetilde{F}\_{conv} - l\_m \widetilde{M}\_{Sn\_{(k)}}
$$

$$
T\_{Sn\_{(k+1)}}^{\*\*} = T_{Sn\_{(k+1)}}^{\*} + \Delta \widetilde{F}\_{conv}^{\*} / (c\_{pi} \Delta \widetilde{Sn}\_{(k+1)}^{\*}) \Delta t\_L
$$

where $c\_{pi}$ is the specific heat of snow (ice). When all of the snow is melted, $\Delta \widetilde{F}\_{conv}^{\*}$ is given to the soil.

The snowmelt of the overall snow is the sum of the snowmelt in each layer (note, however, that it is the grid-mean value):

$$
 M\_{Sn} = \sum\_{k=1}^{K\_{Sn}} \widetilde{M}\_{Sn(k)} A\_{Sn}
$$

By subtracting the snowmelt, the snow water equivalent is partially updated:

$$
 Sn^{\*\*} = Sn^{\*} - M\_{Sn} \Delta t\_L
$$

### 8.3.3 Freeze of snowmelt water and rainfall in snow

The freeze of snowmelt water and rainfall in the snow is calculated next. With regard to the snowmelt water, consideration is given to the effect of the liquid water produced by the snowmelt in the upper layer refreezing in the lower layer. The retention of liquid water content in the snow is not considered, and the entire amount is treated whether it has frozen in the snow or percolated under the snow.

The liquid water flux at the snow upper boundary in the snow-covered portion is

$$
 \widetilde{F}\_{wSn(1)} = Pr\_c^{\*} + Pr\_l^{\*} + M\_{Sn} / A\_{Sn}
$$

Here, the melted portion in the second layer of the snow and below is also assumed to have percolated from the snow upper boundary (in actuality, snowmelt in the second layer or below rarely occurs).

It is reasonable to assume the temperature of the snowmelt water as 0 $^\circ\mathrm{C}$, and the temperature of rainfall on the snow is also assumed to be 0 $^\circ\mathrm{C}$ for convenience. The temperature of the snow increases due to the latent heat of the freezing of water; however, when the temperature of the snow in a certain layer is increased to 0 $^\circ\mathrm{C}$, any additional water is assumed to be unable to freeze and to percolate to the layer below. In addition, an upper limit is set on the ratio of water that can be frozen compared with the mass of snow in the layer. The amount of freeze in a given layer$\widetilde{Fr}\_{Sn(k)}$ is solved by

$$
\widetilde{Fr}\_{Sn\_{(k)}} = \min\left(
\widetilde{F}\_{w\_{Sn\_{(k)}}}, \
\frac{c\_{pi}(T\_{melt}-T\_{Sn\_{(k)}}^{\*\*})}{l\_m} \
\frac{\Delta \widetilde{Sn}\_{(k)}^{\*\*}}{\Delta t\_L} , \
f\_{Fmax}\frac{\Delta \widetilde{Sn}\_{(k)}^{\*\*}}{\Delta t\_L} \
\right)
$$

where $F\_{w\_{Sn\_{(k)}}}$ is the liquid water flux percolated from the upper boundary of the $k$th layer of the snow. $\widetilde{F}\_{w\_{Sn\_{(k)}}}$ is the liquid water flux flowing from the top of the $k$th layer of snow cover. $f\_{Fmax}$ is assumed to be 0.1 as a standard value.

The snow temperature change is updated by

$$
T\_{Sn\_{(k)}}^{\*\*\*} = \frac{l\_m \widetilde{Fr}\_{Sn\_{(k)}}\Delta t\_L
 \+ c\_{pi}(T\_{Sn\_{(k)}}^{\*\*}\Delta \widetilde{Sn}\_{(k)}^{\*\*} 
 \+ T\_{melt} \widetilde{Fr}\_{Sn\_{(k)}}\Delta t\_L)}
 {c\_{pi}(\Delta \widetilde{Sn}\_{(k)}^{\*\*} + \widetilde{Fr}\_{Sn\_{(k)}}\Delta t\_L)},
$$

and the mass is updated as follows:

$$
 \Delta \widetilde{Sn}\_{(k)}^{\*\*\*} = \Delta \widetilde{Sn}\_{(k)}^{\*\*} + \widetilde{Fr}\_{Sn\_{(k)}}\Delta t\_L.
$$

The amount of freeze in the overall snow is the sum of the amounts of freeze in each layer (note, however, that it is the grid-mean value):

$$
 Fr\_{Sn} = \sum\_{k=1}^{K\_{Sn}} \widetilde{Fr}\_{Sn\_{(k)}} A\_{Sn}.
$$


By adding the amount of freeze, the snow water equivalent is partially updated as follows:

$$
 Sn^{\*\*\*} = Sn^{\*\*} + Fr\_{Sn} \Delta t\_L.
$$

The liquid water that has percolated from the snow to the lower boundary is given to the soil.

### 8.3.4 Snowfall

Lastly, by adding the snowfall after interception by the canopy, the finally updated snow water equivalent is obtained:

$$
 Sn^{\tau+1} = Sn^{\*\*\*} + P\_{Sn}^{\*} \Delta t\_L
$$

However, when the temperature of the uppermost soil layer is 0 $^\circ\mathrm{C}$ or more, the snowfall is assumed to melt on the ground. In this case, the energy of the latent heat of melting is taken from the soil.

When snow is produced by snowfall in a grid where no snow was formerly present, the snow-covered ratio ($A\_{Sn}$) is newly diagnosed by [Eq. (210)](#eq210) and the snow temperature ($T\_{Sn(1)}$) is assumed to be equal to the temperature of the uppermost soil layer.

The snowfall is added to the mass of the uppermost layer:

$$
 \Delta \widetilde{Sn}\_{(k)}^{\tau+1} = \Delta \widetilde{Sn}\_{(k)}^{\*\*\*} + P\_{Sn}^{\*} \Delta t\_L /A\_{Sn}.
$$

### 8.3.5 Redivision of snow layer and rediagnosis of temperature

When the snow water equivalent is updated, the snow-covered ratio is rediagnosed by [Eq. (210)](#eq210) and the mass of each layer is redivided by [Eq. (212) to (214)](#eq212). The temperature in each redivided layer is rediagnosed so that the energy is conserved as follows:

$$
T\_{Sn\_{(k)}}^{\mathrm{new}} = \left(
 \sum\_{l=1}^{K\_{Sn}^{\mathrm{old}}} 
 f\_{(l^{\mathrm{old}}\in k^{\mathrm{new}})} T\_{Sn(l)}^{\mathrm{old}} 
 \Delta \widetilde{Sn}\_{(l)}^{\mathrm{old}} A\_{Sn}^{\mathrm{old}} 
\right) \Bigm/ (\Delta \widetilde{Sn}\_{(k)}^{\mathrm{new}} A\_{Sn}^{\mathrm{new}}).
$$

It should be noted that the variables with the index "old" and "new" are those before and after redivision, respectively. $f\_{(l^{\mathrm{old}}\in k^{\mathrm{new}})}$ is the ratio of the mass of the $k$th layer after redivision to the mass of the $l$th layer before redivision.


## 8.4 Calculation of snow heat conduction

### 8.4.1 Snow heat conduction equations

The prognostic equation of the snow temperature due to snow heat conduction is as follows:

$$
c\_{pi}\Delta \widetilde{Sn}\_{(k)} \frac{T\_{Sn(k)}^{\*} - T\_{Sn(k)}^{\tau}}{\Delta t\_L} = \widetilde{F}\_{Sn(k+1/2)} - \widetilde{F}\_{Sn(k-1/2)}
\qquad (k=1,\ldots,K\_{Sn}) \tag{eq237}
$$

with the heat conduction flux $\widetilde{F}\_{Sn}$ given by

$$
\widetilde{F}\_{Sn(k+1/2)}
 = \left\\{
 \begin{aligned}
  & (F\_{Sn(1/2)} - \Delta F\_{conv}) / A\_{Sn} - \Delta F\_{c,conv} 
  \; &&(k = 0) \\
  & k\_{Sn(k+1/2)} \frac{T\_{Sn(k+1)}-T\_{Sn(k)}}{\Delta z\_{Sn(k+1/2)}}
  \; &&(k = 1, ..., K\_{Sn}-1) \\
  & k\_{Sn(k+1/2)} \frac{T\_{Sn(B)}-T\_{Sn(k)}}{\Delta z\_{Sn(k+1/2)}}
  \; &&(k = K\_{Sn})
 \end{aligned}
\right.,
$$

where $k\_{Sn(k+1/2)}$  is the snow heat conductivity, assigned the fixed value of 0.3 W/m/K as a standard. $\Delta z\_{Sn(k+1/2)}$ is the thickness of each snow layer, defined by


$$
\Delta z\_{Sn(k+1/2)}
 = \left\\{
 \begin{aligned}
  & 0.5 \Delta \widetilde{Sn}\_{(1)} / \rho\_{Sn} 
  \; &&(k = 1) \\
  & 0.5 (\Delta \widetilde{Sn}\_{(k)} + \Delta \widetilde{Sn}\_{(k+1)}) / \rho\_{Sn} 
  \; &&(k = 2, ..., K\_{Sn}-1) \\
  & 0.5 \Delta \widetilde{Sn}\_{(K\_{Sn})} / \rho\_{Sn}
  \; &&(k = K\_{Sn})
 \end{aligned}
\right.
$$

where $\rho\_{Sn}$ is the snow density, assigned the fixed value of $300 \mathrm{kg/m^3}$ as a standard. The snow density and heat conductivity are considered to change with the passage of time due to compaction and changes in properties (aging), but the effect of such changes is not considered here.

In [Eq. (238)](#eq238), the snow upper boundary flux $\widetilde{F}\_{Sn(1/2)}$ is given using the heat conduction flux from the snow to the ground surface solved in the ground surface energy balance $F\_{Sn(1/2)}$, the ground surface energy convergence produced when the ground surface temperature is solved by the snowmelt condition $\Delta F\_{conv}$, and the energy correction produced when a change has occurred in the phase of the canopy water $\Delta F\_{c,conv}$. $\Delta F\_{conv}$ is assumed to be given only to the snow-covered portion, while $\Delta F\_{c,conv}$ is given uniformly to the grid cells. Since the sign of the flux is taken as upward positive, the convergence has a negative sign.

In the equation for the snow lower boundary flux $\widetilde{F}\_{Sn\_{(K\_{Sn}+1/2)}}$, $T\_{Sn\_{(B)}}$ is the temperature of the snow lower boundary (the boundary surface of the snow and the soil). However, since the flux from the uppermost soil layer to the snow lower boundary is

$$
\widetilde{F}\_{g(1/2)} = k\_{g(1/2)} \frac{T\_{g(1)}-T\_{Sn\_{(B)}}}{\Delta z\_{g(1/2)}}
$$

there is assumed to be no convergence at the snow lower boundary, and by putting


$$
\widetilde{F}\_{Sn\_{(K\_{Sn}+1/2)}} = \widetilde{F}\_{g(1/2)}
$$

$T\_{Sn\_{(B)}}$ is solved. When this is substituted into [Eq. (242)](#eq242), the following is obtained:

$$
\widetilde{F}\_{Sn\_{(K\_{Sn}+1/2)}} 
 = \left[ \frac{\Delta z\_{g(1/2)}}{k\_{g(1/2)}}
  +\frac{\Delta z\_{Sn\_{(K\_{Sn}+1/2)}}}{k\_{Sn\_{(K\_{Sn}+1/2)}}}
 \right]^{-1}
 (T\_{g(1)} - T\_{Sn\_{(K\_{Sn})}}) \tag{eq242}
$$

### 8.4.2 Case 1: When snowmelt does not occur in the uppermost layer

The implicit method is used to treat the temperature from the uppermost snow layer to the lowest snow layer, as follows:

$$
\widetilde{F}\_{Sn\_{(k+1/2)}}^{\*} 
 = \widetilde{F}\_{Sn\_{(k+1/2)}}^{\tau}
 \+ \frac{\partial \widetilde{F}\_{Sn\_{(k+1/2)}}}{\partial T\_{Sn\_{(k)}}} \Delta T\_{Sn\_{(k)}}
 \+ \frac{\partial \widetilde{F}\_{Sn\_{(k+1/2)}}}{\partial T\_{Sn\_{(k+1)}}} \Delta T\_{Sn\_{(k+1)}}
$$

$$
\widetilde{F}\_{Sn\_{(k+1/2)}}^{\tau}
 = \left\\{ \begin{aligned}
 & (F\_{Sn\_{(1/2)}} - \Delta F\_{conv}) / A\_{Sn} - \Delta F\_{c,conv}
 \; &&(k = 0) \\
 & \frac{k\_{Sn\_{(k+1/2)}}}{\Delta z\_{Sn(k+1/2)}} (T\_{Sn(k+1)}^\tau - T\_{Sn(k)}^\tau)
 \; &&(k = 1, ..., K\_{Sn}-1) \\
 & \left[
  \frac{\Delta z\_{g(1/2)}}{k\_{g(1/2)}}
  \+ \frac{\Delta z\_{Sn\_{(K\_{Sn}+1/2)}}}{k\_{Sn\_{(K\_{Sn}+1/2)}}}
 \right]^{-1} (T\_{g(1)} - T\_{Sn\_{(K\_{Sn})}}^\tau)
 \; &&(k = K\_{Sn})
\end{aligned} \right.
$$

$$
\frac{\partial \widetilde{F}\_{Sn\_{(k+1/2)}}}{\partial T\_{Sn\_{(k)}}}
 = \left\\{ \begin{aligned}
 & \-\frac{k\_{Sn\_{(k+1/2)}}}{\Delta z\_{Sn\_{(k+1/2)}}}
 \; &&(k = 1, ..., K\_{Sn}-1) \\
 & \-\left[ \frac{\Delta z\_{g(1/2)}}{k\_{g(1/2)}} 
  \+ \frac{\Delta z\_{Sn\_{(K\_{Sn}+1/2)}}}{k\_{Sn\_{(K\_{Sn}+1/2}}}
 \right]^{-1}
 \; &&(k = K\_{Sn})
\end{aligned} \right.
$$


$$
\frac{\partial\widetilde{F}\_{Sn\_{(k+1/2)}}}{\partial T\_{Sn\_{(k+1)}}}
 = \left\\{ \begin{aligned}
 & 0
 \; &&(k = 0) \\
 & \frac{k\_{Sn\_{(k+1/2)}}}{\Delta z\_{Sn\_{k+1/2)}}}
 \; &&(k = 1, ..., K\_{Sn}-1)
\end{aligned} \right.
$$

and [Eq. (237)](#eq237) is treated as

$$
\begin{aligned}
 c\_{pi}\Delta \widetilde{Sn}\_{(k)} \frac{\Delta T\_{Sn\_{(k)}}}{\Delta t\_L}
 &= &&\widetilde{F}\_{Sn\_{(k+1/2)}}^{\*} - \widetilde{F}\_{Sn\_{(k-1/2)}}^{\*} \\
 &= &&\widetilde{F}\_{Sn\_{(k+1/2)}}^{\tau}
  \+ \frac{\partial \widetilde{F}\_{Sn\_{(k+1/2)}}}{\partial T\_{Sn\_{(k)}}}   \Delta T\_{Sn\_{(k)}}
  \+ \frac{\partial \widetilde{F}\_{Sn\_{(k+1/2)}}}{\partial T\_{Sn\_{(k+1)}}} \Delta T\_{Sn\_{(k+1)}} \\
 & &&\- \widetilde{F}\_{Sn\_{(k-1/2)}}^{\tau}
  \- \frac{\partial \widetilde{F}\_{Sn\_{(k-1/2)}}}{\partial T\_{Sn\_{(k-1)}}} \Delta T\_{Sn\_{(k-1)}}
  \- \frac{\partial \widetilde{F}\_{Sn\_{(k-1/2)}}}{\partial T\_{Sn\_{(k)}}}   \Delta T\_{Sn\_{(k)}}
\end{aligned}
$$


and solved by the LU factorization method as $\Delta T\_{Sn\_{(k)}}\ (k = 1, ..., K\_{Sn})$ simultaneous equations with respect to $K\_{Sn}$. At this juncture, it should be noted that the flux at the snow upper boundary is fixed as the boundary condition, the snow lower boundary condition is the temperature in the uppermost soil layer, and the snow lower boundary flux is treated explicitly with regard to the temperature of the uppermost soil layer. The snow temperature is partially updated by


$$
 T\_{Sn\_{(k)}}^{\*} = T\_{Sn\_{(k)}}^{\tau} + \Delta T\_{Sn\_{(k)}}
$$

### 8.4.3 Case 2: When snowmelt occurs in the uppermost layer

When the temperature of the uppermost snow layer solved in case 1 is higher than 0degC, snowmelt occurs in the uppermost snow layer. In this case, the temperature of the uppermost snow layer is fixed at 0 $^\circ\mathrm{C}$. The flux from the second snow layer to the uppermost snow layer is then expressed as

$$
\widetilde{F}\_{3/2}^{\*}
 = \frac{k\_{Sn\_{(3/2)}}}{\Delta z\_{Sn\_{(3/2)}}} (T\_{Sn\_{(2)}}^{\tau} - T\_{melt})
 +\frac{\partial \widetilde{F}\_{Sn\_{(3/2)}}}{\partial T\_{Sn\_{(2)}}}
 \Delta T\_{Sn\_{(2)}}
$$

and solved similarly to case 1 (when there is only one snow layer, the snow temperature is similarly fixed in the flux from the soil to the snow).

The energy convergence used for melting in the uppermost snow layer is given by:

$$
\Delta \widetilde{F}\_{conv} 
 = (\widetilde{F}\_{3/2}^{\*} - \widetilde{F}\_{1/2})
 \- c\_{pi}\Delta \widetilde{Sn}\_{(1)} \frac{T\_{melt}-T\_{Sn\_{(1)}}^{\*}}{\Delta t\_L}
$$

Even if the temperature of the second snow layer and below is higher than $T\_{melt}$, the calculation is not iterated and the snowmelt is corrected accordingly.


## 8.5 Fluxes given to the soil or the runoff process

The heat flux given to the soil through the snow process is

$$
\Delta F\_{conv}^{\*} 
 = A\_{Sn} (\Delta\widetilde{F}\_{conv}^{\*} - \widetilde{F}\_{Sn\_{K\_{Sn}}}) - l\_m P\_{Sn,melt}^{\*},
$$

where $\Delta\widetilde{F}\_{conv}^{\*}$ is the energy convergence remaining when all of the snow has melted, $\widetilde{F}\_{Sn\_{K\_{Sn}}}$ is the heat conduction flux at the lowest snow layer, and $P\_{Sn,melt}^{\*}$ is the snowfall that melts immediately when it reaches the ground.

Since the energy of the snow-free portion is given to the soil as it is, the energy correction term due to the phase change of the canopy water is as follows:

$$
 \Delta F\_{c,conv}^{\*} = (1 - A\_{Sn}) \Delta F\_{c,conv}.
$$


The water flux given to the runoff process through the snow process is then expressed as

$$
\begin{aligned}
 Pr\_c^{\*\*} &= ( 1 - A\_{Sn} ) Pr\_c^{\*} \\
 Pr\_l^{\*\*} &= ( 1 - A\_{Sn} ) Pr\_l^{\*} + A\_{Sn} \widetilde{F}\_{wSn}^{\*} + P\_{Sn,melt}^{\*},
\end{aligned}
$$

where $\widetilde{F}\_{wSn}^{\*}$ is the flux of the rainfall or snowmelt water that has percolated through the lowest snow layer.


## 8.6 Glacier formation

In this case, the maximum value is set for the snow water equivalent, and the portion exceeding the maximum value is considered to become glacier runoff:


$$
\begin{aligned}
 Ro\_{gl} &= \max(Sn - Sn\_{\mathrm{max}}, 0) / \Delta t\_L, \\
 Sn &= Sn - Ro\_{gl} \Delta t\_L, \\
 \Delta \widetilde{Sn}\_{(K\_{Sn})} &= \Delta \widetilde{Sn}\_{(K\_{Sn})} - Ro\_{gl} / A\_{Sn} \Delta t\_L,
\end{aligned}
$$

where $Ro\_{gl}$ is the glacier runoff. The mass of this portion is subtracted from the lowest snow layer. $Sn\_{\max}$ is uniformly assigned the value of $1000 \mathrm{kg/m^2}$ as a standard.



## 8.7 Dust in snow

The amount of dust on the snow cover and in the snow layers are calculated.


### 8.7.1 Dust fall on the snow cover

The dust fall is added to the top layer:

$$
M\_{d(1)}^{\tau+1} = M\_{d(1)}^{\tau} + D,
$$

where $M\_{d(k)}$ is the amount of snow on the $k$th layer and $D$ is the dust fall.


### 8.7.2 Redistribution of dust

The amount of dust in each layer is calculated in SUBROUTINE DSTCUT based on the results of snow layer recutting (SUBROUTINE SNWCUT).

Snow mass of $k$th layer after updating of snow mass and before snow layer recutting $Sn^{\tau+1/2}\_{(k)}$ is calculated in

$$
Sn^{\tau+1/2}\_{(k)} = Sn^{\tau}\_{(k)} A\_{Sn}^{\tau} / A\_{Sn}^{\tau+1} \;\; (k = 1, 2, 3),
$$

where $\tau$ and $\tau+1$ represent before and after recutting of snow layer, respectively.

When $Sn^{\tau+1}\_{(1)} > Sn^{\tau+1/2}\_{(1)}$, the amount of dust in the 1st layer increases due to increase in the snow mass in this layer. This is calculated as

$$
M\_{d(1)}^{\tau+1} - M\_{d(1)}^{\tau}
 = \left\\{ \begin{aligned}
 & \rho\_{d(2)} Sn^{\tau+1/2}\_{(2)} 
 \+ \rho\_{d(3)} \left( Sn^{\tau+1}\_{(1)} - Sn^{\tau+1/2}\_{(1)} - Sn^{\tau+1/2}\_{(2)} \right) 
 \; && \left( Sn^{\tau+1}\_{(1)} - Sn^{\tau+1/2}\_{(1)} > Sn^{\tau+1/2}\_{(2)} \right) \\
 & \rho\_{d(2)} \left( Sn^{\tau+1}\_{(1)} - Sn^{\tau+1/2}\_{(1)} \right)
 \; && \left( Sn^{\tau+1}\_{(1)} - Sn^{\tau+1/2}\_{(1)} \leq Sn^{\tau+1/2}\_{(2)} \right)
\end{aligned} \right.,
$$

where $\rho\_{d(k)}$ is the density of dust in the $k$th layer.

When $Sn^{\tau+1}\_{(1)} \leq Sn^{\tau+1/2}\_{(1)}$, the amount of dust in the 1st layer decreases, and thus

$$
M\_{d(1)}^{\tau+1} - M\_{d(1)}^{\tau}
 = -\rho\_{d(1)} \left( Sn^{\tau+1/2}\_{(1)} - Sn^{\tau+1}\_{(1)} \right).
$$

It leads to 

$$
M\_{d(1)}^{\tau+1} - M\_{d(1)}^{\tau} = \Delta M\_{d(1)}^{+} - \Delta M\_{d(1)}^{-},
$$

where

$$
M\_{d(1)}^{+}
 = \rho\_{d(2)} \min\left( \max\left( \Delta Sn\_{(1)}, 0 \right), Sn\_{(2)}^{\tau+1/2} \right)
 \+ \rho\_{d(3)} \max\left( \max\left( \Delta Sn\_{(1)}, 0 \right) - Sn\_{(2)}^{\tau+1/2}, 0 \right),
$$
$$
M\_{d(1)}^{-}
 = \rho\_{d(1)} \max\left( -\Delta Sn\_{(1)}, 0 \right), 
$$
$$
\Delta Sn\_{(1)} 
 = Sn\_{(1)}^{\tau+1} - Sn\_{(1)}^{\tau+1/2}.
$$

The change in the dust amount in the 3rd layer is determined similarly, and thus in the 2nd layer it is calculated as follows:

$$
M\_{d(2)}^{\tau+1} - M\_{d(2)}^{\tau} 
 = \Delta M\_{d(1)}^{-} - \Delta M\_{d(1)}^{+} + \Delta M\_{d(3)}^{-} - \Delta M\_{d(3)}^{+}.
$$



## 8.8 Snow and ice albedo

### 8.8.1 Snow albedo

The albedo of the snow is calculated in SUBROUTINE SNWALB in matsnw.F.

The albedo of the snow is large in fresh snow, but becomes smaller with the passage of time due to compaction and changes in properties as well as soilage. In order to take these effects into consideration, the albedo of the snow is treated as a prognostic variable.


The nondimensional age of snow at the time step of ${\tau}$, $A\_g^{\tau}$, is formulated in

$$
A\_g^{\tau} = \frac{f\_{alb}}{1-f\_{alb}},
$$

where

$$
f\_{alb} = \min\left(
 \frac{\alpha\_{vis}^{\tau}-\alpha\_{vis,new}}{\alpha\_{vis,old}-\alpha\_{vis,new}}, 0.999
\right).
$$

$\alpha\_b^{\tau}$ is the albedo of the snow for band $b$ at the time step of $\tau$. Three bands of wavelength, visible (vis), near infrared (nir) and infrared (ifr) are considered in MATSIRO, and here the factors for visible band are used. $\alpha\_{b,new}$ is the albedo of newly fallen snow for band $b$ and $\alpha\_{b,old}$ is that of old snow. In default, $\alpha\_{vis,new}$, $\alpha\_{nir,new}$, $\alpha\_{ifr,new}$, $\alpha\_{vis,old}$, $\alpha\_{nir,old}$ and $\alpha\_{ifr,old}$ are set to 0.9, 0.7, 0.01, 0.65 (or 0.4), 0.2 and 0.1, respectively.


The age of snow at the next time step ${\tau+1}$ is, after Yang et al. (1997), assumed to be given by the following equation:

$$
A\_g^{\tau+1} = A\_g^{\tau} + (f\_{age} + f\_{age}^{10} + r\_{dirt})\Delta t\_L / \tau\_{age},
$$

where

$$
f\_{age} = \exp{\left[ f\_{ageT} \left( \frac{1}{T\_{melt}} - \frac{1}{T\_{Sn(1)}} \right) \right]},
$$

$$
f\_{ageT} = 5000, \;\; \tau\_{age} = 1 \times 10^6 \;\mathrm{s}, \;\; T\_{melt} = 273.15 \;\mathrm{K}.
$$

$T\_{Sn(1)}$ is the temperature of the first layer of snow.

$r\_{dirt}$ represents the effect of dirt and soot. When the option OPT\_SNWALB is inactive,

$$
r\_{dirt} = \left\\{ \begin{aligned}
 r\_{dirt,c} \;\;& \mathrm{(over \; continental \; ice)} \\
 r\_{dirt,0} \;\;& \mathrm{(elsewhere)}
\end{aligned} \right.,
$$

where $r\_{dirt,c} = 0.01$ and $r\_{dirt,0} = 0.3$. When this option is active, the density of the dirt is considered as

$$
r\_{dirt} = \left\\{ \begin{aligned}
 \min(r\_{dirt,c} + r\_{dirt,s}\rho\_{d(1)}, 1000) \;\;& \mathrm{(over \; continental \; ice)} \\
 \min(r\_{dirt,0} + r\_{dirt,s}\rho\_{d(1)}, 1000) \;\;& \mathrm{(elsewhere)}
\end{aligned} \right.,
$$

where $r\_{dirt,s}$ is the dirt factor for slope with a constant value of 0.1 and $\rho\_{d(1)}$ is the dirt density of the first layer.

Using this, the albedo of the snow at the time step of $\tau+1$, $\alpha\_b^{\tau+1}$, is solved by

$$
\alpha\_b^{\tau+1} = \alpha\_{b,new}^{\tau+1} + \frac{A\_g^{\tau+1}}{1+A\_g^{\tau+1}} (\alpha\_{b,old}-\alpha\_{b,new}),
$$

When snowfall has occurred, the albedo is updated to the value of the fresh snow in accordance with the snowfall:

$$
\alpha\_b^{\tau+1} = \alpha\_b^{\tau+1} + \min\left( \frac{P\_{Sn}^{\*} \Delta t\_L}{\Delta Sn\_c}, 1 \right) (\alpha\_{b,new} - \alpha\_b^{\tau+1}).
$$

$\Delta Sn\_c$ is the snow water equivalent necessary for the albedo to fully return to the value of the fresh snow.


### 8.7.2 Ice albedo

The albedo of the ice sheet, $\alpha\_{b,surf}$, is calculated in ENTRY ICEALB in matice.F.

This is expressed in a following function of the water content above the ice according to Bougamont et al. (2005):

$$
\alpha\_{b,surf} = \alpha\_{b,wet} - (\alpha\_{b,wet}-\alpha\_{b,ice}) \exp{\left( -\frac{w\_{surf}}{w^{\*}} \right)},
$$

where $\alpha\_{b,ice}$ is the land ice albedo without surface water, $\alpha\_{b,wet}$ is the one with surface water, $w\_{surf}$ is the thisness of surfice water and $w^{\*}$ is the characteristic scale for surficial water. $b$ represents the three bands of wavelength, visible (vis), nearinfrared (nir) and infrared (ifr), similar to ice albedo. In default, $\alpha\_{vis,ice}$, $\alpha\_{nir,ice}$ and $\alpha\_{ifr,ice}$ are set to 0.5, 0.3 and 0.05, respectively, and $\alpha\_{b,wet}$ is set to 0.15 for all bands.
