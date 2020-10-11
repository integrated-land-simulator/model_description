# Canopy Water Balance Submodel MATCNW

Calculating the water balance of the upper canopy water component .

## Diagnosis of the phases of the canopy upper water portion.

Moisture in the canopy is considered separately as liquid (interrupted precipitation, condensation, or solid moisture that has melted) and solid (interrupted snow, ice, or liquid moisture that has frozen) and allows for a mixture of them. The predictor is only the amount of moisture ($w_c$) of the liquid and solid combined, and depending on whether the canopy temperature ($T_c$) is higher or lower than $T_{melt} = 0^{\circ}$ C, the case is diagnosed as either liquid or solid, respectively. The reason why liquid and solid can coexist is that the $T_c$ of snow covered areas and snow-free areas are calculated separately. That is, the freezing area fraction ($A_{Snc}$) of water on the canopy is defined as follows (in reality, the averaged result by the coupler is as follows),

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


$$
 w_{cl} = w_c ( 1 - A_{Snc}) \\
 w_{ci} = w_c A_{Snc}
$$



The following table shows the values for each of the two types of moisture in the canopy. $w_{cl}$ and $w_{ci}$ are the liquid and solid moisture on the canopy respectively.

$A_{Snc}$ is given by the coupler as the updated value $A_{Snc}^{\tau+1}$ in the flux calculation section, but the value of the previous step, $A_{Snc}^{\tau}$, should be stored in the MATCNW. $\tau$ represents a time step. This will not become a new predictor since it is obtained at the start of the calculation from the initial values of $T_c$ and $Sn$.

## Forecast for water content in the canopy

The predictive equations for water content in the canopy are given below for the liquid and the solid, respectively.

$$
 \rho_w \frac{w_{cl}^{\tau+1} - w_{cl}^{\tau}}{\Delta t_L}
  = P_{Il} - E_l - D_l + M_c \\
 \rho_w \frac{w_{ci}^{\tau+1} - w_{ci}^{\tau}}{\Delta t_L}
  = P_{Ii} - E_i - D_i - M_c
$$



$P_{Il}$ and $P_{Ii}$ are the precipitation cutoff values for a liquid and a solid, respectively, $E_l$ and $E_i$ are the evaporation (sublimation) value, $D_l$, $D_i$ is the drop value, and $M_c$ is the melting value. Note that the former values of $w_{cl}^{\tau}$ and $w_{ci}^{\tau}$ are defined by the following using the former $A_{Snc}^{\tau}$.

$$
 w_{cl}^{\tau} = w_c^{\tau} ( 1 - A_{Snc}^{\tau}) \\
 w_{ci}^{\tau} = w_c^{\tau} A_{Snc}^{\tau}
$$



### Evaporation (sublimation) of water on the canopy.

First, the evaporation (sublimation) rate is subtracted and the water content in the canopy is partially updated. The amount of evaporation (sublimation) is determined in the flux calculation section.

$$
 w_{cl}^* = w_{cl}^{\tau} - E_l \Delta t_L / \rho_w \\
 w_{ci}^* = w_{ci}^{\tau} - E_i \Delta t_L / \rho_w
$$



$$
 E_l = Et_{(1,3)} \\
 E_i = Et_{(2,3)}
$$



If one of the $w_{cl}$ or $w_{ci}$ becomes negative at this time, the other is compensated until the value returns to zero, and the amount of thawing that occurs in this case (or a negative value in the case of freezing) is set in $M_c$.

### Interruption of precipitation by canopy

Precipitation interception and dripping are considered separately for convective and non-convective precipitation areas. The area fraction of convective precipitation area ($A_c$) is assumed to be uniform (with the standard value of 0.1). It is assumed that stratified precipitation is uniform.

$$
 P_{Il}^{c}  = f_{int} ( Pr_c / A_c + Pr_l ) \\
 P_{Il}^{nc} = f_{int} Pr_l \\
 P_{Ii}^{c}  = f_{int} ( P_{Snc} / A_c + P_{Snl} ) \\
 P_{Ii}^{nc} = f_{int} P_{Snl}
$$





$P_{Il}^{c}$ and $P_{Ii}^{c}$ are cutoffs for convective precipitation areas and $P_{Il}^{nc}$ and $P_{Ii}^{nc}$ are cutoffs for non-convective areas. $f_{int}$ is the cutoff efficiency, easy

$$
 f_{int} = \left\{
\begin{array}{ll}
 LAI  (LAI < 1 {のとき})\\
 1    (LAI \geq 1 {のとき})
\end{array}
\right.
$$


This is given by

The water content on the canopy is further partially updated by adding the intercepted precipitation rate.

$$
 w_{cl}^{c*} = w_{cl}^*  + P_{Il}^c    \Delta t_L / \rho_w \\
 w_{cl}^{nc*}= w_{cl}^*  + P_{Il}^{nc} \Delta t_L / \rho_w \\
 w_{ci}^{c*} = w_{ci}^*  + P_{Ii}^c    \Delta t_L / \rho_w \\
 w_{ci}^{nc*}= w_{ci}^*  + P_{Ii}^{nc} \Delta t_L / \rho_w
$$





### Dropping water into the canopy.

The drop rate is based on both natural drops due to gravity and water overflow in the canopy.

$$
 D_l^c     =  \max( w_{cl}^{c*} - w_{c,cap}, 0 ) + D_{g}(w_{cl}^{c*}) \\
 D_l^{nc}  =  \max( w_{cl}^{nc*}- w_{c,cap}, 0 ) + D_{g}(w_{cl}^{nc*}) \\
 D_i^c     =  \max( w_{ci}^{c*} - w_{c,cap}, 0 ) + D_{g}(w_{ci}^{c*}) \\
 D_i^{nc}  =  \max( w_{ci}^{nc*}- w_{c,cap}, 0 ) + D_{g}(w_{ci}^{nc*})
$$





Moisture volume in the canopy ($w_{c,cap}$) is derived from the moisture volume per unit leaf area ($w_{c\max}$) and the LAI,

$$
 W_{c,cap} = W_{c\max} LAI
$$


The standard value of $W_{c\max}$ is 0.2 mm and the same for liquids and solids. The standard value of $W_{c\max}$ is 0.2mm and the same value is used for liquids and solids.

Gravity-induced spontaneous dropping $D_g$ follows Rutter et al,

$$
 D_g(w_c) = D_1 \exp(D_2 w_c)
$$


The following values are assumed to be the same for both liquids and solids. The standard value is $D_1$=1.14 $\times$ 10 $^{-11}$, $D_2$=3.7 $\times$ 10 $^{3}$ and the same value is used for liquid and solid.

The values are updated by subtracting the drop volume.

$$
 w_{cl}^{c**} = w_{cl}^{c*}  - D_{Il}^c    \Delta t_L / \rho_w \\
 w_{cl}^{nc**}= w_{cl}^{nc*} - D_{Il}^{nc} \Delta t_L / \rho_w \\
 w_{ci}^{c**} = w_{ci}^{c*}  - D_{Ii}^c    \Delta t_L / \rho_w \\
 w_{ci}^{nc**}= w_{ci}^{nc*} - D_{Ii}^{nc} \Delta t_L / \rho_w
$$





### Updating and melting the water content in the canopy.

Furthermore, averaging the convective and non-convective precipitation areas gives the updated water content in the canopy.

$$
 w_{cl}^{**} = A_c w_{cl}^{c**} + (1-A_c) w_{cl}^{nc**} \\
 w_{ci}^{**} = A_c w_{ci}^{c**} + (1-A_c) w_{ci}^{nc**} \\
 w_c^{\tau+1} = w_{cl}^{**} + w_{ci}^{**}
$$




However, if we consider the updated freezing area fraction ($A_{Snc}$), we can conclude that

$$
 w_{cl}^{\tau+1} = w_{c}^{\tau+1} (1-A_{Snc}^{\tau+1}) \\
 w_{ci}^{\tau+1} = w_{c}^{\tau+1} A_{Snc}^{\tau+1}
$$



Therefore, the melting value $M_c$ is diagnosed as follows.

$$
 M_c = - \rho_w ( w_{ci}^{\tau+1} - w_{ci}^{**} ) / \Delta t_L
$$


However, the amount resulting from the evaporation process, if any, is added.

Here, the temperature of the canopy should be changed by the latent heat of melting, but this is not possible because the heat capacity of the canopy is ignored. The temperature of the surrounding atmosphere should be changed, but this is not possible if we wish to close the system with the land surface integrator. To conserve energy in the system, the latent heat of melting is provided as a heat flux to the soil (or to the snowpack).

## Fluxes given to the soil, snowpack, and runoff processes

The water flux $F_w$, which is fed to the snowpack or runoff process via canopy interception, is applied to convective and non-convective precipitation areas, and to liquids and solids, respectively,

$$
 F_{wl}^{c} = (1-f_{int})( Pr_c / A_c + Pr_l ) + D_{l}^{c} \\
 F_{wl}^{nc} =(1-f_{int}) Pr_l + D_{l}^{nc} \\
 F_{wi}^{c} = (1-f_{int})( P_{Snc} / A_c + P_{Snl} ) + D_{i}^{c} \\
 F_{wi}^{nc} =(1-f_{int}) P_{Snl} + D_{i}^{nc}
$$





Convective and stratified precipitation are given separately for use in runoff calculations; for snowfall, they are given together as they are not necessary.

$$
 Pr_c^* = Ac ( F_{wl}^{c} - F_{wl}^{nc} ) \\
 Pr_l^* = F_{wl}^{nc} \\
 P_{Sn}^* = A_c F_{wl}^{c} + (1-A_c) F_{wl}^{nc}
$$




$Pr_c^*$, $Pr_l^*$, and $P_{Sn}^*$ are the amount of convective precipitation, stratified precipitation, and snowfall after interception by a canopy, respectively.

The energy flux corrections to the soil or snow cover are the same as those in the above cases,

$$
 \Delta F_{c,conv} = - l_m M_c
$$


is the latent heat of melting. $l_m$ is the latent heat of melting. 

