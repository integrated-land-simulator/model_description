# Snow Submodel MATSNW

Calculate the snowpack, snow temperature and snow albedo.

## Diagnosis of snow area ratio

In the case of small snow cover, the sub-grid snow cover is taken into account. The area fraction of snow cover, $A_{Sn}$, is a unique function of the snow cover, $Sn$,

$$
 A_{Sn} = \min(Sn/Sn_{c}, 1)^{1/2}
$$


given in . The standard position is $Sn_c$=100\[kg/m$^2$\].

In practice, various factors, such as topography and differences in snowfall and snowmelt, are expected to affect the snow coverage ratio. For this purpose, the introduction of a sub-grid snow coverage model (SSNOWD) based on Liston (private communication) is under consideration.

$A_{Sn}$ is referred to at the beginning of the flux calculation section and is used to compute an area-weighted average of the various fluxes computed there as follows

$$
 \overline{F} = (1-A_{Sn}) F_{(1)} + A_{Sn} F_{(2)}
$$


Here, $F_{(1)}$ and $F_{(2)}$ represent fluxes on a snow-free surface and a snow-covered surface, respectively. Actually, this operation is carried out through the flux coupler.

## Vertical division of the snowpack layer

In order to represent the vertical distribution of the snow temperature, the snow is divided into multiple layers and the temperature is defined for each layer when the snow cover is large. The number of layers is variable, and the number of layers is increased as the amount of snowfall increases. The number of layers is variable, and the number of layers increases as the amount of snowfall increases.

The number of layers and the mass of each layer are uniquely determined by the amount of snow cover. In this way, the mass of each layer is not a new forecast variable.

The mass of each layer ($\Delta \widetilde{Sn}_{(k)} (k=1,2,3)$) is determined as follows ($k=1$ is the top layer).

$$
 \Delta \widetilde{Sn}_{(1)} = \left\{
\begin{array}{ll}
 \widetilde{Sn}  (\widetilde{Sn} < 20) \\
 0.5\widetilde{Sn}  (20 \leq \widetilde{Sn} < 40)\\
 20  (\widetilde{Sn} \geq 40)
\end{array}
\right. \\
 \Delta \widetilde{Sn}_{(2)} = \left\{
\begin{array}{ll}
 0  (\widetilde{Sn} < 20) \\
 \widetilde{Sn} - \Delta Sn_{(1)}  (20 \leq \widetilde{Sn} < 60)\\
 0.5(\widetilde{Sn}-20)  (60 \leq \widetilde{Sn} < 100)\\
 40  (\widetilde{Sn} \geq 100)
\end{array}
\right. \\
 \Delta \widetilde{Sn}_{(3)} = \left\{
\begin{array}{ll}
 0  (\widetilde{Sn} < 60) \\
 \widetilde{Sn} - (\Delta Sn_{(1)} + \Delta Sn_{(2)}) (\widetilde{Sn} \geq 60)
\end{array}
\right. 
$$




Here,

$$
 \widetilde{Sn} =  Sn / A_{Sn}
$$


and while $Sn$ represents the grid-averaged snow cover, $\widetilde{Sn}$ represents the snow cover in the snow region. Note that the mass of each layer ($\Delta \widetilde{Sn}_{(k)}$) is also a value for the snow cover and not a grid average. The unit for each layer is kg/m$^2$.

It is clear from the above that the standard number of snow layers ($K_{Sn}$) is as follows.

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


## Calculating the snowpack.

The forecasting equation for snow cover is given by

$$
 \frac{Sn^{\tau+1}-Sn^{\tau}}{\Delta t_L} = P_{Sn}^* - E_{Sn} - M_{Sn} + Fr_{Sn}
$$


$P_{Sn}^*$ is snowfall flux after interception by canopy, $E_{Sn}$ is sublimation flux, $M_{Sn}$ is snowmelt, and $Fr_{Sn}$ is refreezing of snowmelt water or freezing of rainfall.

### Sublimation of the snowpack

First, we subtract the amount of sublimation and partially update the snowpack.

$$
 Sn^* = Sn^{\tau} - E_{Sn} \Delta t_L \\
 \Delta \widetilde{Sn}_{(1)}^* = \Delta \widetilde{Sn}_{(1)}^{\tau} - E_{Sn}/A_{Sn} \Delta t_L
$$



If, by chance, the sublimation is greater than the snow accumulation in the first layer, the remaining amount is subtracted from the lower layer. The same is true if the second layer is insufficient.

### Melting Snowpack.

Next, the heat conduction during the snow cover is calculated and the amount of snowmelt is determined. The method for calculating the heat conduction in the snowpack is described later. The temperature of the snow cover updated by heat conduction is set to $T_{Sn(k)}^*$. If the temperature of the first snow layer is higher than $T_{melt} = 0^{\circ}$ C, the temperature of the first snow layer is fixed at $T_{melt}$ and the calculation is redone. In this case, the energy convergence $\Delta \widetilde{F}_{conv}$ is calculated for the first layer. This is not a grid-averaged value, but a value for the snow cover area. The amount of snowmelt in the first layer is the same as that in the first layer,

$$
 \widetilde{M}_{Sn(1)} = \min(\Delta \widetilde{F}_{conv} / l_m, \Delta \widetilde{Sn}_{(1)}^*/\Delta t_L ) 
$$


It is.

If the temperature in the second and lower levels is higher than $T_{melt}$, the temperature is returned to $T_{melt}$ and the internal energy of the temperature change is used to melt the snow. In other words,

$$
 T_{Sn(k)}^{**} = T_{melt}
$$


and added $\Delta \widetilde{F}_{conv}$ as a new

$$
 \Delta \widetilde{F}_{conv} = ( T_{Sn(k)}^* - T_{melt} ) c_{pi}\Delta \widetilde{Sn}_{(k)}^*/\Delta t_L
$$


The amount of snowmelt is defined in (11) and is obtained in the same way as in (11).

Update the mass of each layer by subtracting the amount of snowmelt.

$$
 \Delta \widetilde{Sn}_{(k)}^{**} = \Delta \widetilde{Sn}_{(k)}^{*}
 - \widetilde{M}_{Sn(k)}
$$


In the middle of these calculations, if all the layers are melted, the remainder of $\Delta \widetilde{F}_{conv}$ is given to the layer below to raise the temperature of the layer below. That is, the temperature of the lower layer is increased,

$$
 \Delta \widetilde{F}_{conv}^* = \Delta \widetilde{F}_{conv} - l_m \widetilde{M}_{Sn(k)}
$$


$$
 T_{Sn(k+1)}^{**} = T_{Sn(k+1)}^{*} + \Delta \widetilde{F}_{conv}^* / (c_{pi} \Delta \widetilde{Sn}_{(k+1)}^*) \Delta t_L
$$


Here, $c_{pi}$ is the specific heat of snow (ice). When all the snow cover is melted, $\Delta \widetilde{F}_{conv}^*$ is given to the soil.

The total snowmelt of the entire snowpack is the sum of the snowmelt in each layer (note that this is a grid average).

$$
 M_{Sn} = \sum_{k=1}^{K_{Sn}} \widetilde{M}_{Sn(k)} A_{Sn}
$$


Subtracting the amount of snowmelt, the snowpack is partially updated.

$$
 Sn^{**} = Sn^{*} - M_{Sn} \Delta t_L
$$


### Freezing snowmelt water and rainfall in snowpack

The freezing of snowmelt and rainfall in the snowpack is calculated. For the snowmelt, the effect of the liquid water generated by the melting of the upper layers of snow on the refreezing of the lower layers of snow is taken into account. The amount of liquid water retained in the snowpack is not taken into account; it is assumed that all the liquid water either freezes in the snowpack or runs down the snowpack.

Liquid water fluxes at the top of the snow cover in snow regions,

$$
 \widetilde{F}_{wSn(1)} = Pr_c^* + Pr_l^* + M_{Sn} / A_{Sn}
$$


Here, the snow melt below the second layer of the snowpack is also flushed from the top of the snowpack. (As a practical matter, melting below the second layer is unlikely to occur in this case.)

The temperature of snowmelt water is considered to be 0 $^{\circ}$ C, but the temperature of rainfall on the snowpack is assumed to be 0 $^{\circ}$ C in terms of the toilet bowl. The latent heat of freezing water causes the temperature of the snow cover to rise, but if the temperature of a layer of snow cover rises to 0 $^{\circ}$ C, water cannot freeze any higher and flows to the next layer below. In addition, there is an upper limit to the amount of water that can be frozen at a certain ratio to the mass of the snow cover at that layer. In other words, the freezing amount in a layer, $\widetilde{Fr}_{Sn(k)}$, is

$$
 \widetilde{Fr}_{Sn(k)} = \min\left( \widetilde{F}_{wSn(k)}, \
\frac{c_{pi}(T_{melt}-T_{Sn(k)}^{**})}{l_m}
\frac{\Delta \widetilde{Sn}_{(k)}^{**}}{\Delta t_L} , \
f_{Fmax}\frac{\Delta \widetilde{Sn}_{(k)}^{**}}{\Delta t_L} \right)
$$


It is determined by the following formula. The $\widetilde{F}_{wSn(k)}$ is the liquid water flux flowing from the top of the $k$th layer of snow cover. The standard value of the $f_{Fmax}$ is 0.1.

The temperature change in the snowpack is ,

$$
 T_{Sn(k)}^{***} = \frac{l_m \widetilde{Fr}_{Sn(k)}\Delta t_L
   +c_{pi}(T_{Sn(k)}^{**}\Delta \widetilde{Sn}_{(k)}^{**} + T_{melt} \widetilde{Fr}_{Sn(k)}\Delta t_L ) }
  {c_{pi} (\Delta \widetilde{Sn}_{(k)}^{**} + \widetilde{Fr}_{Sn(k)}\Delta t_L)}
$$


and update the mass to

$$
 \Delta \widetilde{Sn}_{(k)}^{***} = \Delta \widetilde{Sn}_{(k)}^{**} + \widetilde{Fr}_{Sn(k)}\Delta t_L
$$


And update.

The total amount of freezing in the entire snowpack is the sum of the amount of freezing in each layer (but it is a grid average).

$$
 Fr_{Sn} = \sum_{k=1}^{K_{Sn}} \widetilde{Fr}_{Sn(k)} A_{Sn}
$$


Add the amount of freeze and partially update the snowpack.

$$
 Sn^{***} = Sn^{**} + Fr_{Sn} \Delta t_L
$$


The liquid water that passes through the snowpack down to the bottom is given to the soil.

### Snowfall.

Finally, the amount of snowfall that has been intercepted by the canopy is added to obtain the final updated snowpack.

$$
 Sn^{\tau+1} = Sn^{***} + P_{Sn}^* \Delta t_L
$$


However, when the temperature of the first layer of soil is higher than $0^{\circ}$ C, the snowfall is assumed to melt on the ground. In this case, the energy of the latent heat of melting is absorbed by the soil.

When snow accumulation occurs due to a snowfall in a grid where there has been no snowfall, the snow coverage ratio ($A_{Sn}$) is newly diagnosed based on (1), and snow temperature ($T_{Sn(1)}$) is assumed to be equal to the temperature of the first layer of soil.

We also add the amount of snowfall to the mass of the first layer.

$$
 \Delta \widetilde{Sn}_{(k)}^{\tau+1} = \Delta \widetilde{Sn}_{(k)}^{***} + P_{Sn}^* \Delta t_L /A_{Sn}
$$


### Redividing the snow layer and re-diagnosing the temperature

When the snow cover is updated, the area fraction is re-diagnosed by (1) and the mass of each layer is reconstructed by (3) $\sim$(5). The temperature of each layer is re-diagnosed so that the energy is conserved.

$$
 T_{Sn(k)}^{new} = \left(\sum_{l=1}^{K_{Sn}^{old}} f_{(l^{old}\in k^{new})} T_{Sn(l)}^{old} \Delta \widetilde{Sn}_{(l)}^{old} A_{Sn}^{old} \right)
\Bigm/ (\Delta \widetilde{Sn}_{(k)}^{new} A_{Sn}^{new})
$$


Note that the variables are those subscripted with $old$ and $new$ are those before and after the reconstruction. $f_{(l^{old}\in k^{new})}$ is the percentage of the mass of the $l$ layer before the reconstruction that is contained in the $k$ layer after the reconstruction.

## Calculating heat transfer during snowfall.

### The Heat Transfer Equation in Snowpack

The prediction equation for snowfall temperature due to heat conduction during snow cover is as follows.

$$
c_{pi}\Delta \widetilde{Sn}_{(k)} \frac{T_{Sn(k)}^* - T_{Sn(k)}^{\tau}}{\Delta t_L} = \widetilde{F}_{Sn(k+1/2)} - \widetilde{F}_{Sn(k-1/2)}
\qquad (k=1,\ldots,K_{Sn})
$$


where the heat transfer flux $\widetilde{F}_{Sn}$ is given by

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
\end{array}
\right. 
$$


$k_{Sn(k+1/2)}$ is the thermal conductivity of the snow cover, which gives a constant value of 0.3 W/m/K in standard practice. $\Delta z_{Sn(k+1/2)}$ is the thickness of each snow layer,

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


The density of snow cover is defined by $\rho_{Sn}$ as 300 kg/m$^3$. $\rho_{Sn}$ is the density of the snow cover, and a constant value of 300 kg/m$^3$ is given in the standard definition. It is assumed that the density and thermal conductivity of the snowpack will change with the passage of time (aging) due to consolidation and alteration of the snowpack, but these effects are not taken into account here.

In (29), the flux $ \widetilde{F}_{Sn(1/2)}$ at the top of the snowpack is the heat transfer flux $F_{Sn(1/2)}$ determined at the surface energy balance, the surface energy convergence $\Delta
F_{conv}$ generated by melting the surface temperature under snow melting conditions, and the phase of water content in the canopy. In the case of a change, the energy is given using the energy correction $\Delta F_{c,conv}$. We assume that the energy is given only for the snow covered surface ($\Delta F_{conv}$) and that the energy is given uniformly for the grid ($\Delta F_{c,conv}$). Since the sign of the fluxes is positively oriented upward, the convergence is negatively signified.

In the equation of snow flux ($\widetilde{F}_{Sn(K_{Sn}+1/2)}$), $T_{Sn(B)}$ is the temperature at the bottom of the snowpack (i.e., the boundary between the snowpack and the soil). However, the flux from the first layer of soil to the bottom of the snowpack is

$$
\widetilde{F}_{g(1/2)} = k_{g(1/2)} \frac{T_{g(1)}-T_{Sn(B)}}{\Delta z_{g(1/2)}}
$$


Therefore, we assume that there is no flux convergence at the lower end of the snowpack,

$$
\widetilde{F}_{Sn(K_{Sn}+1/2)} =  \widetilde{F}_{g(1/2)}
$$


Substituting this into (33), we obtain the following

$$
\widetilde{F}_{Sn(K_{Sn}+1/2)} =
\left[\frac{\Delta z_{g(1/2)}}{k_{g(1/2)}}
+\frac{\Delta z_{Sn(K_{Sn}+1/2)}}{k_{Sn(K_{Sn}+1/2)}}
\right]^{-1}
(T_{g(1)} - T_{Sn(K_{Sn})})
$$


### Case 1: If snowmelt does not occur in the first layer

The implicit method is used for the temperature of the first to lowest layer of snow cover. That is, the implicit method is used to determine the temperature from the first to the lowest layer of snow cover,

$$
 \widetilde{F}_{Sn(k+1/2)}^* = \widetilde{F}_{Sn(k+1/2)}^{\tau}
+\frac{\partial \widetilde{F}_{Sn(k+1/2)}}{\partial T_{Sn(k)}}
 \Delta T_{Sn(k)}
+\frac{\partial \widetilde{F}_{Sn(k+1/2)}}{\partial T_{Sn(k+1)}}
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


and put (28)

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




The fluxes are treated as in the following equations, and are solved by the LU decomposition method as a series of coupled equations of $\Delta T_{Sn(k)}\ (k=1,\ldots,K_{Sn})$ by the $K_{Sn}$ method. Note that the fluxes at the top of the snowpack are fixed as a boundary condition, and that the boundary condition at the bottom of the snowpack is the temperature of the first layer of soil, and that the fluxes at the bottom of the snowpack are explicitly treated as the temperature of the first layer of soil.

$$
 T_{Sn(k)}^* = T_{Sn(k)}^{\tau} + \Delta T_{Sn(k)}
$$


Partially update the snowpack temperature by

### Case 2: When snowmelt occurs in the first layer

If the temperature of the first layer of snow cover melted in Case 1 is higher than the temperature of the first layer of snow cover melted in Case 1, snow melts in the first layer of snow cover. In this case, the temperature of the first snow layer is fixed at $0^{\circ}$ C. In other words, the temperature of the first snow layer is fixed from the second snow layer to the first snow layer. In other words, the flux from the second snow layer to the first snow layer is

$$
 \widetilde{F}_{3/2}^{*} =
\frac{k_{Sn(3/2)}}{\Delta z_{Sn(3/2)}} (T_{Sn(2)}^{\tau} - T_{melt})
+\frac{\partial \widetilde{F}_{Sn(3/2)}}{\partial T_{Sn(2)}}
 \Delta T_{Sn(2)}
$$


and solve as in case 1 (when there is only one layer of snow, the snow temperature is fixed in the flux from soil to snow in the same way).

The energy convergence used to melt the first layer of snow is given by

$$
 \Delta \widetilde{F}_{conv} = (\widetilde{F}_{3/2}^{*} - \widetilde{F}_{1/2})
  - c_{pi}\Delta \widetilde{Sn}_{(1)} \frac{T_{melt}-T_{Sn(1)}^*}{\Delta t_L}
$$


Even if the temperature below the second layer of snow accumulation is higher than the $T_{melt}$, the snow melting is not performed again, and the snow melting is processed as a correction.

## Generating Glaciers.

A maximum value is set for the snowpack, and the excess snowfall is considered to be glacial runoff.

$$
 Ro_{gl} = \max( Sn - Sn_{\max} ) / \Delta t_L
$$


$$
 Sn = Sn - Ro_{gl} \Delta t_L \\
 \Delta \widetilde{Sn}_{(K_{Sn})} = \Delta \widetilde{Sn}_{(K_{Sn})}
 - Ro_{gl} / A_{Sn} \Delta t_L
$$



$Ro_{gl}$ is the amount of glacial runoff. This mass is subtracted from the bottom of the snowpack. $Sn_{\max}$ is given uniformly as 1000 kg/m$^2$ by default.

## Fluxes fed to the soil or runoff process

The heat flux to the soil through the snow accumulation process is as follows.

$$
\Delta F_{conv}^* = A_{Sn} ( \Delta \widetilde{F}_{conv}^* - \widetilde{F}_{Sn_{K_{Sn}}} ) - l_m P_{Sn,melt}^*
$$


$\Delta \widetilde{F}_{conv}^*$ is the energy convergence of the remaining snowpack, $\widetilde{F}_{Sn_{K_{Sn}}}$ is the heat conduction flux in the lowest layer of the snowpack, and $P_{Sn,melt}^*$ is the amount of snowfall that melted immediately after reaching the ground.

The energy correction term for the phase change of water on the canopy is given directly to the soil as follows.

$$
 \Delta F_{c,conv}^* = ( 1 - A_{Sn}) \Delta F_{c,conv}
$$


The water fluxes fed to the runoff process through the snow accumulation process are as follows.

$$
 Pr_c^{**} = ( 1 - A_{Sn} ) Pr_c^{*} \\
 Pr_l^{**} = ( 1 - A_{Sn} ) Pr_l^{*} + A_{Sn} \widetilde{F}_{wSn}^*
 + P_{Sn,melt}^*
$$



$\widetilde{F}_{wSn}^*$ is a flux of rainfall or snowmelt water that has passed through the lowest layer of snow cover.

## Snow albedo calculations.

The snow albedo is large in fresh snow, but decreases with time due to consolidation, deterioration and accumulation of dirt. In order to take this effect into account, snow albedo is treated as a predictor variable.

The time evolution of the "age" (age) of the snow cover follows Wiscombe and Warren (1980) and follows the following equation.

$$
 \frac {A_{g}^{\tau +1} - A_{g}^{\tau}}{\Delta t_L}
 = \left\{
\exp \left[ f_{ageT} \left( \frac{1}{T_{melt}}-\frac{1}{T_{Sn(1)}}\right) \right]
  + r_{dirt} \right\} \Bigm/ {\tau_{age}}
$$


$f_{ageT}$ = 5000, $\tau_{age}$ = 1 $\times$ 10 $^6$. $r_{dirt}$ is a parameter for dirt adhesion, giving a value of $0.01$ on the ice sheet and $0.3$ at other locations.

With this, the albedo of the snowpack is ,

$$
 \alpha_{Sn(b)}^{\tau+1} = \alpha_{Sn(b)}^{new} + \frac{A_g^{\tau+1}}{1+A_g^{\tau+1}} (\alpha_{Sn(b)}^{old} - \alpha_{Sn(b)}^{new}) \qquad (b=1,2,3)
$$


This can be calculated by Here, $A_g^{\tau}$ is calculated backward from the predictor, $\alpha_{Sn(1)}^{\tau}$, using the same formula as above.

When there is a snowfall, the albedo is updated to the new snow value according to the amount of snowfall.

$$
 \alpha_{Sn(b)}^{\tau+1} = \alpha_{Sn(b)}^{\tau+1}
+ \min\left( \frac{P_{Sn}^* \Delta t_L}{\Delta{Sn_c}}, 1 \right) (\alpha_{Sn(b)}^{new} - \alpha_{Sn(b)}^{\tau+1}) \qquad (b=1,2,3)
$$


$\Delta {Sn_c}$ is the amount of snow cover required for the albedo to return to a completely fresh snow value.

