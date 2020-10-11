# Boundary Value Submodel MATBND

## Set of vegetation shape parameters.

The leaf area index (LAI) and vegetation height are set as vegetation shape parameters.

The LAI reads the seasonally varying horizontal distributions, and the top and bottom canopy heights are determined by land use type as external parameters. If there is snowfall, the LAI considers only the vegetation above the snow depth and corrects the geometry parameters.

     EQ=00036.
     EQ=00036.
     EQ=00036.

Here, TERM00000 is the height at the top of the canopy (vegetation height), TERM00001 is the height at the bottom of the canopy (dead height), TERM00002 is the leaf area index, and TERM00003, TERM00004, and TERM00005 are the values without snow, respectively. TERM00006 is the snow cover depth. It is assumed that the LAI is uniformly distributed vertically between the top and bottom edges of the canopy.

Afterwards, the average of snow-free and snow-covered surfaces weighted by the snow area ratio (TERM00007) is calculated, but since the snow-free surface and the snow-covered surface are calculated separately, TERM00008 requires either TERM00009 (snow-free surface) or TERM00010 (snow-covered surface). Note that it contains either of the values of the (surface), and mixing of values does not occur here (there are several similar locations later).

## Calculating radiant parameters.

Calculation of radiative parameters (albedo, vegetation permeability, etc.).

### Calculation of surface (forest floor) albedo

The horizontal distribution of the ground (forest floor) albedo TERM00011 and TERM00011 is read as an external parameter. TERM00012 and TERM00012 represent the visible and near-infrared wavelengths, respectively. The TERM00013 value of the infrared surface albedo (TERM00013) is set to a fixed value (horizontal distribution may be prepared).

The dependence of the incident angle of albedo on ice and snow cover is considered as a function of the angle of incidence as follows

     EQ=00037.

where TERM00014 and TERM00014 are wavelengths, TERM00015 and TERM00015 are direct and scattered, respectively, and TERM00016 is an albedo value for a direct angle of incidence of TERM00017 (from directly above). TERM00018 is the cosine of the incident angle of incidence for direct and scattered light, respectively,

     EQ=00038.

We give the TERM00019 is the solar zenith angle.

Except for the ice and snow cover surfaces, the albedo of the ground (forest floor) gives the same values for direct and diffuse light, without considering the dependence on the zenith angle. In other words, the results are as follows.

     EQ=00039.

For infrared wavelengths, we only need to consider the scattered light. The infrared albedo gives a value that is independent of the zenith angle for all surfaces.

     EQ=00040.

### Canopy albedo and transmittance calculations

The calculation of albedo and transmittance of the canopy is based on the radiation calculation in the canopy layer by Watanabe and Otani (1995).

Considering a vertically uniform canopy and making some simplifying assumptions, the transfer equation and boundary conditions for the insolation within the canopy are expressed as follows

     EQ=00041.
     EQ=00041.
     EQ=00041.
     EQ=00041.
     EQ=00041.
     EQ=00041.

where TERM00020 is direct downward light, TERM00021 and TERM00022 are upward and downward scattered light, respectively, TERM00023 is the leaf area accumulated from the top of the canopy downward, TERM00024 is the scatter factor (TERM00025), TERM00026 and TERM 00027 is the reflection coefficient and transmission coefficient of the leaf surface (the same values are used for scattered light and direct light), respectively, and TERM00028 is a factor indicating the orientation of the leaf relative to radiation. For simplicity, we assume that the distribution of leaf orientation is random (TERM00029).

These can be solved analytically and the solution is as follows.

     EQ=00042.
     EQ=00042.
     EQ=00042.

Here,

     EQ=00043.
     EQ=00043.
     EQ=00043.
     EQ=00043.
     EQ=00043.
     EQ=00043.
     EQ=00043.
     EQ=00043.

It is.

The Albedo TERM00030 seen at the top of the canopy,

     EQ=00044.

So,

     EQ=00045.
     EQ=00045.

Get.

The transmission coefficient of the canopy (TERM00031), or more precisely, the percentage of the incident light absorbed by the forest floor at the top of the canopy, is

     EQ=00046.

Defined by ,

     EQ=00047.
     EQ=00047.
     EQ=00047.
     EQ=00047.

The above is performed for TERM00032 and TERM00032 (visible and near-infrared), respectively. The above procedure is performed for TERM00032 and TERM00032 (visible and near-infrared), respectively.

The reflectance TERM00033 and transmission TERM00034 are read as external parameters for each land cover type, but before they are used in the above calculations, the following two modifications are made.

1. the effect of snow (ice) on the leaves
 When the canopy temperature is less than 0 TERM00035 C, the water above the canopy is regarded as snow (ice). In this case, the snow albedo (TERM00036) and the water content in the canopy (TERM00037) are used to determine the snow (ice),

         EQ=00048.
         EQ=00048.

 The following table shows the volume of water on the canopy. TERM00038 is the water content in the canopy. The transmittance is given in the following formula for convenience to avoid negative absorption (TERM00039), i.e.

         EQ=00000.

 When the water on the canopy is liquid, we should ignore the change in the radiative parameters of the leaf surface. When the liquid water on the canopy is liquid, changes in the radiative parameters of the leaf surface due to the liquid water on the canopy are ignored. In the case of snowfall trapping by the canopy (snow), and in the case of freezing of the liquid water on the canopy (ice), the same albedo as that of the snow cover on the forest floor is used here, although the radiative characteristics of each case may be different.

2. the effect of considering the direction of reflection and transmission
 In the solution of the above equation, it is assumed that all the reflected light returns to the direction of the incident light, but considering that some of it is scattered in the same direction as the incident light, we can replace the radial parameters of the leaf surface with the following (Watanabe, in press).

         EQ=00049.
         EQ=00049.

The above is done for TERM00040 and TERM00040 (visible and near-infrared), respectively.

We also take into account cases where vegetation is unevenly distributed in parts of the grid (e.g., savannahs), prior to the calculation of albedo, etc,

     EQ=00001.

The LAI of the vegetation cover (the original LAI is considered to be the grid average) is calculated as the LAI of the vegetation cover, which is used in the calculation of the albedo described above. TERM00041 is the vegetation coverage of the grid. After the albedo and other data are obtained, the LAI of the grid is calculated by

     EQ=00050.
     EQ=00050.

We take the area-weighted average of the vegetation-covered and non-vegetation-covered portions, as

### Calculations such as surface radiation flux

Using the downward radiation flux (TERM00042) and the albedo obtained above, the following radiation fluxes are obtained.

     EQ=00051.
     EQ=00051.
     EQ=00051.
     EQ=00051.
     EQ=00051.

TERM00043 and TERM00044 represent the downward and upward shortwave radiation fluxes, TERM00045 represents the downward longwave radiation flux, TERM00046 represents the shortwave radiation flux absorbed by the forest floor, and TERM00047 represents the downward Photosynthetically Active Radiation (PAR) flux .

The canopy transmittance of the shortwave and longwave canopies and the longwave emission coefficient are obtained as follows.

     EQ=00052.
     EQ=00052.
     EQ=00052.

## Calculation of turbulent parameters (bulk coefficients).

Calculate the turbulence parameters (bulk coefficient).

### roughness calculations for momentum and heat.

The calculation of roughness is based on Watanabe (1994). Using the results of Kondo and Watanabe's (1992) multi-layered canopy model, Watanabe (1994) proposed the following roughness functions for the bulk model that best fit the results.

     EQ=00053.
     EQ=00053.
     EQ=00053.
     EQ=00053.
     EQ=00053.
     EQ=00053.
     EQ=00053.
     EQ=00053.
     EQ=00053.
     EQ=00053.
     EQ=00053.
     EQ=00053.

where TERM00048 and TERM00049 are the roughness of the entire canopy with respect to momentum and heat, respectively, TERM00050 and TERM00051 are the roughness of the ground surface (forest floor) with respect to momentum and heat, respectively, TERM00052 and TERM00053 are the roughness of the ground surface with respect to momentum and heat, respectively TERM00054 is the vegetation height, TERM00055 is the zero-plane displacement, and TERM00056 is the LAI for the heat transfer coefficient between the individual leaves and the atmosphere for the TERM00057 is the roughness of the heat flux at the leaf surface under the assumption of no heat flux, and is used to determine the heat transport coefficient from the forest floor.

TERM00058 and TERM00059 are given as external data for each land cover type, but the standard values (TERM00060 m, TERM00061 m) are fixed regardless of land cover type. However, for snow cover, the following modifications are made.

     EQ=00054.
     EQ=00054.
     EQ=00054.

where TERM00062, TERM00063 and TERM00064 are the roughness of the snow surface with respect to momentum and heat, respectively.

TERM00065 and TERM00066 are parameters determined by the shape of the leaves and are given as external data for each land cover type.

### Calculating Bulk Coefficients for Momentum and Heat

The bulk coefficients are also derived following Watanabe (1994), using Monin-Obukhov's law of similarity, as follows

     EQ=00055.
     EQ=00055.
     EQ=00055.
     EQ=00055.

where TERM00067 and TERM00068 are the bulk coefficient of total canopy (foliage TERM00069 forest floor) for momentum and heat, respectively, TERM00070 is the bulk coefficient of surface (forest floor) flux for heat, and TERM00071 is the bulk coefficient of canopy (leaf surface) flux for heat. Bulk coefficients, TERM00072 and TERM00073 are Monin-Obukhov shear functions for momentum and heat, respectively, and TERM00074 is the reference altitude of the atmosphere (altitude of the first layer of the atmosphere). TERM00075 and TERM00076 are calculated using the Monin-Obukhov length TERM00077 and TERM00078 for the whole canopy and ground surface (forest floor), respectively,

     EQ=00056.
     EQ=00056.

where the length is denoted by The Monin-Obukhov length is expressed in

     EQ=00057.
     EQ=00057.

is expressed in where TERM00079 =300K, TERM00080 is the absolute surface wind speed, TERM00081 is the Kalman constant, TERM00082 is the acceleration due to gravity, TERM00083, TERM00084, and TERM00085 are the first atmospheric layer, the canopy (leaf surface) and the ground (forest floor), respectively ) temperature.

Since the bulk coefficients are required for the calculation of the Monin-Obukhov length and the Monin-Obukhov length is required for the calculation of the bulk coefficients, the neutral bulk coefficients are used as the initial values and are repeated (twice in the standard case).

Prior to this calculation, the snow depth is added to the zero-plane displacements, but the zero-plane displacements should be limited to a maximum value so that they are not too large compared to the TERM00086.

     EQ=00058.

The standard is taking TERM00087 to 0.5.

### Calculating Bulk Coefficients for Water Vapor

This calculation is performed after the calculation of the stomatal resistance, which is described below.

Once the stomatal resistance (TERM00088) and surface evaporation resistance (TERM00089) are obtained, the bulk coefficient for water vapor is calculated as follows

     EQ=00059.
     EQ=00059.

(Previously, the pore resistance was calculated via roughness by converting the pore resistance into a reduction in the exchange coefficient, but this method was changed to a simpler method because it seemed to be problematic.)

Note that the bulk coefficient of water vapor is the same as the bulk coefficient of heat when no stomatal resistance is applied (e.g., evaporation from a wet surface).

## calculation of stomatal resistance.

The calculation of the stomatal resistance is based on the photosynthesis-stomatal model based on Farquhar et al. (1980), Ball (1988), Collatz et al. The code of SiB2 (Sellers et al., 1996) is used almost verbatim, except for the method to determine the resistance of the entire canopy. It is also possible to use Jarvis-type empirical equations instead, but the explanation is omitted here.

### Calculating Soil Moisture Stress Factors.

Determine the soil water stress on transpiration. The soil water stress factor for each soil layer is determined and the overall soil stress factor is calculated by weighting the stress factor by the distribution of roots in each layer.

Soil water stress in each layer is assessed using SiB2 (Sellers et al., 1996) as a guide, using the following equation

     EQ=00002.

Overall soil stressors are ,

     EQ=00003.

Here, TERM00090 is the ratio of the presence of roots in each layer and is an external parameter for each land cover type. This is TERM00091.

In addition, the weights that distribute the transpiration to the siphoning flux in each layer are calculated as follows.

     EQ=00004.

Note that it is TERM00092.

### Calculating Photosynthesis

Following SiB2 (Sellers et al., 1996), we calculate the amount of photosynthesis.

We believe that the amount of photosynthesis is determined by three upper limits.

     EQ=00005.

TERM00093 is the upper limit of photosynthetic enzyme (Rubisco) efficiency, and TERM00094 is the upper limit of photosynthetically available radiation. TERM00095 is the upper limit of the sink of photosynthetic products in the case of plants, and TERM00097 is the upper limit of the concentration of TERM00098 in the case of plants (Collatz et al., 1991, 1992).

The size of each is estimated as follows.

     EQ=00060.
     EQ=00060.
     EQ=00060.

where TERM00105 is the Rubisco reaction capacity, TERM00106 is the partial pressure of TERM00107 in the stomatal chamber, TERM00108 is the partial pressure of oxygen in the stomatal chamber, and TERM00109 is the photosynthetically available radiation (PAR). TERM00110 is the compensation point of TERM00111 and is represented by TERM00112 TERM00113, TERM00114, and TERM00115 are functions of temperature and will be shown in functional form later. TERM00116 and TERM00117 are constants determined by vegetation type.

(76) is actually solved as follows to represent a smooth transition between the different upper bounds.

     EQ=00061.
     EQ=00061.

Solving the two equations in sequence, choosing the smaller of the two solutions for each equation, yields TERM00118. TERM00119 and TERM00119 are constants determined by vegetation type. Note that when TERM00120, it coincides with a simple minimum value operation.

Once the amount of photosynthesis is determined, the net photosynthesis amount (TERM00121) is determined as follows.

     EQ=00006.

TERM00122 is the respiratory rate and is expressed as

     EQ=00007.

TERM00123 is a constant determined by vegetation type.

TERM00124, for example, depends on temperature and soil moisture as follows (TERM00125 depends differently on temperature depending on the term that appears, but is represented by the same TERM00126).

     EQ=00062.
     EQ=00062.
     EQ=00062.
     EQ=00062.
     EQ=00062.
     EQ=00062.

Here, TERM00138, TERM00139 and TERM00139 are constants determined by the vegetation type.

Given the above values for TERM00140, TERM00141, TERM00142, TERM00143 and TERM00144, the amount of photosynthesis in each individual leaf can be calculated. In reality, these values can be considered to be distributed evenly within the same canopy, but we assumed that TERM00145, TERM00146, and TERM00147 are the same for all leaves and that the vertical distributions of TERM00148 and TERM00149 are considered. The vertical distribution of the TERM00150 is large at the top of the canopy and diminishes as it moves downward, and the distribution of the TERM00151 is considered to be similar to that of the TERM00153 following this distribution of the TERM00152.

The average vertical distribution of the TERM00154 (and therefore the vertical distribution of the TERM00155) is shown in the following table.

     EQ=00008.

Here, TERM00156 is the leaf area accumulated from the top of the canopy, TERM00157 is the TERM00158 at the top of the canopy, TERM00159 is the attenuation factor defined in (17), and TERM00160 is a constant for adjustment. Using this value, the factor (TERM00162) which represents the average value of TERM00161 is defined as follows.

     EQ=00009.

Since each term in TERM00163 (TERM00164 and TERM00164) is proportional to TERM00165 or TERM00166, on the assumption that the vertical distributions of TERM00167 and TERM00168 are proportional to those of TERM00169 at the top end of the canopy By multiplying the TERM00171 calculated using the TERM00170 value by TERM00172, the average leaf photosynthetic rate (TERM00173) can be obtained.

     EQ=00010.

Hereinafter, we will refer to it again as TERM00174.

### Stomatal Resistance Calculations.

Net photosynthesis (TERM00175) and stomatal conductance (TERM00176) are related by the quasi-empirical formula of Ball (1988) as follows

     EQ=00011.

where TERM00177 is the TERM00178 molar fraction at the leaf surface (the number of mol of TERM00179 per 1mol of air), TERM00180 is the soil moisture stress factor, and TERM00181 and TERM00182 are constants determined by vegetation type.

TERM00183 is the relative humidity at the leaf surface, defined as

     EQ=00012.

TERM00184 is the mole fraction of water vapor at the leaf surface, TERM00185 is the mole fraction of water vapor in the stomata, and TERM00186 is the mole fraction of water vapor in the stomata. TERM00187 is the mole fraction of saturated water vapor.

Assuming that the water vapor flux from the stomatal surface to the leaf surface is equal to the water vapor flux from the leaf surface to the atmosphere (i.e., there is no convergent water vapor divergence at the leaf surface),

     EQ=00013.

than ,

     EQ=00014.

is obtained. where TERM00188 is the atmospheric water vapor mole fraction and TERM00189 is the conductance between the leaf surface and the atmosphere. TERM00190 is represented by TERM00191 using the bulk coefficient.

Similarly, given the lack of convergent divergence of TERM00192 on the leaf surface,

     EQ=00015.

than ,

     EQ=00063.
     EQ=00063.

where TERM00193 and TERM00194 are obtained from the atmosphere and pores, respectively. where TERM00193 and TERM00194 are the TERM00195 mole fractions in the atmosphere and in the pores, respectively. 1.4 and 1.6 are constants that appear due to the difference in diffusion coefficients of water vapor and TERM00196.

Substituting (94) and (96) into (93), we obtain the following equation for TERM00197.

     EQ=00016.

However,

     EQ=00017.

and use (99) for TERM00198.

Of the two solutions of (100), the larger of the two solutions makes more sense. From the above, assuming that TERM00199 is known, we can solve for TERM00200, but we use TERM00202 to solve for TERM00201. TERM00203 can be obtained by (99) if TERM00204 is obtained. In other words, finding TERM00205 requires TERM00206 and finding TERM00207 requires TERM00208 and thus TERM00209, so the calculation must be repeated.

The algorithm for iterative computation is ported from SiB2. Six iterations are performed and the next solution is estimated in the order of increasing errors to accelerate the convergence.

Finally, using the stomatal conductance, the stomatal resistance is expressed as

     EQ=00018.

### Calculation of Surface Evaporation Resistance

Calculate the surface evaporation resistance (TERM00210) and the relative humidity (TERM00211) of the first layer of soil as follows.

     EQ=00064.
     EQ=00064.

where TERM00212 is the saturation degree of the first soil layer, TERM00213 is the moisture potential of the first soil layer, TERM00214 is the gravitational acceleration, TERM00215 is the gas constant of air, and TERM00216 is the temperature of the first soil layer. TERM00217 and TERM00218 are constants and the standard uses TERM00219, TERM00220=0.2.

# Earth Surface Submodel MATSFC

## Calculation of surface turbulence flux.

The bulk method is used to obtain the turbulent flux at the surface as follows. When the surface energy balance is solved and the surface temperature (TERM00221) and the canopy temperature (TERM00222) are updated, the surface flux is also updated with respect to these values. The value obtained here is a provisional value until then. In order to linearize the energy balance for TERM00223 and TERM00224, the derivatives of each flux for TERM00225 and TERM00226 have been calculated.

 - momentum flux

         EQ=00065.
         EQ=00065.

 Here, TERM00227 and TERM00228 are the momentum fluxes (surface stresses) in the east-west and north-south directions, respectively.

 - Sensible Heat Flux

         EQ=00066.
         EQ=00066.
         EQ=00066.
         EQ=00066.

 where TERM00229 and TERM00230 are sensible heat fluxes from the ground surface (forest floor) and canopy (leaf surface), respectively, TERM00231 and TERM00232 are the gas constant of air, and TERM00233 is the specific heat of air.

 - Bare ground (forest floor) evaporation flux

         EQ=00067.
         EQ=00067.
         EQ=00067.
         EQ=00067.

 where TERM00234 and TERM00235 are water evaporation and ice sublimation fluxes on bare ground, respectively, TERM00236 is the specific humidity at the saturated surface temperature, TERM00237 is the relative humidity at the soil surface, TERM00238 is the snow cover area fraction, and TERM00239 is the percentage of ice in the first soil layer

         EQ=00019.

 in TERM00240. Note that the value of TERM00240 should be either TERM00241 (snow-free surface) or TERM00242 (snow-covered surface) because snow-free and snow-covered surfaces are calculated separately. In the case of downward-facing (condensation) fluxes, no soil moisture resistance is applied, so the bulk coefficient should be calculated as follows

         EQ=00020.

 - Transpiration Flux

         EQ=00068.
         EQ=00068.
         EQ=00068.
         EQ=00068.

 Here, TERM00243 and TERM00244 are water and ice transpiration, while TERM00245 is always zero. TERM00246 is the wetting area ratio of the canopy. In the case of downward-facing fluxes, the bulk factor is considered to be condensation on dry parts of the leaves and is calculated as follows

         EQ=00021.

 - Evaporated flux on the canopy
     TERM00247 TERM00248 0 TERM00249 C

         EQ=00069.
         EQ=00069.
         EQ=00069.
         EQ=00069.

     TERM00250 TERM00251 0 TERM00252 In case of C

         EQ=00070.
         EQ=00070.
         EQ=00070.
         EQ=00070.

 Here, TERM00253 and TERM00254 are the evaporation of water and ice sublimation on the canopy.

 - Snow Sublimation Flux

         EQ=00071.
         EQ=00071.

     TERM00255 is a snow sublimation flux. Note that since snow-free and snow-covered surfaces are calculated separately, TERM00256 contains either TERM00257 (snow-free surface) or TERM00258 (snow-covered surface).

## Calculating heat transfer flux.

Calculating the heat conduction fluxes on snow-free and snow-covered surfaces. As well as the turbulent fluxes, the heat conduction fluxes are also updated when the surface temperature is updated after the energy balance is solved.

Note that since snow-free and snow-covered surfaces are calculated separately, the snow coverage area ratio (TERM00259) should be set to either TERM00260 (snow-free surface) or TERM00261 (snow-covered surface), as shown below.

 - Heat Transfer Flux on Snow-Free Surfaces

         EQ=00072.
         EQ=00072.

 where TERM00262 is the heat transfer flux, TERM00263 is the thermal conductivity of the soil, TERM00264 is the thickness of the first layer of soil from the temperature definition point to the ground surface, and TERM00265 is the temperature of the first layer of soil.

 - Heat Transfer Flux of Snow Surface

         EQ=00073.
         EQ=00073.

 where TERM00266 is the heat transfer flux, TERM00267 is the thermal conductivity of the snowpack, TERM00268 is the thickness of the first layer of snow from the temperature definition point to the ground surface, and TERM00269 is the temperature of the first layer of snowpack.

## Surface, Solving the Canopy Energy Balance

The energy balance is solved for two cases: 1: the case of no melting and 2: the case of melting at the surface. In Case 2, we fix the surface temperature (TERM00270) to TERM00271 C, and diagnose the energy available for melting based on the energy balance. Since the snow melting on vegetation will be processed by correction later, we do not solve this case separately here. The case in which the snow melts completely within a time step is also processed by later corrections.

### Surface, Canopy Energy Balance

The amount of energy dissipation at the ground surface (forest floor) is ,

     EQ=00022.

However, TERM00272 and TERM00273 are the latent heat of evaporation and sublimation, respectively, and TERM00274 is the net radiative divergence at the ground surface,

     EQ=00023.

TERM00275 is the Stefan-Boltzman constant.

The amount of energy dissipation in the canopy (leaf surface) is ,

     EQ=00024.

However, TERM00276 is the net radiative divergence in the canopy,

     EQ=00025.

### Case 1: In the absence of surface melting

In the absence of melting of the ground surface, as TERM00277, we solve for TERM00278 and TERM00279 so that the energy balance between the ground surface and the canopy is maintained.

The linearized energy balance equation for each term for TERM00280 and TERM00281 is,

     EQ=00026.

I could write.

The part marked with TERM00282 on the right-hand side is the flux calculated from (107) to (134) using the values of TERM00283 and TERM00284 in the previous step and substituted into (136) to (139).

The differential term is ,

     EQ=00074.
     EQ=00074.
     EQ=00074.
     EQ=00074.

However,

     EQ=00075.
     EQ=00075.
     EQ=00075.
     EQ=00075.

Using the above, solve (140) for TERM00285 and TERM00286.

### Case 2: When there is ground surface melting

Melting of the ground surface occurs when there is snow or ice cover on the ground surface and the temperature of the ground surface (TERM00287) is higher than 0 TERM00288 C after the solution in Case 1. If there is ground surface melting, the surface temperature is fixed at 0 TERM00289 C. In other words, the surface temperature is fixed at 0 TERM00289 C,

     EQ=00027.

is the melting point of ice (0 TERM00291 C). TERM00290 is the melting point of ice (0 TERM00291 C).

Assuming that TERM00292 is known, TERM00293 is obtained by the following equation as well as (140).

     EQ=00028.

If the TERM00294 and TERM00295 are thus known, the energy convergence at the surface used for melting will be

     EQ=00029.

It is obtained by.

### Constraints on solutions.

We set some constraints on the solution of the surface energy balance. If the condition is violated, the energy balance is re-solved by fixing the violated flux at the limit of the condition to be met.

1. don't take too much water vapor from the first layer of the atmosphere
 A large downward latent heat may be generated due to temporary computational instability. Even in such a case, the condition is set so that all the water vapor from the surface to the first layer of the atmosphere is not lost.

         EQ=00076.
         EQ=00076.

 Here, TERM00296 and TERM00297 are the acceleration due to gravity and the time step of the atmospheric model. For the values such as TERM00298 used in the judgment, an updated flux value (TERM00301) is used with respect to the value of TERM00299 and TERM00300, which have been updated to satisfy the energy balance. This is the same for all other cases below. Updating the flux value will be described later.

2. soil moisture is not negative.
 Prevent soil moisture from becoming negative through transpiration.

         EQ=00030.

 where TERM00302 is the density of water and TERM00303 is the time step of the land surface model.

3. no negative water content on the canopy
 Ensure that water on the canopy does not become negative by evaporation.

         EQ=00031.

4. the snowpack is not negative
 Ensure that the snowpack does not become negative due to sublimation of the snowpack.

         EQ=00032.

### Ground Surface, Canopy Temperature Update

Update surface and canopy temperatures.

     EQ=00077.
     EQ=00077.

Based on the updated canopy temperature, it is necessary to diagnose whether the water in the canopy is liquid or solid. This information will be used in the future when dealing with the freeze and thaw of the water on the canopy.

     EQ=00033.

The TERM00304 is the freezing area fraction of water on the canopy.

### Update the value of the flux

Update the flux value with respect to the updated TERM00305 and TERM00306 values. If you set the TERM00307 to an arbitrary flux, updating the value is done as follows

     EQ=00034.

The updated flux value is used to calculate the flux output to the atmosphere.

     EQ=00078.
     EQ=00078.
     EQ=00078.
     EQ=00078.

TERM00308 is the radiant temperature of the ground surface.

The root uptake flux of each soil layer is calculated.

     EQ=00035.

TERM00309 is the weight of the uptake flux of the roots, and TERM00310 is the weight that distributes the transpiration rate to the uptake flux of the roots in each layer.
