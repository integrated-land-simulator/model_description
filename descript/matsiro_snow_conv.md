<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

# 8. Snow

The snow cover fraction, snow water equivalent, snow temperature and snow albedo are calculated here.

## 8.1 Diagnosis of snow cover fraction

The snow cover fraction is diagnosed with a physically based parameterization of sub-grid snow distribution considering various factors such as differences in topography, the time of snowfall or snow melting, etc (Tatebe et al., 2019).

The snow cover fraction is formulated for accumulation and ablation seasons separately.
For the accumulation season, snowfall occures uniformly and the snow cover fraction is assumed to be equal in the grid cell.
For the ablation season, the snow cover fraction decreases based on the sub-grid distribution of the snow water equivalent. Under the assumption of uniform melt depth $D_m$, the sum of snow-free and snow-covered fraction equals unity:

$$
\int_0^{D_m} f(D)dD + \int_{D_m}^\infty f(D)dD = 1, \tag{A4}
$$

where $D$ is the snow water equivalent depth and $f(D)$ is the probability distribution function (PDF) of snow water equivalent depth within the grid cell. The snow depth distribution within each grid cell is assumed to follow a lognormal distribution:

$$
f(D) = \frac{1}{D\zeta\sqrt{2}} \exp{ \left[
 -\frac{1}{2} {\left( \frac{\ln(D)-\lambda}{\zeta} \right)}^2
\right] }, \tag{A5}
$$

where

$$
\lambda = \ln(\mu) - \frac{1}{2}\zeta^2 \tag{A6}
$$

and

$$
\zeta^2 = \ln(1+CV^2). \tag{A7}
$$

Here $\mu$ is the accumulated snowfall and $CV$ is the coefficient of variation. $CV$ is diagnosed from the standard deviation of the subgrid topography, coldness index and vegetation type that is a proxy for surface winds. For coldness index, the annually averaged temperature over the latest 30 years using the time relaxation method of Krinner et al. (2005), in which the timescale parameter is set to 16 years. The temperature threshold for a category diagnosis is set to 0 and 10 $^\circ\mathrm{C}$.

$D_m$ is calculated from $Sn$ and the following equation using Newton-Raphson methods:

$$
Sn(D_m) = \int_0^{D_m} 0[f(D)]dD + \int_{D_m}^\infty (D-D_m)[f(D)]dD. \tag{A9}
$$

Then, the snow cover fraction $A_{Sn}(D_m)$ is calculated by

$$
A_{Sn}(D_m) = 1 - \int_0^{D_m} f(D)dD. \tag{A8}
$$


## 8.2 Vertical division of snow layers

In order to express the vertical distribution of the snow temperature, when the snow water equivalent is large, the snow is divided into multiple layers and the temperature is defined in each layer. The number of snow layers can be varied, with the number of layers increasing as the snow water equivalent becomes larger. A minimum of one layer and a maximum of three layers are set as a standard.

The number of layers and the mass of each layer are determined uniquely by the snow water equivalent. Consequently, the mass of each layer does not become a new prognostic variable.

As a standard, the mass of each layer ($\Delta {\widetilde{Sn}}_{(k)} (k=1,2,3)$) is determined as follows ($k=1$ is the uppermost layer):

$$
\begin{aligned}
\widetilde{Sn}_{(1)} &= \left\{
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
\widetilde{Sn}_{(2)} &= \left\{
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
\widetilde{Sn}_{(3)} &= \left\{
\begin{array}{ll}
 0 \\
 \widetilde{Sn} - (\Delta Sn_{(1)} + \Delta Sn_{(2)})
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
 \widetilde{Sn} =  Sn / A_{Sn}
$$

 $Sn$ is the grid-mean snow water equivalent, and $\widetilde{Sn}$ is the snow water equivalent in the snow-covered portion. Note that the mass of each layer ($\Delta {\widetilde{Sn}}_{(k)}$) is also the value of the snow-covered portion, not the grid-mean value. The unit is kg/m^2^.

From the above, it can be clearly seen that the number of snow layers ($K_{Sn}$) is as follows, as a standard:

$$
 K_{Sn} = \left\{
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
 \frac{Sn^{\tau+1}-Sn^{\tau}}{\Delta t_L} = P_{Sn}^{*} - E_{Sn} - M_{Sn} + Fr_{Sn}
$$

where $P_{Sn}^{*}$ is the snowfall flux after interception by the canopy, $E_{Sn}$ is the sublimation flux, $M_{Sn}$ is the snowmelt, and $Fr_{Sn}$ is the refreeze of snowmelt or the freeze of rainfall.

### 8.3.1 Sublimation of snow

First, by subtracting the sublimation, the snow water equivalent is partially updated:

$$
 Sn^{*} = Sn^{\tau} - E_{Sn} \Delta t_L \\
 \Delta \widetilde{Sn}_{(1)}^{*} = \Delta \widetilde{Sn}_{(1)}^{\tau} - E_{Sn}/A_{Sn} \Delta t_L
$$

In a case where the sublimation is larger than the snow water equivalent in the uppermost layer, the remaining amount is subtracted from the layer below. If the amount in the second layer is insufficient for such subtraction, the remaining amount is subtracted from the layer below that.

### 8.3.2 Snowmelt

Next, the snow heat conduction is calculated to solve the snowmelt. The method of calculating the snow heat conduction is described later. The updated snow temperature incorporating the heat conduction is assumed to be $T_{Sn(k)}^{*}$. When the temperature is calculated and the temperature of the uppermost snow layer becomes higher than $T_{melt} = 0 ^\circ\mathrm{C}$, the temperature of the uppermost layer is fixed at $T_{melt}$ and the calculation is performed again. In this case, the energy convergence $\Delta \widetilde{F}_{conv}$ in the uppermost layer is calculated. This is not the grid-mean value but the value of the snow-covered portion. The snowmelt in the uppermost layer is

$$
 \widetilde{M}_{Sn(1)} = \min(\Delta \widetilde{F}_{conv} / l_m, \Delta \widetilde{Sn}_{(1)}^{*}/\Delta t_L ) \tag{eq220}
$$

With regard to the second layer and below, if the temperature is higher than $T_{melt}$, it is put back to $T_{melt}$ and the internal energy of that temperature change portion is applied to the snowmelt. That is, it is assumed to be

$$
T_{Sn(k)}^{**} = T_{melt}
$$

$\Delta \widetilde{F}_{conv}$ is newly defined by

$$
\Delta \widetilde{F}_{conv} = ( T_{Sn_{(k)}}^{*} - T_{melt} ) c_{pi}\Delta \widetilde{Sn}_{(k)}^{*}/\Delta t_L
$$

and the snowmelt is solved as in [Eq. (220)](#eq220).

By subtracting the snowmelt, the mass of each layer is updated:

$$
\Delta \widetilde{Sn}_{(k)}^{**} = \Delta \widetilde{Sn}_{(k)}^{*} - \widetilde{M}_{Sn_{(k)}}
$$


During these calculations, when a certain layer is fully melted, the remaining amount of $\Delta \widetilde{F}_{conv}$ is given to the layer below to raise the temperature in that layer; that is,

$$
\Delta \widetilde{F}_{conv}^{*} = \Delta \widetilde{F}_{conv} - l_m \widetilde{M}_{Sn_{(k)}}
$$

$$
T_{Sn_{(k+1)}}^{**} = T_{Sn_{(k+1)}}^{*} + \Delta \widetilde{F}_{conv}^{*} / (c_{pi} \Delta \widetilde{Sn}_{(k+1)}^{*}) \Delta t_L
$$

where $c_{pi}$ is the specific heat of snow (ice). When all of the snow is melted, $\Delta \widetilde{F}_{conv}^{*}$ is given to the soil.

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
 \widetilde{F}_{wSn(1)} = Pr_c^{*} + Pr_l^{*} + M_{Sn} / A_{Sn}
$$

Here, the melted portion in the second layer of the snow and below is also assumed to have percolated from the snow upper boundary (in actuality, snowmelt in the second layer or below rarely occurs).

It is reasonable to assume the temperature of the snowmelt water as 0 $^\circ\mathrm{C}$, and the temperature of rainfall on the snow is also assumed to be 0 $^\circ\mathrm{C}$ for convenience. The temperature of the snow increases due to the latent heat of the freezing of water; however, when the temperature of the snow in a certain layer is increased to 0 $^\circ\mathrm{C}$, any additional water is assumed to be unable to freeze and to percolate to the layer below. In addition, an upper limit is set on the ratio of water that can be frozen compared with the mass of snow in the layer. The amount of freeze in a given layer$\widetilde{Fr}_{Sn(k)}$ is solved by

$$
\widetilde{Fr}_{Sn_{(k)}} = \min\left(
\widetilde{F}_{w_{Sn_{(k)}}}, \
\frac{c_{pi}(T_{melt}-T_{Sn_{(k)}}^{**})}{l_m} \
\frac{\Delta \widetilde{Sn}_{(k)}^{**}}{\Delta t_L} , \
f_{Fmax}\frac{\Delta \widetilde{Sn}_{(k)}^{**}}{\Delta t_L} \
\right)
$$

where $F_{w_{Sn_{(k)}}}$ is the liquid water flux percolated from the upper boundary of the $k$th layer of the snow. $\widetilde{F}_{w_{Sn_{(k)}}}$ is the liquid water flux flowing from the top of the $k$th layer of snow cover. The standard value of the $f_{Fmax}$ is assumed to be 0.1 as a standard value.

The snow temperature change is updated by

$$
 T_{Sn_{(k)}}^{***} = \frac{l_m \widetilde{Fr}_{Sn_{(k)}}\Delta t_L
   + c_{pi}(T_{Sn_{(k)}}^{**}\Delta \widetilde{Sn}_{(k)}^{**} + T_{melt} \widetilde{Fr}_{Sn_{(k)}}\Delta t_L ) }
  {c_{pi} (\Delta \widetilde{Sn}_{(k)}^{**} + \widetilde{Fr}_{Sn_{(k)}}\Delta t_L)},
$$

and the mass is updated as follows:

$$
 \Delta \widetilde{Sn}_{(k)}^{***} = \Delta \widetilde{Sn}_{(k)}^{**} + \widetilde{Fr}_{Sn_{(k)}}\Delta t_L.
$$

The amount of freeze in the overall snow is the sum of the amounts of freeze in each layer (note, however, that it is the grid-mean value):

$$
 Fr_{Sn} = \sum_{k=1}^{K_{Sn}} \widetilde{Fr}_{Sn_{(k)}} A_{Sn}.
$$


By adding the amount of freeze, the snow water equivalent is partially updated as follows:

$$
 Sn^{***} = Sn^{**} + Fr_{Sn} \Delta t_L.
$$

The liquid water that has percolated from the snow to the lower boundary is given to the soil.

### 8.3.4 Snowfall

Lastly, by adding the snowfall after interception by the canopy, the finally updated snow water equivalent is obtained:

$$
 Sn^{\tau+1} = Sn^{***} + P_{Sn}^{*} \Delta t_L
$$

However, when the temperature of the uppermost soil layer is 0 $^\circ\mathrm{C}$ or more, the snowfall is assumed to melt on the ground. In this case, the energy of the latent heat of melting is taken from the soil.

When snow is produced by snowfall in a grid where no snow was formerly present, the snow-covered ratio ($A_{Sn}$) is newly diagnosed by [Eq. (210)](#eq210) and the snow temperature ($T_{Sn(1)}$) is assumed to be equal to the temperature of the uppermost soil layer.

The snowfall is added to the mass of the uppermost layer:

$$
 \Delta \widetilde{Sn}_{(k)}^{\tau+1} = \Delta \widetilde{Sn}_{(k)}^{***} + P_{Sn}^{*} \Delta t_L /A_{Sn}.
$$

### 8.3.5 Redivision of snow layer and rediagnosis of temperature

When the snow water equivalent is updated, the snow-covered ratio is rediagnosed by [Eq. (210)](#eq210) and the mass of each layer is redivided by [Eq. (212) to (214)](#eq212). The temperature in each redivided layer is rediagnosed so that the energy is conserved as follows:

$$
 T_{Sn_{(k)}}^{\mathrm{new}} = \left(
\sum_{l=1}^{K_{Sn}^{\mathrm{old}}}
  f_{(l^{\mathrm{old}}\in k^{\mathrm{new}})} T_{Sn(l)}^{\mathrm{old}}
  \Delta \widetilde{Sn}_{(l)}^{\mathrm{old}} A_{Sn}^{\mathrm{old}}
\right) \Bigm/ (\Delta \widetilde{Sn}_{(k)}^{\mathrm{new}} A_{Sn}^{\mathrm{new}}).
$$

It should be noted that the variables with the index "old" and "new" are those before and after redivision, respectively. $f_{(l^{\mathrm{old}}\in k^{\mathrm{new}})}$ is the ratio of the mass of the $k$th layer after redivision to the mass of the $l$th layer before redivision.


## 8.4 Calculation of snow heat conduction

### 8.4.1 Snow heat conduction equations

The prognostic equation of the snow temperature due to snow heat conduction is as follows:

$$
c_{pi}\Delta \widetilde{Sn}_{(k)} \frac{T_{Sn(k)}^{*} - T_{Sn(k)}^{\tau}}{\Delta t_L} = \widetilde{F}_{Sn(k+1/2)} - \widetilde{F}_{Sn(k-1/2)}
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

where $\rho_{Sn}$ is the snow density, assigned the fixed value of 300 kg/m^3^ as a standard. The snow density and heat conductivity are considered to change with the passage of time due to compaction and changes in properties (aging), but the effect of such changes is not considered here.

In [Eq. (238)](#eq238), the snow upper boundary flux $\widetilde{F}_{Sn(1/2)}$ is given using the heat conduction flux from the snow to the ground surface solved in the ground surface energy balance $F_{Sn(1/2)}$, the ground surface energy convergence produced when the ground surface temperature is solved by the snowmelt condition $\Delta
F_{conv}$), and the energy correction produced when a change has occurred in the phase of the canopy water $\Delta F_{c,conv}$. ($\Delta F_{conv}$) is assumed to be given only to the snow-covered portion, while ($\Delta F_{c,conv}$) is given uniformly to the grid cells. Since the sign of the flux is taken as upward positive, the convergence has a negative sign.

In the equation for the snow lower boundary flux ($\widetilde{F}_{Sn_{(K_{Sn}+1/2)}}$), $T_{Sn_{(B)}}$ is the temperature of the snow lower boundary (the boundary surface of the snow and the soil). However, since the flux from the uppermost soil layer to the snow lower boundary is

$$
\widetilde{F}_{g(1/2)} = k_{g(1/2)} \frac{T_{g(1)}-T_{Sn_{(B)}}}{\Delta z_{g(1/2)}}
$$

there is assumed to be no convergence at the snow lower boundary, and by putting


$$
\widetilde{F}_{Sn_{(K_{Sn}+1/2)}} =  \widetilde{F}_{g(1/2)}
$$

$T_{Sn_{(B)}}$ is solved. When this is substituted into [Eq. (242)](#eq242), the following is obtained:

$$
\widetilde{F}_{Sn_{(K_{Sn}+1/2)}} =
\left[\frac{\Delta z_{g(1/2)}}{k_{g(1/2)}}
+\frac{\Delta z_{Sn_{(K_{Sn}+1/2)}}}{k_{Sn_{(K_{Sn}+1/2)}}}
\right]^{-1}
(T_{g(1)} - T_{Sn_{(K_{Sn})}}) \tag{eq242}
$$

### 8.4.2 Case 1: When snowmelt does not occur in the uppermost layer

The implicit method is used to treat the temperature from the uppermost snow layer to the lowest snow layer, as follows:


$$
 \widetilde{F}_{Sn_{(k+1/2)}}^{*} = \widetilde{F}_{Sn_{(k+1/2)}}^{\tau}
+\frac{\partial \widetilde{F}_{Sn_{(k+1/2)}}}{\partial T_{Sn_{(k)}}}
 \Delta T_{Sn_{(k)}}
+\frac{\partial \widetilde{F}_{Sn_{(k+1/2)}}}{\partial T_{Sn_{(k+1)}}}
 \Delta T_{Sn_{(k+1)}}
$$

$$
 \widetilde{F}_{Sn_{(k+1/2)}}^{\tau} = \left\{
\begin{array}{ll}
(F_{Sn_{(1/2)}} - \Delta F_{conv})/A_{Sn} - \Delta F_{c,conv} (k=0)\\
\displaystyle{
\frac{k_{Sn_{(k+1/2)}}}{\Delta z_{Sn(k+1/2)}} (T_{Sn(k+1)}^{\tau} - T_{Sn(k)}^{\tau})
} (k=1,\ldots,K_{Sn}-1) \\
\displaystyle{
\left[
\frac{\Delta z_{g(1/2)}}{k_{g(1/2)}}
+\frac{\Delta z_{Sn_{(K_{Sn}+1/2)}}}{k_{Sn_{(K_{Sn}+1/2)}}}
\right]^{-1} (T_{g(1)} - T_{Sn_{(K_{Sn})}}^{\tau})
} (k=K_{Sn})
\end{array}
\right.
$$


$$
\frac{\partial \widetilde{F}_{Sn_{(k+1/2)}}}{\partial T_{Sn_{(k)}}} =
\left\{
\begin{array}{ll}
\displaystyle{
- \frac{k_{Sn_{(k+1/2)}}}{\Delta z_{Sn_{(k+1/2)}}}
}
 (k=1,\ldots,K_{Sn}-1) \\
\displaystyle{
- \left[\frac{\Delta z_{g(1/2)}}{k_{g(1/2)}}
+\frac{\Delta z_{Sn_{(K_{Sn}+1/2)}}}{k_{Sn_{(K_{Sn}+1/2)}}}
\right]^{-1}
}
 (k=K_{Sn})
\end{array}
\right.
$$


$$
 \frac{\partial \widetilde{F}_{Sn_{(k+1/2)}}}{\partial T_{Sn_{(k+1)}}} =
\left\{
\begin{array}{ll}
0  \ \quad \qquad \qquad \qquad \qquad (k=0) \\
\displaystyle{
\frac{k_{Sn_{(k+1/2)}}}{\Delta z_{Sn_{(k+1/2)}}}
}
   \ \quad \qquad \qquad \qquad \qquad (k=1,\ldots,K_{Sn}-1)
\end{array}
\right.
$$


and [Eq. (237)](#eq237) is treated as

$$
c_{pi}\Delta \widetilde{Sn}_{(k)} \frac{\Delta T_{Sn_{(k)}}}{\Delta t_L}
= \widetilde{F}_{Sn_{(k+1/2)}}^{*} - \widetilde{F}_{Sn_{(k-1/2)}}^{*}  \\
= \widetilde{F}_{Sn_{(k+1/2)}}^{\tau}
+\frac{\partial \widetilde{F}_{Sn_{(k+1/2)}}}{\partial T_{Sn_{(k)}}}
 \Delta T_{Sn_{(k)}}
+\frac{\partial \widetilde{F}_{Sn_{(k+1/2)}}}{\partial T_{Sn_{(k+1)}}}
 \Delta T_{Sn_{(k+1)}}  \\
- \widetilde{F}_{Sn_{(k-1/2)}}^{\tau}
-\frac{\partial \widetilde{F}_{Sn_{(k-1/2)}}}{\partial T_{Sn_{(k-1)}}}
 \Delta T_{Sn_{(k-1)}}
-\frac{\partial \widetilde{F}_{Sn_{(k-1/2)}}}{\partial T_{Sn_{(k-1)}}}
 \Delta T_{Sn_{(k)}}
$$

and solved by the LU factorization method as $\Delta T_{Sn_{(k)}}\ (k=1,\ldots,K_{Sn})$ simultaneous equations with respect to $K_{Sn}$. At this juncture, it should be noted that the flux at the snow upper boundary is fixed as the boundary condition, the snow lower boundary condition is the temperature in the uppermost soil layer, and the snow lower boundary flux is treated explicitly with regard to the temperature of the uppermost soil layer. The snow temperature is partially updated by


$$
 T_{Sn_{(k)}}^{*} = T_{Sn_{(k)}}^{\tau} + \Delta T_{Sn_{(k)}}
$$

### 8.4.3 Case 2: When snowmelt occurs in the uppermost layer

When the temperature of the uppermost snow layer solved in case 1 is higher than 0degC, snowmelt occurs in the uppermost snow layer. In this case, the temperature of the uppermost snow layer is fixed at 0 $^\circ\mathrm{C}$. The flux from the second snow layer to the uppermost snow layer is then expressed as

$$
 \widetilde{F}_{3/2}^{*} =
\frac{k_{Sn_{(3/2)}}}{\Delta z_{Sn_{(3/2)}}} (T_{Sn_{(2)}}^{\tau} - T_{melt})
+\frac{\partial \widetilde{F}_{Sn_{(3/2)}}}{\partial T_{Sn_{(2)}}}
 \Delta T_{Sn_{(2)}}
$$

and solved similarly to case 1 (when there is only one snow layer, the snow temperature is similarly fixed in the flux from the soil to the snow).

The energy convergence used for melting in the uppermost snow layer is given by:

$$
 \Delta \widetilde{F}_{conv} = (\widetilde{F}_{3/2}^{*} - \widetilde{F}_{1/2})
  - c_{pi}\Delta \widetilde{Sn}_{(1)} \frac{T_{melt}-T_{Sn_{(1)}}^{*}}{\Delta t_L}
$$

Even if the temperature of the second snow layer and below is higher than $T_{melt}$, the calculation is not iterated and the snowmelt is corrected accordingly.


## 8.5 Fluxes given to the soil or the runoff process

The heat flux given to the soil through the snow process is

$$
\Delta F_{conv}^{*} = A_{Sn} (\Delta\widetilde{F}_{conv}^{*} - \widetilde{F}_{Sn_{K_{Sn}}}) - l_m P_{Sn,melt}^{*},
$$

where $\Delta\widetilde{F}_{conv}^{*}$ is the energy convergence remaining when all of the snow has melted, $\widetilde{F}_{Sn_{K_{Sn}}}$ is the heat conduction flux at the lowest snow layer, and $P_{Sn,melt}^{*}$ is the snowfall that melts immediately when it reaches the ground.

Since the energy of the snow-free portion is given to the soil as it is, the energy correction term due to the phase change of the canopy water is as follows:

$$
 \Delta F_{c,conv}^{*} = ( 1 - A_{Sn}) \Delta F_{c,conv}.
$$


The water flux given to the runoff process through the snow process is then expressed as

$$
 Pr_c^{**} = ( 1 - A_{Sn} ) Pr_c^{*} \\
 Pr_l^{**} = ( 1 - A_{Sn} ) Pr_l^{*} + A_{Sn} \widetilde{F}_{wSn}^{*}
 + P_{Sn,melt}^{*},
$$

where $\widetilde{F}_{wSn}^{*}$ is the flux of the rainfall or snowmelt water that has percolated through the lowest snow layer.


## 8.6 Glacier formation

In this case, the maximum value is set for the snow water equivalent, and the portion exceeding the maximum value is considered to become glacier runoff:


$$
 Ro_{gl} = \max( Sn - Sn_{\mathrm{max}} ) / \Delta t_L
$$


$$
 Sn = Sn - Ro_{gl} \Delta t_L \\
 \Delta \widetilde{Sn}_{(K_{Sn})} = \Delta \widetilde{Sn}_{(K_{Sn})}
 - Ro_{gl} / A_{Sn} \Delta t_L
$$

where $Ro_{gl}$ is the glacier runoff. The mass of this portion is subtracted from the lowest snow layer. $Sn_{\max}$ is uniformly assigned the value of 1000 kg/m^2^ as a standard.


## 8.7 Snow and ice albedo

### 8.7.1 Snow albedo

The albedo of the snow is large in fresh snow, but becomes smaller with the passage of time due to compaction and changes in properties as well as soilage. In order to take these effects into consideration, the albedo of the snow is treated as a prognostic variable.

The time development of the age of the snow is, after Wiscombe and Warren (1980), assumed to be given by the following equation:

$$
\frac{A_g^{\tau +1} - A_g^{\tau}}{\Delta t_L}
 = \left\{
 \exp \left[ f_{ageT} \left( \frac{1}{T_{melt}}-\frac{1}{T_{Sn(1)}}\right) \right]
 + r_{dirt} \right\} \Bigm/ {\tau_{age}}
$$

where $f_{ageT}$ = 5000 and $\tau_{age}$ = 1 &times; 10^6^. $\tau_{age}$ is a parameter related to soilage which is given the value of 0.01 on the ice sheet and 0.3 elsewhere.

Using this, the albedo of the snow at the time step of $\tau+1$, $\alpha_b^{\tau+1}$, is solved by

$$
\alpha_b^{\tau+1} = \alpha_{b,\mathrm{new}}^{\tau+1} + \frac{A_g^{\tau+1}}{1+A_g^{\tau+1}} (\alpha_{b,\mathrm{old}}-\alpha_{b,\mathrm{new}}),
$$

where $\alpha_{b,\mathrm{new}}$ is the albedo of newly fallen snow for band $b$, $\alpha_{b,\mathrm{old}}$ is the albedo of old snow, and $A_g$ is an aging factor from Yang et al. (1997). This factor evolves with time, as a function of snow temperature and the densities of dust and black carbon. We consider the three bands of wavelength, visible (vis), near infrared (nir) and infrared (ifr), and in default, $\alpha_{\mathrm{vis,new}}$, $\alpha_{\mathrm{nir,new}}$, $\alpha_{\mathrm{ifr,new}}$, $\alpha_{\mathrm{vis,old}}$, $\alpha_{\mathrm{nir,old}}$ and $\alpha_{\mathrm{ifr,old}}$ are set to 0.9, 0.7, 0.01, 0.65 (or 0.4), 0.2 and 0.1, respectively.

When snowfall has occurred, the albedo is updated to the value of the fresh snow in accordance with the snowfall:

$$
 \alpha_b^{\tau+1} = \alpha_b^{\tau+1} + \min\left( \frac{P_{Sn}^{*} \Delta t_L}{\Delta Sn_c}, 1 \right) (\alpha_{b,\mathrm{new}} - \alpha_b^{\tau+1}).
$$

$\Delta Sn_c$ is the snow water equivalent necessary for the albedo to fully return to the value of the fresh snow.


### 8.7.2 Ice albedo

The ice sheet albedo, $\alpha_{b,surf}$, is expressed in a following function of the water content above the ice according to Bougamont et al. (2005):

$$
\alpha_{b,surf} = \alpha_{b,wet} - (\alpha_{b,wet}-\alpha_{b,ice}) \exp{\left( -\frac{w_{surf}}{w^{*}} \right)},
$$

where $\alpha_{b,ice}$ is the land ice albedo without surface water, $\alpha_{b,wet}$ is the one with surface water, $w_{surf}$ is the thisness of surfice water and $w^{*}$ is the characteristic scale for surficial water. $b$ represents the three bands of wavelength, visible (vis), nearinfrared (nir) and infrared (ifr), similar to ice albedo. In default, $\alpha_{vis,ice}$, $\alpha_{nir,ice}$ and $\alpha_{ifr,ice}$ are set to 0.5, 0.3 and 0.05, respectively, and $\alpha_{b,wet}$ is set to 0.15 for all bands.

