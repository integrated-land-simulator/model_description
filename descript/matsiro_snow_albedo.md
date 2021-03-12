## 8.7 Snow and ice albedo

### 8.7.1 Snow albedo

The albedo of the snow is large in fresh snow, but becomes smaller with the passage of time due to compaction and changes in properties as well as soilage. In order to take these effects into consideration, the albedo of the snow is treated as a prognostic variable.

The time development of the age of the snow is, after Wiscombe and Warren (1980), assumed to be given by the following equation:

$$
\frac{A\_g^{\tau +1} - A\_g^{\tau}}{\Delta t\_L}
 = \left\{
 \exp \left[ f\_{ageT} \left( \frac{1}{T\_{melt}}-\frac{1}{T\_{Sn(1)}} \right) \right] + r\_{dirt} 
 \right\} \Bigm/ {\tau\_{age}}
$$

$$
\frac{A\_g^{\tau +1} - A\_g^{\tau}}{\Delta t\_L}
$$

$$
\left{ \exp \left[ f\_{ageT} \left( \frac{1}{T\_{melt}}-\frac{1}{T\_{Sn(1)}} \right) \right] + r\_{dirt} \right}
$$

$$
\Bigm/ {\tau\_{age}}
$$

where $f\_{ageT}$ = 5000 and $\tau\_{age}$ = 1 &times; 10^6^. $\tau\_{age}$ is a parameter related to soilage which is given the value of 0.01 on the ice sheet and 0.3 elsewhere.

Using this, the albedo of the snow at the time step of $\tau+1$, $\alpha\_b^{\tau+1}$, is solved by

$$
\alpha\_b^{\tau+1} = \alpha\_{b,\mathrm{new}}^{\tau+1} + \frac{A\_g^{\tau+1}}{1+A\_g^{\tau+1}} (\alpha\_{b,\mathrm{old}}-\alpha\_{b,\mathrm{new}}), 
$$

where $\alpha\_{b,\mathrm{new}}$ is the albedo of newly fallen snow for band $b$, $\alpha\_{b,\mathrm{old}}$ is the albedo of old snow, and $A\_g$ is an aging factor from Yang et al. (1997). This factor evolves with time, as a function of snow temperature and the densities of dust and black carbon. We consider the three bands of wavelength, visible (vis), near infrared (nir) and infrared (ifr), and in default, $\alpha\_{\mathrm{vis,new}}$, $\alpha\_{\mathrm{nir,new}}$, $\alpha\_{\mathrm{ifr,new}}$, $\alpha\_{\mathrm{vis,old}}$, $\alpha\_{\mathrm{nir,old}}$ and $\alpha\_{\mathrm{ifr,old}}$ are set to 0.9, 0.7, 0.01, 0.65 (or 0.4), 0.2 and 0.1, respectively.

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

