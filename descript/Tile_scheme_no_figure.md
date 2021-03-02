# Tile scheme

In the latest version of MATSIRO, a tile treatment of the land surface has been introduced to represent the subgrid fraction of land surface types, so as to partially mimic the behavior at a higher resolution. 

Basically, one land surface grid is divided into three tiles in the control run: lake, potential vegetation and cropland. All the prognostic and diagnostic variables are calculated in each tile, and the fluxes at the land surface $F$ are averaged:
$$
F=F_{lake}f_{lake}+\sum_{i=1}^nF_if_i(1-f_{lake})
$$

$$
\sum_{i=1}^nf_i=1
$$
where n is 2, $F_{lake}$, $F_1$ and $F_2$ denote fluxes at the land surface of lake, potential vegetation and cropland, $f_{lake}$, $f_1$ and $f_2$ denote their corresponding fractional weights, respectively.

By default, tile scheme is applied in land surface type, but it can be used for multiple purposes.

## Lake

The surface heat and water fluxes over lakes have been calculated as one of the tiles in a grid. The water temperature and mass are predicted for the surface layer (minimum thickness of 1 m) and four subsurface layers, based on the thermal diffusion and mass conversion, considering vertical overturning, evaporation, precipitation, and in-flow from and outflow to rivers. 

## Potential Vegetation and Cropland

Both potential vegetation and cropland tiles consist of six soil layers, up to three snow layers, and a single canopy layer, driving predictions of the temperature and amount of water in the canopy, soil, and snow. 

Potential vegetation is defined according to the vegetation types of the Simple Biosphere Model 2 (SiB2; Sellers et al. 1996) scheme and has 10 categories including land ice. There is no wetland category for land cover in the original SiB2 vegetation types or soil types. 

# Reference

  -
    Sellers, P. J., Meeson, B. W., Closs, J., Collatz, J., Corprew, F., Dazlich, D., Hall, F. G., Kerr, Y., Koster, R., Los, S., Mitchell, K., McManus, J., Myers, D., Sun, K.-J, and Try, P.: The ISLSCP Initiative I global datasets: surface boundary conditions and atmospheric forcings for land-atmosphere studies, B. Am. Meteorol. Soc., <span>**77**</span>, 1987–2006, 1996.