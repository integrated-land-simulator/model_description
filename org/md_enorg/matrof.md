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

    EQ=00000.

TERM00000 is the saturated hydraulic conductivity of soil at the depth TERM00001, TERM00002 is the saturated hydraulic conductivity at the ground surface, and TERM00003 is the attenuation coefficient.

If the depth of the groundwater surface at a certain point (TERM00004) is defined as TERM00005, then the groundwater flux down slope at that point (TERM00006) is expressed as

    EQ=00001.

TERM00007 is the slope slope slope, using assumption 2. Although TERM00008 is the depth of the impermeable surface, the term TERM00009 is usually assumed to be deeper than that of TERM00010, and the term TERM00011 is omitted. The slope directional soil water flux in the unsaturated zone above the groundwater surface is neglected because it is small.

Assuming that the groundwater recharge rate is uniformly set to the TERM00012, Assumption 3 can be expressed as follows

    EQ=00002.

Here, TERM00013 is the total upstream area (per unit contour length at the point TERM00015) relative to the point TERM00014.

Solving this for TERM00016 yields the following.

    EQ=00003.

The average groundwater depth in the region (TERM00017) is the depth of the groundwater table (TERM00018),

    EQ=00004.

    EQ=00005.

Thus, the recharge rate (TERM00019) as a function of mean groundwater depth (TERM00020) is expressed as

    EQ=00006.

According to Assumption 3, this is the amount of groundwater discharged from the area (TERM00021).

Substituting TERM00022 into (4) gives the following relationship between TERM00023 and TERM00024.

    EQ=00007.

The region satisfying the TERM00025 is the surface saturation region.

## Application of TOPMODEL under the assumption of simplified terrain

When TOPMODEL is used, detailed topographical data of the target area are usually required, but here we estimate roughly the average shape of the slopes in the grid based on the data of average slope and standard deviation of the elevation of the grid (this method is currently provisional and requires further study).

The topography of the grid is represented by the slope of TERM00026 with a uniform slope of TERM00026 and the distance from the ridge to the valley of TERM00027.

TERM00028 is estimated using the standard deviation of elevation (TERM00029) as follows.

    EQ=00008.

TERM00030 is the difference between the elevation of the ridge and the valley in the serrated terrain with the standard deviation of the elevation of the TERM00031.

Taking the TERM00032 axis from the ridge to the valley on the horizontal plane. Since the total upstream area of the curve at the TERM00033 is TERM00034, (4) becomes the following.

    EQ=00009.

Based on this, the mean groundwater surface is calculated from (5) as

    EQ=00010.

Groundwater recharge rate is from (7)

    EQ=00011.

The relationship between groundwater level and mean groundwater level in TERM00035 is from (8)

    EQ=00012.

The result is Solving for TERM00036 with respect to TERM00037 yields the following.

    EQ=00013.

    EQ=00014.

Therefore, the area factor of the saturation region is

    EQ=00015.

In the case of TERM00038 and TERM00039, the saturation region does not exist. However, for the TERM00038 and TERM00039, there is no saturation region.

## Calculation of flow rate

Four discharge mechanisms are considered and the total amount of discharge by each mechanism is defined as the total amount of discharge from the grid.

    EQ=00016.

TERM00040 is a saturation excess runoff (Dunne runoff), TERM00041 is an infiltration excess runoff (Horton runoff), TERM00042 is an overflow of the first layer of soil, and the above is the total amount of runoff from the grid by each mechanism. Classified. TERM00043 is a groundwater runoff .

### Estimates of Mean Groundwater Depth.

Assuming that soil moisture content starts from the lowest layer of soil and that the layer that becomes unsaturated for the first time is the TERM00044th layer, the average depth of the groundwater table (TERM00045) is estimated as follows

    EQ=00017.

This corresponds to the assumption that the moisture potential at the top of the unsaturated layer is set to TERM00046, under which the distribution of soil moisture is considered to be in equilibrium (i.e., the equilibrium condition between gravity and capillary force).

If the TERM00047 is the lowest level, no groundwater surface is assumed to exist in the TERM00048 region. If the TERM00049 is not the bottom layer, the uppermost layer of the saturated groundwater layer (the uppermost layer) is assumed to be the TERM00050 and the above equation is applied to the lower layer.

In the case where the frozen ground surface exists in the middle of the soil, the depth of the groundwater surface is estimated above the frozen ground surface.

### Calculation of Groundwater Runoff

Since the groundwater discharge is equal to the recharge rate of (12) under quasi-steady assumptions, we can assume that the groundwater recharge rate is the same as that of (12),

    EQ=00018.

(1). However, in the case of a frozen surface under the ground surface, see the case where the term TERM00051 in (2) is not omitted,

    EQ=00019.

The depth of the frozen ground surface is defined as TERM00052 is the depth of the frozen ground. In this case, the other formulas of the TOPMODEL system should be different, but we do not change them for the sake of simplicity.

If there is an antifreeze layer beneath the frozen ground surface and a groundwater surface exists there, the runoff of groundwater is calculated and added in the same way.

The groundwater runoff is later removed from the TERM00053 layer.

    EQ=00020.

TERM00054 represents the runoff flux from the soil in the TERM00055th layer.

### Calculation of Surface Runoff.

All precipitation that falls in the saturated area of the earth's surface will runoff intact (saturation excess runoff).

    EQ=00021.

The area fraction of saturated area TERM00056 is given by (16). Here, the correlation between precipitation distribution on the subgrid and the topography is ignored.

The precipitation that falls in the unsaturated area is infiltrated excess runoff (infiltration excess runoff). The soil infiltration capacity is given in terms of the saturated hydraulic conductivity of the first layer of soil for simplicity. Convective precipitation is assumed to be localized, and the area fraction of the precipitation area (TERM00057) is assumed to be uniform (the standard value is 0.1). Stratified precipitation is assumed to be uniform.

    EQ=00026.
    EQ=00026.

    EQ=00022.

TERM00058 and TERM00059 are TERM00060 for convective and non-convective precipitation areas, respectively, and TERM00061 is the saturated hydraulic conductivity of the first soil layer.

The overflow of the first layer of soil allows for a small amount of waterlogging TERM00062 (1 mm by default),

    EQ=00023.

This amount will be subtracted from the first layer of soil later. This amount will later be subtracted from the first layer of soil, and is therefore included in the runoff from the first layer.

    EQ=00024.

## Water flux to the soil

The water fluxes fed to the soil through the runoff process are as follows.

    EQ=00025.
 Translated with www.DeepL.com/Translator (free version)
