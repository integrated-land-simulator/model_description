<!-- TOC depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [11 Lake](#11-lake)
	- [11.1 Lake surface conditions `[LAKEBC]` [100% Written in Jan, 2021]](#111-lake-surface-conditions-lakebc-100-written-in-jan-2021)
		- [11.1.1. lake surface albedo `[LAKEALB]`](#1111-lake-surface-albedo-lakealb)
		- [11.1.2 Lake surface roughness `[LAKEZ0F]`](#1112-lake-surface-roughness-lakez0f)
	- [11.2 Lake surface heat balance `[LAKEHB]` [100% Written in Jan, 2021]](#112-lake-surface-heat-balance-lakehb-100-written-in-jan-2021)
	- [11.3 Lake ice submodel `[LAKEIC]`  [100% Written in Jan, 2021]](#113-lake-ice-submodel-lakeic-100-written-in-jan-2021)
		- [11.3.1 Heat Flux and Growth Rate `MODULE[FIHEATL]`](#1131-heat-flux-and-growth-rate-modulefiheatl)
		- [11.3.2 Sublimation of Sea Ice`MODULE[FWATERL]`](#1132-sublimation-of-sea-icemodulefwaterl)
		- [11.3.3 Update snow and ice volume `[PCMPCTL]`](#1133-update-snow-and-ice-volume-pcmpctl)
		- [11.3.4 Growth and Melting `[PTHICKL]`](#1134-growth-and-melting-pthickl)
	- [11.4 Physical formulation & processes `[LAKEPO]`  [20% Written in Jan, 2021]](#114-physical-formulation-processes-lakepo-20-written-in-jan-2021)
		- [Set parameters](#set-parameters)
			- [Diffusion tracer flux `[VDIFFL]`](#diffusion-tracer-flux-vdiffl)
			- [11.3.2 Estimate the advection and diffusion terms of the tracer equations `[FLXTRCL]`](#1132-estimate-the-advection-and-diffusion-terms-of-the-tracer-equations-flxtrcl)
			- [SLVTRCL](#slvtrcl)
			- [OVTURNL](#ovturnl)
		- [11.3.1 Setting vertical diffusion and viscosity coefficients `[VDIFFL]`](#1131-setting-vertical-diffusion-and-viscosity-coefficients-vdiffl)
		- [THOMASL](#thomasl)
		- [11.3.4 Convective adjustment for the unstable water column `[OVTSETL]`](#1134-convective-adjustment-for-the-unstable-water-column-ovtsetl)

<!-- /TOC -->

# 11 Lake

Up to and including the calculation of the surface flux (11.1-11.2), the method is derived from the land surface model MATSIRO, while the calculation below the lake ice (11.3-11.4) is derived from the ocean model COCO. (The description in this section is also based on Emori (2000) for the first half and [Hasumi (2015)](https://ccsr.aori.u-tokyo.ac.jp/~hasumi/COCO/coco4.pdf) for the second half.) For practical use, note, for example, that the unit of temperature is $\mathrm{K}$ until section 11.2, while it is $\mathrm{°C}$ after section 11.3. It is also noted that because the second half part is based on the old version of COCO, hence it is slightly different from the MIROC6-AOGCM and [Hasumi (2015)](https://ccsr.aori.u-tokyo.ac.jp/~hasumi/COCO/coco4.pdf).

Dimensions of the lake scheme is defined in `include/zkg21c.F`. `KLMAX` is the number of vertical layers set to 5 in MIROC6/MATSIRO6. `NLTDIM` is the number of tracers, 1:temperature 2:salt. Since the vertical layers are actually from `KLSTR=2` to `KLEND=KLMAX+1`, `NLZDIM = KLMAX+KLSTR` exists as a parameter for management.

Maximum and minimum thresholds for the lake scheme are given in `matdrv.F`.

| Meaning                         | Presentation   | Variable | unit          | value              |
|:--------------------------------|:---------------|:---------|:--------------|:-------------------|
| minimum depth of lake           | $h_{min}$      | HHMIN    | $\mathrm{cm}$ | $10^\times 10^{2}$ |
| maximum of surface high anomaly | $\eta_{max}$   | HAMAX    | $\mathrm{cm}$ | $10^\times 10^{2}$ |
| maximum of lake snow            | $h_{snow,max}$ | HSMAX    | $\mathrm{cm}$ | $10^\times 10^{2}$ |
| maximum of lake ice thickness   | $h_{ice,max}$  | HIMAX    | $\mathrm{cm}$ | $10^\times 10^{2}$ |


## 11.1 Lake surface conditions `[LAKEBC]` [100% Written in Jan, 2021]

- Outputs

| Meaning                    | Presentation                    | Variable | dimension            | unit |
|:---------------------------|:--------------------------------|:---------|:---------------------|:-----|
| surface albedo             | $\alpha$                        | GRALB    | IJLSDM, NRDIR, NRBND | -    |
| surface roughness          | $r_0$                           | GRZ0     | IJLSDM, NTYZ0        |      |
| heat flux                  | $G$                             | FOGFLX   | IJLSDM               |      |
| heat diffusion coefficient | $\frac{\partial G}{\partial T}$ | DGFDS    | IJLSDM               |      |

- Inputs

| Meaning                | Presentation           | Variable | dimension | unit         |
|:-----------------------|:-----------------------|:---------|:----------|:-------------|
| skin temperature       | $T_s$                  | GRTS     | IJLSDM    | $\mathrm{K}$ |
| ice base temperature   | $T_b$                  | GRTB     | IJLSDM    |              |
| lake ice amount        | $Ic$                   | GRICE    | IJLSDM    |              |
| snow amount            | $Sn$                   | GRSNW    | IJLSDM    |              |
| lake ice concentration | $R_{ice}$              | GRICR    | IJLSDM    |              |
| u surface wind         | $U_0$                  | GDUA     | IJLSDM    |              |
| v surface wind         | $V_0$                  | GDVA     | IJLSDM    |              |
| cos(solar zenith)      | $\mathrm{cos}(\theta)$ | RCOSZ    | IJLSDM    |              |

- Internal work variables

| Meaning                    | Presentation                            | Variable | dimension | unit |
|:---------------------------|:----------------------------------------|:---------|:----------|:-----|
| snow fraction              | $R_{snow}$                              | GRSNR    | IJLSDM    | -    |
|                            | $T_m^{max}-T_m^{min}$                   | TALSNX   | IJLSDM    |      |
|                            | $\alpha_{snow(2,b)}-\alpha_{snow(1,b)}$ | ALBSNX   | IJLSDM    |      |
|                            | $\alpha_0$                              | ALB0     | IJLSDM    |      |
|                            | tmp                                     | DALB     | IJLSDM    |      |
|                            | $F(T_s)$                                | TFACT    | IJLSDM    |      |
|                            | $\alpha''$                              | ALBX     | IJLSDM    |      |
|                            | $r'$                                    | Z00      | IJLSDM    |      |
|                            |                                         | DZ0      | IJLSDM    |      |
| heat diffusion coefficient |                                         | DFGT     | IJLSDM    |      |
|                            |                                         | DFGX     | IJLSDM    |      |

- Internal parameters

| Meaning                       | Presentation           | Variable         | unit | Header                                                    |
|:------------------------------|:-----------------------|:-----------------|:-----|:----------------------------------------------------------|
| diffusion coef. of snow       | $D_{snow}$             | DFSNOW           |      | $0.4$                                                     |
| maximum snow depth            |                        | SNWDMX           |      | $5.0$                                                     |
| minimum snow                  |                        | EPSSNW           |      | $1.0\times 10^{-8}$                                       |
| ice forming snow              |                        | SNWMAX           |      | $1000.0$                                                  |
| snow albedo                   | $\alpha_{snow(d,b)}$   | ABLSNW(2, NRBND) |      | $0.75, 0.5, 0.75, 0.5, 0.0, 0.0$                          |
| temperature for albedo change | $T_m^{min}, T_m^{max}$ | TALSNW(2)        |      | $258.15, 273.15$                                          |
| roughness of snow             | $r_{snow}$             | Z0SNW(NTYZ0)     |      | $1.0\times 10^{-2}, 1.0\times 10^{-3}, 1.0\times 10^{-3}$ |
| snow amount for fraction=1    |                        | SNWCRT           |      | $100.0$                                                   |
| snow density                  |                        | SNWDEN           |      | $400.0$                                                   |
| diffusion coef. of lake ice   | $D_{ice}$              | DFICE            |      | $2.00$                                                    |
| lake ice albedo               | $\alpha_{ice(b)}$      | ALBICE( NRBND )  |      | $0.5, 0.5, 0.05$                                          |
| roughness of lake ice         | $r_{ice}$              | Z0ICE ( NTYZ0 )  |      | $2.0\times 10^{-2}, 2.0\times 10^{-3}, 2.0\times 10^{-3}$ |
| ice amount for conc.=1        |                        | SICCRT           |      | $300.0$                                                   |
| sea ice density               |                        | SICDEN           |      | $1000.0$                                                  |
| heat z0/moumentum z0          |                        | Z0FCT            |      | $0.1$                                                     |
| minimum z0                    |                        | Z0MIN            |      | $.0\times 10^{-6}$                                        |
| depth of ML Ocean             |                        | DZOCN            |      | $50.0$                                                    |
| ocean dG/dTs                  |                        | DFOCN            |      | $1.0\times 10^{10}$                                       |
| LW albedo (1-emis)            |                        | ALBLO            |      | $5.0\times 10^{-2}$                                       |

In this module, surface albedo and roughness are calculated. They are calculated supposing ice-free conditions, then modified.

First, let us consider the lake albedo. The lake level $\alpha_{(d,b)}$, $b=1,2,3$ represent the visible, near-infrared, and infrared wavelength bands, respectively. Also, $d=1,2$ represents direct and scattered light, respectively. The albedo for the visible bands are calculated in `MODULE [LAKEALB]`, supposing ice-free conditions. The albedo for near-infrared is set to same as the visible one. The albedo for infrared is uniformly set to a constant value.

When lake ice is present, the albedo is modified to take into account the ice concentration $R_{ice}$.

$$
	{\alpha'} = \alpha + (\alpha_{ice}-\alpha) R_{ice}
$$

where $\alpha_{ice}$ is the sea ice albedo. In addition, we want to consider the albedo change due to snow cover. Assuming that the snow albedo depends on the surface temperature ($T_s$), we can calculate the function $F(T_s)$

$$
	F(T_s) = \frac{T_s-T_m^{min}}{T_m^{max}-T_m^{min}}
$$

but $0 \le F(T_s)\le 1$.
The snow cover albedo can be expressed using

$$
	{\alpha''} = \alpha(1,b) + (\alpha_{snow(2,b)}-\alpha_{snow(1,b)})F(T_s)
$$

Therefore, taking into account the snow coverage $R_{snow}$, we can express it as


$$
	\alpha = {\alpha'} +(\alpha''-\alpha')R_{snow}
$$


Second, let us consider the lake surface roughness. The roughnesses of for momentum, heat and vapor are calculated in `[LAKEZ0F]`, supposing the ice-free conditions.

When lake ice is present, each roughness is modified to take into account the ice concentration $R_{ice}$.

$$
	{r_0'} = r_0 + (r_{ice} -r_0) R_{ice}
$$

Then, taking into account the snow coverage $R_{snow}$, we can express it as

$$
	{r_0} = {r_0'} + (r_{snow} - {r_0'}) R_{snow}
$$

If the lake ice exists, the heat diffusion coefficient of lake ice $D_{ice}$

$$
	\Big(\frac{\partial G}{\partial T}\Big)_{ice} = \frac{D_{ice}}{R_{ICE}}
$$

If the snow exists, the heat diffusion coefficient of snow covered area is

$$
	\Big(\frac{\partial G}{\partial T}\Big)_{snow}  =  \frac{D_{ice}D_{snow}}{D_{ice}R_{snow}+D_{snow}R_{ice}}
$$

Therefore, the net heat diffusion coefficient is finally
$$
	\frac{\partial G}{\partial T} = \Big(\frac{\partial G}{\partial T} \Big)_{ice} (1-R_{snow}) + \Big(\frac{\partial G}{\partial T}\Big)_{snow} R_{snow}
$$

The temperature differences between the snow surface ($T_S$) and the ice bottom ($T_B$) is saved as heat flux, because the difference should be zero in the ice-free conditions.

$$
	G = \frac{\partial G}{\partial T} (T_B-T_S)
$$


###  11.1.1. lake surface albedo `[LAKEALB]`

- Inputs

| Meaning           | Presentation  | Variable | dimension | unit |
|:------------------|:--------------|:---------|:----------|:-----|
| cos(solar zenith) | $cos(\theta)$ | COSZ     | IJLSDM    | [-]  |

- Outputs

| Meaning                               | Presentation    | Variable | dimension | unit |
|:--------------------------------------|:----------------|:---------|:----------|:-----|
| lake surface albedo (direct, diffuse) | $\alpha_{L(d)}$ | GALB     | IJLSDM ,2 | [-]  |

- Internal parameters

| Meaning | Presentation     | Variable | unit | Header                         |
|:--------|:-----------------|:---------|:-----|:-------------------------------|
|         | $C_1, C_2, C_3$  | CC       | [-]  | $-0.7479, -4.677039, 1.583171$ |
|         | $\alpha_{L(2)} $ | ALBDIF   | [-]  | $0.06$                         |


For lake surface level albedo $\alpha_{L(d)}$, $d=1,2$ represents direct and scattered light, respectively.


Using the solar zenith angle at latitude $\theta$, the albedo for direct light is presented by

$$
	\alpha_{L(1)} = e^{(C_3A^* + C_2) A^* +C_1}
$$

where $A = \mathrm{min}(\mathrm{max}(\mathrm{cos}(\theta),0.03459),0.961) $

On the other hand, the albedo for scattered light is uniformly set to a constant parameter.

$$
	\alpha_{L(2)} = 0.06
$$

### 11.1.2 Lake surface roughness `[LAKEZ0F]`

- Outputs

| Meaning                        | Presentation | Variable | dimension | unit |
|:-------------------------------|:-------------|:---------|:----------|:-----|
| surface roughness for momentum | $r_{0,M}$    | GRZ0M    | IJLSDM    |      |
| surface roughness for heat     | $r_{0,H}$    | GRZ0H    | IJLSDM    |      |
| surface roughness for vapor    | $r_{0,E}$    | GRZ0E    | IJLSDIM   |      |

- Inputs

| Meaning        | Presentation | Variable | dimension | unit |
|:---------------|:-------------|:---------|:----------|:-----|
| u surface wind | $U_0$        | GDUA     | IJLSDM    |      |
| v surface wind | $V_0$        | GDVA     | IJLSDM    |      |


[surface flux section of MIROC-DOC](https://github.com/MIROC-DOC/model_description/blob/surface/draft/p-sfc.md)  will be transplanted after modification.

The roughness variation of the lake surface is determined by the friction velocity $u^\star$

$$
u^{\star} = \sqrt{C_{M_0} ({U_0}^2  +{V_0}^2)}
$$

The bulk coefficient for $u^\star$ (${C_{M_0}}$) is given as a parameter.

$r_{0,M},r_{0,H}$ and $r_{0,E}$ are surface roughness for momentum, heat, and vapor are presented by

$$
	r_{0,M} = z_{0,M_0} + z_{0,M_R} + \frac{z_{0,M_R} {u^\star }^2 }{g} + \frac{z_{0,M_S}\nu }{u^\star}
$$

$$
	r_{0,H} = z_{0,H_0} + z_{0,H_R} + \frac{z_{0,H_R} {u^\star }^2 }{g} + \frac{z_{0,H_S}\nu }{u^\star}
$$

$$
	r_{0,E} = z_{0,E_0} + z_{0,E_R} + \frac{z_{0,E_R} {u^\star }^2 }{g} + \frac{z_{0,E_S}\nu }{u^\star}
$$

Here, $\nu = 1.5 \times 10^{-5} \mathrm{[m^2/s]}$ is the kinetic viscosity of the atmosphere. $z_{0,M_0},z_{0,H_0}$ and $z_{0,E_0}$ are base, and rough factor ($z_{0,M_R},z_{0,M_R}$ and $z_{0,E_R}$) and smooth factor ($z_{0,M_S},z_{0,M_S}$ and $z_{0,E_S}$), respectively.

## 11.2 Lake surface heat balance `[LAKEHB]` [100% Written in Jan, 2021]

The comments for some variables say "soil", but this is because the program was adapted from a land surface scheme, and has no particular meaning.

- Outputs

| Meaning                | Presentation   | Variable | dimension | unit |
|:-----------------------|:---------------|:---------|:----------|:-----|
| surface water flux \*1 | $W_{free/ice}$ | WFLUXS   | IJLSDM,2  |      |
| upward long wave       | $LW^\uparrow$  | RFLXLU   | IJLSDM    |      |
| flux balance           | $F$            | SFLXBL   | IJLSDM    |      |


- Inputs variables

| Meaning                       | Presentation                      | Variable |
|:------------------------------|:----------------------------------|:---------|
| sensible heat flux coefficent | $\frac{\partial H}{\partial T_s}$ | DTFDS    |
| latent heat flux coefficient  | $\frac{\partial E}{\partial T_s}$ | DQFDS    |
| surface heat flux coefficient | $\frac{\partial G}{\partial T_s}$ | DGFDS    |
| downward SW radiation         | $SW^\downarrow$                   | RFLXSD   |
| upward SW radiation           | $SW^\uparrow$                     | RFLXLU   |
| downward LW radiation         | $LW^\downarrow$                   | RFLXLD   |
| lake surface albedo           | $\alpha$                          | GRALBL   |
| lake ice concentration        | $R_{ice}$                         | GRICR    |

- Modified in this subroutine

| Meaning                         | Presentation | Variable | dimension | unit |
|:--------------------------------|:-------------|:---------|:----------|:-----|
| skin temperature                | $T_s$        | GDTS     | IJLSDM    |      |
| surface heat flux from `LAKEBC` | $G$          | GFLUXS   | IJLSDM    |      |
| sensible heat flux              | $H$          | TFLUXS   | IJLSDM    |      |
| latent heat flux                | $E$          | QFLUXS   | IJLDSM    |      |

- Internal work

| Meaning                                         | Presentation                            | Variable | dimension |
|:------------------------------------------------|:----------------------------------------|:---------|:----------|
| latent heat for sublimation                     | $l_s$                                   | ESUB     |           |
| emissivity of the lake surface                  | $\epsilon$                              | EMIS     |           |
| black body radiation                            | $(1-\alpha)\sigma T_s^4 $               | STG      |           |
| dR/dTs                                          | $\frac{\partial R}{\partial T_s}$       | DRFDS    |           |
| net surface flux                                | $F^*$                                   | SFLUX    |           |
| net heat flux (downward positive)               | $G^*$                                   | GSFLUX   |           |
| The temperature derivative term of $G^*$        | $\frac{dG^*}{dT_s}$                     | DGSFDS   |           |
| surface heat flux for ice-free area             | $G_{free}$                              | GFLUXF   |           |
| sensible heat flux for ice covered area         | $\delta H_{ice}$                        | SFLUXBI  |           |
| temperature derivative term of $G_{ice}$        | $\frac{\partial G_{ice}}{\partial T_s}$ | DSBDSI   |           |
| surface temperature change for ice-covored area | $\Delta T_{ice}$                        | DTI      |           |
| latennt heat flux for ice covered area          | $E_{ice}$                               | EVAPI    |           |
| surface heat flux for ice covered area          | $G_{ice}$                               | GFLUXI   |           |
|                                                 | $1-R_{ice}$                             | FF       |           |
| lake ice fraction                               | $R_{ice}$                               | FI       |           |
|                                                 | $R_{ice}\Delta T_{ice}$                 | DTX      |           |

- Others (appeared in texts)

| Meaning                                                | Presentation | Variable | dimension | unit |
|:-------------------------------------------------------|:-------------|:---------|:----------|:-----|
| lake surface albedo for shortwave radiation (ice-free) | $\alpha_S$   |          | [-]       |      |
| the Stefan-Boltzmann constant                          | $\sigma$     | STB      |           |      |

Reference: [Hasumi, 2015, Appendices A](https://ccsr.aori.u-tokyo.ac.jp/~hasumi/COCO/coco4.pdf)

Downward radiative fluxes are not directly dependent on the condition of the sea surface, and their observed values are simply specified to drive the model. Shotwave emission from the sea surface is negligible, so the upward part of the shortwave radiative flux is accounted for solely by reflection of the incoming downward flux. Let $\alpha _S$ be the sea surface albedo for shortwave radiation. The upward shortwave radiative flux is represented by

$$
	SW^\uparrow = - \alpha_S SW^\downarrow
$$

On the other hand, the upward longwave radiative flux has both reflection of the incoming flux and emission from the lake surface. Let $\alpha$ be the lake surface albedo for longwave radiation and $\epsilon$ be emissivity of the lake surface relative to the black body radiation. The upward shortwave radiative flux is represented by

$$
	LW^\uparrow = - \alpha LW^\downarrow + \epsilon \sigma T_s ^4
$$

where $\sigma$ is the Stefan-Boltzmann constant and $T_s$ is skin temperature. If lake ice exists, snow or lake ice temperature is considered by fractions. When radiative equilibrium is assumed, emissivity becomes identical to co-albedo:

$$
	\epsilon = 1 - \alpha
$$

The net surface flux is presented by

$$
	F^*=H + (1-\alpha)\sigma T_s^4 + \alpha LW^\uparrow - LW^\downarrow +SW^\uparrow - SW^\downarrow		
$$

The heat flux into the lake surface is presented, with the surface heat flux calculated in `LAKEBC`

$$
	G^* = G - F^*
$$

Note that $G^*$ is downward positive.

The temperature derivative term is

$$
	\frac{\partial G^*}{\partial T_s} = \frac{\partial G}{\partial T_s}+\frac{\partial H}{\partial T_s}+\frac{\partial R}{\partial T_s}
$$

When the lake ice exists, the sublimation flux is considered

$$
	G_{ice} = G^* - l_s E
$$

The temperature derivative term is

$$
	\frac{\partial G_{ice}}{\partial T_s}=\frac{\partial G^*}{\partial T_s} + l_s\frac{\partial E}{\partial T_s}
$$

Finally, we can update the surface temperature with the lake ice concentration with $\Delta T_s=G_{ice} ( \frac{\partial G_{ice}}{\partial T_s})^{-1}$


$$
	T_s = T_s +R_{ice} \Delta T_s
$$

Then, the sensible and latent heat flux on the lake ice is updated.

$$
	E_{ice} = E + \frac{\partial E}{\partial T_s}\Delta T_s
$$

$$
	H_{ice} = H + \frac{\partial H}{\partial T_s}\Delta T_s
$$

When the lake ice does not existed, otherwise, the evaporation flux is added to the net flux.

$$
	G_{free}=F^* + l_cE
$$

Finally each flux is updated.

For the sensible heat flux, the temperature change on the lake ice is considered.

$$
	H=H+ R_{ice}  H_{ice}
$$

Then, the heat used for the temperature change is saved.

$$
	F = R_{ice} H_{ice}
$$

For the upward longwave radiative flux, the temperature change on the lake ice is considered.

$$
	LW^\uparrow=LW^\uparrow +  4\frac{\sigma}{T_s}R_{ice}  \Delta T_s
$$

For the surface heat flux, the lake ice  concentration is considered.

$$
	G=(1-R_{ice})G_{free} + R_{ice}G_{ice}
$$

For the latent heat flux, the lake ice  concentration is considered.

$$
	E=(1-R_{ice})E + R_{ice}E_{ice}
$$

Each term above are saved as freshwater flux.

$$
	W_{free} = (1-R_{ice}) E
$$

$$
	W_{ice} = R_{ice} E_{ice}
$$


## 11.3 Lake ice submodel `[LAKEIC]`  [100% Written in Jan, 2021]

The following is an addition based on [Hasumi, 2015, Appendix B1](https://ccsr.aori.u-tokyo.ac.jp/~hasumi/COCO/coco4.pdf).

A relatively simply lake ice model is based on two-category thickness representation, zero-layer thermodynamics [Semtner, 1976] and dynamics with elastic-visous-plastic rheology [Hunke and Dukowicz, 1997].

There are five prognostic variables in the lake ice model described herein: lake ice concentration $A_I$, which is area fraction of a grid covered by lake ice and takes a value between zero and unity; mean lake ice thickness $h_I$ over ice-covered part of a grid; mean snow depth $h_S$ over lake ice; and x and y direction horizontal velocity components of lake ice motion $u_I$ and $v_I$. The model calculates temperature at snow top (lake ice top when there is no snow cover) $T_I$, whic is a diagnostic variable. Density of lake ice ($\rho_I$) and snow $(\rho_S)$ are assumed to be constant Lake ice is assumed to have nonzero salinity, and its value $S_I$ is assumed to be a constant parameter.


### 11.3.1 Heat Flux and Growth Rate `MODULE[FIHEATL]`


- variables

| Meaning                                                                                            | Presentation | Variable | dimension              | unit   |
|:---------------------------------------------------------------------------------------------------|:-------------|:---------|:-----------------------|:-------|
| lake ice concentration                                                                             | $A_I$        | A        | IJLDIM                 | -      |
| Lake ice growth rate in ice-free area                                                              | $W_{AO}$     | WAO      | IJLDIM                 |        |
| air-ice heat flux multiplied by the factor of sea ice concentration                                | $Q_{AI}$     | QAI      | IJLDIM                 |        |
| vertical heat flux through sea ice and snow                                                        | $Q_{IO}$     | QIO      | IJLDIM                 |        |
| snow growth rate due to heat inbalance                                                             | $W_{AS}$     | WAS      | IJLDIM                 |        |
| basal growth rate of lake ice                                                                      | $W_{IO}$     | WIO      | IJLDIM                 |        |
| Shortwave radiation absorbed at ice-free lake surface, with the factor of ice-free area multiplied | $SW^A$       | SWABS    |                        |        |
| Lake temperature  /Salinity                                                                        | $T, S$       | T        | IJLDIM, NLZDIM, NLTDIM | ◦C/psu |
| time step                                                                                          | $\Delta t$   | TS       |                        |        |
| surfaceheat flux                                                                                   | $G$          | FT       | IJLDIM, NLTDIM         |        |


- Internal works

| Meaning                   | Presentation | Variable | dimension | unit |
|:--------------------------|:-------------|:---------|:----------|:-----|
| freezing point depression | $\Delta T$   | TDEV     |           |      |
| Sea ice growth rate       | $W_{FZ}$     | WFRZ     |           |      |

- parameters


| Meaning                                                   | Presentation                    | Variable | unit                | value                        |
|:----------------------------------------------------------|:--------------------------------|:---------|:--------------------|:-----------------------------|
| coeficient for a decreasing function of salinity          | $\frac{\partial T}{\partial S}$ | dtds     |                     | $-0.0543$                    |
| density of sea water                                      | $\rho_O$                        | rhoo     | $\mathrm{g/cm^3}$   | $1.0$                        |
| latent heat cofefficient to melt                          |                                 | emeltl   | $\mathrm{J/kg}$     | $3.4 \times 10^5$            |
| latent heat fusion \*3                                    | $L_f$                           | hfus     | $\mathrm{erg/g}$    | $E_l \times 1.0 \times 10^4$ |
|                                                           | $\frac{1}{\rho_O L_f}$          | rrhfus   | $\mathrm{cm^3/erg}$ | $1.0 /\rho_I/L_f$            |
| fraction of $SW^A$ absorbed by the lake model's top level | $I(z=2)$                        | SWCNV1   | $\mathrm{ND}$       |                              |
| heat capacity of lake water                               | $C_{po}$                        | cpo      | $\mathrm{erg/g/K}$  | $3.990\times 10^7$           |
| thickness of the lake model's top level                   | $D_1$                           | DZ1      | $\mathrm{cm}$       | $1.0\times 10^2$             |


*3 same value is applied to snow and sea ice.

The following is an addition based on [Hasumi, 2015, Appendix B1.1](https://ccsr.aori.u-tokyo.ac.jp/~hasumi/COCO/coco4.pdf).

This section is actually the same with

Let us consider here a case that the model is integrated from the n-th time level to the (n+1)-th time level. $A_I$, $h_I$ and $h_S$ are incrementally modified in the following order.

Temperature at lake ice base is taken to be the lake model’s top level temperature $T(k=2)$. In this model, lake ice exists only when and where $T(k=2)$ is at the freezing point $T_f$, which is a decreasing function of salinity ($T_f= −0.0543 S \mathrm{[℃]}$ is used here, where temperature and salinity are measured by ◦C and psu, respectively). In heat budget calculation for snow and lake ice, only latent heat of fusion and sublimation is taken into account, and heat content associated with temperature is neglected. Therefore, temperature inside sea ice and snow are not calculated, and $T_I$ is estimated from surface heat balance.

Nonzero minimum values are prescribed for $A_I$ and $h_I$ , which are denoted by $A^{min}_I$ and $h^{min}_I$, respectively. These parameters define a minimum possible volume of sea ice in a grid. If a predicted volume $A_Ih_I$ is less than that minimum, $A_I$ is reset to zero, and $T_1$ is lowered to compensate the corresponding latent heat. In this case, the lake model’s top level is kept at a supercooled state. Such a state continues until the lake is further cooled and the temperature becomes low enough to produce more lake ice than that minimum by releasing the latent heat corresponding to the supercooling.

Surface heat flux is separately calculated for each of air-sea and air-ice interfaces in one grid.

The surface temperature of lake ice $T_I$ is determined such That

$$
	Q_{AI} = Q_{IO}
$$

is satisified, where $Q_{IO}$ is corresponding to $G+SW^\downarrow$ and $Q_{AI}$ is corresponding to $G_{ice} - W_{ice}$. However, When the estimated $T_I$ exceeds the melting point of lake ice $T_m$ (which is set to 0 ◦C for convenience), $T_I$ is reset to $T_m$ and $Q_{AI}$ and $Q_{IO}$ are re-estimated by using it. The heat inbalance between $Q_{AI}$ and $Q_{IO}$ is consumed to melt snow (lake ice when there is no snow cover). Snow growth rate due to this heat imbalance is estimated by

$$
	W_{AS} = \frac{Q_{AI}-Q_{IO}}{\rho L_f}
$$

where $\rho_O$ is density of seawater and $L_f$ is the latent heat of fusion (the same value is applied to snow and lake ice). This growth rate is expressed as a change of equivalent liquid water depth per time.  It is zero when $T_I < T_m$ and negative when $T_I = T_m$. Note that $W_{AS}$ is weighted by lake ice concentration.

Although it is assumed that $T(2) = T_f$ when lake ice exists, $T_1$ could deviated from $T_f$ due to a change of salinity or other factors. Such deviation should be adjusted by forming or melting lake ice. Under a temperature deviation of the top layer of lake,

$$
	\Delta T = T(k=2) - T_f S(k=2)
$$

lake ice growth rate necessary to compensate it in the single time step is given by

$$
	W_{FZ} = - \frac{C_{po} \Delta T \Delta z_1}{L_f \Delta t}
$$

where $C_{po}$ is the heat capacity of lake water and $\Delta z_1=100 \mathrm{cm}$ is the thickenss of the lake model's top level (uniformly set to constant in case of the current lake model.) This growth rate is estimated at all grids, irrespective of lake ice existence, for a technical reason. As described below, this growth rate first estimates negative ice volume for ice-free grids, but the same heat flux calculation procedure as for ice-covered grids finally results in the correct heat flux to force the lake. Basal growth rate of lake ice is given by

$$
	W_{IO} = A_I W_{FZ} + \frac{Q_{IO}}{\rho_OL_f}
$$

where, again, $W_{IO}$ is weighted by lake ice concentration.

Lake ice formation could also occur in the ice-free area. Let us define $Q_{AO}$ by

$$
	Q_{AO} = (1-A_{I}) [Q-(1-\alpha_s)SW^\downarrow]
$$

i.e., air-lake heat flux except for shortwave, multiplied by the factor of the fraction of ice-free area. Here, $Q$ is  air-ice heat flux. Shortwave radiation absorbed at ice-free lake surface, with the factor of ice-free area multiplied, is represented by

$$
	SW^A = (1-A_I)(1-\alpha_S) SW^\downarrow
$$

Lake ice growth rate in ice-free area is calculated by

$$
	W_{AO} = (1-A_I)W_{FZ} + \frac{Q_{AO}+I(k=2) SW^A}{\rho_O L_f}
$$

where $I(k=2)$ denotes the fraction of $SW^A$ absorbed by the lake model's top level, which is calculate in `[SVTSETL]` in lakepo.F.

Finaly, the heat flux for freshwater is

$$
	G_{lake} = \Delta z_1 \frac{\Delta T }{\Delta t}
$$

### 11.3.2 Sublimation of Sea Ice`MODULE[FWATERL]`

- variables

| Meaning                         | Presentation   | Variable | dimension | unit          |
|:--------------------------------|:---------------|:---------|:----------|:--------------|
| lake ice fraction               | $A_I'$         | AX       | IJLDIM    |               |
| lake ice thickenss              | $h_I'$         | HIX      | IJLDIM    |               |
| Snow depth                      | $h_S'$         | HSX      | IJLDIM    |               |
| latent heat flux of evaporation | $F_W^{EV}$     | WEV      |           |               |
| latent heat flux of sublimation | $F_W^{SB}$     | WSB      | IJLDIM    | \mathrm{cm/s} |
|                                 | $\Delta F_W$   | WDIF     |           |               |
| time step                       | $\Delta t$     | TS       |           |               |
| latent heat flux of evaporation | $F_W^{EV}$     | EVAP     | IJLDIM    |               |
| latent heat flux of sublimation | $F_W^{SB}{''}$ | SUBI     | IJLDIM    |               |


- Internal variables

| Meaning                | Presentation | Variable | dimension | unit |
|:-----------------------|:-------------|:---------|:----------|:-----|
| Lake ice concentration | $A_I^n$      | AZ       | IJLDIM    |      |
| Snow depth             | $h_S^n$      | HSZ      | IJLDIM    |      |
| lake ice thickness     | $h_I^n$      | HIZ      | IJLDIM    |      |

- parameters

| Meaning                       | Presentation | Variable | unit              | value           |
|:------------------------------|:-------------|:---------|:------------------|:----------------|
| density of snow               | $\rho_S$     | rhos     | $\mathrm{g/cm^3}$ | $0.33$          |
| density of lake ice           | $\rho_I$     | rhoi     | $\mathrm{g/cm^3}$ | $0.9$           |
| Ratio of density (ocean/snow) | $R_{\rho_S}$ | rrs      | [-]               | $\rho_O/\rho_s$ |
| Ratio of density (ocean/ice)  | $R_{\rho_I}$ | rri      | [-]               | $\rho_O/\rho_I$ |
| Minimum thickness of ice      | $h_I^{min}$  | himin    |                   | 1.0\times 10^1  |


The following is an addition based on [Hasumi, 2015, Appendix B1.2](https://ccsr.aori.u-tokyo.ac.jp/~hasumi/COCO/coco4.pdf).

Sublimation (freshwater) flux, which is practically come from the land ice runoff, is calculated or prescribed over lake ice cover. The flux is first consumed to reduce snow thickness in n-th timstep:

$$
	h_S' = h_S^n -  \frac{\rho_O  F_W^{SB}\Delta t}{\rho_S A_I^n}
$$

If $h_S'$ becomes less than zero, it is reset to zero.  Then, the melted snow flux is added to $F_W^{SB}$. $F_W^{SB}$ is redefined by

$$
	F_W^{SB}{'} = F_W^{SB} + \frac{\rho_S A_I^n (h_S' - h_S^n)}{\rho_O\Delta t}
$$

Where there no remains snow, but $F_W^{SB}{'}$ is not zero, The remain flux is consumed to reduce sea ice thickness:

$$
	h_I' = h_I^n - \frac{\rho_O F_W^{SB}{'} \Delta t }{\rho_I A_I^n}
$$

If $h_I'$ becomes less than $h_I^{min}$, it is reset to zero. Then,  the melted iceflux is added to $F_W^{SB}{'}$. $F_W^{SB}{'}$ is redefined by

$$
	F_W^{SB}{''} = F_W^{SB}{'} - A_I^n \frac{\rho_S (h_I^n-h_I')}{\rho_O\Delta t}
$$

Finaly, nonzero $F_W^{SB}{''}$ is consumed to reduce lake ice concentration:

$$
	A_I' = A_I^n - \frac{R_{\rho_I}F_W^{SB}{''} \Delta t }{h_I^{min}}
$$

if $A_I'$ becomes less then 0, it is reset to zero. Even if $A_I'$ becomes less than $A_I^{min}$, on the other hand, it is not adjusted here. If $A_I'$ is adjusted to zero, it means that the sublimation flux is not used up by eliminating snow and lake ice.

The remaining part is consumed to reduce lake water, so the evaporation flux $F_W^{EV}$ is modified as


$$
	F_W^{EV} = F_W^{EV} + F_W^{SB} + \frac{(A_I'-A_I^n) h_I^{min}}{R_{\rho_I}\Delta t}
$$

The later two terms cancel out if the adjustment does not take place.

If there is no lake ice, evaporation flux is just as

$$
	F_W^{EV}{'} = F_W^{EV} + F_W^{SB}
$$

The adjusted evaporation flux is saved

$$
	\Delta F_W^{EV} = F_W^{EV}{'}-	F_W^{EV}
$$

When sublimation flux is consumed to reduce lake ice amount, salt contained in lake ice has to be added to the remaining lake ice or the underlying water. Otherwise, total salt of the ice-lake system is not coserved. Here, it is added to underlying water, and the way of this adjustment is described later. Nothe that lake ice tends to gradually drain high salinity water contained in brine pockets in reality. Thus, such an adjustment is not very unreasonable. When $A_I'$ is adjusted to zero, on the other hand, the remaining sublimation flux is consumed to reduce lake water. In this case, difference between the latent heat of sublimation and evaporation has to be adjusted, which is also described later.

If the ice and/or snow is too thick, they are converted to snow flux. Here, the overflow snowflux $S_{off}$ is added to ${F_W^{SN}}$

$$
	F_W^{SN} = F_W^{SN} + S_{off}
$$

$S_{off}$ is actually calculated in `MATDRV` and handed to `LAKEIC`.

### 11.3.3 Update snow and ice volume `[PCMPCTL]`

The lake ice fraction is updated, using the lake ice growth (retreat) rate in ice-free area $W_{AO}$:

$$
	{A_I^{n+1}} = {A_I'} +\frac{\rho_O }{\rho_I h_I \phi W_{AO}\Delta t}
$$

If $A_I^{n+1}$ becomes greater than 1, it is reset to 1, and if $A_I^{n+1}$ becomes smaller than zero, it is reset to zero.


### 11.3.4 Growth and Melting `[PTHICKL]`

- variables

| Meaning                                    | Presentation            | Variable | dimension      | unit |
|:-------------------------------------------|:------------------------|:---------|:---------------|:-----|
| lake ice fraction                          | $A_I^{n+1}$             | AX       | IJLDIM         |      |
| lake ice volume                            | $V_I$                   | AXHIX    | IJLDIM         |      |
| lake snow volume                           | $V_S, V_S', V_S^{**}$   | AXHSX    | IJLDIM         |      |
| lake ice volume                            | $V_I$                   | AXHIXN   | IJLDIM         |      |
|                                            |                         | AXHSXN   | IJLDIM         |      |
| lake ice thickenss                         | $h_I'$                  | HIX      | IJLDIM         |      |
| Snow depth                                 | $h_S'$                  | HSX      | IJLDIM         |      |
| Snow depth                                 | $h_S^n$                 | HSZ      | IJLDIM         |      |
| lake ice thickness                         | $h_I^n$                 | HIZ      | IJLDIM         |      |
| snow growth rate due to heat inbalance     | $W_{AS}$                | WAS      | IJLDIM         |      |
| lake ice growth rate due to heat inbalance | $W_{AI}$                | WAI      | IJLDIM         |      |
| Reduced heat flux                          | $W_{res}$               | WRES     | IJLDIM         |      |
| basal growth rate of lake ice              | $W_{IO}$                | WIO      | IJLDIM         |      |
| snow fall flux                             | $F_W^{SN}, {F_W^{SN}}'$ | SNOW     | IJLDIM         |      |
| Lake ice growth rate in ice-free area      | $W_{AO}$                | WAO      | IJLDIM         |      |
| precipitation flux                         | $F_W^{PR}$              | PREC     | IJLDIM         |      |
| latent heat flux of evaporation            | $L_e$                   | EVAP     | IJLDIM         |      |
| latent heat flux of sublimation            | $$                      | SUBI     | IJLDIM         |      |
| Lake ice concentration                     | $A_I'$                  | AZ       | IJLDIM         |      |
|                                            |                         | ROFF     | IJLDIM         |      |
|                                            |                         | ADJLAT   | IJLDIM         |      |
| lake heat flux                             | $H_{lake}$              | FT       | IJLDIM, NLTDIM |      |
|                                            |                         | FS       | IJLDIM         |      |
| time step                                  | $\Delta t$              | TS       |                |      |

- parameters

| Meaning                       | Presentation | Variable | unit              | value               |
|:------------------------------|:-------------|:---------|:------------------|:--------------------|
| density of snow               | $\rho_S$     | rhos     | $\mathrm{g/cm^3}$ | $0.33$              |
| density of lake ice           | $\rho_I$     | rhoi     | $\mathrm{g/cm^3}$ | $0.9$               |
| Ratio of density (ocean/snow) | $R_{rho_I}$  | rrs      | [-]               | $\rho_O/\rho_s$     |
| Ratio of density (ocean/ice)  | $R_{rho_I}$  | rri      | [-]               | $\rho_O/\rho_I$     |
| Minimum thickness of ice      | $h_I^{min}$  | himin    |                   | $1.0\times 10^1$    |
|                               |              | AMIN     |                   | $1.0\times 10^{-6}$ |
|                               |              | AMAX     |                   | $1.0$               |
|                               |              | SI       |                   | $0.0$               |
|                               |              | SREF     |                   | $3.5\times 10^1$    |
|                               |              | AIH      |                   | $2.0\times 10^8$    |
|                               |              | AIHB     |                   | $2.0\times 10^2$    |


以下、[Hasumi, 2015, Appendix B.1.3 and B.1.4 ](https://ccsr.aori.u-tokyo.ac.jp/~hasumi/COCO/coco4.pdf)をもとに加筆修正。


The lake ice volume $V_I'$ and snow volume $V_S'$ before the snow and ice growth are presented by

$$
	V_I' = A_I' h_I^n
$$

$$
	V_S' = A_I' h_S^n
$$

From here, let us consider the contribution of snowfall and freshwater fluxes to the growth.

- Snowfall flux to snow

Changes of snow depth due to snow fall (freshwater) flux $F_W^{SN}$ (expressed by negative values to be consistent with other freshwater flux components) is first taken into account. $F_W^{SN}$ is not weighted by lake ice concentration or ice-free area are fraction, as snowfall take place for both regions.

If the newly predicted (in `PCMCTL`) lake ice concentration $A_I^{n+1}$ is zero, the amount of snow existed before the growth is added to the snowfall flux.

$$
	{F_W^{SN}}' = F_W^{SN} + \frac{\rho_S V_S'}{\rho_O \Delta t}
$$

Snow depth and amount is set to zero:

$$
	h_S'=0, \quad V_S^{**} = 0
$$

Otherwise, snowfall accumulates over the ice covered region. Snow depth is modified by

$$
	h_S^* = \frac{V_S'}{A_I^{n+1}} + \frac{\rho_O F_W^{SN}\Delta t}{\rho_S}
$$

And the snow amount is also modifie by

$$
	V_S^* = A_I^{n+1} h_S^*
$$

The snowfall flux is reduced by that amount:

$$
	{F_W^{SN}}' = (1-A_I^{n+1}) F_W^{SN}
$$

Then, the snowfall flux is put together with the precipitation flux.

$$
	F_W^{PR} = F_W^{PR} + {F_W^{SN}}'
$$

- Freshwater flux for snow growth

When the lake ice is not existed ($A_I^{n+1}=0$), the snow amount grown above is converted to ice. Growth rate of the lake ice is presented by:

$$
 W_{AI}^* =   \frac{\rho_O V_S^{*}}{\rho_S \Delta t}
$$

When the lake ice existed, if the snow growth rate
$$
	W_{AS}^* = W_{AS} +  \frac{\rho_O V_S^{*}}{\rho_S \Delta t}
$$

is positive, the energy is used for the snow growing. Otherwise, $W_{AS}^*$ is assumed to reduce the lake ice.

$$
	W_{AI}^* = W_{AS}^*
$$

and deficient flux is come from the snow amount changes.

$$
	W_{AS}^* = - \frac{\rho_O V_S^{*}}{\rho_S \Delta t}
$$


Then, the snow depth is modified with the accumulation.

$$
	h_S^{**} = \frac{V_S^{*}+ \rho_O W_{AS} \Delta t}{\rho_S {A_I^{n+1}}}
$$

if $h_S'$ is less than 0, it is reset to zero.


- Freshwater flux for ice growth


When the lake ice is not existed, the flux is just handed to the lake surface.


$$
	W_{IO}^* = W_{IO} + W_{AI}^*
$$

When the lake ice exists ($A_I^{n+1}>0), if the ice growth rate

$$
	W_{AI}^* = W_{AI} + \frac{V_I^{*}}{R_{\rho_I \Delta t}}
$$

is negative, the flux is handed to the lake surface.

$$
		W_{IO}^* = W_{IO} + W_{AI}^*
$$

and deficient flux is come from the lake amount changes.

$$
	W_{AI}^* = - \frac{V_I^{*}}{R_{\rho_I \Delta t}}
$$

The amount of the ice is then updated,

$$
	V_I^* = V_I' + \frac{\rho_O W_{AI}\Delta t}{\rho_I}
$$

- Get the variables in the new timestep (n+1)

For the snow amount,

$$
	V_S^{n+1} = A_I^{n+1} h_S^{**}
$$

For the ice amount

$$
	V_I^{n+1} = V_I^* + \frac{\rho_O (W_{IO}+W_{AO})\Delta t}{\rho_I}
$$

If $V_I^{n+1}$ is equal or less than 0, lake ice fraction is set to zero (A_I^{n+1}=0)and its thickness is set to $h_I^{min}$. Otherwise,

$$
	h_I^{***} = \frac{V_I^{n+1}}{A^*}
$$

If $h_I^{***}$ is smaller than $h_I^{min}$, it is set t0 $h_I^{min}$ and the lake ice concentration is adjusted.

$$
	A_I^{n+1} = \frac{V_I^{n+1}}{h_I^{min}}
$$

If the $A_I^{n+1}$ is less than $A_I^{min}$, it is set to 0. If the $A_I^{n+1}$ is larger than $A_I^{max}=1$, it is set to $A_I^{max}$.

Let us consider the case of the ice is very thick.  Here, the remained volume, which is not covered by ice is considered.

$$
	V_0^{free} = (A_{max}-A_{min})h_I^{min}
$$

$$
	V^{free} = (A_{max}-A_I^{n+1})h_I^{*** }
$$

If $V^{free}>V_0^{free}$, the ice thickness is increased, by adding $V^{free}$

![](lakeice_volume.jpeg)

$$
	h_I^{*** } = V^{free} + \frac{A_I^{n+1} h_I^{m+1}}{A_I^{max}}
$$

The deficient water is come from the snow. The snow depth is now updated

$$
	h_S^{*** } = A_I^{n+1}\frac{h_S^{***}}{A_{max}-\frac{V_0^{free}}{h_I^{*** }}}
$$

Finally, check if the snow is under water.

$$
	h_S^{n+1} = \mathrm{min}(h_S^{*** }, \frac{\rho_O-\rho_I}{\rho_S}h_I^{*** })
$$

and the ice thickness is also updated.

$$
	h_I^{n+1} = h_I^{*** } + \frac{\rho_S}{\rho_I} (h_S^{*** }-h_S^{n+1})
$$

The growth rate of the lake ice is

$$
	W_I^n = \frac{\rho_S A_I^{n+1}h_I^{n+1} - V_I'}{\rho_I \Delta t}
$$

$$
	W_I^{n+1} = \frac{\rho_S A_I^{n+1}h_I^{n+1} - V_I^{n+1}}{\rho_I \Delta t}
$$

The growth rate of the snow is

$$
	W_S^n =  \frac{\rho_S A_I^{n+1}h_S^{n+1} - V_S'}{\rho_S \Delta t}
$$


$$
	W_S^{n+1} =  \frac{\rho_S A_I^{n+1}h_S^{n+1} - V_S^{n+1}}{\rho_S \Delta t}
$$

The surface salinity flux $F_S$ is

$$
	F_S = S_I(W_I-F_W^{SB}{''})
$$

The freshwater flux $F_W$ is

$$
	F_W(1) = - F_W + \frac{L_f}{C_p} \Big(W_I^{n+1}+W_S^{n+1}-Sn + \Delta F_W^{EV}\Big)
$$

塩分変化に関係する分？

$$
	F_W(2) =F_W^{EV} - F_W^{PR} - R_{off} + W_S^n + W_I^n
$$

## 11.4 Physical formulation & processes `[LAKEPO]`  [20% Written in Jan, 2021]
`lakepo.F`


### Set parameters

#### Diffusion tracer flux `[VDIFFL]`


- Inputs

Though several valuables are written, they are not used here.

- Outputs

| Meaning                        | Presentation | Variable | dimension      | unit |
|:-------------------------------|:-------------|:---------|:---------------|:-----|
| vertical diffusion coefficient | $K_V$        | AHV      | IJLDIM, NLZDIM |      |

- Parameters

| Meaning                                             | Presentation | Variable        | unit | value         |
|:----------------------------------------------------|:-------------|:----------------|:-----|:--------------|
| vertical diffusion coefficient at the surface layer | $K_{V0}$     | AHVL0(NZ=KLMAX) |      | $k\times 1.0$ |

The case considered in COCO4 is that( [Hasumi, 2015, Section 1.2](https://ccsr.aori.u-tokyo.ac.jp/~hasumi/COCO/coco4.pdf)):
1. Diffusive flux of tracer follows the Fick's law.
2. Diffusuion coefficient tensor is diagonal, and its horizontal component is identical.

Here, the vertical diffusion coefficent $K_V$ is simply set as

$$
	K_V(k) = K_{V0} k
$$

#### 11.3.2 Estimate the advection and diffusion terms of the tracer equations `[FLXTRCL]`

- Inputs

| Meaning                        | Presentation | Variable | dimension              | unit |
|:-------------------------------|:-------------|:---------|:-----------------------|:-----|
| vertical diffusion coefficient | $K_V$        | AHV      | IJLDIM, NLZDIM         |      |
| water temperature              | $T$          | TX       | IJLDIM, NLZDIM, NLTDIM |      |
| water depth                    | $h$          | HX       | IJLDIM                 |      |

- Outputs

| Meaning                                     | Presentation                   | Variable | dimension              | unit |
|:--------------------------------------------|:-------------------------------|:---------|:-----------------------|:-----|
| vertical component of diffusive tracer flux | $F_D$                          | ADT      | IJLDIM, NLZDIM, NLTDIM |      |
|                                             | $\frac{F_D}{D(k-\frac{1}{2})}$ | DIFFZ    | IJLDIM, NLZDIM         |      |

- Internal variables

| Meaning | Presentation | Variable | dimension              | unit |
|:--------|:-------------|:---------|:-----------------------|:-----|
|         |              | TH       | IJLDIM, NLZDIM, NLTDIM |      |
|         | $h'$         | HZBOT    | IJLDIM                 |      |

-Parameters

| Meaning                                                      | Presentation | Variable      | unit          | value                              |
|:-------------------------------------------------------------|:-------------|:--------------|:--------------|:-----------------------------------|
| thickness of each lake level                                 | $D$          | DZ(NLZDIM)    | $\mathrm{cm}$ | $0, S_0(1), S_0(2), S_0(3),S_0(4)$ |
|                                                              | $S$          | DS(NLZDIM)    | $\mathrm{ND}$ |                                    |
| thickness of the lake model’s top level                      | $D_1$        | DZ1           | $\mathrm{cm}$ | $1.0\times 10^2$                   |
| Ratio of the thickness of the each layer in sigma coordinate | $S_0$        | DS0(NLZDIM-1) | $\mathrm{ND}$ | $0.1, 0.1, 0.2, 0.6$               |

Supposing that the thickness of the 1st top layer ($k=2$) is $D_1$,

$$
	D(2) = D_1
$$

 the thickness of the remaining water column ($h'$) is presented by

$$
	h' = h - D_1
$$

The thickness of each remaining layer ($k=3,4,5,6$) is

$$
	D(k) = S(k) {h'}
$$

Then, the component of the diffusive tracer flux is represented by

$$
	F_D = K_V \frac{\partial T}{\partial z}
$$

practically,

$$
	F_D(k) = K_V(k) \frac{T(k-1)-T(k)}{\frac{D(k-1)+D(k)}{2}} - K_V(k+1) \frac{T(k)-T(k+1)}{\frac{D(k)+D(k+1)}{2}}
$$



#### SLVTRCL

- Inputs

| Meaning                                     | Presentation                   | Variable | dimension              | unit                    |
|:--------------------------------------------|:-------------------------------|:---------|:-----------------------|:------------------------|
| vertical component of diffusive tracer flux | $F_D$                          | ADT      | IJLDIM, NLZDIM, NLTDIM |                         |
|                                             | $\frac{F_D}{D(k-\frac{1}{2})}$ | DIFFZ    | IJLDIM, NLZDIM         |                         |
| minimum depth of lake                       |                                | HXMIN    |                        | $\mathrm{cm}$           |
| heat flux                                   |                                | FT       |                        | $\mathrm{K cm/s}$       |
| absorbed shortwave                          |                                | SWABS    |                        | $\mathrm{erg/cm^2/sec}$ |
|                                             |                                | FS       |                        |                         |
| time step                                   | $\Delta t$                     | TS       |                        |                         |
| surface-type fraction (lake)                | $$                             | LKFRAC   | IJLDIM                 | [-]                     |

- Outputs

| Meaning              | Presentation | Variable | dimension | unit          |
|:---------------------|:-------------|:---------|:----------|:--------------|
| lake water deficient |              | XHD      | IJLDIM    | $\mathrm{cm}$ |

$$
	A_A(k) = -\frac{K_V(k)}{\frac{D(k-1)+D(k)}{2}} \Delta t
$$

$$
	A_C(k) = -\frac{K_V(k+1)}{\frac{D(k)+D(k+1)}{2}} \Delta t
$$

$$
	A_B(k) = D)k-A_A(k)-A(k)
$$

- THOMASL
Solve the linear equations expressed by tri-diagonal matrix. (original files ./ocean/utrdg.F)

Then,
$$
	T(k)=T(k)+ F_D(k)\Delta t
$$



$$
	h_D = -F_T \Delta t
$$

$$
	V_D = \mathrm{max}(h_{min}-h - h_D, 0) R_{lake}
$$

$$
	h_D = \mathrm{max}(h_D,h_{min}-h)
$$

Then, the deficient water is added.

$$
	h = h + h_D
$$

$$
	h_{BOT}=h-D_1
$$


ここで、

If $h_D\ge0$, $D^{top}=h_D S(\mathrm{KLEND})$ and $D^{bottom}=0$

If $h_D\ge0$,
下からループ

$$
	T(k) = T(k) + \frac{  T(k-1) D^{top}}{h_{BOT}S(k)}
$$

$$
	D
$$


#### OVTURNL


Reference: [Hasumi, 2015, Section 4.1](https://ccsr.aori.u-tokyo.ac.jp/~hasumi/COCO/coco4.pdf)


Let us consider finite difference discretization of a flux-form, one-dimensional advection equation for tracer $\psi$.

$$
	\frac{\partial \psi}{\partial t} + \frac{\partial}{\partial z} (w\psi) = 0
$$

- Inputs

| Meaning                 | Presentation | Variable | dimension | unit |
|:------------------------|:-------------|:---------|:----------|:-----|
| $depth of water column$ | $h$          | H        |           |      |
| time step               | $\Delta t$   | TS       |           |      |

- Outputs

| Meaning | Presentation | Variable | dimension | unit |
|:--------|:-------------|:---------|:----------|:-----|
|         |              | R        |           |      |


The unit of XHD will be changed to $\mathrm{kg/m2}$ after this module (in `MATDRV`).

### 11.3.1 Setting vertical diffusion and viscosity coefficients `[VDIFFL]`



Reference: [Hasumi, 2015, Section 1](https://ccsr.aori.u-tokyo.ac.jp/~hasumi/COCO/coco4.pdf)





- Variables

| Meaning                                                            | Presentation          | Variable | dimension      | unit          |
|:-------------------------------------------------------------------|:----------------------|:---------|:---------------|:--------------|
| the fraction of shortwave radiation absorved by the lake's z-level |                       | SWCONV   | IJLDIM, NLZDIM | $\mathrm{ND}$ |
|                                                                    |                       | AA       | IJLDIM, NLZDIM |               |
|                                                                    |                       | AB       | IJLDIM, NLZDIM |               |
|                                                                    |                       | AC       | IJLDIM, NLZDIM |               |
|                                                                    |                       | DH       | IJLDIM         |               |
| thickness of the layers from the 2nd to the bottom                 | $h_B$                 | HZBOT    | IJLDIM         | $\mathrm{cm}$ |
|                                                                    |                       | HXBOT    | IJLDIM         |               |
|                                                                    |                       | DZB      | IJLDIM         |               |
|                                                                    |                       | DZT      | IJLDIM         |               |
|                                                                    | $I^{-\frac{1}{2}}(z)$ | RADUP    |                | $\mathrm{ND}$ |
| shortwave radiation flux at an arbitrary depth                     | $I^{+\frac{1}{2}}(z)$ | RADDN    |                | $\mathrm{ND}$ |
| Depth of each level                                                | $D_H$                 | DEPTH    |                | $\mathrm{cm}$ |
| the fraction of shortwave radiation absorved by the lake's z-level | $\Delta I(z)$         | SWCNV1   | NLZDIM         | $\mathrm{ND}$ |
| total of abrsorbed shortwave radiation                             |                       | TSWCNV   | IJLDIM         | $\mathrm{ND}$ |


- parameters

| Meaning                                              | Presentation                    | Variable     | unit                | value                        |
|:-----------------------------------------------------|:--------------------------------|:-------------|:--------------------|:-----------------------------|
|                                                      | $E_l$                           | emeltl       | $\mathrm{J/kg}$     | $\mathrm{3.4\times 10^5}$    |
| density of sea water                                 | $\rho_O$                        | rhoo         | $\mathrm{g/cm^3}$   | $1.0$                        |
| density of sea ice                                   | $\rho_I$                        | rhoi         | $\mathrm{g/cm^3}$   | $0.9$                        |
| density of snow                                      | $\rho_S$                        | rhos         | $\mathrm{g/cm^3}$   | $0.33$                       |
| latent heat fusion                                   | $L_f$                           | hfus         | $\mathrm{erg/g}$    | $E_l \times 1.0 \times 10^4$ |
|                                                      | $\frac{1}{\rho_O L_f}$          | rrhfus       | $\mathrm{cm^3/erg}$ | $1.0 /\rho_I/L_f$            |
| heat capacity of lake water                          | $C_{po}$                        | cpo          | $\mathrm{erg/g/K}$  | $3.990\times 10^7$           |
| heat capacity of lake ice                            | $C_{pi}$                        | cpi          | $\mathrm{erg/g/K}$  | $2.093\times 10^7$           |
| coeficient for a decreasing function of salinity     | $\frac{\partial T}{\partial S}$ | dtds         |                     | $-0.0543$                    |
|                                                      |                                 | dtdz         |                     | $-7.59\times 10^{-6}$        |
| fraction of the fast-attenuating portion             | $R$                             | RRR          |                     | $5.0\times 10^{-1}$          |
| length scale for fast-attenuating portion            | $\zeta_1$                       | ZETA1        |                     | $3.5\times 10^1$             |
| length scale for deeply penetrating spectral portion | $\zeta_2$                       | ZETA2        |                     | $2.3\times 10^3$             |
| thickness of the lake                                | $D(z)$                          | DZ(NZ=KLMAX) | $\mathrm{cm}$       | `DZ1`                        |
|                                                      | $S(z)$                          | DS(NZ=KLMAX) | $\mathrm{ND}$       | `DS0(K-KLSTR)`               |
| thickness of the lake model's top level              | $D(1) $                         | DZ1          | $\mathrm{cm}$       | $1.0\times 10^2$             |
|                                                      | $S_0(z)$                        | DS0(NZ-1)    | $\mathrm{ND}$       | $0.1, 0.1, 0.2, 0.6$         |

- $\mathrm{erg}=10^{-7} \mathrm{J}$

Reference: [Hasumi, 2015, Section 3.2.4](https://ccsr.aori.u-tokyo.ac.jp/~hasumi/COCO/coco4.pdf)


Then, the depth of each level is presented by

$$
	H(k) = \sum _{k=2} ^{k-1} H +D(k)
$$

While incoming downward longwave radiation is completely absorbed within a very thin surface layer, shortwave radiation can penetrate significantly into depths. In order to take account of its effect, shortwave radiation flux at an arbitary depth in the ocean is parameterized by

$$
	 I^{+\frac{1}{2}}(z)  = R e^{-\frac{D(z)}{\zeta_1}} + (1- R)e^{-\frac{D(z)}{\zeta_2}}
$$

$$
	\Delta I(z) = I^{-\frac{1}{2}}(z) - I^{+\frac{1}{2}}(z)
$$

where $I(0)=1.0$. Here, shortwave radiation is split into two portions: one is a fast-attenuating spectral portion and the other is a deeply penetrating spectral portion, and these two portions attenuate with length scales of $\zeta_1$ and $\zeta_2$, respectively. $\Delta I(z=2)$ is handed to the lake ice scheme (hence $\Delta I(z=2)$ is set to zero).

The residual is absorbed by the bottom layer.

$$
	\Delta I(z_{max}+1) = 1- \Sigma _{z=2}^{z_{max}}
$$

For the preparation of the next step, the unit of $\Delta I(z)$ is modified. The new variable is represented as $\Delta I_{tmp}(z)$ here.

$$
	\Delta I_{tmp}(z) = \frac{\Delta I(z)}{\rho_O {C_p}_o}
$$




### THOMASL


### 11.3.4 Convective adjustment for the unstable water column `[OVTSETL]`

Reference: [Hasumi, 2015, Section 4.4](https://ccsr.aori.u-tokyo.ac.jp/~hasumi/COCO/coco4.pdf)
