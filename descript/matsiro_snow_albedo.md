## 8.7 Snow and ice albedo

### 8.7.1 Snow albedo (SUBROUTINE SNWALB)

The albedo of the snow is calculated in SUBROUTINE SNWALB as a prognostic variable.

The albedo of the snow is large in fresh snow, but becomes smaller with the passage of time due to compaction and changes in properties as well as soilage. In order to take these effects into consideration, the albedo of the snow is treated as a prognostic variable. 

The time development of the age of the snow is, after Yang et al. (1997), assumed to be given by the following equation:

$$
\frac{A\_g^{\tau+1} - A\_g^{\tau}}{\Delta t\_L} = (f\_{age} + f\_{age}^{10} + r\_{dirt}) / \tau\_{age},
$$

where

$$
f\_{age} = \exp{\left[ f\_{ageT} \left( \frac{1}{T\_{melt}} - \frac{1}{T\_{Sn(1)}} \right) \right]},
$$

$$
f\_{ageT} = 5000, \;\; \tau\_{age} = 1 \times 10^6 \mathrm{s}, T\_{melt} = 273.15 \mathrm{K}.
$$

$T\_{Sn(1)}$ is the temperature of the first layer of snow.

$r\_{dirt}$ represents the effect of dirt and soot. When the option OPT\_SNWALB is inactive, 

$$
r\_{dirt} = \left\\{
 r\_{dirt,c} \mathrm{(over \; continental \; ice)} \\
 r\_{dirt,0} \mathrm{(elsewhere)}
\right.,
$$

where $r\_{dirt,c} = 0.01$ and $r\_{dirt,0} = 0.3$.

When the option OPT\_SNWALB is active, the density of the dirt is considered as

$$
r\_{dirt} = \left\\{
\min(r\_{dirt,c} + r\_{dirt,s}\rho\_{d(1)}, 1000) \mathrm{(over \; continental \; ice)} \\
\min(r\_{dirt,0} + r\_{dirt,s}\rho\_{d(1)}, 1000) \mathrm{(elsewhere)}
\right.,
$$

where $r\_{dirt,s}$ is the dirt factor for slope with a constant value of 0.1 and $\rho\_{d(1)}$ is the dirt density of the first layer.


The nondimensional age of snow at the time step of ${\tau}$, $A\_g^{\tau}$, is formulated in 

$$
A\_g^{tau} = \frac{f\_{alb}}{1-f\_{alb}},
$$

where

$$
f\_{alb} = \min(\frac{\alpha\_{vis}^{\tau}-\alpha\_{vis,new}}{\alpha\_{vis,old}-\alpha\_{vis,new}}, 0.999).
$$

$\alpha\_b^{\tau}$ is the albedo of the snow for band $b$ at the time step of $\tau$. Three bands of wavelength, visible (vis), near infrared (nir) and infrared (ifr) are considered in MATSIRO, and here factors for visible band are used. $\alpha\_{b,new} is the albedo of newly fallen snow for band $b$ and $\alpha\_{b,old}$ is that of old snow. In default, $\alpha\_{\mathrm{vis,new}}$, $\alpha\_{\mathrm{nir,new}}$, $\alpha\_{\mathrm{ifr,new}}$, $\alpha\_{\mathrm{vis,old}}$, $\alpha\_{\mathrm{nir,old}}$ and $\alpha\_{\mathrm{ifr,old}}$ are set to 0.9, 0.7, 0.01, 0.65 (or 0.4), 0.2 and 0.1, respectively.

Using this, the albedo of the snow at the time step of $\tau+1$, $\alpha\_b^{\tau+1}$, is solved by

$$
\alpha\_b^{\tau+1} = \alpha\_{b,\mathrm{new}}^{\tau+1} + \frac{A\_g^{\tau+1}}{1+A\_g^{\tau+1}} (\alpha\_{b,\mathrm{old}}-\alpha\_{b,\mathrm{new}}), 
$$

When snowfall has occurred, the albedo is updated to the value of the fresh snow in accordance with the snowfall:

$$
 \alpha\_b^{\tau+1} = \alpha\_b^{\tau+1} + \min\left( \frac{P\_{Sn}^{\*} \Delta t\_L}{\Delta Sn\_c}, 1 \right) (\alpha\_{b,\mathrm{new}} - \alpha\_b^{\tau+1}).
$$

$\Delta Sn\_c$ is the snow water equivalent necessary for the albedo to fully return to the value of the fresh snow.


### 8.7.2 Ice albedo

The ice sheet albedo, $\alpha\_{b,surf}$, is expressed in a following function of the water content above the ice according to Bougamont et al. (2005):

$$
\alpha\_{b,surf} = \alpha\_{b,wet} - (\alpha\_{b,wet}-\alpha\_{b,ice}) \exp{\left( -\frac{w\_{surf}}{w^{\*}} \right)},
$$

where $\alpha\_{b,ice}$ is the land ice albedo without surface water, $\alpha\_{b,wet}$ is the one with surface water, $w\_{surf}$ is the thisness of surfice water and $w^{\*}$ is the characteristic scale for surficial water. $b$ represents the three bands of wavelength, visible (vis), nearinfrared (nir) and infrared (ifr), similar to ice albedo. In default, $\alpha\_{vis,ice}$, $\alpha\_{nir,ice}$ and $\alpha\_{ifr,ice}$ are set to 0.5, 0.3 and 0.05, respectively, and $\alpha\_{b,wet}$ is set to 0.15 for all bands.

