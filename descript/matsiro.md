# 11 Lake

The lake program is based on the ocean model COCO, hence this section follows [Hasumi (2015)](https://ccsr.aori.u-tokyo.ac.jp/~hasumi/COCO/coco4.pdf) with neccessary modifications.

Dimensions of the lake scheme is defined in `include/zkg21c.F`. `KLMAX` is the number of vertical layers set to 5 in MIROC6/MATSIRO6. `NLTDIM` is 1:temp. 2:salt for lake. Since the vertical layers are actually from `KLSTR=2` to `KLEND=KLMAX+1`, `NLZDIM = KLMAX+KLSTR` exists as a parameter for management.

Maximum and minimum thresholds for the lake scheme are given in `matdrv.F`.

| Header0                         | name in the texts | name in the program | unit          | value              |
|:--------------------------------|:------------------|:--------------------|:--------------|:-------------------|
| minimum depth of lake           | $h_{min}$         | HHMIN               | $\mathrm{cm}$ | $10^\times 10^{2}$ |
| maximum of surface high anomaly | $\eta_{max}$      | HAMAX               | $\mathrm{cm}$ | $10^\times 10^{2}$ |
| maximum of lake snow            | $h_{snow,max}$    | HSMAX               | $\mathrm{cm}$ | $10^\times 10^{2}$ |
| maximum of lake ice thickness   | $h_{ice,max}$     | HIMAX               | $\mathrm{cm}$ | $10^\times 10^{2}$ |



## 11.1 Lake surface conditions `[LAKEBC]`

- Output variables

| Header0           | name in the texts | name in the program | dimension            | unit |
|:------------------|:------------------|:--------------------|:---------------------|:-----|
| surface albedo    | $\alpha$          | GRALB               | IJLSDM, NRDIR, NRBND | -    |
| surface roughness |                   | GRZ0                | IJLSDM, NTYZ0        |      |
| heat flux         |                   | FOGFLX              | IJLSDM               |      |
| dG/dTs            |                   | DGFDS               | IJLSDM               |      |

- Input variables

| Header0              | name in the texts | name in the program | dimension | unit |
|:---------------------|:------------------|:--------------------|:----------|:-----|
| skin temperature     | $T_s$             | GRTS                | IJLSDM    |      |
| ice base temperature |                   | GRTB                | IJLSDM    |      |
| sea ice              |                   | GRICE               | IJLSDM    |      |
| snow amount          |                   | GRSNW               | IJLSDM    |      |
| ice fraction         |                   | GRICR               | IJLSDM    |      |
| u surface wind       |                   | GDUA                | IJLSDM    |      |
| v surface wind       |                   | GDVA                | IJLSDM    |      |
| cos(solar zenith)    |                   | RCOSZ               | IJLSDM    |      |

- Internal work variables

| Header0       | name in the texts | name in the program | dimension | unit |
|:--------------|:------------------|:--------------------|:----------|:-----|
| snow fraction |                   | GRSNR               | IJLSDM    | -    |
|               |                   | TALSNX              | IJLSDM    |      |
|               |                   | ALBSNX              | IJLSDM    |      |
|               |                   | ALB0                | IJLSDM    |      |
|               |                   | DALB                | IJLSDM    |      |
|               |                   | TFACT               | IJLSDM    |      |
|               |                   | ALBX                | IJLSDM    |      |
|               |                   | Z00                 | IJLSDM    |      |
|               |                   | DZ0                 | IJLSDM    |      |
|               |                   | DFGT                | IJLSDM    |      |
|               |                   | DFGX                | IJLSDM    |      |

- Internal parameters

| Header0                       | name in the texts      | name in the program | unit | Header                                                    |
|:------------------------------|:-----------------------|:--------------------|:-----|:----------------------------------------------------------|
| diffusion coef. of snow       |                        | DFSNOW              |      | $0.4$                                                     |
| maximum snow depth            |                        | SNWDMX              |      | $5.0$                                                     |
| minimum snow                  |                        | EPSSNW              |      | $1.0\times 10^{-8}$                                       |
| ice forming snow              |                        | SNWMAX              |      | $1000.0$                                                  |
| snow albedo                   | $\alpha_{snow(d,b)}$   | ABLSNW(2, NRBND)    |      | $0.75, 0.5, 0.75, 0.5, 0.0, 0.0$                          |
| temperature for albedo change | $T_m^{min}, T_m^{max}$ | TALSNW(2)           |      | $258.15, 273.15$                                          |
| roughness of snow             |                        | Z0SNW(NTYZ0)        |      | $1.0\times 10^{-2}, 1.0\times 10^{-3}, 1.0\times 10^{-3}$ |
| snow amount for fraction=1    |                        | SNWCRT              |      | $100.0$                                                   |
| snow density                  |                        | SNWDEN              |      | $400.0$                                                   |
| diffusion coef. of lake ice   |                        | DFICE               |      | $2.00$                                                    |
| lake ice albedo               | $\alpha_{ice(b)}$      | ALBICE( NRBND )     |      | $0.5, 0.5, 0.05$                                          |
| roughness of lake ice         |                        | Z0ICE ( NTYZ0 )     |      | $2.0\times 10^{-2}, 2.0\times 10^{-3}, 2.0\times 10^{-3}$ |
| ice amount for conc.=1        |                        | SICCRT              |      | $300.0$                                                   |
| sea ice density               |                        | SICDEN              |      | $1000.0$                                                  |
| heat z0/moumentum z0          |                        | Z0FCT               |      | $0.1$                                                     |
| minimum z0                    |                        | Z0MIN               |      | $.0\times 10^{-6}$                                        |
| depth of ML Ocean             |                        | DZOCN               |      | $50.0$                                                    |
| ocean dG/dTs                  |                        | DFOCN               |      | $1.0\times 10^{10}$                                       |
| LW albedo (1-emis)            |                        | ALBLO               |      | $5.0\times 10^{-2}$                                       |

The lake level albedo $\alpha_{(d,b)}$, $b=1,2,3$ represent the visible, near-infrared, and infrared wavelength bands, respectively. Also, $d=1,2$ represents direct and scattered light, respectively. The albedo for the visible bands are calculated in `MODULE [LAKEALB]`. The albedo for near-infrared is set to same as the visible one. The albedo for infrared is uniformly set to a constant value.

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

The lake surface roughnesses are calculated in `MODULE: [LAKEZ0F]`.

When lake ice is present, modified to take into account the ice concentration $R_{ice}$.

$$
	{z_0'} = z_0 + (z_{ice} -z_0) R_{ice}
$$

Then, taking into account the snow coverage $R_{snow}$, we can express it as

$$
	{z_0} = {z_0'} + (z_{snow} - {z_0'}) R_{snow}
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

The heat flux from the lake to the ice/snow is presented by

$$
	F_{lake} = \frac{\partial G}{\partial T} (T_B-T_S)
$$

If the temperature of the lake ice bottom ($T_B$) is higher than the surface temperature ($T_s$), $F_{lake}$ becomes positive, meaning to melting.

###  11.1.1. lake surface albedo `MODULE:[LAKEALB]`

- Inputs

| Header0          | name in the texts | name in the program | dimension | unit |
|:-----------------|:------------------|:--------------------|:----------|:-----|
| cos(solar angle) | $cos(\zeta)$      | COSZ                | IJLSDM    |      |

- Outputs

| Header0                               | name in the texts | name in the program | dimension | unit |
|:--------------------------------------|:------------------|:--------------------|:----------|:-----|
| lake surface albedo (direct, diffuse) | $\alpha_{L(1,2)}$ | GALB                | IJLSDM ,2 |      |

- Internal variables

- Internal parameters

| Header0 | name in the texts | name in the program | unit | Header                         |
|:--------|:------------------|:--------------------|:-----|:-------------------------------|
|         | $C_1, C_2, C_3$   | CC                  |      | $-0.7479, -4.677039, 1.583171$ |
|         | $\alpha_{L(2)} $  | ALBDIF              |      | $0.06$                         |


For lake surface level albedo $\alpha_{(d)}$, $d=1,2$ represents direct and scattered light, respectively.


Using the solar zenith angle $\zeta (\theta)$ at latitude $\theta$,

$$
	A = \mathrm{min}(\mathrm{max}(\mathrm{cos}(\zeta),0.03459),0.961)
$$

$$
	\alpha_{L(1)} = e^{(C_3A^* + C_2) A^* +C_1}
$$

$$
	\alpha_{L(2)} = 0.06
$$

### 11.1.2 Lake surface roughness `[LAKEZ0F]`

[surface flux section of MIROC-DOC](https://github.com/MIROC-DOC/model_description/blob/surface/draft/p-sfc.md)  will be transplanted after modification.

The roughness variation of the lake surface is determined by the friction velocity $u^*$

$$
u^{\star} = \sqrt{C_{M_0} ({U_0}^2  +{V_0}^2)}
$$

We perform successive approximation calculation of ${C_{M_0}}$, because $F_u,F_v,F_\theta,F_q$ are required.

$$
	r_{0,M} = z_{0,M_0} + z_{0,M_R} + \frac{z_{0,M_R} {u^\star }^2 }{g} + \frac{z_{0,M_S}\nu }{u^\star}
$$

$$
	r_{0,H} = z_{0,H_0} + z_{0,H_R} + \frac{z_{0,H_R} {u^\star }^2 }{g} + \frac{z_{0,H_S}\nu }{u^\star}
$$

$$
	r_{0,E} = z_{0,E_0} + z_{0,E_R} + \frac{z_{0,E_R} {u^\star }^2 }{g} + \frac{z_{0,E_S}\nu }{u^\star}
$$

Here, $\nu = 1.5 \times 10^{-5} \mathrm{[m^2/s]}$ is the kinetic viscosity of the atmosphere.
$z_{0,M},z_{0,H}$ and $z_{0,E}$ are surface roughness for momentum, heat, and vapor, respectively.
$z_{0,M_0},z_{0,H_0}$ and $z_{0,E_0}$ are base, and rough factor ($z_{0,M_R},z_{0,M_R}$ and $z_{0,E_R}$) and smooth factor ($z_{0,M_S},z_{0,M_S}$ and $z_{0,E_S}$) are taken into account.

## 11.2 Lake surface heat balance `[LAKEHB]`

- Outputs

| Header0                | name in the texts | name in the program | dimension | unit |
|:-----------------------|:------------------|:--------------------|:----------|:-----|
| surface water flux \*1 | $W_{free/ice}$    | WFLUXS              | IJLSDM,2  |      |
| upward long wave       | $LW^\uparrow$     | RFLXLU              | IJLSDM    |      |
| flux balance           | $F$               | SFLXBL              | IJLSDM    |      |

	- \*1 コメントアウトには*soil*とかかれているが、陸面スキームから流用したプログラムのためであり、特に意味はない。

- Inputs variables

| Header0                             | name in the texts                 | name in the program |
|:------------------------------------|:----------------------------------|:--------------------|
| dH/dTs \*2                          | $\frac{\partial H}{\partial T_s}$ | DTFDS               |
| dE/dTs \*2                          | $\frac{\partial E}{\partial T_s}$ | DQFDS               |
| dG/dTs \*2                          | $\frac{\partial G}{\partial T_s}$ | DGFDS               |
| downward SW radiation               | $SW^\downarrow$                   | RFLXSD              |
| upward SW radiation                 | $SW^\uparrow$                     | RFLXLU              |
| downward LW radiation               | $LW^\downarrow$                   | RFLXLD              |
| lake surface LW albedo (1-emission) | $\alpha_L$                        | GRALBL              |
| snow/ice ration                     | $R_ice$                           | GRICR               |

\*2 コメントアウトには添字の*g*が使われているが、陸面スキームから流用したプログラムのためであり、特に意味はない。

	- Modified in this subroutine

	| Header0               | name in the texts | name in the program | dimension | unit |
	|:----------------------|:------------------|:--------------------|:----------|:-----|
	| skin temperature      | $T_s$             | GDTS                | IJLSDM    |      |
	| surface heat flux \*1 | $G$               | GFLUXS              | IJLSDM    |      |
	| flux of T             | $H$               | TFLUXS              | IJLSDM    |      |
	| flux of q             | $E$               | QFLUXS              | IJLDSM    |      |

- Internal work

| Header0                        | name in the texts                       | name in the program | dimension |
|:-------------------------------|:----------------------------------------|:--------------------|:----------|
| 昇華潜熱                       | $l_s$                                   | ESUB                |           |
| emissivity of the lake surface | $\epsilon_L$                            | EMIS                |           |
| black body radiation           | $(1-\alpha_L)\sigma T_s^4 $             | STG                 |           |
| dR/dTs                         | $\frac{\partial R}{\partial T_s}$       | DRFDS               |           |
| 地表面から射出されるフラックス | $F^*$                                   | SFLUX               |           |
| 正味の地表面フラックス         | $F^*-G$                                 | GSFLUX              |           |
| dG/dTs (更新後)                | $\frac{dG_s}{dT_s}$                     | DGSFDS              |           |
| 無海氷域における地表フラックス | $G_{free}$                              | GFLUXF              |           |
| 海氷域における顕熱フラックス   | $\delta H_{ice}$                        | SFLUXBI             |           |
| 海氷域における dG/dTs          | $\frac{\partial G_{ice}}{\partial T_s}$ | DSBDSI              |           |
| 海氷域における地表面温度変化   | $\delta T_{ice}$                        | DTI                 |           |
| 海氷域における潜熱フラックス   | $\delta E_{ice}$                        | EVAPI               |           |
| 海氷域における地表フラックス   | $G_{ice}$                               | GFLUXI              |           |
| sea ice free fraction          | $1-R_{ice}$                             | FF                  |           |
| sea ice fraction               | $R_{ice}$                               | FI                  |           |
|                                | $R_{ice}\delta T_{ice}$                 | DTX                 |           |

- Others (appeared in texts)

| Header0                                    | name in the texts | name in the program | dimension | unit |
|:-------------------------------------------|:------------------|:--------------------|:----------|:-----|
| sea surface albedo for shortwave radiation | $\alpha_S$        |                     |           |      |
| the Stefan-Boltzmann constant              | $\sigma$          | STB                 |           |      |

Reference: [Hasumi, 2015, Appendices A](https://ccsr.aori.u-tokyo.ac.jp/~hasumi/COCO/coco4.pdf)

Downward radiative fluxes are not directly dependent on the condition of the sea surface, and their observed values are simply specified to drive the model. Shotwave emission from the sea surface is negligible, so the upward part of the shortwave radiative flux is accounted for solely by reflection of the incoming downward flux. Let $\alpha _S$ be the sea surface albedo for shortwave radiation. The upward shortwave radiative flux is represented by

$$
	SW^\uparrow = - \alpha_S SW^\downarrow
$$

On the other hand, the upward longwave radiative flux has both reflection of the incoming flux and emission from the lake surface. Let $\alpha_L$ be the lake surface albedo for longwave radiation and $\epsilon_L$ be emissivity of the lake surface relative to the black body radiation. The upward shortwave radiative flux is represented by

$$
	LW^\uparrow = - \alpha_L LW^\downarrow + \epsilon_L \sigma T_s ^4
$$

where $\sigma$ is the Stefan-Boltzmann constant and $T_s$ is skin temperature. If lake ice exists, snow or lake ice temperature is considered by fractions. When radiative equilibrium is assumed, emissivity becomes identical to co-albedo:

$$
	\epsilon_L = 1 - \alpha_L
$$

<!-- ここからソースベース -->
海表面から出るフラックスは、

$$
	F^*=H + (1-\alpha_L)\sigma T_s^4 + \alpha_L LW^\uparrow - LW^\downarrow +SW^\uparrow - SW^\downarrow		
$$

正味で海表面に入るフラックスは、

$$
	G = H_s - F^*
$$

地表面フラックスの温度微分項は、
$$
	\frac{\partial G}{\partial T_s} = \frac{\partial G}{\partial T_s}+\frac{\partial H}{\partial T_s}+\frac{\partial R}{\partial T_s}
$$

無海氷域($L=2$)では、凝結によって得られた潜熱フラックスを足して、

$$
	G_{free}=F^* + l_cE
$$


一方、海氷域($L=1$)では、

$$
	G_{ice} = G - l_s E
$$

$$
	\frac{\partial G_{ice}}{\partial T_s}=\frac{\partial G}{\partial T_s} + l_s\frac{\partial E}{\partial T_s}
$$

よって、地表面温度変化は、

$$
	\delta T_{ice} = G_{ice} ( \frac{\partial G_{ice}}{\partial T_s})^{-1}
$$

このとき、潜熱フラックス、顕熱フラックスはそれぞれ

$$
	E_{ice} = E + \frac{\partial E}{\partial T_s} \delta T_{ice}
$$

$$
	H_{ice} = E + \frac{\partial H}{\partial T_s} \delta T_{ice}
$$

以上より、地表面温度を更新する。

$$
	T_s = T_s +R_{ice}\delta T_{ice}
$$

また、各フラックスも更新する。

$$
	H=H+\frac{\partial H}{\partial T_s} R_{ice} \delta T_{ice}
$$

$$
	LW^\uparrow=LW^\uparrow + \frac{\partial R}{\partial T_s} R_{ice} \delta T_{ice}
$$

$$
	E=(1-R_{ice})E + R_{ice}E_{ice}
$$

$$
	G=(1-R_{ice})G_{free} + R_{ice}G_{ice}
$$

$$
	W_{free} = (1-R_{ice}) E
$$

$$
	W_{ice} = R_{ice} E_{ice}
$$

$$
	F = R_{ice} H_{ice}
$$

## 11.3 Lake ice submodel `[LAKEIC]`

The following is an addition based on [Hasumi, 2015, Appendix B1](https://ccsr.aori.u-tokyo.ac.jp/~hasumi/COCO/coco4.pdf).

A relatively simply lake ice model is based on two-category thickness representation, zero-layer thermodynamics [Semtner, 1976] and dynamics with elastic-visous-plastic rheology [Hunke and Dukowicz, 1997].

There are five prognostic variables in the lake ice model described herein: lake ice concentration $A_I$, which is area fraction of a grid covered by lake ice and takes a value between zero and unity; mean lake ice thickness $h_I$ over ice-covered part of a grid; mean snow depth $h_S$ over lake ice; and x and y direction horizontal velocity components of lake ice motion $u_I$ and $v_I$. The model calculates temperature at snow top (lake ice top when there is no snow cover) $T_I$, whic is a diagnostic variable. Density of lake ice ($\rho_I$) and snow $(\rho_S)$ are assumed to be constant Lake ice is assumed to have nonzero salinity, and its value $S_I$ is assumed to be a constant parameter.


### 11.3.1 Heat Flux and Growth Rate `MODULE[FIHEATL]`

- variables

| Header0                                                                                            | name in the texts    | name in the program | dimension              | unit |
|:---------------------------------------------------------------------------------------------------|:---------------------|:--------------------|:-----------------------|:-----|
| lake ice concentration                                                                             | $A_I$                | A                   | IJLDIM                 | -    |
| Lake ice growth rate in ice-free area                                                              | $W_{AO}$             | WAO                 | IJLDIM                 |      |
| air-ice heat flux multiplied by the factor of sea ice concentration                                | $Q_{AI}$             | QAI                 | IJLDIM                 |      |
| vertical heat flux through sea ice and snow                                                        | $Q_{IO}$             | QIO                 | IJLDIM                 |      |
| snow growth rate due to heat inbalance                                                             | $W_{AS}$             | WAS                 | IJLDIM                 |      |
| basal growth rate of lake ice                                                                      | $W_{IO}$             | WIO                 | IJLDIM                 |      |
| Shortwave radiation absorbed at ice-free lake surface, with the factor of ice-free area multiplied | $SW^A$               | SWABS               |                        |      |
| Lake temperature                                                                                   | $T_{temp}, T_{salt}$ | T                   | IJLDIM, NLZDIM, NLTDIM | ◦C   |
| time step                                                                                          | $\Delta t$           | TS                  |                        |      |
| lake heat flux                                                                                     | $H_{lake}$           | FT                  | IJLDIM, NLTDIM         |      |


- Internal works

| Header0                  | name in the texts | name in the program | dimension | unit |
|:-------------------------|:------------------|:--------------------|:----------|:-----|
| $T_{temp} - T_fT_{salt}$ | $\Delta T$        | TDEV                |           |      |
| Sea ice growth rate      | $W_{FZ}$          | WFRZ                |           |      |

- parameters


| Header0                                                   | name in the texts      | name in the program | unit                | value                        |
|:----------------------------------------------------------|:-----------------------|:--------------------|:--------------------|:-----------------------------|
| coeficient for a decreasing function of salinity          | $T_f$                  | dtds                |                     | $-0.0543$                    |
| density of sea water                                      | $\rho_O$               | rhoo                | $\mathrm{g/cm^3}$   | $1.0$                        |
|                                                           |                        | emeltl              | $\mathrm{J/kg}$     | $3.4 \times 10^5$            |
| latent heat fusion \*3                                    | $L_f$                  | hfus                | $\mathrm{erg/g}$    | $E_l \times 1.0 \times 10^4$ |
|                                                           | $\frac{1}{\rho_O L_f}$ | rrhfus              | $\mathrm{cm^3/erg}$ | $1.0 /\rho_I/L_f$            |
| fraction of $SW^A$ absorbed by the lake model's top level | $I(z=2)$               | SWCNV1              | $\mathrm{ND}$       |                              |
| heat capacity of lake water                               | $C_{po}$               | cpo                 | $\mathrm{erg/g/K}$  | $3.990\times 10^7$           |
| thickness of the lake model's top level                   | $D_1$                  | DZ1                 | $\mathrm{cm}$       | $1.0\times 10^2$             |


- \*3 same value is applied to snow and sea ice.

The following is an addition based on [Hasumi, 2015, Appendix B1.1](https://ccsr.aori.u-tokyo.ac.jp/~hasumi/COCO/coco4.pdf).

Let us consider here a case that the model is integrated from the n-th time level to the (n+1)-th time level. $A_I$, $h_I$ and $h_S$ are incrementally modified in the following order.

Temperature at sea ice base is taken to be the lake model’s top level temperature $T_1$. In this model, lake ice exists only when and where T1 is at the freezing point Tf , which is a decreasing function of salinity ($T_f = −0.0543 S$ is used here, where temperature and salinity are measured by ◦C and psu, respectively). In heat budget calculation for snow and lake ice, only latent heat of fusion and sublimation is taken into account, and heat content associated with temperature is neglected. Therefore, temperature inside sea ice and snow are not calculated, and $T_I$ is estimated from surface heat balance.

Nonzero minimum values are prescribed for $A_I$ and $h_I$ , which are denoted by $A^{min}_I$ and $h^{min}_I$, respectively. These parameters define a minimum possible volume of sea ice in a grid. If a predicted volume $A_Ih_I$ is less than that minimum, $A_I$ is reset to zero, and $T_1$ is lowered to compensate the corresponding latent heat. In this case, the lake model’s top level is kept at a supercooled state. Such a state continues until the lake is further cooled and the temperature becomes low enough to produce more lake ice than that minimum by releasing the latent heat corresponding to the supercooling.

Surface heat flux is separately calculated for each of air-sea and air-ice interfaces in one grid. $Q_{IO}$ is corresponding to $G_s$ and $Q_{AI} is corresponding to $G_{ice} - \delta H_{ice}$ in `MODULE[LAKEHB]`.

$T_I$ is determined such That

$$
	Q_{AI} = Q_{IO}
$$

is satisified. However, When the estimated $T_I$ exceeds the melting point of lake ice $T_m$ (which is set to 0 ◦C for convenience), $T_I$ is reset to $T_m$ and $Q_{AI}$ and $Q_{IO} are re-estimated by using it. The heat inbalance between $Q_{AI}$ and $Q_{IO}$ is consumed to melt snow (lake ice when there is no snow cover). Snow growth rate due to this heat imbalance is estimated by

$$
	W_{AS} = \frac{Q_{AI}-Q_{IO}}{\rho L_f}
$$

where $\rho_O$ is density of seawater and $L_f$ is the latent heat of fusion (the same value is applied to snow and lake ice). This growth rate is expressed as a change of equivalent liquid water depth per time.  It is zero when $T_I < T_m$ and negative when $T_I = T_m$. Note that $W_{AS}$ is weighted by lake ice concentration.

Although it is assumed that $T_1 = T_f$ when lake ice exists, $T_1$ could deviated from $T_f$ due to a change of salinity or other factors. Such deviation should be adjusted by forming or melting lake ice. Under a temperature deviation

$$
	\Delta T = T_{temp} - L_fT_{salt}
$$

lake ice growth rate necessary to compensate it in the single time step is given by

$$
	W_{FZ} = - \frac{C_{po} \Delta T * \Delta z_1}{L_f \Delta t}
$$

where $C_{po}$ is the heat capacity of lake water and $\Delta z_1=100 \mathrm{cm}$ is the thickenss of the lake model's top level (fixed in case of the lake model, while it'd be changed in case of the ocean model.) This growth rate is estimated at all grids, irrespective of lake ice existence, for a technical reason. As described below, this growth rate first estimates negative ice volume for ice-free grids, but the same heat flux calculation procedure as for ice-covered grids finally results in the correct heat flux to force the lake. Basal growth rate of lake ice is given by

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
	W_{AO} = (1-A_I)W_{FZ} + \frac{Q_{AO}+I(z=2) SW^A}{\rho_O L_f}
$$

where $I(z=2)$ denotes the fraction of $SW^A$ absorbed by the lake model's top level, which is calculate in `MODULE:[SVTSETL]` in lakepo.F.

Lake heat flux is

$$
	H_{lake} = \frac{\Delta T\Delta z_1}{\Delta t}
$$

### 11.3.2 Sublimation of Sea Ice`MODULE[FWATERL]`

- variables

| Header0                         | name in the texts | name in the program | dimension | unit          |
|:--------------------------------|:------------------|:--------------------|:----------|:--------------|
| lake ice fraction               | $A_I'$            | AX                  | IJLDIM    |               |
| lake ice thickenss              | $h_I'$            | HIX                 | IJLDIM    |               |
| Snow depth                      | $h_S'$            | HSX                 | IJLDIM    |               |
| latent heat flux of evaporation | $F_W^{EV}$        | WEV                 |           |               |
| latent heat flux of sublimation | $F_W^{SB}$        | WSB                 | IJLDIM    | \mathrm{cm/s} |
|                                 | $\Delta F_W$      | WDIF                |           |               |
| time step                       | $\Delta t$        | TS                  |           |               |
| latent heat flux of evaporation | $F_W^{EV}$        | EVAP                | IJLDIM    |               |
| latent heat flux of sublimation |                   | SUBI                | IJLDIM    |               |


- Internal variables

| Header0                | name in the texts | name in the program | dimension | unit |
|:-----------------------|:------------------|:--------------------|:----------|:-----|
| Lake ice concentration | $A_I^n$           | AZ                  | IJLDIM    |      |
| Snow depth             | $h_S^n$           | HSZ                 | IJLDIM    |      |
| lake ice thickness     | $h_I^n$           | HIZ                 | IJLDIM    |      |

- parameters

| Header0                       | name in the texts | name in the program | unit              | value           |
|:------------------------------|:------------------|:--------------------|:------------------|:----------------|
| density of snow               | $\rho_S$          | rhos                | $\mathrm{g/cm^3}$ | $0.33$          |
| density of lake ice           | $\rho_I$          | rhoi                | $\mathrm{g/cm^3}$ | $0.9$           |
| Ratio of density (ocean/snow) | $R_{\rho_S}$      | rrs                 | [-]               | $\rho_O/\rho_s$ |
| Ratio of density (ocean/ice)  | $R_{\rho_I}$      | rri                 | [-]               | $\rho_O/\rho_I$ |
| Minimum thickness of ice      | $h_I^{min}$       | himin               |                   | 1.0\times 10^1  |


The following is an addition based on [Hasumi, 2015, Appendix B1.2](https://ccsr.aori.u-tokyo.ac.jp/~hasumi/COCO/coco4.pdf).

Sublimation (freshwater) flux, which is practically come from the land ice, is calculated or prescribed over lake ice cover. The flux is first consumed to reduce snow thickness in n-th timstep:

$$
	h_S' = h_S^n -  \frac{\rho_O  F_W^{SB}\Delta t}{\rho_S A_I^n}
$$

If $h_S'$ becomes less than zero, it is reset to zero.  Then, the melted snow flux is added to $F_W^{SB}$. $F_W^{SB}$ is redefined by

$$
	F_W^{SB} = F_W^{SB} + \frac{\rho_S A_I^n (h_S' - h_S^n)}{\rho_O\Delta t}
$$

Where there no remains snow, but $F_W^{SB}$ is not zero, The remain flux is consumed to reduce sea ice thickness:

$$
 h_I' = h_I^n - \frac{\rho_O F_W^{SB} \Delta t }{\rho_I A_I^n}
$$

If $h_I'$ becomes less than $h_I^{min}$, it is reset to zero. Then,  the melted iceflux is added to $F_W^{SB}$. $F_W^{SB}$ is redefined by

$$
F_W^{SB} = F_W^{SB} - A_I^n \frac{\rho_S (h_I^n-h_I')}{\rho_O\Delta t}
$$

Finaly, nonzero $F_W^{SB}$ is consumed to reduce lake ice concentration:

$$
	A_I' = A_I^n - \Delta t \frac{R_{\rho_I}F_W^{SB}}{h_I^{min}}
$$

if $A_I'$ becomes less then 0, it is reset to zero. Even if $A_I'$ becomes less than $A_I^{min}$, on the other hand, it is not adjusted here. If $A_I'$ is adjusted to zero, it means that the sublimation flux is not used up by eliminating snow and lake ice.

The remaining part is consumed to reduce lake water, so the evaporation flux $F_W^{EV}$ is modified as


$$
	E = F_W^{EV} + F_W^{SB} + \frac{(A_I'-A_I^n) h_I^{min}}{R_{\rho_I}\Delta t}
$$

The later two terms cancel out if the adjustment does not take place.

If there is no lake ice, evaporation flux is just as

$$
	E = F_W^{EV} + F_W^{SB}
$$

The adjusted evaporation flux is saved as $E_{adj}$

$$
\Delta E_{adj} = E-	F_W^{EV}
$$

When sublimation flux is consumed to reduce lake ice amount, salt contained in lake ice has to be added to the remaining lake ice or the underlying water. Otherwise, total salt of the ice-lake system is not coserved. Here, it is added to underlying water, and the way of this adjustment is described later. Nothe that lake ice tends to gradually drain high salinity water contained in brine pockets in reality. Thus, such an adjustment is not very unreasonable. When $A_I'$ is adjusted to zero, on the other hand, the remaining sublimation flux is consumed to reduce lake water. In this case, difference between the latent heat of sublimation and evaporation has to be adjusted, which is also described later.

If the ice and/or snow is too thick, they are consumed to snow flux. Here, the overflow snowflux $S_{off}$ is added to F_W^{SN}

$$
	F_W^{SN} = F_W^{SN} + S_{off}
$$

### 11.2.3 `PCMPCTL`

The lake ice fraction is updated, using the lake ice growth (retreat) rate in ice-free area $W_{AO}$:

$$
	A_I = A_I +\frac{\rho_O }{\rho_I h_I \phi W_{AO}\Delta t}
$$

If $A_I$ becomes greater than 1, it is reset to 1, and if $A_I$ becomes smaller than zero, it is reset to zero.


### 11.2.4 Growth and Melting `MODULE[PTHICKL]`

- variables

| Header0                                    | name in the texts       | name in the program | dimension      | unit |
|:-------------------------------------------|:------------------------|:--------------------|:---------------|:-----|
| lake ice fraction                          | $A_I,A_I^*$             | AX                  | IJLDIM         |      |
| lake ice volume                            | $V_I$                   | AXHIX               | IJLDIM         |      |
| lake snow volume                           | $V_S, V_S', V_S^{**}$   | AXHSX               | IJLDIM         |      |
| lake ice volume                            | $V_I$                   | AXHIXN              | IJLDIM         |      |
|                                            |                         | AXHSXN              | IJLDIM         |      |
| lake ice thickenss                         | $h_I'$                  | HIX                 | IJLDIM         |      |
| Snow depth                                 | $h_S'$                  | HSX                 | IJLDIM         |      |
| Snow depth                                 | $h_S^n$                 | HSZ                 | IJLDIM         |      |
| lake ice thickness                         | $h_I^n$                 | HIZ                 | IJLDIM         |      |
| snow growth rate due to heat inbalance     | $W_{AS}$                | WAS                 | IJLDIM         |      |
| lake ice growth rate due to heat inbalance | $W_{AI}$                | WAI                 | IJLDIM         |      |
| Reduced heat flux                          | $W_{res}$               | WRES                | IJLDIM         |      |
| basal growth rate of lake ice              | $W_{IO}$                | WIO                 | IJLDIM         |      |
| snow fall flux                             | $F_W^{SN}, {F_W^{SN}}'$ | SNOW                | IJLDIM         |      |
| Lake ice growth rate in ice-free area      | $W_{AO}$                | WAO                 | IJLDIM         |      |
| precipitation flux                         | $F_W^{PR}$              | PREC                | IJLDIM         |      |
| latent heat flux of evaporation            | $L_e$                   | EVAP                | IJLDIM         |      |
| latent heat flux of sublimation            | $$                      | SUBI                | IJLDIM         |      |
| Lake ice concentration                     | $A_I'$                  | AZ                  | IJLDIM         |      |
|                                            |                         | ROFF                | IJLDIM         |      |
|                                            |                         | ADJLAT              | IJLDIM         |      |
| lake heat flux                             | $H_{lake}$              | FT                  | IJLDIM, NLTDIM |      |
|                                            |                         | FS                  | IJLDIM         |      |
| time step                                  | $\Delta t$              | TS                  |                |      |

- parameters

| Header0                       | name in the texts | name in the program | unit              | value               |
|:------------------------------|:------------------|:--------------------|:------------------|:--------------------|
| density of snow               | $\rho_S$          | rhos                | $\mathrm{g/cm^3}$ | $0.33$              |
| density of lake ice           | $\rho_I$          | rhoi                | $\mathrm{g/cm^3}$ | $0.9$               |
| Ratio of density (ocean/snow) | $R_{rho_I}$       | rrs                 | [-]               | $\rho_O/\rho_s$     |
| Ratio of density (ocean/ice)  | $R_{rho_I}$       | rri                 | [-]               | $\rho_O/\rho_I$     |
| Minimum thickness of ice      | $h_I^{min}$       | himin               |                   | $1.0\times 10^1$    |
|                               |                   | AMIN                |                   | $1.0\times 10^{-6}$ |
|                               |                   | AMAX                |                   | $1.0$               |
|                               |                   | SI                  |                   | $0.0$               |
|                               |                   | SREF                |                   | $3.5\times 10^1$    |
|                               |                   | AIH                 |                   | $2.0\times 10^8$    |
|                               |                   | AIHB                |                   | $2.0\times 10^2$    |


以下、[Hasumi, 2015, Appendix B.1.3 and B.1.4 ](https://ccsr.aori.u-tokyo.ac.jp/~hasumi/COCO/coco4.pdf)をもとに加筆修正。

- Volume of lake ice and snow
The lake ice volume $V_I$ and snow volume $V_S$, which are defined by

$$
	V_I = A_I' h_I^n
$$

$$
	V_S = A_I' h_S^n
$$

- Snowfall flux to snow

Changes of snow depth due to snow fall (freshwater) flux $F_W^{SN}$ (expressed by negative values to be consistent with other freshwater flux components) is first taken into account. $F_W^{SN}$ is not weighted by lake ice concentration or ice-frea are fraction, as snowfall take place for both regions.

If the newly predicted lake ice concentration $A_I^*$ is zero, the amount of snow existed before the dynamic redistribution is added to the snowfall flux.

$$
	{F_W^{SN}}' = F_W^{SN} + \frac{\rho_S V_S}{\rho_O \Delta t}
$$

Snow depth and amount is set to zero:

$$
	h_S'=0, \quad V_S^{**} = 0
$$


Otherwise, snowfall accumulates over the ice covered region.

$$
	{F_W^{SN}}' = (1-A_I^*) F_W^{SN}
$$

The snowfall flux is reduced by that amount:

$$
	V_S^{**} = A_I^{*} - \frac{A_I^* \rho_O F_W^{SN}\Delta t}{\rho_S}
$$

Snow depth is modified by

$$
	h_S' = \frac{V_S^{**}}{A_I^{*}} + \frac{\rho_O F_W^{SN}\Delta t}{\rho_S}
$$

and snow amount is also modified by

$$
	V_S^{**} = A_I^*{h_S'}
$$

Then, the snowfall flux is put together with the precipitation flux.

$$
	F_W^{PR} = F_W^{PR} + {F_W^{SN}}'
$$

- Freshwater flux for snow growth

Let us add $W_{AS}$ and snowfall flux.
$$
	W_{res} = W_{AS} + \frac{\rho_O V_S^{**}}{\rho_S \Delta t}
$$

If the lake ice is not existed ($A_I^*=0$), $W_{AS}$ (snow growth rate due to heat inbalance) is used to grown the lake ice (lake ice growth rate due to heat inbalance):

$$
 W_{AI} = W_{AS}
$$

Otherwise,if $W_{res}$ is nevative the heat flux for snow growth is presented by

$$
	W_{AS} = - \frac{\rho_O V_S^{**}}{\rho_S \Delta t}
$$

while it is only used for snow melting henc $W_{AI}$ is set to zero with positive $W_{res}$.

Then, the snow depth is modified with the accumulation.

$$
	h_S' = \frac{V_S^{**}+ \rho_O W_{AS} \Delta t}{\rho_S {A_I^*}}
$$

if $h_S'$ is less than 0, it is reset to zero.


The heat flux for ice growh is presented by

$$
	W_{AI} = W_{res}
$$

- Freshwater flux for ice growth

In the next step, the heat flux conducted to the bottom of the lake ice is considered.

If the lake ice exists ($A_I>0$), the ruduced heat flux is:

$$
	W_{res} = W_{AS} + \frac{V_S^{**}}{R_{\rho_I \Delta t}}
$$

and if $W_{res}$ is less than 0 (expressed by negative values to be consistent with other freshwater flux components), $W_{res}$ is added to $W_{IO}$

$$
	W_{IO} = W_{IO} + W_{res}
$$

then $W_{AI}$ is modified as

$$
	W_{AI} = -\frac{V_S^{**}}{R_{\rho_I \Delta t}}
$$

The freshwater flux $W_{AI}$ is then used for increasing of the lake ice amount,

$$
	V_I = V_I + W_{AI}R_{\rho_I}\Delta t
$$

If the lake ice does not exist,  $W_{AI}$ is added to $W_{IO}$.

$$
	W_{IO} = W_{IO} + W_{AI}
$$

all of $W_{AS}$ is accumulated as snow.

- Adjusting the volume of snow and ice

The snow volume is adjusted, considering the snow depth,

$$
	V_S = A_I *h_S
$$

The lake ice volume is adjusted, considering both ice-covered and ice-free area,
$$
	V_I = V_I + \Delta t R_{\rho_I}(W_{IO}+W_{AO})
$$

If the lake ice volume is less then zero, the lake ice concentration is set to zero ($A_I=0$) and the ice thickness is set as $h_I^{min}$ ($h_I =h_I^{min}$).

Otherwise, the lake ice thickenss is:

$$
	h_I = V_I/A_I
$$

If the thickness is less then $h_I^{min}$, it is set to $h_I^{min}$ and the lake ice concentration is adjusted:

$$
	A_I = \frac{V_I}{h_I^{min}}
$$

Finally the lake ice concentration is set to 0 or 1 if it is above 0 or beyond 1.

- Check if the ice volume is too small.

$$
	CREDIS = h_I^{min}(A_{max}-A_{min})
$$
If the lake ice exists but its volume is very small ($(A_I^{max}-A_I) h_I > (A_{max}-A_{min})h_I^{min}$),

![lakeice_volume](lakeice_volume.jpeg)

 $h_I$ is adjusted as:

$$
	h_I = \frac{credis +A_Ih_I}{A_I^{max}}
$$

Then, $A_I$ is adjusted as:

$$
	A_I'=\frac{\big[(A_I^{max}-A_I) h_I - (A_{max}-A_{min})h_I^{min} \big]+A_Ih_I}{h_I}
$$

The snow depth is also modified by the change of the lake ice concentration.
$$
	h_S' = h_S \frac{A_I'}{A_I}
$$

Summarizing as the source code,

$$
	h_S' = \frac{A_I h_S}{A_I^{max}-CREDIS/h_I}
$$

$$
	A_I = A_I^{max} - \frac{CREDIS}{h_I}
$$

Finally, residual waterflux is calculated. For the lake ice,
$$
	W_I = \frac{A_Ih_I-V_I}{R_{\rho_I} \Delta t}
$$

and for the snow,

$$
	W_S = \frac{A_Ih_S-V_S}{R_{\rho_S} \Delta t}
$$


## 11.4 Physical formulation & processes `[LAKEPO]`
`lakepo.F`


### Set parameters

#### Diffusion tracer flux `MODULE:[VDIFFL]`


- Inputs

Though several valuables are written, they are not used here.

- Outputs

| Header0                        | name in the texts | name in the program | dimension      | unit |
|:-------------------------------|:------------------|:--------------------|:---------------|:-----|
| vertical diffusion coefficient | $K_V$             | AHV                 | IJLDIM, NLZDIM |      |

- Parameters

| Header0                                             | name in the texts | name in the program | unit | value         |
|:----------------------------------------------------|:------------------|:--------------------|:-----|:--------------|
| vertical diffusion coefficient at the surface layer | $K_{V0}$          | AHVL0(NZ=KLMAX)     |      | $k\times 1.0$ |

The case considered in COCO4 is that( [Hasumi, 2015, Section 1.2](https://ccsr.aori.u-tokyo.ac.jp/~hasumi/COCO/coco4.pdf)):
1. Diffusive flux of tracer follows the Fick's law.
2. Diffusuion coefficient tensor is diagonal, and its horizontal component is identical.

Here, the vertical diffusion coefficent $K_V$ is simply set as

$$
	K_V(k) = K_{V0} k
$$

#### 11.3.2 Estimate the advection and diffusion terms of the tracer equations `MODULE: [FLXTRCL]`

- Inputs

| Header0                        | name in the texts | name in the program | dimension              | unit |
|:-------------------------------|:------------------|:--------------------|:-----------------------|:-----|
| vertical diffusion coefficient | $K_V$             | AHV                 | IJLDIM, NLZDIM         |      |
| water temperature              | $T$               | TX                  | IJLDIM, NLZDIM, NLTDIM |      |
| water depth                    | $h$               | HX                  | IJLDIM                 |      |

- Outputs

| Header0                                     | name in the texts              | name in the program | dimension              | unit |
|:--------------------------------------------|:-------------------------------|:--------------------|:-----------------------|:-----|
| vertical component of diffusive tracer flux | $F_D$                          | ADT                 | IJLDIM, NLZDIM, NLTDIM |      |
|                                             | $\frac{F_D}{D(k-\frac{1}{2})}$ | DIFFZ               | IJLDIM, NLZDIM         |      |

- Internal variables

| Header0 | name in the texts | name in the program | dimension              | unit |
|:--------|:------------------|:--------------------|:-----------------------|:-----|
|         |                   | TH                  | IJLDIM, NLZDIM, NLTDIM |      |
|         | $h'$              | HZBOT               | IJLDIM                 |      |

-Parameters

| Header0                                                      | name in the texts | name in the program | unit          | value                              |
|:-------------------------------------------------------------|:------------------|:--------------------|:--------------|:-----------------------------------|
| thickness of each lake level                                 | $D$               | DZ(NLZDIM)          | $\mathrm{cm}$ | $0, S_0(1), S_0(2), S_0(3),S_0(4)$ |
|                                                              | $S$               | DS(NLZDIM)          | $\mathrm{ND}$ |                                    |
| thickness of the lake model’s top level                      | $D_1$             | DZ1                 | $\mathrm{cm}$ | $1.0\times 10^2$                   |
| Ratio of the thickness of the each layer in sigma coordinate | $S_0$             | DS0(NLZDIM-1)       | $\mathrm{ND}$ | $0.1, 0.1, 0.2, 0.6$               |

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

| Header0                                     | name in the texts              | name in the program | dimension              | unit                    |
|:--------------------------------------------|:-------------------------------|:--------------------|:-----------------------|:------------------------|
| vertical component of diffusive tracer flux | $F_D$                          | ADT                 | IJLDIM, NLZDIM, NLTDIM |                         |
|                                             | $\frac{F_D}{D(k-\frac{1}{2})}$ | DIFFZ               | IJLDIM, NLZDIM         |                         |
| minimum depth of lake                       |                                | HXMIN               |                        | $\mathrm{cm}$           |
| heat flux                                   |                                | FT                  |                        | $\mathrm{K cm/s}$       |
| absorbed shortwave                          |                                | SWABS               |                        | $\mathrm{erg/cm^2/sec}$ |
|                                             |                                | FS                  |                        |                         |
| time step                                   | $\Delta t$                     | TS                  |                        |                         |
| surface-type fraction (lake)                | $$                             | LKFRAC              | IJLDIM                 | [-]                     |

- Outputs

| Header0              | name in the texts | name in the program | dimension | unit          |
|:---------------------|:------------------|:--------------------|:----------|:--------------|
| lake water deficient |                   | XHD                 | IJLDIM    | $\mathrm{cm}$ |

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

| Header0                 | name in the texts | name in the program | dimension | unit |
|:------------------------|:------------------|:--------------------|:----------|:-----|
| $depth of water column$ | $h$               | H                   |           |      |
| time step               | $\Delta t$        | TS                  |           |      |

- Outputs

| Header0 | name in the texts | name in the program | dimension | unit |
|:--------|:------------------|:--------------------|:----------|:-----|
|         |                   | R                   |           |      |


The unit of XHD will be changed to $\mathrm{kg/m2}$ after this module (in `MATDRV`).

### 11.3.1 Setting vertical diffusion and viscosity coefficients `MODULE:[VDIFFL]`



Reference: [Hasumi, 2015, Section 1](https://ccsr.aori.u-tokyo.ac.jp/~hasumi/COCO/coco4.pdf)





- Variables

| Header0                                                            | name in the texts     | name in the program | dimension      | unit          |
|:-------------------------------------------------------------------|:----------------------|:--------------------|:---------------|:--------------|
| the fraction of shortwave radiation absorved by the lake's z-level |                       | SWCONV              | IJLDIM, NLZDIM | $\mathrm{ND}$ |
|                                                                    |                       | AA                  | IJLDIM, NLZDIM |               |
|                                                                    |                       | AB                  | IJLDIM, NLZDIM |               |
|                                                                    |                       | AC                  | IJLDIM, NLZDIM |               |
|                                                                    |                       | DH                  | IJLDIM         |               |
| thickness of the layers from the 2nd to the bottom                 | $h_B$                 | HZBOT               | IJLDIM         | $\mathrm{cm}$ |
|                                                                    |                       | HXBOT               | IJLDIM         |               |
|                                                                    |                       | DZB                 | IJLDIM         |               |
|                                                                    |                       | DZT                 | IJLDIM         |               |
|                                                                    | $I^{-\frac{1}{2}}(z)$ | RADUP               |                | $\mathrm{ND}$ |
| shortwave radiation flux at an arbitrary depth                     | $I^{+\frac{1}{2}}(z)$ | RADDN               |                | $\mathrm{ND}$ |
| Depth of each level                                                | $D_H$                 | DEPTH               |                | $\mathrm{cm}$ |
| the fraction of shortwave radiation absorved by the lake's z-level | $\Delta I(z)$         | SWCNV1              | NLZDIM         | $\mathrm{ND}$ |
| total of abrsorbed shortwave radiation                             |                       | TSWCNV              | IJLDIM         | $\mathrm{ND}$ |


- parameters

| Header0                                              | name in the texts      | name in the program | unit                | value                        |
|:-----------------------------------------------------|:-----------------------|:--------------------|:--------------------|:-----------------------------|
|                                                      | $E_l$                  | emeltl              | $\mathrm{J/kg}$     | $\mathrm{3.4\times 10^5}$    |
| density of sea water                                 | $\rho_O$               | rhoo                | $\mathrm{g/cm^3}$   | $1.0$                        |
| density of sea ice                                   | $\rho_I$               | rhoi                | $\mathrm{g/cm^3}$   | $0.9$                        |
| density of snow                                      | $\rho_S$               | rhos                | $\mathrm{g/cm^3}$   | $0.33$                       |
| latent heat fusion                                   | $L_f$                  | hfus                | $\mathrm{erg/g}$    | $E_l \times 1.0 \times 10^4$ |
|                                                      | $\frac{1}{\rho_O L_f}$ | rrhfus              | $\mathrm{cm^3/erg}$ | $1.0 /\rho_I/L_f$            |
| heat capacity of lake water                          | $C_{po}$               | cpo                 | $\mathrm{erg/g/K}$  | $3.990\times 10^7$           |
| heat capacity of lake ice                            | $C_{pi}$               | cpi                 | $\mathrm{erg/g/K}$  | $2.093\times 10^7$           |
| coeficient for a decreasing function of salinity     | $T_f$                  | dtds                |                     | $-0.0543$                    |
|                                                      |                        | dtdz                |                     | $-7.59\times 10^{-6}$        |
| fraction of the fast-attenuating portion             | $R$                    | RRR                 |                     | $5.0\times 10^{-1}$          |
| length scale for fast-attenuating portion            | $\zeta_1$              | ZETA1               |                     | $3.5\times 10^1$             |
| length scale for deeply penetrating spectral portion | $\zeta_2$              | ZETA2               |                     | $2.3\times 10^3$             |
| thickness of the lake                                | $D(z)$                 | DZ(NZ=KLMAX)        | $\mathrm{cm}$       | `DZ1`                        |
|                                                      | $S(z)$                 | DS(NZ=KLMAX)        | $\mathrm{ND}$       | `DS0(K-KLSTR)`               |
| thickness of the lake model's top level              | $D(1) $                | DZ1                 | $\mathrm{cm}$       | $1.0\times 10^2$             |
|                                                      | $S_0(z)$               | DS0(NZ-1)           | $\mathrm{ND}$       | $0.1, 0.1, 0.2, 0.6$         |

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


### 11.3.4 Convective adjustment for the unstable water column `MODULE:[OVTSETL]`

Reference: [Hasumi, 2015, Section 4.4](https://ccsr.aori.u-tokyo.ac.jp/~hasumi/COCO/coco4.pdf)
