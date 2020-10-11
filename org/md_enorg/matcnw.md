# Canopy Water Balance Submodel MATCNW

Calculating the water balance of the upper canopy water component .

## Diagnosis of the phases of the canopy upper water portion.

Moisture in the canopy is considered separately as liquid (interrupted precipitation, condensation, or solid moisture that has melted) and solid (interrupted snow, ice, or liquid moisture that has frozen) and allows for a mixture of them. The predictor is only the amount of moisture (TERM00000) of the liquid and solid combined, and depending on whether the canopy temperature (TERM00001) is higher or lower than TERM00002 C, the case is diagnosed as either liquid or solid, respectively. The reason why liquid and solid can coexist is that the TERM00003 of snow covered areas and snow-free areas are calculated separately. That is, the freezing area fraction (TERM00004) of water on the canopy is defined as follows (in reality, the averaged result by the coupler is as follows),

    EQ=00000.

    EQ=00003.
    EQ=00003.

The following table shows the values for each of the two types of moisture in the canopy. TERM00005 and TERM00006 are the liquid and solid moisture on the canopy respectively.

TERM00007 is given by the coupler as the updated value TERM00008 in the flux calculation section, but the value of the previous step, TERM00009, should be stored in the MATCNW. TERM00010 represents a time step. This will not become a new predictor since it is obtained at the start of the calculation from the initial values of TERM00011 and TERM00012.

## Forecast for water content in the canopy

The predictive equations for water content in the canopy are given below for the liquid and the solid, respectively.

    EQ=00004.
    EQ=00004.

TERM00013 and TERM00014 are the precipitation cutoff values for a liquid and a solid, respectively, TERM00015 and TERM00016 are the evaporation (sublimation) value, TERM00017, TERM00018 is the drop value, and TERM00019 is the melting value. Note that the former values of TERM00020 and TERM00021 are defined by the following using the former TERM00022.

    EQ=00005.
    EQ=00005.

### Evaporation (sublimation) of water on the canopy.

First, the evaporation (sublimation) rate is subtracted and the water content in the canopy is partially updated. The amount of evaporation (sublimation) is determined in the flux calculation section.

    EQ=00006.
    EQ=00006.

    EQ=00007.
    EQ=00007.

If one of the TERM00023 or TERM00024 becomes negative at this time, the other is compensated until the value returns to zero, and the amount of thawing that occurs in this case (or a negative value in the case of freezing) is set in TERM00025.

### Interruption of precipitation by canopy

Precipitation interception and dripping are considered separately for convective and non-convective precipitation areas. The area fraction of convective precipitation area (TERM00026) is assumed to be uniform (with the standard value of 0.1). It is assumed that stratified precipitation is uniform.

    EQ=00008.
    EQ=00008.
    EQ=00008.
    EQ=00008.

TERM00027 and TERM00028 are cutoffs for convective precipitation areas and TERM00029 and TERM00030 are cutoffs for non-convective areas. TERM00031 is the cutoff efficiency, easy

    EQ=00001.

This is given by

The water content on the canopy is further partially updated by adding the intercepted precipitation rate.

    EQ=00009.
    EQ=00009.
    EQ=00009.
    EQ=00009.

### Dropping water into the canopy.

The drop rate is based on both natural drops due to gravity and water overflow in the canopy.

    EQ=00010.
    EQ=00010.
    EQ=00010.
    EQ=00010.

Moisture volume in the canopy (TERM00032) is derived from the moisture volume per unit leaf area (TERM00033) and the LAI,

    EQ=00011.

The standard value of TERM00034 is 0.2 mm and the same for liquids and solids. The standard value of TERM00034 is 0.2mm and the same value is used for liquids and solids.

Gravity-induced spontaneous dropping TERM00035 follows Rutter et al,

    EQ=00012.

The following values are assumed to be the same for both liquids and solids. The standard value is TERM00036=1.14 TERM00037 10 TERM00038, TERM00039=3.7 TERM00040 10 TERM00041 and the same value is used for liquid and solid.

The values are updated by subtracting the drop volume.

    EQ=00013.
    EQ=00013.
    EQ=00013.
    EQ=00013.

### Updating and melting the water content in the canopy.

Furthermore, averaging the convective and non-convective precipitation areas gives the updated water content in the canopy.

    EQ=00014.
    EQ=00014.
    EQ=00014.

However, if we consider the updated freezing area fraction (TERM00042), we can conclude that

    EQ=00015.
    EQ=00015.

Therefore, the melting value TERM00043 is diagnosed as follows.

    EQ=00016.

However, the amount resulting from the evaporation process, if any, is added.

Here, the temperature of the canopy should be changed by the latent heat of melting, but this is not possible because the heat capacity of the canopy is ignored. The temperature of the surrounding atmosphere should be changed, but this is not possible if we wish to close the system with the land surface integrator. To conserve energy in the system, the latent heat of melting is provided as a heat flux to the soil (or to the snowpack).

## Fluxes given to the soil, snowpack, and runoff processes

The water flux TERM00044, which is fed to the snowpack or runoff process via canopy interception, is applied to convective and non-convective precipitation areas, and to liquids and solids, respectively,

    EQ=00017.
    EQ=00017.
    EQ=00017.
    EQ=00017.

Convective and stratified precipitation are given separately for use in runoff calculations; for snowfall, they are given together as they are not necessary.

    EQ=00018.
    EQ=00018.
    EQ=00018.

TERM00045, TERM00046, and TERM00047 are the amount of convective precipitation, stratified precipitation, and snowfall after interception by a canopy, respectively.

The energy flux corrections to the soil or snow cover are the same as those in the above cases,

    EQ=00002.

is the latent heat of melting. TERM00048 is the latent heat of melting. 
