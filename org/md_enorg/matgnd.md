# Soil Submodel MATGND

Calculating soil temperature, soil moisture and frozen ground.

## Calculating heat transfer in soil.

### The Heat Transfer Equation in Soil

The prediction equation for soil temperature due to heat transfer in the soil is as follows.

    EQ=00000.

TERM00000 is the heat capacity of the soil and is defined by

    EQ=00001.

TERM00001 is the specific heat of the soil and is given as a parameter for each soil type. TERM00002 is the specific heat of water and TERM00003 is the soil water content (volume moisture content). TERM00004 is the thickness of the TERM00005 layer of soil. Thus, when the heat capacity of the soil is included in the heat capacity of the soil, the energy is not conserved unless the heat transport due to soil moisture transfer is taken into account. Since the heat transport associated with soil moisture transfer is not considered in MATGND, we are now discussing its introduction. However, it should be noted that the energy conservation is somehow broken unless the heat capacity of water vapor and precipitation in the atmosphere is taken into account.

The heat transfer flux TERM00006 is given by

    EQ=00002.

where TERM00007 is the thermal conductivity of the soil and is given as follows

    EQ=00003.

TERM00008 is the thermal conductivity of the soil when the soil moisture content is TERM00009, and TERM00010 and TERM00011 are constants.

TERM00012 is the thickness between the temperature definition point of the first TERM00013 layer and the soil temperature definition point of the TERM00014 layer (for TERM00015, it is the thickness between the temperature definition point of the first layer and the top of the soil, and for TERM00016, it is the thickness between the temperature definition point of the lowest layer and the bottom of the soil).

In (3), the boundary condition (TERM00017) is obtained by adding the energy convergence at the bottom edge of the snowpack (including the heat flux at the bottom edge of the snowpack) and the assignment of the energy correction term to the snow-free surface due to the phase change of water content in the canopy. The fluxes are given. The fluxes are positive upward and are negative when adding the convergence amount. The boundary condition TERM00018 at the lower edge of the soil is assumed to be zero flux.

### Solving the heat transfer equation.

These equations are solved in terms of soil temperature from the first to the lowest layer using the implicit method. In other words, for TERM00019 and TERM00019, the heat transfer fluxes are estimated by

    EQ=00004.

    EQ=00005.

    EQ=00006.

    EQ=00007.

and then add (1) to

    EQ=00022.
    EQ=00022.
    EQ=00022.

and solved by the LU decomposition method as a series of TERM00021 equations for TERM00020 and TERM00020. Note that the fluxes at the top and bottom of the soil are fixed as boundary conditions.

    EQ=00008.

In addition, the soil temperature is partially updated by EQ=00008. After correction for the phase change of soil moisture content, which will be described later, the soil temperature is completely updated.

## Calculation of soil moisture transfer

### Equation for Soil Moisture Transfer

The equation for soil moisture transfer (Richards' equation) is given by

    EQ=00009.

Soil moisture flux TERM00022 is given by

    EQ=00010.

where TERM00023 is the soil permeability coefficient based on Clapp and Hornberger (1978) and is given as follows

    EQ=00011.

TERM00024 is the saturated hydraulic conductivity and TERM00025 is the index of moisture potential curve as an external parameter for each soil type. TERM00026 is the saturation degree excluding freezing soil moisture and is given by

    EQ=00012.

TERM00027 is the porosity of soil, which is also given as a parameter for each soil type. TERM00028 is the parameter that indicates the suppression of soil moisture migration due to the presence of frozen soil, and is currently given as follows.

    EQ=00013.

This parameter is TERM00029.

TERM00030 is the soil moisture potential given by Clapp and Hornberger as follows

    EQ=00023.

TERM00031 is given as an external parameter for each soil type.

In (11), TERM00032 is the source term and, considering the absorption and runoff by roots, is given by

    EQ=00014.

In (12), the boundary condition TERM00033 is the difference between the water flux (TERM00034) and the evaporation flux (TERM00035) at the top of the soil through the runoff process. Apart from this, the sublimation flux is subtracted from the frozen soil moisture in the first layer prior to the calculation of soil moisture transfer.

    EQ=00024.
    EQ=00024.

### Solving the soil moisture transfer equation

These equations are solved from the first to the lowest layer using the implicit method. In other words, for TERM00036 and TERM00036, the soil moisture fluxes are estimated by

    EQ=00015.

    EQ=00016.

    EQ=00017.

    EQ=00018.

and (11) as

    EQ=00025.
    EQ=00025.
    EQ=00025.

The equations are treated as follows for TERM00037 and TERM00037, and are solved by the LU decomposition method as a series of TERM00038 equations for TERM00037 and TERM00037. Note that the fluxes at the top and bottom of the soil are fixed as boundary conditions.

    EQ=00019.

The soil moisture content is updated using the LU decomposition method.

If this calculation results in supersaturation of soil moisture, the supersaturation is removed by vertical adjustment. The supersaturation is not considered as runoff because this supersaturation is artificial and is caused by the solution of the vertical soil moisture transfer without information about the saturation. First, supersaturated soil moisture is applied from the second soil layer downward. Then, from the lowermost layer of soil to the uppermost layer, the supersaturated soil moisture is added to the uppermost layer. This operation results in the formation of a saturated layer near the bottom of the soil when soil moisture is sufficiently high to define the groundwater level (with a certain amount of water content of the ground surface in the vicinity of the lowest layer of soil (with a certain amount of water content of the ground surface in the vicinity of the lowest level of soil).

## Phase changes in soil moisture.

As a result of the heat conduction in the soil, the phase change of soil moisture content is calculated when the temperature of the layer with liquid moisture is below TERM00039 C or when the temperature of the layer with solid moisture is above TERM00040. Assuming that the freezing rate of soil moisture in the TERM00041st layer is set to TERM00042,

In case of TERM00043 and TERM00044 (frozen)

    EQ=00020.

In case of TERM00045 and TERM00046 (melting)

    EQ=00021.

Update soil freezing moisture and soil temperature as follows.

    EQ=00026.
    EQ=00026.

### Ice sheet process.

If land cover type is ice-cover, return to TERM00048 when soil temperature exceeds TERM00047.

    EQ=00027.

The rate of change in the amount of ice cover, TERM00049, is diagnosed as

    EQ=00028.
 Translated with www.DeepL.com/Translator (free version)
