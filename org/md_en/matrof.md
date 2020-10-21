# Spillover sub-model MATROF

Surface runoff and groundwater runoff are calculated using a simplified version of TOPMODEL (Beven and Kirkby, 1979).

## Overview of TOPMODEL

In the TOPMODEL, we consider the horizontal distribution of groundwater level along the slope in the basin. It is assumed that the groundwater flow down a slope is balanced with the total recharge rate of the groundwater recharge rate at the slope above the point (quasi-stationary assumption). Then, the lower the slope is, the larger the groundwater flow should be. Based on another assumption, which will be discussed later, it is assumed that the shallow groundwater surface is necessary for the groundwater flow to be high. Thus, the distribution of shallow groundwater level is derived for the lower slopes. When the average groundwater level is shallower than a certain level, the groundwater level rises to the ground below a certain point of the slope and forms a saturated area. Thus, TOPMODEL is characterized by the fact that the concepts of mean groundwater level, saturated area, and velocity of groundwater flow, which are important for the estimation of runoff, are physically consistent with each other.

In the TOPMODEL, three main assumptions are made as follows

The saturated hydraulic conductivity of soil decays exponentially with depth.

The slope of the groundwater surface is nearly equal to the slope slope locally.

The groundwater flow down a slope corresponds to the accumulated groundwater recharge rate above the point of slope.

In the following, the use of symbols follows the conventions of TOPMODEL (Sivapalan et al., 1987 ; Stieglitz et al., 1997).

The assumption 1 can be written as

$$
 K_s(z) = K_0 \exp (-f z)
$$


$K_s(z)$ is the saturated hydraulic conductivity of soil at the depth $z$, $K_0$ is the saturated hydraulic conductivity at the ground surface, and $f$ is the attenuation coefficient.

If the depth of the groundwater surface at a certain point ($i$) is defined as $z_i$, then the groundwater flux down slope at that point ($q_i$) is expressed as

$$
 q_i = \int_{z_i}^Z K_s(z) dz \cdot \tan\beta
   = \frac{K_0}{f}  \tan\beta [\exp(-f z_i) - \exp(-f Z)]
$$


$\beta$ is the slope slope slope, using assumption 2. Although $Z$ is the depth of the impermeable surface, the term $Z$ is usually assumed to be deeper than that of $1/f$, and the term $\exp(-f Z)$ is omitted. The slope directional soil water flux in the unsaturated zone above the groundwater surface is neglected because it is small.

Assuming that the groundwater recharge rate is uniformly set to the $R$, Assumption 3 can be expressed as follows

$$
 a R = \frac{K_0}{f} \tan\beta \exp(-f z_i)
$$


Here, $a$ is the total upstream area (per unit contour length at the point $i$) relative to the point $i$.

Solving this for $z_i$ yields the following.

$$
 z_i = -\frac{1}{f} \ln \left( \frac{faR}{K_0 \tan \beta}\right)
$$


The average groundwater depth in the region ($A$) is the depth of the groundwater table ($\overline{z}$),

$$
   \overline{z} = \frac1{A}\int_{A} z_i dA
  = - \Lambda - \frac1{f} \ln R
$$


$$
 \Lambda \equiv
  \frac1{A}\int_{A} \ln \left( \frac{fa}{K_0 \tan \beta}\right) dA
$$


Thus, the recharge rate ($R$) as a function of mean groundwater depth ($\overline{z}$) is expressed as

$$
 R = \exp (-f \overline{z} -\Lambda)
$$


According to Assumption 3, this is the amount of groundwater discharged from the area ($A$).

Substituting $R$ into (4) gives the following relationship between $z_i$ and $\overline{z}$.

$$
 z_i = \overline{z} - \frac{1}{f} \left[
\ln \left( \frac{fa}{K_0 \tan \beta}\right) - \Lambda
\right]
$$


The region satisfying the $z_i \leq 0$ is the surface saturation region.

## Application of TOPMODEL under the assumption of simplified terrain

When TOPMODEL is used, detailed topographical data of the target area are usually required, but here we estimate roughly the average shape of the slopes in the grid based on the data of average slope and standard deviation of the elevation of the grid (this method is currently provisional and requires further study).

The topography of the grid is represented by the slope of $\beta_s$ with a uniform slope of $\beta_s$ and the distance from the ridge to the valley of $L_s$.

$L_s$ is estimated using the standard deviation of elevation ($\sigma_z$) as follows.

$$
 L_s = 2\sqrt{3} \sigma_z / \tan\beta_s
$$


$2\sqrt{3}\sigma_z$ is the difference between the elevation of the ridge and the valley in the serrated terrain with the standard deviation of the elevation of the $\sigma_z$.

Taking the $x$ axis from the ridge to the valley on the horizontal plane. Since the total upstream area of the curve at the $x$ is $x$, (4) becomes the following.

$$
 z(x) = - \frac{1}{f} \ln \left( \frac{fxR}{K_0 \tan \beta_s}\right)
$$


Based on this, the mean groundwater surface is calculated from (5) as

$$
 \overline{z} = \frac 1{L_s}\int_0^{L_s} z(x) dx
 = - \frac1{f}\left[
 \ln \left( \frac{f L_s R}{K_0 \tan\beta_s}\right) -1
\right]
$$


Groundwater recharge rate is from (7)

$$
 R = \frac{K_0 \tan\beta_s}{f L_s}\exp(1-f \overline{z})
$$


The relationship between groundwater level and mean groundwater level in $x$ is from (8)

$$
 z(x) = \overline{z} - \frac{1}{f}\left(
\ln \frac{x}{L_s} + 1
\right)
$$


The result is Solving for $z(x) \leq 0$ with respect to $x$ yields the following.

$$
 x \geq x_0
$$


$$
x_0 = L_s \exp(f\overline{z}-1)
$$


Therefore, the area factor of the saturation region is

$$
 A_{sat} = (L_s - x_0)/ L_s = 1 - \exp(f\overline{z}-1)
$$


In the case of $A_{sat} \geq 0$ and $\overline{z} > 1/f$, the saturation region does not exist. However, for the $A_{sat} \geq 0$ and $\overline{z} > 1/f$, there is no saturation region.

## Calculation of flow rate

Four discharge mechanisms are considered and the total amount of discharge by each mechanism is defined as the total amount of discharge from the grid.

$$
 Ro = Ro_s + Ro_i + Ro_o + Ro_b
$$


$Ro_s$ is a saturation excess runoff (Dunne runoff), $Ro_i$ is an infiltration excess runoff (Horton runoff), $Ro_o$ is an overflow of the first layer of soil, and the above is the total amount of runoff from the grid by each mechanism. Classified. $Ro_b$ is a groundwater runoff .

### Estimates of Mean Groundwater Depth.

Assuming that soil moisture content starts from the lowest layer of soil and that the layer that becomes unsaturated for the first time is the $k_{WT}$th layer, the average depth of the groundwater table ($\overline{z}$) is estimated as follows

$$
 \overline{z} = z_{g(k_{WT}-1/2)} - \psi_{k_{WT}}
$$


This corresponds to the assumption that the moisture potential at the top of the unsaturated layer is set to $\psi_{k_{WT}}$, under which the distribution of soil moisture is considered to be in equilibrium (i.e., the equilibrium condition between gravity and capillary force).

If the $\overline{z} > z_{g(k_{WT}+1/2)}$ is the lowest level, no groundwater surface is assumed to exist in the $k_{WT}$ region. If the $k_{WT}$ is not the bottom layer, the uppermost layer of the saturated groundwater layer (the uppermost layer) is assumed to be the $k_{WT}$ and the above equation is applied to the lower layer.

In the case where the frozen ground surface exists in the middle of the soil, the depth of the groundwater surface is estimated above the frozen ground surface.

### Calculation of Groundwater Runoff

Since the groundwater discharge is equal to the recharge rate of (12) under quasi-steady assumptions, we can assume that the groundwater recharge rate is the same as that of (12),

$$
 Ro_b = \frac{K_0 \tan\beta_s}{f L_s}\exp(1-f \overline{z})
$$


(1). However, in the case of a frozen surface under the ground surface, see the case where the term $\exp(-fZ)$ in (2) is not omitted,

$$
 Ro_b = \frac{K_0 \tan\beta_s}{f L_s}
  [ \exp(1-f \overline{z}) - \exp(1-f z_f) ]
$$


The depth of the frozen ground surface is defined as $z_f$ is the depth of the frozen ground. In this case, the other formulas of the TOPMODEL system should be different, but we do not change them for the sake of simplicity.

If there is an antifreeze layer beneath the frozen ground surface and a groundwater surface exists there, the runoff of groundwater is calculated and added in the same way.

The groundwater runoff is later removed from the $k_{WT}$ layer.

$$
 Ro_{(k_{WT})} = Ro_b
$$


$Ro_{(k)}$ represents the runoff flux from the soil in the $k$th layer.

### Calculation of Surface Runoff.

All precipitation that falls in the saturated area of the earth's surface will runoff intact (saturation excess runoff).

$$
 Ro_s = (Pr_c^{**} + Pr_l^{**}) A_{sat}
$$


The area fraction of saturated area $A_{sat}$ is given by (16). Here, the correlation between precipitation distribution on the subgrid and the topography is ignored.

The precipitation that falls in the unsaturated area is infiltrated excess runoff (infiltration excess runoff). The soil infiltration capacity is given in terms of the saturated hydraulic conductivity of the first layer of soil for simplicity. Convective precipitation is assumed to be localized, and the area fraction of the precipitation area ($A_c$) is assumed to be uniform (the standard value is 0.1). Stratified precipitation is assumed to be uniform.

$$
 Ro_i^c = \max( Pr_c^{**}/A_c + Pr_l^{**} - K_{s(1)}, 0 ) (1 - A_{sat}) \\
 Ro_i^{nc} = \max( Pr_l^{**} - K_{s(1)}, 0 ) (1 - A_{sat})
$$



$$
 Ro_i = A_c Ro_i^c + ( 1 - A_c ) Ro_i^{nc}
$$


$Ro_i^c$ and $Ro_i^{nc}$ are $Ro_i$ for convective and non-convective precipitation areas, respectively, and $K_{s(1)}$ is the saturated hydraulic conductivity of the first soil layer.

The overflow of the first layer of soil allows for a small amount of waterlogging $w_{str}$ (1 mm by default),

$$
 Ro_o = \max(w_{(1)} - w_{sat(1)} - w_{str}, 0) \rho_w \Delta z_{g(1)} / \Delta t_L
$$


This amount will be subtracted from the first layer of soil later. This amount will later be subtracted from the first layer of soil, and is therefore included in the runoff from the first layer.

$$
 Ro_{(1)} = Ro_{(1)} + Ro_o
$$


## Water flux to the soil

The water fluxes fed to the soil through the runoff process are as follows.

$$
 Pr^{*** } = Pr^{**}_c + Pr^{**}_l - Ro_s - Ro_i
$$

 Translated with www.DeepL.com/Translator (free version)
