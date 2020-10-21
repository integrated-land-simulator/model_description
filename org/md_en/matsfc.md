# Boundary Value Submodel MATBND

## Set of vegetation shape parameters.

The leaf area index (LAI) and vegetation height are set as vegetation shape parameters.

The LAI reads the seasonally varying horizontal distributions, and the top and bottom canopy heights are determined by land use type as external parameters. If there is snowfall, the LAI considers only the vegetation above the snow depth and corrects the geometry parameters.

$$
 h = \max( h_0 - D_{Sn}, 0 ) \\
 h_B = \max( h_{B0} - D_{Sn}, 0 ) \\
 LAI = LAI_0 \frac{h-h_B}{h_0-h_{B0}}
$$




Here, $h$ is the height at the top of the canopy (vegetation height), $h_B$ is the height at the bottom of the canopy (dead height), $LAI$ is the leaf area index, and $h_0$, $h_{B0}$, and $LAI_0$ are the values without snow, respectively. $D_{Sn}$ is the snow cover depth. It is assumed that the LAI is uniformly distributed vertically between the top and bottom edges of the canopy.

Afterwards, the average of snow-free and snow-covered surfaces weighted by the snow area ratio ($A_{Sn}$) is calculated, but since the snow-free surface and the snow-covered surface are calculated separately, $A_{Sn}$ requires either $0$ (snow-free surface) or $1$ (snow-covered surface). Note that it contains either of the values of the (surface), and mixing of values does not occur here (there are several similar locations later).

## Calculating radiant parameters.

Calculation of radiative parameters (albedo, vegetation permeability, etc.).

### Calculation of surface (forest floor) albedo

The horizontal distribution of the ground (forest floor) albedo $\alpha_{0(b)}\ \ (b=1,2)$ is read as an external parameter. $b=1, 2$ represent the visible and near-infrared wavelengths, respectively. The $\alpha_{0(3)}$ value of the infrared surface albedo ($\alpha_{0(3)}$) is set to a fixed value (horizontal distribution may be prepared).

The dependence of the incident angle of albedo on ice and snow cover is considered as a function of the angle of incidence as follows

$$
 \alpha_{0(d,b)} = \hat{\alpha}_{0(b)} + ( 1 - \hat{\alpha}_{0(b)} )
                         \cdot 0.4 ( 1 - \cos \phi_{in(d)} )^5
$$


where $b=1,2$ are wavelengths, $d=1,2$ are direct and scattered, respectively, and $\hat{\alpha}_{0(b)}$ is an albedo value for a direct angle of incidence of $0$ (from directly above). $\cos \psi_{in(d)}$ is the cosine of the incident angle of incidence for direct and scattered light, respectively,

$$
 \cos\psi_{in(1)} = \cos\zeta, \ \ \
 \cos\psi_{in(2)} = \cos 50^{\circ}
$$


We give the $\zeta$ is the solar zenith angle.

Except for the ice and snow cover surfaces, the albedo of the ground (forest floor) gives the same values for direct and diffuse light, without considering the dependence on the zenith angle. In other words, the results are as follows.

$$
 \alpha_{0(d,b)} = \alpha_{0(b)}\ \ \ (d=1,2;\ b=1,2)
$$


For infrared wavelengths, we only need to consider the scattered light. The infrared albedo gives a value that is independent of the zenith angle for all surfaces.

$$
 \alpha_{0(2,3)} = \alpha_{0(3)}
$$


### Canopy albedo and transmittance calculations

The calculation of albedo and transmittance of the canopy is based on the radiation calculation in the canopy layer by Watanabe and Otani (1995).

Considering a vertically uniform canopy and making some simplifying assumptions, the transfer equation and boundary conditions for the insolation within the canopy are expressed as follows

$$
 \frac{dS^{\downarrow}_d}{dL} = -F \sec\zeta S^{\downarrow}_d \\
 \frac{dS^{\downarrow}_r}{dL} = -F (1-t_{f(b)})d_f S^{\downarrow}_r
                                  +F t_{f(b)} \sec\zeta S^{\downarrow}_d
                                  +F r_{f(b)} d_f S^{\uparrow}_r \\
 \frac{dS^{\uparrow}_r}{dL}   =  F (1-t_{f(b)})d_f S^{\uparrow}_r
                                  -F r_{f(b)} ( d_f S^{\downarrow}_r
                                         + \sec\zeta S^{\downarrow}_d ) \\
 S^{\downarrow}_d(0) = S^{top}_d \\
 S^{\downarrow}_r(0) = S^{top}_r \\
 S^{\uparrow}_r(LAI) = \alpha_{0(1,b)}S^{\downarrow}_d(LAI)
                       + \alpha_{0(2,b)}S^{\downarrow}_r(LAI)
$$







where $S^{\downarrow}_d$ is direct downward light, $S^{\uparrow}_r$ and $S^{\downarrow}_r$ are upward and downward scattered light, respectively, $L$ is the leaf area accumulated from the top of the canopy downward, $d_f$ is the scatter factor ($=\sec 53^{\circ}$), $r_{f(b)}$ and $t_{f(b)}$ is the reflection coefficient and transmission coefficient of the leaf surface (the same values are used for scattered light and direct light), respectively, and $F$ is a factor indicating the orientation of the leaf relative to radiation. For simplicity, we assume that the distribution of leaf orientation is random ($F=0.5$).

These can be solved analytically and the solution is as follows.

$$
 S^{\downarrow}_d(L) = S^{top}_d \exp(-F\cdot L\cdot \sec\zeta) \\
 S^{\downarrow}_r(L) = C_1 e^{a L} + C_2 e^{-a L} + C_3 S^{\downarrow}_d(L) \\
 S^{\uparrow}_r(L)   = A_1 C_1 e^{a L} + A_2 C_2 e^{-a L} + C_4 S^{\downarrow}_d(L)
$$




Here,

$$
   a = F d_f [(1-t_{f(b)})^2 - r_{f(b)}^2]^{1/2}  \\
 A_1 = \{ 1 - t_{f(b)} + [(1-t_{f(b)})^2 - r_{f(b)}^2]^{1/2}\} / r_{f(b)} \\
 A_2 = \{ 1 - t_{f(b)} - [(1-t_{f(b)})^2 - r_{f(b)}^2]^{1/2}\} / r_{f(b)} \\
 A_3 = (A_1 - \alpha_{0(2,b)}) e^{ a LAI }
        -(A_2 - \alpha_{0(2,b)}) e^{-a LAI } \\
 C_1 = \{ -(A_2 - \alpha_{0(2,b)}) e^{-a LAI} (S^{top}_r - C_3 S^{top}_d)
            +[C_3\alpha_{0(2,b)}+\alpha_{0(1,b)}-C_4]S^{\downarrow}_d(LAI)\} / A_3 \\
 C_2 = \{  (A_1 - \alpha_{0(2,b)}) e^{ a LAI} (S^{top}_r - C_3 S^{top}_d)
            -[C_3\alpha_{0(2,b)}+\alpha_{0(1,b)}-C_4]S^{\downarrow}_d(LAI)\} / A_3 \\
 C_3 = \frac{\sec\zeta[t_{f(b)}\sec\zeta + d_f t_{f(b)}(1-t_{f(b)}) + d_f r_{f(b)}^2]}
              {d_f^2[(1-t_{f(b)})^2-r_{f(b)}^2]-\sec^2\zeta} \\
 C_4 = \frac{r_{f(b)}(d_f - \sec\zeta)\sec\zeta}
              {d_f^2[(1-t_{f(b)})^2-r_{f(b)}^2]-\sec^2\zeta}
$$









It is.

The Albedo $\alpha_s$ seen at the top of the canopy,

$$
 S^{\uparrow}_r(0) = \alpha_{s(1,b)} S^{\downarrow}_d(0)
                   + \alpha_{s(2,b)} S^{\downarrow}_r(0)
$$


So,

$$
 \alpha_{s(2,b)} = \{ A_2 ( A_1 - \alpha_{0(2,b)}) e^{ a LAI }
                      - A_1 ( A_2 - \alpha_{0(2,b)}) e^{-a LAI }
                   \} / A_3 \\
 \alpha_{s(1,b)} = - C_3 \alpha_{s(2,b)} + C_4
                  + ( A_1 - A_2 ) ( C_3 \alpha_{0(2,b)} + \alpha_{0(1,b)} -C_4)
                  e^{- F\cdot LAI\cdot \sec\zeta} / A_3
$$



Get.

The transmission coefficient of the canopy (${\mathcal{T}}_c$), or more precisely, the percentage of the incident light absorbed by the forest floor at the top of the canopy, is

$$
 S^{\downarrow}_d(LAI) + S^{\downarrow}_r(LAI) - S^{\uparrow}_r(LAI)
= {\mathcal{T}}_{c(1,b)} S^{\downarrow}_d(0)
+ {\mathcal{T}}_{c(2,b)} S^{\downarrow}_r(0)
$$


Defined by ,

$$
  {\mathcal{T}}_{c(2,b)}= \{ ( 1 - A_2 )( A_1 - \alpha_{0(2,b)} )
                      - ( 1 - A_1 )( A_2 - \alpha_{0(2,b)} ) \} / A_3 \\
 {\mathcal{T}}_{c(1,b)}= - C_3 {\mathcal{T}}_{c(2,b)}  \\
 +               \{ ( C_3 \alpha_{0(2,b)} + \alpha_{0(1,b)} -C_4 )
                   ( ( 1 - A_1 ) e^{ a LAI }
                   - ( 1 - A_2 ) e^{-a LAI } )  / A_3
                   + C_3 - C_4 +1 \} e^{- F\cdot LAI\cdot \sec\zeta}
 \\
$$





The above is performed for $b=1, 2$ (visible and near-infrared), respectively. The above procedure is performed for $b=1, 2$ (visible and near-infrared), respectively.

The reflectance $r_f$ and transmission $t_f$ are read as external parameters for each land cover type, but before they are used in the above calculations, the following two modifications are made.

1. the effect of snow (ice) on the leaves
 When the canopy temperature is less than 0 $^{\circ}$ C, the water above the canopy is regarded as snow (ice). In this case, the snow albedo ($\alpha_{Sn(b)}$) and the water content in the canopy ($w_c$) are used to determine the snow (ice),

$$
 r_{f(b)} = ( 1 - f_{cwet} ) r_{f(b)}
         + f_{cwet} \alpha_{Sn(b)} \\
  f_{cwet} = {w_c}/w_{c,cap}
$$



 The following table shows the volume of water on the canopy. $w_{c,cap}$ is the water content in the canopy. The transmittance is given in the following formula for convenience to avoid negative absorption ($1-r_f-t_f$), i.e.

$$
 t_{f(b)} = ( 1 - f_{cwet} ) t_{f(b)}
         + f_{cwet} t_{Sn(b)}, \ \ \
 t_{Sn(b)} = \min( 0.5(1 - \alpha_{Sn(b)}), t_{f(b)} )
$$


 When the water on the canopy is liquid, we should ignore the change in the radiative parameters of the leaf surface. When the liquid water on the canopy is liquid, changes in the radiative parameters of the leaf surface due to the liquid water on the canopy are ignored. In the case of snowfall trapping by the canopy (snow), and in the case of freezing of the liquid water on the canopy (ice), the same albedo as that of the snow cover on the forest floor is used here, although the radiative characteristics of each case may be different.

2. the effect of considering the direction of reflection and transmission
 In the solution of the above equation, it is assumed that all the reflected light returns to the direction of the incident light, but considering that some of it is scattered in the same direction as the incident light, we can replace the radial parameters of the leaf surface with the following (Watanabe, in press).

$$
  r_{f(b)} = 0.75 r_{f(b)} + 0.25 t_{f(b)} \\
  t_{f(b)} = 0.75 t_{f(b)} + 0.25 r_{f(b)}
$$



The above is done for $b=1, 2$ (visible and near-infrared), respectively.

We also take into account cases where vegetation is unevenly distributed in parts of the grid (e.g., savannahs), prior to the calculation of albedo, etc,

$$
  LAI = LAI / f_V
$$


The LAI of the vegetation cover (the original LAI is considered to be the grid average) is calculated as the LAI of the vegetation cover, which is used in the calculation of the albedo described above. $f_V$ is the vegetation coverage of the grid. After the albedo and other data are obtained, the LAI of the grid is calculated by

$$
  \alpha_{s(d,b)} = f_V \alpha_{s(d,b)}
                       + ( 1 - f_V ) \alpha_{0(d,b)} \\
  {\mathcal{T}}_{c(d,b)} = f_V {\mathcal{T}}_{c(d,b)}
                       + ( 1 - f_V ) ( 1 - \alpha_{0(d,b)} )
$$



We take the area-weighted average of the vegetation-covered and non-vegetation-covered portions, as

### Calculations such as surface radiation flux

Using the downward radiation flux ($R^{\downarrow}_{(d,b)}$) and the albedo obtained above, the following radiation fluxes are obtained.

$$
 R^{\downarrow}_S = \sum_{b=1}^2\sum_{d=1}^2 R^{\downarrow}_{(d,b)} \\
 R^{\uparrow}_S = \sum_{b=1}^2\sum_{d=1}^2 \alpha_{s(d,b)} R^{\downarrow}_{(d,b)} \\
 R^{\downarrow}_L = R^{\downarrow}_{(2,3)} \\
 R^{gnd}_S = \sum_{b=1}^2\sum_{d=1}^2 {\mathcal{T}}_{s(d,b)} R^{\downarrow}_{(d,b)} \\
 PAR = \sum_{d=1}^2 R^{\downarrow}_{(d,1)}
$$






$R^{\downarrow}_S$ and $R^{\uparrow}_S$ represent the downward and upward shortwave radiation fluxes, $R^{\downarrow}_L$ represents the downward longwave radiation flux, $R^{gnd}_S$ represents the shortwave radiation flux absorbed by the forest floor, and $PAR$ represents the downward Photosynthetically Active Radiation (PAR) flux .

The canopy transmittance of the shortwave and longwave canopies and the longwave emission coefficient are obtained as follows.

$$
 {\mathcal{T}}_{cS} = R^{gnd}_S / ( R^{\downarrow}_S - R^{\uparrow}_S ) \\
 {\mathcal{T}}_{cL} = \exp( - F \cdot LAI \cdot d_f ) \\
 \epsilon = 1 - \alpha_{s(2,3)}
$$




## Calculation of turbulent parameters (bulk coefficients).

Calculate the turbulence parameters (bulk coefficient).

### roughness calculations for momentum and heat.

The calculation of roughness is based on Watanabe (1994). Using the results of Kondo and Watanabe's (1992) multi-layered canopy model, Watanabe (1994) proposed the following roughness functions for the bulk model that best fit the results.

$$
 \left(\ln \frac{h-d}{z_0}\right)^{-1} =
 \left[ 1 - \exp( -A^+) + \left(-\ln \frac{z_{0s}}{h}\right)^{-1/0.45}
  \exp(-2A^+)\right]^{0.45} \\
 \left(\ln \frac{h-d}{z_T^{\dagger}}\right)^{-1} =
 \frac{1}{-\ln(z_{Ts}/h)} \left[ \frac{P_1}{P_1 + A^+ \exp({A^+})}\right] ^{P2} \\
 \left(\ln \frac{h-d}{z_0}\right)^{-1} \left(\ln \frac{h-d}{z_T}\right)^{-1}
 = C_T^{\infty} \left[1-\exp(-P_3 A^+)
  + \left(\frac{C_T^0}{C_T^{\infty}}\right)^{1/0.9} \exp(-P_4 A^+)\right]^{0.9} \\
 h-d = h [1-\exp(-A^+)] / {A^+} \\
 A^+ = \frac{c_d LAI}{2k^2} \\
 \frac1{C_T^0} = \ln \frac{h-d}{z_0} \ln \frac{h-d}{z_T^{\dagger}} \\
 C_T^{\infty} = \frac{-1+(1+8F_T)^{1/2}}{2} \\
 P_1 = 0.0115 \left(\frac{z_{Ts}}{h}\right)^{0.1}
  \exp\left[5 \left(\frac{z_{Ts}}{h}\right)^{0.22}\right] \\
 P_2 = 0.55 \exp\left[-0.58 \left(\frac{z_{Ts}}{h}\right)^{0.35}\right] \\
 P_3 = [F_T + 0.084 \exp(-15 F_T)]^{0.15} \\
 P_4 = 2 F_T^{1.1} \\
 F_T = c_h / c_d
$$













where $z_0$ and $z_T$ are the roughness of the entire canopy with respect to momentum and heat, respectively, $z_0s$ and $z_Ts$ are the roughness of the ground surface (forest floor) with respect to momentum and heat, respectively, $c_d$ and $c_h$ are the roughness of the ground surface with respect to momentum and heat, respectively $h$ is the vegetation height, $d$ is the zero-plane displacement, and $LAI$ is the LAI for the heat transfer coefficient between the individual leaves and the atmosphere for the $z_T^{\dagger}$ is the roughness of the heat flux at the leaf surface under the assumption of no heat flux, and is used to determine the heat transport coefficient from the forest floor.

$z_{0s}$ and $z_{Ts}$ are given as external data for each land cover type, but the standard values ($z_{0s}=0.05$ m, $z_{Ts}=0.005$ m) are fixed regardless of land cover type. However, for snow cover, the following modifications are made.

$$
 z_{0s} = \max( f_{Sn} z_{0s}, z_{0Sn} ) \\
 z_{Ts} = \max( f_{Sn} z_{0s}, z_{TSn} ) \\
          f_{Sn} = 1 - D_{Sn} / z_{0s}
$$




where $D_{Sn}$, $z_{0Sn}$ and $z_{TSn}$ are the roughness of the snow surface with respect to momentum and heat, respectively.

$c_d$ and $c_h$ are parameters determined by the shape of the leaves and are given as external data for each land cover type.

### Calculating Bulk Coefficients for Momentum and Heat

The bulk coefficients are also derived following Watanabe (1994), using Monin-Obukhov's law of similarity, as follows

$$
 C_M = k^2 \left[ \ln \frac{z_a-d}{z_0} + \Psi_m(\zeta) \right]^{-2} \\
 C_H = k^2 \left[ \ln \frac{z_a-d}{z_0} + \Psi_m(\zeta) \right]^{-1}
             \left[ \ln \frac{z_a-d}{z_T} + \Psi_h(\zeta) \right]^{-1} \\
 C_{Hs} = k^2 \left[ \ln \frac{z_a-d}{z_0} + \Psi_m(\zeta_g) \right]^{-1}
             \left[ \ln \frac{z_a-d}{z_T^{\dagger}} + \Psi_h(\zeta_g) \right]^{-1} \\
 C_{Hc} = C_H - C_{Hs}
$$





where $C_M$ and $C_H$ are the bulk coefficient of total canopy (foliage $+$ forest floor) for momentum and heat, respectively, $C_{Hs}$ is the bulk coefficient of surface (forest floor) flux for heat, and $C_{Hc}$ is the bulk coefficient of canopy (leaf surface) flux for heat. Bulk coefficients, $\Psi_m$ and $\Psi_h$ are Monin-Obukhov shear functions for momentum and heat, respectively, and $z_a$ is the reference altitude of the atmosphere (altitude of the first layer of the atmosphere). $\zeta$ and $\zeta_g$ are calculated using the Monin-Obukhov length $L$ and $L_g$ for the whole canopy and ground surface (forest floor), respectively,

$$
 \zeta = \frac{z_a - d}{L} \\
 \zeta_g = \frac{z_a - d}{L_g}
$$



where the length is denoted by The Monin-Obukhov length is expressed in

$$
 L = \frac{\Theta_0 C_M^{3/2}|V_a|^2}{kg(C_{Hs}(T_s - T_a) + C_{Hc}(T_c - T_a))} \\
 L_s = \frac{\Theta_0 C_M^{3/2}|V_a|^2}{kg C_{Hs}(T_s - T_a)}
$$



is expressed in where $\Theta_0$ =300K, $|V_a|$ is the absolute surface wind speed, $k$ is the Kalman constant, $g$ is the acceleration due to gravity, $T_a$, $T_c$, and $T_s$ are the first atmospheric layer, the canopy (leaf surface) and the ground (forest floor), respectively ) temperature.

Since the bulk coefficients are required for the calculation of the Monin-Obukhov length and the Monin-Obukhov length is required for the calculation of the bulk coefficients, the neutral bulk coefficients are used as the initial values and are repeated (twice in the standard case).

Prior to this calculation, the snow depth is added to the zero-plane displacements, but the zero-plane displacements should be limited to a maximum value so that they are not too large compared to the $z_a$.

$$
 d = \min( d + D_{Sn} ,\  f_{\max} \cdot z_a )
$$


The standard is taking $f_{\max}$ to 0.5.

### Calculating Bulk Coefficients for Water Vapor

This calculation is performed after the calculation of the stomatal resistance, which is described below.

Once the stomatal resistance ($r_{st}$) and surface evaporation resistance ($r_{soil}$) are obtained, the bulk coefficient for water vapor is calculated as follows

$$
 C_{Ec} |V_a| = \left[ (C_{Hc} |V_a|)^{-1} + r_{st} / LAI\right]^{-1} \\
 C_{Es} |V_a| = \left[ (C_{Hs} |V_a|)^{-1} + r_{soil}\right]^{-1}
$$



(Previously, the pore resistance was calculated via roughness by converting the pore resistance into a reduction in the exchange coefficient, but this method was changed to a simpler method because it seemed to be problematic.)

Note that the bulk coefficient of water vapor is the same as the bulk coefficient of heat when no stomatal resistance is applied (e.g., evaporation from a wet surface).

## calculation of stomatal resistance.

The calculation of the stomatal resistance is based on the photosynthesis-stomatal model based on Farquhar et al. (1980), Ball (1988), Collatz et al. The code of SiB2 (Sellers et al., 1996) is used almost verbatim, except for the method to determine the resistance of the entire canopy. It is also possible to use Jarvis-type empirical equations instead, but the explanation is omitted here.

### Calculating Soil Moisture Stress Factors.

Determine the soil water stress on transpiration. The soil water stress factor for each soil layer is determined and the overall soil stress factor is calculated by weighting the stress factor by the distribution of roots in each layer.

Soil water stress in each layer is assessed using SiB2 (Sellers et al., 1996) as a guide, using the following equation

$$
 f_{w(k)} = [ 1 + \exp( 0.02 (\psi_{cr} - \psi_{k}) ) ]^{-1}
\ \ \ \ \ (k=1,\ldots,K_g)
$$


Overall soil stressors are ,

$$
 f_w = \sum_{k=1}^{K_g} f_{w(k)} f_{root(k)}
$$


Here, $f_{root(k)}$ is the ratio of the presence of roots in each layer and is an external parameter for each land cover type. This is $\sum_{k=1}^{K_g} f_{root(k)}=1$.

In addition, the weights that distribute the transpiration to the siphoning flux in each layer are calculated as follows.

$$
 f_{rootup(k)} = f_{w(k)} f_{root(k)} / f_w
\ \ \ \ \ (k=1,\ldots,K_g)
$$


Note that it is $\sum_{k=1}^{K_g} f_{rootup(k)} = 1$.

### Calculating Photosynthesis

Following SiB2 (Sellers et al., 1996), we calculate the amount of photosynthesis.

We believe that the amount of photosynthesis is determined by three upper limits.

$$
 A \leq \min( w_c, w_e, w_s) 
$$


$w_c$ is the upper limit of photosynthetic enzyme (Rubisco) efficiency, and $w_e$ is the upper limit of photosynthetically available radiation. $w_s$ is the upper limit of the sink of photosynthetic products in the case of plants, and C$_4$ is the upper limit of the concentration of CO$_2$ in the case of plants (Collatz et al., 1991, 1992).

The size of each is estimated as follows.

$$
 w_c = \left\{
\begin{array}{ll}
\displaystyle{
V_m \left[ \frac{c_i - \Gamma^*}{c_i + K_c(1+O_2/K_O)}\right]
}
  ({C$_3$ 植物の場合})\\
 V_m
  ({C$_4$ 植物の場合})
\end{array}
\right. \\
 w_e = \left\{
\begin{array}{ll}
\displaystyle{
PAR\cdot \epsilon_3 \left[ \frac{c_i-\Gamma^*}{c_i+2\Gamma^*}\right]
}
  ({C$_3$ 植物の場合})\\
PAR\cdot \epsilon_4
  ({C$_4$ 植物の場合})
\end{array}
\right. \\
 w_s = \left\{
\begin{array}{ll}
V_m / 2
  ({C$_3$ 植物の場合})\\
V_m c_i/ 5
  ({C$_4$ 植物の場合})
\end{array}
\right.
$$




where $V_m$ is the Rubisco reaction capacity, $c_i$ is the partial pressure of CO$_2$ in the stomatal chamber, $O_2$ is the partial pressure of oxygen in the stomatal chamber, and $PAR$ is the photosynthetically available radiation (PAR). $\Gamma^*$ is the compensation point of CO$_2$ and is represented by $\Gamma^* = 0.5 O_2 / S$ $K_c$, $K_O$, and $S$ are functions of temperature and will be shown in functional form later. $\epsilon_3$ and $\epsilon_4$ are constants determined by vegetation type.

(76) is actually solved as follows to represent a smooth transition between the different upper bounds.

$$
 \beta_{ce} w_p^2 - w_p(w_c + w_e) + w_c w_e = 0 \\
 \beta_{ps} A^2 - A(w_p + w_s) + w_p w_s = 0
$$



Solving the two equations in sequence, choosing the smaller of the two solutions for each equation, yields $A_n$. $\beta_{ce}, \beta_{ps}$ are constants determined by vegetation type. Note that when $\beta=1$, it coincides with a simple minimum value operation.

Once the amount of photosynthesis is determined, the net photosynthesis amount ($A_n$) is determined as follows.

$$
 A_n = A - R_d
$$


$R_d$ is the respiratory rate and is expressed as

$$
 R_d = f_d V_m
$$


$f_d$ is a constant determined by vegetation type.

$V_m$, for example, depends on temperature and soil moisture as follows ($V_m$ depends differently on temperature depending on the term that appears, but is represented by the same $V_m$).

$$
 V_m = V_{\max} f_T(T_c) f_w \\
 K_c = 30 \times 2.1^{Q_T} \\
 K_O = 30000 \times 1.2^{Q_T} \\
 S   = 2600 \times 0.57^{Q_T} \\
 f_T(T_c) = \left\{
\begin{array}{ll}
 2.1^{Q_T}/\{1 + \exp[s_1(T_c-s_2)]\}  ({C$_3$ の $w_c$, $w_e$ のとき})\\
 1.8^{Q_T}/\{1 + \exp[s_3(s_4-T_c)]\}  ({C$_3$ の $w_s$ のとき}) \\
 2.1^{Q_T}/\{1 + \exp[s_1(T_c-s_2)]\}/\{1 + \exp[s_3(s_4-T_c)]\}
    ({C$_4$ の $w_c$, $w_e$ のとき})\\
 1.8^{Q_T}   ({C$_4$ の $w_s$ のとき}) \\
 2^{Q_T}/\{1 + \exp[s_5(T_c-s_6)]\}   ({$R_d$ のとき})
\end{array}
\right. \\
Q^T = (T_c - 298) / 10
$$







Here, $V_{\max}$, $s_1, \ldots, s_6$ are constants determined by the vegetation type.

Given the above values for $V_{\max}$, $PAR$, $c_i$, $T_c$ and $f_w$, the amount of photosynthesis in each individual leaf can be calculated. In reality, these values can be considered to be distributed evenly within the same canopy, but we assumed that $c_i$, $T_c$, and $f_w$ are the same for all leaves and that the vertical distributions of $V_{\max}$ and $PAR$ are considered. The vertical distribution of the $PAR$ is large at the top of the canopy and diminishes as it moves downward, and the distribution of the $V_{\max}$ is considered to be similar to that of the $PAR$ following this distribution of the $PAR$.

The average vertical distribution of the $PAR$ (and therefore the vertical distribution of the $V_{\max}$) is shown in the following table.

$$
 PAR(L) = PAR^{top} \exp(- f_{atn} a L)
$$


Here, $L$ is the leaf area accumulated from the top of the canopy, $PAR^{top}$ is the $PAR$ at the top of the canopy, $a$ is the attenuation factor defined in (17), and $f_{atn}$ is a constant for adjustment. Using this value, the factor ($f_{avr}$) which represents the average value of $PAR$ is defined as follows.

$$
 f_{avr} = \int_0^{LAI} PAR(L) dL \Bigm / (LAI \cdot PAR^{top})
 = \frac{1 - \exp(- f_{atn} a L)}{f_{atn} a}
$$


Since each term in $A_n$ ($w_c, w_s, w_e, R_d$) is proportional to $V_{\max}$ or $PAR$, on the assumption that the vertical distributions of $V_{\max}$ and $PAR$ are proportional to those of $V_{\max}$ at the top end of the canopy By multiplying the $A_n$ calculated using the $PAR$ value by $f_{avr}$, the average leaf photosynthetic rate ($\overline{A_n}$) can be obtained.

$$
 \overline{A_n} = f_{avr} A_n
$$


Hereinafter, we will refer to it again as $A_n$.

### Stomatal Resistance Calculations.

Net photosynthesis ($A_n$) and stomatal conductance ($g_s$) are related by the quasi-empirical formula of Ball (1988) as follows

$$
 g_s = m \frac {A_n}{c_s} h_s + b f_w
$$


where $c_s$ is the CO$_2$ molar fraction at the leaf surface (the number of mol of CO$_2$ per 1mol of air), $f_w$ is the soil moisture stress factor, and $m$ and $b$ are constants determined by vegetation type.

$h_s$ is the relative humidity at the leaf surface, defined as

$$
 h_s = e_s / e_i
$$


$e_s$ is the mole fraction of water vapor at the leaf surface, $e_i$ is the mole fraction of water vapor in the stomata, and $e_i = e^*(T_c)$ is the mole fraction of water vapor in the stomata. $e^*$ is the mole fraction of saturated water vapor.

Assuming that the water vapor flux from the stomatal surface to the leaf surface is equal to the water vapor flux from the leaf surface to the atmosphere (i.e., there is no convergent water vapor divergence at the leaf surface),

$$
 g_s(e_i - e_s) = g_l(e_s - e_a)
$$


than ,

$$
 e_s = ( g_l e_a + g_s e_i ) / ( g_l + g_s )
$$


is obtained. where $e_a$ is the atmospheric water vapor mole fraction and $g_l$ is the conductance between the leaf surface and the atmosphere. $g_l$ is represented by $g_l = C_{Hc}|V_a| /
LAI$ using the bulk coefficient.

Similarly, given the lack of convergent divergence of CO$_2$ on the leaf surface,

$$
 A_n = g_l(c_a - c_s)/1.4
     = g_s(c_s - c_i)/1.6
$$


than ,

$$
 c_s = c_a - 1.4 A_n/g_l \\
 c_i = c_s - 1.6 A_n/g_s
$$



where $c_a$ and $c_i$ are obtained from the atmosphere and pores, respectively. where $c_a$ and $c_i$ are the CO$_2$ mole fractions in the atmosphere and in the pores, respectively. 1.4 and 1.6 are constants that appear due to the difference in diffusion coefficients of water vapor and CO$_2$.

Substituting (94) and (96) into (93), we obtain the following equation for $g_s$.

$$
 H g_s^2 + ( H g_l - e_i - H b f_w ) g_s - g_l ( H b f_w + e_a ) = 0
$$


However,

$$
 H = (e_i c_s)/(m A_n)
$$


and use (99) for $c_s$.

Of the two solutions of (100), the larger of the two solutions makes more sense. From the above, assuming that $A_n$ is known, we can solve for $g_s$, but we use $c_i$ to solve for $A_n$. $c_i$ can be obtained by (99) if $g_s$ is obtained. In other words, finding $g_s$ requires $A_n$ and finding $A_n$ requires $c_i$ and thus $g_s$, so the calculation must be repeated.

The algorithm for iterative computation is ported from SiB2. Six iterations are performed and the next solution is estimated in the order of increasing errors to accelerate the convergence.

Finally, using the stomatal conductance, the stomatal resistance is expressed as

$$
 r_{st} = 1/g_{st}
$$


### Calculation of Surface Evaporation Resistance

Calculate the surface evaporation resistance ($r_{soil}$) and the relative humidity ($h_{soil}$) of the first layer of soil as follows.

$$
 r_{soil} = a_1 ( 1 - W_{(1)} ) / ( a_2 + W_{(1)} ) \\
 h_{soil} = \exp \left(\frac{\psi_{(1)} g}{R_{air} T_{g(1)}} \right)
$$



where $W_{(1)} = w_{(1)}/w_{sat(1)}$ is the saturation degree of the first soil layer, $\psi_{1}$ is the moisture potential of the first soil layer, $g$ is the gravitational acceleration, $R_{air}$ is the gas constant of air, and $T_{g(1)}$ is the temperature of the first soil layer. $a_1$ and $a_2$ are constants and the standard uses $a_1=800$, $a_2$=0.2.

# Earth Surface Submodel MATSFC

## Calculation of surface turbulence flux.

The bulk method is used to obtain the turbulent flux at the surface as follows. When the surface energy balance is solved and the surface temperature ($T_s$) and the canopy temperature ($T_c$) are updated, the surface flux is also updated with respect to these values. The value obtained here is a provisional value until then. In order to linearize the energy balance for $T_s$ and $T_c$, the derivatives of each flux for $T_s$ and $T_c$ have been calculated.

 - momentum flux

$$
 \tau_x = - \rho C_{M}|V_a| u_a \\
 \tau_y = - \rho C_{M}|V_a| v_a
$$



 Here, $\tau_x$ and $\tau_y$ are the momentum fluxes (surface stresses) in the east-west and north-south directions, respectively.

 - Sensible Heat Flux

$$
 H_s = c_p \rho C_{Hs}|V_a| (T_s - (P_s/P_a)^{\kappa}T_a)
  \\
 H_c = c_p \rho C_{Hc}|V_a| (T_c - (P_s/P_a)^{\kappa}T_a) \\
 \partial H_s/\partial T_s = c_p \rho C_{Hs}|V_a| \\
 \partial H_c/\partial T_c = c_p \rho C_{Hc}|V_a|
$$





 where $H_s$ and $H_c$ are sensible heat fluxes from the ground surface (forest floor) and canopy (leaf surface), respectively, $\kappa = R_{air} / c_p$ and $R_{air}$ are the gas constant of air, and $c_p$ is the specific heat of air.

 - Bare ground (forest floor) evaporation flux

$$
 Et_{(1,1)} = (1-A_{Sn})(1-f_{ice})\cdot
           \rho \widetilde{C_{Es}}|V_a|(h_{soil}q^*(T_s) - q_a) \\
 Et_{(2,1)} = (1-A_{Sn})f_{ice}\cdot
           \rho \widetilde{C_{Es}}|V_a|(h_{soil}q^*(T_s) - q_a) \\
 \partial Et_{(1,1)}/\partial T_s = (1-A_{Sn})(1-f_{ice})\cdot
           \rho \widetilde{C_{Es}}|V_a|h_{soil}\cdot dq^*/dT |_{T_s} \\
 \partial Et_{(2,1)}/\partial T_s = (1-A_{Sn})f_{ice}\cdot
           \rho \widetilde{C_{Es}}|V_a|h_{soil}\cdot dq^*/dT |_{T_s}
$$





 where $Et_{(1,1)}$ and $Et_{(2,1)}$ are water evaporation and ice sublimation fluxes on bare ground, respectively, $q^*(T_s)$ is the specific humidity at the saturated surface temperature, $h_{soil}$ is the relative humidity at the soil surface, $A_{Sn}$ is the snow cover area fraction, and $f_{ice}$ is the percentage of ice in the first soil layer

$$
  f_{ice} = w_{i(1)}/w_{(1)}
$$


 in $A_{Sn}$. Note that the value of $A_{Sn}$ should be either $0$ (snow-free surface) or $1$ (snow-covered surface) because snow-free and snow-covered surfaces are calculated separately. In the case of downward-facing (condensation) fluxes, no soil moisture resistance is applied, so the bulk coefficient should be calculated as follows

$$
  \widetilde{C_{Es}} = \left\{
  \begin{array}{ll}
   C_{Es} (h_{soil}q^*(T_s) - q_a > 0 {のとき})\\
   C_{Hs} (h_{soil}q^*(T_s) - q_a \leq 0 {のとき})
  \end{array}
  \right.
$$


 - Transpiration Flux

$$
 Et_{(1,2)} = (1-f_{cwet}) \cdot \rho \widetilde{C_{Ec}}|V_a|(q^*(T_c) - q_a) \\
 Et_{(2,2)} = 0 \\
 \partial Et_{(1,2)}/\partial T_c =
  (1-f_{cwet}) \cdot \rho \widetilde{C_{Ec}}|V_a|\cdot dq^*/dT|_{T_c} \\
 \partial Et_{(2,2)}/\partial T_c = 0
$$





 Here, $Et_{(1,2)}$ and $Et_{(2,2)}$ are water and ice transpiration, while $Et_{(2,2)}$ is always zero. $f_{cwet} = w_c / w_{c,cap}$ is the wetting area ratio of the canopy. In the case of downward-facing fluxes, the bulk factor is considered to be condensation on dry parts of the leaves and is calculated as follows

$$
  \widetilde{C_{Ec}} = \left\{
  \begin{array}{ll}
   C_{Ec} (q^*(T_c) - q_a > 0 {のとき})\\
   C_{Hc} (q^*(T_c) - q_a \leq 0 {のとき})
  \end{array}
  \right.
$$


 - Evaporated flux on the canopy
     $T_c$ $\geq$ 0 $^{\circ}$ C

$$
 Et_{(1,3)} =
  f_{cwet} \cdot \rho C_{Hc}|V_a|(q^*(T_c) - q_a) \\
 Et_{(2,3)} = 0 \\
 \partial Et_{(1,3)} \partial T_c =
  f_{cwet} \cdot \rho C_{Hc}|V_a|\cdot dq^*/dT|_{T_c} \\
 \partial Et_{(2,3)} \partial T_c = 0
$$





     $T_c$ $<$ 0 $^{\circ}$ In case of C

$$
 Et_{(1,3)} = 0 \\
 Et_{(2,3)} =
  f_{cwet} \cdot \rho C_{Hc}|V_a|(q^*(T_c) - q_a) \\
 \partial Et_{(1,3)} \partial T_c = 0 \\
 \partial Et_{(2,3)} \partial T_c =
  f_{cwet} \cdot \rho C_{Hc}|V_a|\cdot dq^*/dT|_{T_c}
$$





 Here, $Et_{(1,3)}$ and $Et_{(2,3)}$ are the evaporation of water and ice sublimation on the canopy.

 - Snow Sublimation Flux

$$
 E_{Sn} = A_{Sn}\cdot \rho C_{Hs}|V_a|(q^*(T_s) - q_a) \\
 \partial E_{Sn}/\partial T_s = A_{Sn}\cdot \rho C_{Hs}|V_a|
 \cdot dq^*/dT|_{T_s}
$$



     $E_{Sn}$ is a snow sublimation flux. Note that since snow-free and snow-covered surfaces are calculated separately, $A_{Sn}$ contains either $0$ (snow-free surface) or $1$ (snow-covered surface).

## Calculating heat transfer flux.

Calculating the heat conduction fluxes on snow-free and snow-covered surfaces. As well as the turbulent fluxes, the heat conduction fluxes are also updated when the surface temperature is updated after the energy balance is solved.

Note that since snow-free and snow-covered surfaces are calculated separately, the snow coverage area ratio ($A_{Sn}$) should be set to either $0$ (snow-free surface) or $1$ (snow-covered surface), as shown below.

 - Heat Transfer Flux on Snow-Free Surfaces

$$
  F_{g(1/2)} = (1 - A_{Sn}) \cdot k_{g(1/2)} / \Delta z_{g(1/2)} (T_{g(1)} - T_s) \\
  \partial F_{g(1/2)}/\partial T_s =
  - (1 - A_{Sn}) \cdot k_{g(1/2)} / \Delta z_{g(1/2)}
$$



 where $F_{g(1/2)}$ is the heat transfer flux, $k_{g(1/2)}$ is the thermal conductivity of the soil, $\Delta z_{g(1/2)}$ is the thickness of the first layer of soil from the temperature definition point to the ground surface, and $T_{g(1)}$ is the temperature of the first layer of soil.

 - Heat Transfer Flux of Snow Surface

$$
  F_{Sn(1/2)} = A_{Sn} \cdot k_{Sn(1/2)} / \Delta z_{Sn(1/2)} (T_{Sn(1)} - T_s)
 \\
  \partial F_{Sn(1/2)}/\partial T_s =
  - A_{Sn} \cdot k_{Sn(1/2)} / \Delta z_{Sn(1/2)}
$$



 where $F_{Sn(1/2)}$ is the heat transfer flux, $k_{Sn(1/2)}$ is the thermal conductivity of the snowpack, $\Delta z_{Sn(1/2)}$ is the thickness of the first layer of snow from the temperature definition point to the ground surface, and $T_{Sn(1)}$ is the temperature of the first layer of snowpack.

## Surface, Solving the Canopy Energy Balance

The energy balance is solved for two cases: 1: the case of no melting and 2: the case of melting at the surface. In Case 2, we fix the surface temperature ($T_s$) to $0^{\circ}$ C, and diagnose the energy available for melting based on the energy balance. Since the snow melting on vegetation will be processed by correction later, we do not solve this case separately here. The case in which the snow melts completely within a time step is also processed by later corrections.

### Surface, Canopy Energy Balance

The amount of energy dissipation at the ground surface (forest floor) is ,

$$
 \Delta F_s =
  H_s + R^{net}_s + l Et_{(1,1)} + l_s ( Et_{(2,1)} + E_{Sn} )
  - F_{g(1/2)} - F_{Sn(1/2)}
$$


However, $l$ and $l_s$ are the latent heat of evaporation and sublimation, respectively, and $R^{net}_s$ is the net radiative divergence at the ground surface,

$$
  R^{net}_s = -(R^{\downarrow}_S - R^{\uparrow}_S) {\mathcal{T}}_{cS}
              - \epsilon R^{\downarrow}_L {\mathcal{T}}_{cL}
              + \epsilon \sigma T_s^4
              - \epsilon \sigma T_c^4 (1 - {\mathcal{T}}_{cL})
$$


$\sigma$ is the Stefan-Boltzman constant.

The amount of energy dissipation in the canopy (leaf surface) is ,

$$
  \Delta F_c =
  H_c + R^{net}_c + l ( Et_{(1,2)} + Et_{(1,3)} )
  + l_s ( Et_{(2,2)} + Et_{(2,3)} )
$$


However, $R^{net}_c$ is the net radiative divergence in the canopy,

$$
  R^{net}_c = -(R^{\downarrow}_S - R^{\uparrow}_S) (1-{\mathcal{T}}_{cS})
              - \epsilon R^{\downarrow}_L (1-{\mathcal{T}}_{cL})
              + ( 2 \epsilon \sigma T_c^4
              - \epsilon \sigma T_s^4 ) (1 - {\mathcal{T}}_{cL})
$$


### Case 1: In the absence of surface melting

In the absence of melting of the ground surface, as $\Delta F_s=\Delta F_c=0$, we solve for $T_s$ and $T_c$ so that the energy balance between the ground surface and the canopy is maintained.

The linearized energy balance equation for each term for $T_s$ and $T_c$ is,

$$
 \left(
\begin{array}{l}
 \Delta F_s \\
 \Delta F_c \\
\end{array}
\right)^{current}
=
\left(
\begin{array}{l}
 \Delta F_s \\
 \Delta F_c \\
\end{array}
\right)^{past}
+
\left(
\begin{array}{ll}
 {\partial \Delta F_s}/{\partial T_s} 
 {\partial \Delta F_s}/{\partial T_c} \\
 {\partial \Delta F_c}/{\partial T_s} 
 {\partial \Delta F_c}/{\partial T_c} \\
\end{array}
\right)
\left(
\begin{array}{l}
 \Delta T_s \\
 \Delta T_c \\
\end{array}
\right)
=
\left(
\begin{array}{l}
 0 \\
 0 \\
\end{array}
\right)
$$


I could write.

The part marked with $past$ on the right-hand side is the flux calculated from (107) to (134) using the values of $T_s$ and $T_c$ in the previous step and substituted into (136) to (139).

The differential term is ,

$$
 \frac{\partial \Delta F_s}{\partial T_s} =
 \frac{\partial H_s}{\partial T_s}
+\frac{\partial R^{net}_s}{\partial T_s}
+l\frac{\partial Et_{(1,1)}}{\partial T_s}
+l_s\left(\frac{\partial Et_{(2,1)}}{\partial T_s}
+    \frac{\partial E_{Sn}}{\partial T_s}\right)
-\frac{\partial F_{g(1/2)}}{\partial T_s}
-\frac{\partial F_{Sn(1/2)}}{\partial T_s} \\
 \frac{\partial \Delta F_s}{\partial T_c} =
 \frac{\partial R^{net}_s}{\partial T_c} \\
 \frac{\partial \Delta F_c}{\partial T_s} =
 \frac{\partial R^{net}_c}{\partial T_s} \\
 \frac{\partial \Delta F_c}{\partial T_c} =
 \frac{\partial H_c}{\partial T_c}
+\frac{\partial R^{net}_c}{\partial T_c}
+l  \left(\frac{\partial Et_{(1,2)}}{\partial T_c}
+         \frac{\partial Et_{(1,3)}}{\partial T_c}\right)
+l_s\left(\frac{\partial Et_{(2,2)}}{\partial T_c}
+         \frac{\partial Et_{(2,3)}}{\partial T_c}\right)
$$





However,

$$
 \frac{\partial R^{net}_s}{\partial T_s} =
 \epsilon 4 \sigma T_s^3 \\
 \frac{\partial R^{net}_s}{\partial T_c} =
 - ( 1 - {\mathcal{T}}_{cL} ) \epsilon 4 \sigma T_c^3 \\
 \frac{\partial R^{net}_c}{\partial T_s} =
 - ( 1 - {\mathcal{T}}_{cL} ) \epsilon 4 \sigma T_s^3 \\
 \frac{\partial R^{net}_c}{\partial T_c} =
  2( 1 - {\mathcal{T}}_{cL} ) \epsilon 4 \sigma T_c^3
$$





Using the above, solve (140) for $T_s$ and $T_c$.

### Case 2: When there is ground surface melting

Melting of the ground surface occurs when there is snow or ice cover on the ground surface and the temperature of the ground surface ($T_s^{current} = T_s^{past}+\Delta T_s$) is higher than 0 $^{\circ}$ C after the solution in Case 1. If there is ground surface melting, the surface temperature is fixed at 0 $^{\circ}$ C. In other words, the surface temperature is fixed at 0 $^{\circ}$ C,

$$
 \Delta T_s = \Delta T_s^{melt} = T_{melt} - T_s^{past}
$$


is the melting point of ice (0 $^{\circ}$ C). $T_{melt}$ is the melting point of ice (0 $^{\circ}$ C).

Assuming that $T_c$ is known, $\Delta T_s$ is obtained by the following equation as well as (140).

$$
 \Delta T_c = \left( - \Delta F_c^{past}
            - \frac{\partial \Delta F_c}{\partial T_s} \Delta T_s^{melt}
              \right) \Bigm/ \frac{\partial \Delta F_c}{\partial T_c}
$$


If the $\Delta T_s$ and $\Delta T_c$ are thus known, the energy convergence at the surface used for melting will be

$$
 \Delta F_{conv} =
 - \Delta F_s^{current} = - \Delta F_s^{past}
 - \frac{\partial \Delta F_s}{\partial T_s} \Delta T_s^{melt}
 - \frac{\partial \Delta F_s}{\partial T_c} \Delta T_c
$$


It is obtained by.

### Constraints on solutions.

We set some constraints on the solution of the surface energy balance. If the condition is violated, the energy balance is re-solved by fixing the violated flux at the limit of the condition to be met.

1. don't take too much water vapor from the first layer of the atmosphere
 A large downward latent heat may be generated due to temporary computational instability. Even in such a case, the condition is set so that all the water vapor from the surface to the first layer of the atmosphere is not lost.

$$
  Et_{(i,j)}^{current} > - q_a ( P_s - P_a ) / (g \Delta t)
   \ \ \ \ \ (i=1,2 ; j=1,2,3) \\
  E_{Sn}^{current} > - q_a ( P_s - P_a ) / (g \Delta t)
$$



 Here, $g$ and $\Delta t$ are the acceleration due to gravity and the time step of the atmospheric model. For the values such as $Et$ used in the judgment, an updated flux value ($current$) is used with respect to the value of $T_s$ and $T_c$, which have been updated to satisfy the energy balance. This is the same for all other cases below. Updating the flux value will be described later.

2. soil moisture is not negative.
 Prevent soil moisture from becoming negative through transpiration.

$$
   Et_{(1,2)}^{current} <
     \sum_{k\in rootzone} \rho_w w_{k}\Delta z_{g(k)} /\Delta t_L
$$


 where $\rho_w$ is the density of water and $\Delta t_L$ is the time step of the land surface model.

3. no negative water content on the canopy
 Ensure that water on the canopy does not become negative by evaporation.

$$
   Et_{(i,3)}^{current} < \rho_w w_c /\Delta t_L
   \ \ \ \ \ (i=1,2)
$$


4. the snowpack is not negative
 Ensure that the snowpack does not become negative due to sublimation of the snowpack.

$$
   E_{Sn}^{current} < Sn /\Delta t_L
$$


### Ground Surface, Canopy Temperature Update

Update surface and canopy temperatures.

$$
 T_s^{current} = T_s^{past} + \Delta T_s \\
 T_c^{current} = T_c^{past} + \Delta T_c
$$



Based on the updated canopy temperature, it is necessary to diagnose whether the water in the canopy is liquid or solid. This information will be used in the future when dealing with the freeze and thaw of the water on the canopy.

$$
 A_{Snc} = \left\{
\begin{array}{ll}
 0 (T_c \geq T_{melt})\\
 1 (T_c <    T_{melt})
\end{array}
\right.
$$


The $A_{Snc}$ is the freezing area fraction of water on the canopy.

### Update the value of the flux

Update the flux value with respect to the updated $T_s$ and $T_c$ values. If you set the $F$ to an arbitrary flux, updating the value is done as follows

$$
 F^{current} = F^{past} + \frac{\partial F}{\partial T_s} \Delta T_s
                        + \frac{\partial F}{\partial T_c} \Delta T_c
$$


The updated flux value is used to calculate the flux output to the atmosphere.

$$
 H = H_s + H_c \\
 E = \sum_{j=1}^3 \sum_{i=1}^2 Et_{(i,j)} + E_{Sn} \\
 R^{\uparrow}_L = {\mathcal{T}}_{cL} \epsilon \sigma T_s^4
 + (1 - {\mathcal{T}}_{cL}) \epsilon \sigma T_c^4
 + (1 - \epsilon) R^{\downarrow}_L \\
 T_{sR} = ( R^{\uparrow}_L / \sigma )^{1/4}
$$





$T_{sR}$ is the radiant temperature of the ground surface.

The root uptake flux of each soil layer is calculated.

$$
 F_{root(k)} = f_{rootup(k)} Et_{(1,2)} \ \ \ \ (k=1,\ldots,K_g)
$$


$F_{root(k)}$ is the weight of the uptake flux of the roots, and $f_{rootup(k)}$ is the weight that distributes the transpiration rate to the uptake flux of the roots in each layer.

