# Introduction.

Minimal Advanced Treatments of Surface Interaction and RunOff (MATSIRO) is a land-surface process parameterization that has been developed to introduce the global climate model CCSR/NIES AGCM and other models. MATSIRO is mainly designed to be used for long-term climate calculations for integration from one month to several hundred years, coupled with atmospheric models with grid scales of several 10 km or more. In the development of the system, we paid attention to the fact that the processes to be taken into account in the water-energy cycle of the atmospheric land system are represented as adequately as possible and are modeled as concisely as possible so that the results can be easily interpreted. The development of MATSIRO was based on the CCSR/NIES AGCM5.4g land surface sub-model, combined with the vegetation canopy parameterization by Watanabe (1994), and at the same time improved the processes of snow accumulation and runoff. Subsequently, the AGCM was modified to correspond to the current AGCM5.6 through the modification of the AGCM structure, including the use of a flux coupler and parallelization. As for the physiological processes of the vegetation, the Farquhar-type photosynthesis scheme, which was initially used as a Jarvis-type function for stomatal resistance, has been transferred from the SiB2 code to the Farquhar-type photosynthesis scheme, which is now used as a quasi-standard scheme due to recent advances in climate-ecosystem interaction research.

# Composition of MATSIRO

## MATSIRO Overall

### Overall Structure.

MATSIRO consists of ,

 - Flux Calculation Unit (LNDFLX)

 - Land Surface Integrator (LNDSTP)

This is similar to the standard land process routine of AGCM5.6. This is the same as the standard land process routine of AGCM5.6.

The flux calculator is called in the time step of the atmospheric model as part of the physical process of the atmospheric model. In contrast, the land surface integrator is called from the coupled model main routine as the land surface model equivalent to the atmospheric and oceanic models. The time step is set independently from the atmospheric model.

The data exchange between the fluxing section and the land surface integrating section is carried out through the flux coupler. The flux calculation section treats snow-covered and snow-free surfaces separately and obtains surface fluxes for each of them. The fluxes are weighted and averaged according to the ratio of the snow-covered and snow-free surfaces, and the fluxes are passed through the flux coupler to the land surface integrating unit. At the same time, the temporal averaging operation is also carried out.

Programmatically, the driver program (matdrv.F) contains an entry for the flux calculation part, LNDFLX, and an entry for the land surface integration part, LNDSTP, from which the subroutines of the necessary processes are called. LNDFLX and LNDSTP share the internal variables of MATSIRO.

### Internal variables of MATSIRO

MATSIRO has the following internal variables.

 - TAB00000:0.0
     TERM00000

 - TAB00000:0.1
     TERM00001,TERM00001

 - TAB00000:0.2
 surface temperature

 - TAB00000:0.3
     \K.L.A.[K.R.I.E.D.]

 - TAB00000:1.0
     TERM00002

 - TAB00000:1.1
     TERM00003,TERM00003

 - TAB00000:1.2
 Canopy temperature

 - TAB00000:1.3
     \K.L.A.[K.R.I.E.D.]

 - TAB00000:3.0
     TERM00004

 - TAB00000:3.1
     TERM00005,TERM00005

 - TAB00000:3.2
 Soil temperature

 - TAB00000:3.3
     \K.L.A.[K.R.I.E.D.]

 - TAB00000:4.0
     TERM00006

 - TAB00000:4.1
     TERM00007,TERM00007

 - TAB00000:4.2
 soil moisture content

 - TAB00000:4.3
     \[TERM00008/TERM00009]

 - TAB00000:5.0
     TERM00010

 - TAB00000:5.1
     TERM00011,TERM00011

 - TAB00000:5.2
 Frozen soil moisture content

 - TAB00000:5.3
     \[TERM00012/TERM00013]

 - TAB00000:7.0
     TERM00014

 - TAB00000:7.1

 - TAB00000:7.2
 Water content in the canopy

 - TAB00000:7.3
     \\0.25\\0.25\0.25\0.25\0.25\0.25\0.25\0.00}.

 - TAB00000: 8.0
     TERM00015

 - TAB00000:8.1

 - TAB00000:8.2
 amount of snowfall

 - TAB00000:8.3
     \kosmos[kg/TERM00016]

 - TAB00000:9.0
     TERM00017

 - TAB00000:9.1
     TERM00018,TERM00018

 - TAB00000:9.2
 snow temperature

 - TAB00000:9.3
     \K.L.A.[K.R.I.E.D.]

 - TAB00000:10.0
     TERM00019

 - TAB00000:10.1
     TERM00020,TERM00020

 - TAB00000:10.2
 snow albedo

 - TAB00000:10.3
     \The state of affairs in the state of affairs of others [TERM00021]

where TERM00022 and TERM00022 are snow-free and snow-covered areas, respectively, TERM00023 is the vertical layer number of soil and snow cover (top layer is 1 and increases downward), TERM00024 is the number of soil layers, TERM00025 is the number of snow-covered layers, TERM00026 and TERM00026 are It represents the visible, near-infrared and infrared wavelengths.

In standard practice, there are five layers of soil, with the thicknesses of each layer being 5cm, 20cm, 75cm, 1m, and 2m from the top. The definition points of soil temperature, soil moisture and frozen soil moisture are the same.

The number of layers of the snowpack is variable, and the number of layers increases as the snowpack increases. The standard number of layers is three at most.

The surface temperature and the canopy temperature are so-called skin temperature, which have no heat capacity, but are formally predictive variables (the current calculation method uses the stability evaluated in the previous step, and therefore depends on the value of the previous step. If we evaluate the stability and so on with the updated value and repeat the calculation until the convergence is achieved, then we have a complete diagnostic variable that does not depend on the value of the previous step.) The other variables are all forecast variables that require the values of the previous step.

The surface temperature and the canopy temperature are updated in the flux calculation section. The other variables (the original forecast variables) are all updated in the land surface integration part.

## Flux calculation section

### Structure of the flux calculation section

The flux calculation section proceeds as follows.

1. receive input variables from the coupler.

2. diagnose the snow area ratio of the subgrid.

For the snow-free area (TERM00027) and the snow-covered area (TERM00028), subroutines are called to calculate the fluxes and to update the surface and canopy temperatures. Concretely, the following subroutines are called in sequence.

     MATLAI vegetation shape parameter (LAI, vegetation height)

     2. calculation of MATRAD radiation parameters (albedo, vegetation permeability, etc.)

     MATBLK calculation of turbulent parameters (bulk coefficient) (momentum and heat)

     4. MATRST calculation of stomatal resistance, bare ground evaporation resistance, etc.

     5. MATBLQ calculation of turbulent parameters (bulk coefficient) (water vapor)

     6. calculation of MATFLX surface flux

     7. calculation of MATGHC ground heat transfer

     8. MATSHB Deciphering the energy balance of the ground surface and canopy

4. pass output variables to the coupler.

Register and add history output variables. 5.

(a) to (e) are classified into boundary value submodels and the programs are summarized in matbnd.

(f)-(h) are classified as surface submodels, and the programs are summarized in matsfc.

The photosynthesis scheme MATPHT is called from (d). The photosynthesis scheme is summarized in matpht.

### The input variables in the flux calculation section.

The following variables are entered into the flux calculation section.

 - TAB00001:0.0
     TERM00029

 - TAB00001:0.1

 - TAB00001:0.2
 Atmospheric 1st layer east-west wind

 - TAB00001:0.3
     \The "m/score

 - TAB00001:1.0
     TERM00030

 - TAB00001:1.1

 - TAB00001:1.2
 First layer of atmospheric north-south wind

 - TAB00001:1.3
     \The "m/score

 - TAB00001:2.0
     TERM00031

 - TAB00001:2.1

 - TAB00001:2.2
 Atmospheric 1st layer temperature

 - TAB00001:2.3
     \K.L.A.[K.R.I.E.D.]

 - TAB00001:3.0
     TERM00032

 - TAB00001:3.1

 - TAB00001:3.2
 Specific humidity in the first layer of the atmosphere

 - TAB00001:3.3
     [kg/kg\\]

 - TAB00001:4.0
     TERM00033

 - TAB00001:4.1

 - TAB00001:4.2
 Atmospheric 1st layer pressure

 - TAB00001:4.3
     \The state of affairs of the city of Los Angeles[Pahren]

 - TAB00001:5.0
     TERM00034

 - TAB00001:5.1

 - TAB00001:5.2
 surface pressure

 - TAB00001:5.3
     \The state of affairs of the city of Los Angeles[Pahren]

 - TAB00001:7.0
     TERM00035

 - TAB00001:7.1
     TERM00036, TERM00036

 - TAB00001:7.2
 Surface downward radiation flux

 - TAB00001:7.3
     \W/TERM00037]

 - TAB00001:8.0
     TERM00038

 - TAB00001:8.1

 - TAB00001:8.2
 cosine of the solar zenith angle

 - TAB00001:8.3
     \The state of affairs of the company in the first place is in the form of the following.

where TERM00040 and TERM00040 represent the direct line and scattering, respectively, and TERM00041 and TERM00041 represent the visible, near-infrared, and infrared spectral bands, respectively.

### Output variables in the flux calculation section

The following variables are output from the flux calculation section.

 - TAB00002:0.0
     TERM00042

 - TAB00002:0.1

 - TAB00002:0.2
 surface-to-west wind stress

 - TAB00002:0.3
     \N/TERM00043]

 - TAB00002:1.0
     TERM00044

 - TAB00002:1.1

 - TAB00002:1.2
 surface-to-south wind stress

 - TAB00002:1.3
     \N/TERM0004545]

 - TAB00002:2.0
     TERM00046

 - TAB00002:2.1

 - TAB00002:2.2
 surface sensible heat flux

 - TAB00002:2.3
     The\\\brahammer\bra_Penny.com[W/TERM00047]

 - TAB00002:3.0
     TERM00048

 - TAB00002:3.1

 - TAB00002:3.2
 Surface Water Vapor Flux

 - TAB00002:3.3
     \[kg/TERM00049/s]

 - TAB00002:4.0
     TERM00050

 - TAB00002:4.1

 - TAB00002:4.2
 Upward Bound Shortwave Radiation Flux

 - TAB00002:4.3


 - TAB00002:5.0
     TERM00052

 - TAB00002:5.1

 - TAB00002:5.2
 Upward Bound Longwave Radiation Flux

 - TAB00002:5.3


 - TAB00002:6.0
     TERM00054

 - TAB00002:6.1
     TERM00055,TERM00055

 - TAB00002:6.2
 surface albedo

 - TAB00002:6.3
     \The state of affairs of the world[TERM00056]

 - TAB00002:7.0
     TERM00057

 - TAB00002:7.1

 - TAB00002:7.2
 surface radiation temperature

 - TAB00002:7.3
     \K.L.A.[K.R.I.E.D.]

 - TAB00002:8.0
     TERM00058

 - TAB00002:8.1

 - TAB00002:8.2
 Surface Heat Transfer Flux

 - TAB00002:8.3


 - TAB00002:9.0
     TERM00060

 - TAB00002:9.1

 - TAB00002:9.2
 Heat Transfer Flux for Snow Surface

 - TAB00002:9.3
     The\\\brax.com[W/TERM00061]

 - TAB00002:10.0
     TERM00062

 - TAB00002:10.1
     TERM00063,TERM00063

 - TAB00002:10.2
 Evapotranspiration components

 - TAB00002:10.3
     \[kg/TERM00064/s\braham]

 - TAB00002:11.0
     TERM00065

 - TAB00002:11.1

 - TAB00002:11.2
 surface energy convergence

 - TAB00002:11.3


 - TAB00002:12.0
     TERM00067

 - TAB00002:12.1
     TERM00068,TERM00068

 - TAB00002:12.2
 Root sucking flux

 - TAB00002:12.3
     \[kg/TERM00069/s]

 - TAB00002:13.0
     TERM00070

 - TAB00002:13.1

 - TAB00002:13.2
 leaf area index

 - TAB00002:13.3
     \[TERM00071/TERM00072]

 - TAB00002:14.0
     TERM00073

 - TAB00002:14.1

 - TAB00002:14.2
 Canopy freezing area ratio

 - TAB00002:14.3
     \Holy shit...[TERM00074]

Here, TERM00075 and TERM00075 in evapotranspiration represent liquid and solid, respectively, and TERM00076 and TERM00076 represent bare ground (forest floor) evaporation, evaporation and evaporation of water on the canopy, respectively. The other subscripts are the same as those in the previous section.

## Land surface integral part

### Composition of the Land Surface Integrator

The land surface integration section proceeds as follows.

1. receive input variables from the coupler.

The subroutines of each process are called and the land surface forecast variables are updated. Specifically, the following subroutines are called in sequence.

     1. calculation of the water balance of the MATCNW canopy

 Calculation of     MATSNW snowpack, snow temperature and snow albedo

     3. calculation of MATROF runoff

     MATGND Calculation of soil temperature, soil moisture, and frozen ground

3. pass output variables to the coupler.

Register and add history output variables. 4.

Each subroutine called from the main part of the land surface integrator consists of a submodel. The programs of each sub-model are organized in a single file. In concrete terms, each subroutine is described as follows

 - MATCNW (matcnw.F) Canopy water balance sub-model

 - MATSNW (matsnw.F) snow sub-model

 - MATROF (matrof.F) Spillover sub-model

 - MATGND (matgnd.F) Soil sub-model

The submodels are basically executed in this order, but if necessary, subroutines may be called among the submodels in order to refer to the values of the parameters managed by other submodels. Subroutines within the above submodels may also be called by the fluxing part for the same purpose.

### Input variables in the land surface integration section

The following variables are entered into the land surface integrator.

 - TAB00003:0.0
     TERM00077

 - TAB00003:0.1

 - TAB00003:0.2
 Convective rainfall flux

 - TAB00003:0.3
     \[kg/TERM00078/s]

 - TAB00003:1.0
     TERM00079

 - TAB00003:1.1

 - TAB00003:1.2
 Layered Rainfall Flux

 - TAB00003:1.3
     \[kg/TERM00080/s]

 - TAB00003:2.0
     TERM00081

 - TAB00003:2.1

 - TAB00003:2.2
 Convective snowfall flux

 - TAB00003:2.3
     \[kg/TERM00082/s]

 - TAB00003:3.0
     TERM00083

 - TAB00003:3.1

 - TAB00003:3.2
 Layered Snowfall Flux

 - TAB00003:3.3
     \[kg/TERM00084/s]

 - TAB00003:4.0
     TERM00085

 - TAB00003:4.1

 - TAB00003:4.2
 Surface Heat Transfer Flux

 - TAB00003:4.3
     \The "W/TERM00086\

 - TAB00003:5.0
     TERM00087

 - TAB00003:5.1

 - TAB00003:5.2
 Heat Transfer Flux for Snow Surface

 - TAB00003:5.3
     \W/TERM000888]

 - TAB00003:6.0
     TERM00089

 - TAB00003:6.1
     TERM00090,TERM00090

 - TAB00003:6.2
 Evapotranspiration components

 - TAB00003:6.3
     \[kg/TERM00091/s]

 - TAB00003:7.0
     TERM00092

 - TAB00003:7.1

 - TAB00003:7.2
 surface energy convergence

 - TAB00003:7.3


 - TAB00003:8.0
     TERM00094

 - TAB00003:8.1
     TERM00095,TERM00095

 - TAB00003:8.2
 Root sucking flux

 - TAB00003:8.3
     [kg/TERM00096/s\\\blade}]

 - TAB00003:9.0
     TERM00097

 - TAB00003:9.1

 - TAB00003:9.2
 leaf area index

 - TAB00003:9.3
     \The state of affairs of the state [TERM00098/TERM00099]

 - TAB00003:10.0
     TERM00100

 - TAB00003:10.1

 - TAB00003:10.2
 Canopy freezing area ratio

 - TAB00003:10.3
     \The state of affairs in the state of affairs of the company [TERM001010101]

### Output variables of the land surface integration section

The land surface integrator outputs the following variables.

 - TAB00004:0.0
     TERM00102

 - TAB00004:0.1

 - TAB00004:0.2
 runoff

 - TAB00004:0.3
     [kg/TERM00103/s\\blind}

The runoff is used as an input variable for the river network model.

## External Parameters.

There are two types of external parameters for executing MATSIRO: one is the parameter values of each grid by the horizontal distribution (map), and the other is the parameter values for each land cover type or soil type by the table. Land cover type and soil type are one of the parameters given by the map, and each parameter given by the table is assigned to each grid. Namely,

> the parameter given by a map > the parameter given by a table \\[EQ=00000.\\.066} or \.066\.066\.

where TERM00104 and TERM00104 are indices of the horizontal position of the grid, TERM00105 is the land use type, and TERM00106 is the soil type. where TERM00104 and TERM00104 are the indexes of the horizontal position of the grid, TERM00105 is the land use type, and TERM00106 is the soil type.

### External parameters given by the map

The types of external parameters given by the map are as follows.

 - TAB00005:0.0
     TERM00107

 - TAB00005:0.1

 - TAB00005:0.2
 Land cover type

 - TAB00005:0.3
 constant

 - TAB00005:0.4
     \\\.com

 - TAB00005:1.0
     TERM00108

 - TAB00005:1.1

 - TAB00005:1.2
 Soil Type

 - TAB00005:1.3
 constant

 - TAB00005:1.4
     \\\.com

 - TAB00005:2.0
     TERM00109

 - TAB00005:2.1

 - TAB00005:2.2
 Leaf Area Index (LAI)

 - TAB00005:2.3
 every month

 - TAB00005:2.4
     \[TERM00110/TERM00111]

 - TAB00005:3.0
     TERM00112

 - TAB00005:3.1
     TERM00113,TERM00113

 - TAB00005:3.2
 Ground surface (forest floor) albedo

 - TAB00005:3.3
 constant

 - TAB00005:3.4
     \\\.com

 - TAB00005:4.0
     TERM00114

 - TAB00005:4.1

 - TAB00005:4.2
 Tangent of the mean surface slope

 - TAB00005:4.3
 constant

 - TAB00005:4.4
     \\\.com

 - TAB00005:5.0
     TERM00115

 - TAB00005:5.1

 - TAB00005:5.2
 elevation standard deviation

 - TAB00005:5.3
 constant

 - TAB00005:5.4
     \\0.25\\0.25\0.25\0.25\0.25\0.25\0.25\0.00}.

### External parameters given by the table for each land cover type

The external parameters given by the table for each land cover type are as follows

 - TAB00006:0.0
     TERM00116

 - TAB00006:0.1

 - TAB00006:0.2
 vegetation height

 - TAB00006:0.3
     \\0.25\\0.25\0.25\0.25\0.25\0.25\0.25\0.00}.

 - TAB00006:1.0
     TERM00117

 - TAB00006:1.1

 - TAB00006:1.2
 Height of the bottom of the canopy

 - TAB00006:1.3
     \\0.25\\0.25\0.25\0.25\0.25\0.25\0.25\0.00}.

 - TAB00006:2.0
     TERM00118

 - TAB00006:2.1
     (TERM00119=1,2)

 - TAB00006:2.2
 Reflectivity of individual leaves

 - TAB00006:2.3
     \\\.com

 - TAB00006:3.0
     TERM00120

 - TAB00006:3.1
     (TERM00121=1,2)

 - TAB00006:3.2
 Transmittance of individual leaves

 - TAB00006:3.3
     \\\.com

 - TAB00006:4.0
     TERM00122

 - TAB00006:4.1
     (TERM00123,TERM00123)

 - TAB00006:4.2
 Percentage of root presence

 - TAB00006:4.3
     \\\.com

 - TAB00006:5.0
     TERM00124

 - TAB00006:5.1

 - TAB00006:5.2
 Momentum exchange coefficient between the individual leaves and the atmosphere

 - TAB00006:5.3
     \\\.com

 - TAB00006:6.0
     TERM00125

 - TAB00006:6.1

 - TAB00006:6.2
 Heat Exchange Coefficient between individual leaves and the atmosphere

 - TAB00006:6.3
     \\\.com

 - TAB00006:7.0
     TERM00126

 - TAB00006:7.1

 - TAB00006:7.2
 vegetation coverage

 - TAB00006:7.3
     \\\.com

 - TAB00006:8.0
     TERM00127

 - TAB00006:8.1

 - TAB00006:8.2
     Rubisco Reaction Capacity

 - TAB00006:8.3
     \The "m/score

 - TAB00006:9.0
     TERM00128

 - TAB00006:9.1

 - TAB00006:9.2
     TERM00129-TERM00130 Slope of the relationship

 - TAB00006:9.3
     \\\.com

 - TAB00006:10.0
     TERM00131

 - TAB00006:10.1

 - TAB00006:10.2
     TERM00132-TERM00133 relationship intercepts

 - TAB00006:10.3
     \The "m/score

 - TAB00006:11.0
     TERM00134, TERM00135

 - TAB00006:11.1

 - TAB00006:11.2
 Photosynthetic efficiency per photon

 - TAB00006:11.3
     \centric[m/s/mol\]

 - TAB00006:12.0
     TERM00136

 - TAB00006:12.1

 - TAB00006:12.2
 Coupling factor between     TERM00137 and TERM00138

 - TAB00006:12.3
     \\\.com

 - TAB00006:13.0
     TERM00139

 - TAB00006:13.1

 - TAB00006:13.2
 Coupling factor between     TERM00140 and TERM00141

 - TAB00006:13.3
     \\\.com

 - TAB00006:14.0
     TERM00142

 - TAB00006:14.1

 - TAB00006:14.2
 respiratory coefficient

 - TAB00006:14.3
     \\\.com

 - TAB00006:15.0
     TERM00143

 - TAB00006:15.1

 - TAB00006:15.2
 Critical temperature of high temperature suppression

 - TAB00006:15.3
     \K.L.A.[K.R.I.E.D.]

 - TAB00006:16.0
     TERM00144

 - TAB00006:16.1

 - TAB00006:16.2
 Critical temperature of cryogenic suppression

 - TAB00006:16.3
     \K.L.A.[K.R.I.E.D.]

### External parameters given by the table for each soil type

The external parameters given by the table for each land cover are as follows.

 - TAB00007:0.0
     TERM00145

 - TAB00007:0.1
     (TERM00146,TERM00146)

 - TAB00007:0.2
 Specific Heat of Soil

 - TAB00007:0.3
     \The "\brahammer"[J/TERM00147147]

 - TAB00007:1.0
     TERM00148

 - TAB00007:1.1
     (TERM00149,TERM00149)

 - TAB00007:1.2
 Thermal Conductivity of Soil

 - TAB00007:1.3
     \The state of affairs in the event of a race is incompatible with the state of the art.

 - TAB00007:2.0
     TERM00150

 - TAB00007:2.1
     (TERM00151,TERM00151)

 - TAB00007:2.2
 Soil Porosity

 - TAB00007:2.3
     \The state of affairs of the company [TERM00152/TERM00153]

 - TAB00007:3.0
     TERM00154

 - TAB00007:3.1
     (TERM00155,TERM00155)

 - TAB00007:3.2
 Saturated Permeability of Soil

 - TAB00007:3.3
     \The "m/score

 - TAB00007:4.0
     TERM00156

 - TAB00007:4.1
     (TERM00157,TERM00157)

 - TAB00007:4.2
 Soil Saturation Moisture Potential

 - TAB00007:4.3
     \\0.25\\0.25\0.25\0.25\0.25\0.25\0.25\0.00}.

 - TAB00007:5.0
     TERM00158

 - TAB00007:5.1
     (TERM00159,TERM00159)

 - TAB00007:5.2
 Index of Soil Moisture Potential Curve

 - TAB00007:5.3
     \\\.com
