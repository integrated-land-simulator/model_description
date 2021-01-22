# 9 Runoff

The surface runoff and groundwater runoff are solved using a simplified TOPMODEL (Beven and Kirkby, 1979).

## 9.1 Outline of TOPMODEL

In TOPMODEL, the horizontal distribution of a water table along the slope in a catchment basin is considered. The downward groundwater flow at a certain point on the slope is assumed to be equal to the accumulated groundwater recharge in the upper part of the slope above that point (quasi-equilibrium assumption). Then, the groundwater flow must be greater in the lower part of the slope. Under another assumption described later, for the groundwater flow to be greater, the water table needs to be shallow. Thus, the distribution is derived such that the lower the slope, the shallower the water table. When the mean water table is shallower than a certain level, the water table rises to the ground surface at an area lower than a certain point in the slope to form a saturated area. In this way, TOPMODEL is characterized by the mean water table, the size of the saturated area, and the groundwater flow velocity, which are important concepts for estimating the runoff, being physically connected in a coherent manner.

TOPMODEL contains the following major assumptions:

1.  The soil saturation hydraulic conductivity is attenuated toward the depth of the soil in the manner of an exponential function.

2.  The gradient of the water table is in close agreement locally with the gradient of the slope.

3.  The downward groundwater flow at a certain point on the slope is equal to the accumulated groundwater recharge in the upper slope above that point.

The usage of the symbols below is in accordance with the usual practice in descriptions of TOPMODEL (Sivapalan et al., 1987; Stieglitz et al., 1997).

Assumption 1 can be expressed as

$$
 K_s(z) = K_0 \exp (-f z)
$$

where $K_s(z)$ is the soil saturation hydraulic conductivity at depth $z$, $K_0$ is the saturation hydraulic conductivity at the ground surface, and  $f$ is the attenuation coefficient.

When the depth of the water table at a certain point ($i$)  is designated as $z_i$, the downward groundwater flux on the slope at that point ($q_i$) is

$$
 q_i = \int_{z_i}^Z K_s(z) dz \cdot \tan\beta
   = \frac{K_0}{f}  \tan\beta [\exp(-f z_i) - \exp(-f Z)] \tag{eq262}
$$


where $\beta$ is the gradient of the slope, and assumption 2 is applied here. $Z$ is the depth of the impervious surface; normally, however, $Z$ is assumed to be sufficiently deep compared with $1/f$, so the term $\exp(-f Z)$ is omitted. Moreover, since the slope direction soil moisture flux in the unsaturated zone above the water table is small, it is ignored.

If the groundwater recharge rate $R$ is assumed to be horizontally uniform, assumption 3 is expressed as

$$
 a R = \frac{K_0}{f} \tan\beta \exp(-f z_i)
$$

where $a$ is the total upstream area (per unit contour line length at point  $i$ with respect to point $i$.

When this is solved for $z_i$, the following is obtained:
$$
 z_i = -\frac{1}{f} \ln \left( \frac{faR}{K_0 \tan \beta}\right)  \tag{eq264}
$$

The averaged water table depth ($\overline{z}$) in domain $A$ is


$$
   \overline{z} = \frac1{A}\int_{A} z_i dA
  = - \Lambda - \frac1{f} \ln R  \tag{eq265}
$$


$$
 \Lambda \equiv
  \frac1{A}\int_{A} \ln \left( \frac{fa}{K_0 \tan \beta}\right) dA  \tag{eq266}
$$


The recharge rate  $R$ can then be expressed as a function of the mean water table depth ($\overline{z}$) as follows:


$$
 R = \exp (-f \overline{z} -\Lambda)  \tag{eq267}
$$

Under assumption 3, this is exclusively the groundwater runoff discharged from domain  $A$.

Next, if $R$ is substituted into Eq. (264), the following relationship of $z_i$ and $\overline{z}$ is obtained:

$$
 z_i = \overline{z} - \frac{1}{f} \left[
\ln \left( \frac{fa}{K_0 \tan \beta}\right) - \Lambda
\right]  \tag{eq268}
$$

The domain that satisfies $z_i \leq 0$ is the surface saturated area.

## 9.2 Application of TOPMODEL assuming simplified topography

Normally, when TOPMODEL is used, detailed topographical data on the target area is required. Here, however, the average shape of the slope in a grid cell is roughly estimated from the data on the average inclination and the standard deviation of the altitude in the grid (this estimation method is temporary at this stage, and further study is required).

The topography in the grid cell is represented by the slope with uniform gradient $\beta_s$ and the distance from the ridge to valley $L_s$.

$L_s$ is estimated using the standard deviation of altitude ($\sigma_z$) as follows:


$$
L_s = \frac{2\sqrt{3} \sigma_z}{\tan\beta_s}
$$


where $2\sqrt{3}\sigma_z$ is the altitude difference between the ridge and valley in serrate topography such that the standard deviation of altitude is $\sigma_z$.

The x-axis is taken from the ridge toward the valley on the horizontal surface. Then, the total upstream area at point $x$ is $x$, and Eq. (264) becomes

$$
 z(x) = - \frac{1}{f} \ln \left( \frac{fxR}{K_0 \tan \beta_s}\right)
$$

Using this, from [Eq. (265)](#eq265) the mean water table is

$$
 \overline{z} = \frac 1{L_s}\int_0^{L_s} z(x) dx
 = - \frac1{f}\left[
 \ln \left( \frac{f L_s R}{K_0 \tan\beta_s}\right) -1
\right]
$$


from [Eq. (267)](#eq267) the groundwater recharge rate is

$$
 R = \frac{K_0 \tan\beta_s}{f L_s}\exp(1-f \overline{z}) \tag{eq272}
$$

and from [Eq. (268)](#eq268), the relationship between the water table at point $x$ and the mean water table is

$$
z(x) = \overline{z} - \frac{1}{f}\left(
\ln \frac{x}{L_s} + 1
\right)
$$


If  $z(x) \leq 0$ is solved for $x$, the following are obtained:

$$
 x \geq x_0
$$


$$
x_0 = L_s \exp(f\overline{z}-1)
$$


Therefore, the fraction of the saturated area is solved as


$$
A_{sat} = \frac{L_s - x_0}{L_s} = 1 - \exp(f\overline{z}-1) \tag{eq276}
$$


However, $A_{sat} \geq 0$ and $\overline{z} > 1/f$, and when $A_{sat} \geq 0$ and $\overline{z} > 1/f$, no saturated area exists.

## 9.3 Calculation of runoff

Four types of runoff mechanisms are considered, and the total of the runoffs $Ro$ by each mechanism is assumed to be the total runoff from the grid cell:

$$
Ro = Ro_s + Ro_i + Ro_o + Ro_b
$$

where $Ro_s$ is the saturation excess runoff (Dunne runoff), $Ro_i$ is the infiltration excess runoff (Horton runoff), and $Ro_o$  is the overflow of the uppermost soil layer, these three being classified as the surface runoff; and $Ro_b$  is the groundwater runoff.

However, when taking snow-fed wetland into account, part of the surface water will be stored in a surface tank and runoff to rivers will be delayed, which lead to an increase in land surface wetness and hence evaporation in water-limited regimes. In this regard, the total of the runoffs will become:
$$
Ro = (Ro_s + Ro_i + Ro_o) τ + Ro_b
$$
here $τ$ determines the outflow from the surface tank.
### 9.3.1 Estimation of mean water table depth

The soil moisture is examined from the lowest soil layer. When a layer that becomes unsaturated for the first time is assumed to be the $k_{WT}$th layer, the mean water table depth  ($\overline{z}$) is estimated by:

$$
\overline{z} = z_{g(k_{WT}-\frac1 2)} - \psi_{k_{WT}}
$$

This is equivalent to considering the moisture potential on the upper boundary of the unsaturated layer as $\psi_{k_{WT}}$, and the soil moisture distribution as being in the equilibrium state underneath (i.e., the state in which gravity and the capillary force are in equilibrium).

When $\overline{z} > z_{g(k_{WT}-\frac{1}2)}$ is the lowest layer, the water table is assumed to not exist. When $k_{WT}$  is not the lowest layer, the layer below (the uppermost layer among the saturated layers) is assumed to be $k_{WT}$ and the above equation is applied.

When there is a frozen soil surface in the middle of the soil, estimation of the water table depth is performed from above the frozen soil surface. 

### 9.3.2 Calculation of groundwater runoff

From the quasi-equilibrium assumption, the groundwater runoff is equal to the groundwater recharge rate in [Eq. (272)](#eq272); therefore,

$$
Ro_b = \frac{K_0 \tan\beta_s}{f L_s}\exp(1-f \overline{z})
$$

However, when a frozen soil surface exists under the water table, referring to the case of not omitting the term $\exp(-fZ)$ in [Eq. (262)](#eq262), it is assumed that

$$
 Ro_b = \frac{K_0 \tan\beta_s}{f L_s}
  [ \exp(1-f \overline{z}) - \exp(1-f z_f) ]
$$

$z_f$ is the depth of frozen soil surface. Although other relations in TOPMODEL should also be changed in such a case, the other relations are not changed here for the sake of simplification. 

When there is an unfrozen layer under the frozen soil surface and a water table exists, the groundwater runoff from there is added by a similar calculation.

The water content from the groundwater runoff is removed from the  $k_{WT}$th soil layer:

$$
Ro_{(k_{WT})} = Ro_b
$$

where $Ro_{(k)}$ denotes the runoff flux from the $k_{WT}$th soil layer.

### 9.3.3 Calculation of surface runoff

All of the rainfall that falls on the surface saturated area runs off as is (saturation excess runoff):

$$
Ro_s = (Pr_c^{**} + Pr_l^{**}) A_{sat}
$$

The fraction of the surface saturated area $A_{sat}$ is given by [Eq. (276)](#eq276). Here, the correlation between the rainfall distribution of the subgrid and topography is ignored.

With regard to rainfall that falls on the surface unsaturated area, only the portion that exceeds the soil infiltration capacity runs off (infiltration excess runoff). The soil infiltration capacity is given by the saturation hydraulic conductivity of the uppermost soil layer for simplification. The convective precipitation is considered to fall locally, and the fraction of the precipitation area ($A_c$) is assumed to be uniform (0.1 as a standard value). The stratiform precipitation is also assumed to be uniform.

$$
Ro_i^c = \max( \frac{Pr_c^{**}}{A_c} + Pr_l^{**} - K_{s(1)}, 0 ) (1 - A_{sat}) \\
 Ro_i^{nc} = \max( Pr_l^{**} - K_{s(1)}, 0 ) (1 - A_{sat})
$$

$$
 Ro_i = A_c Ro_i^c + ( 1 - A_c ) Ro_i^{nc}
$$

where $Ro_i^c$ and $Ro_i^{nc}$ are $Ro_i$ in the convective precipitation area and nonconvective precipitation area, respectively; and $K_{s(1)}$ is the saturation hydraulic conductivity in the uppermost soil layer.

The overflow of the uppermost soil layer, allowing a small amount of ponding  $w_{str}$ (1 mm as a standard value), is assumed to be

$$
Ro_o = \frac{\max(w_{(1)} - w_{sat(1)} - w_{str}, 0) \rho_w \Delta z_{g(1)}}{\Delta t_L}
$$

This portion is subtracted from the uppermost soil layer later, and therefore should be remembered as the runoff from the uppermost layer, as follows.

$$
Ro_{(1)} = Ro_{(1)} + Ro_o
$$

When calculating surface runoff $R_s$, glacial runoff $Ro_{gl}$ should also be considered. Then the $R_s$ calculated by MATSIRO will be:
$$
Rs=Ro+Ro_{gl}-Ro_b=Ro_s + Ro_i + Ro_o + Ro_{gl}
$$
When snow-fed wetlands scheme is considered:
$$
Rs=(Ro_s + Ro_i + Ro_o)τ + Ro_{gl}
$$
A tank for surface water storage $S$ is introduced that temporarily stores part of the surface runoff, where the runoff from the tank is calculated.
$$
\frac{dS}{dt}=-\frac Sτ+(1-α)Rs
$$
$t$ is the time, and $α$ and $τ$ are parameters related to the inflow and outflow of the surface tank, respectively. This equation is added to water inflow to the soil surface (i.e., precipitation that passes through canopy gaps, water drops from the canopy,  and snowmelt water), so that the land surface tends to get wetter. 

To represent snow-fed wetlands, which tend to be formed on flat areas, a spatially dependent time constant $τ$ is introduced. A function of the standard deviation of elevation above sea level is applied.
$$
τ = max (τ_0 (1 − \frac{min(zsd(x), zsd_{max})}{zsd_{max}}) , Δt)
$$
where $τ_0$ is the maximum of the time constant, $zsd$ is the standard deviation of elevation above sea level within each grid at point $x$, and $Δt$ is the time step of the model.

## 9.4 Water flux given to soil

The water flux given to the soil through the runoff process is

$$
P_r^{***} = Pr^{**}_c + Pr^{**}_l - Ro_s - Ro_i
$$
