# Soil Submodel MATGND

Calculating soil temperature, soil moisture and frozen ground.

## Calculating heat transfer in soil.

### The Heat Transfer Equation in Soil

The prediction equation for soil temperature due to heat transfer in the soil is as follows.

$$
C_{g(k)} \frac{T_{g(k)}^* - T_{g(k)}^{\tau}}{\Delta t_L} = F_{g(k+1/2)} - F_{g(k-1/2)}
\qquad (k=1,\ldots,K_{g})
$$


$C_{g(k)}$ is the heat capacity of the soil and is defined by

$$
 C_{g(k)} = ( c_{g(k)} + \rho_w c_{pw} w_{(k)} ) \Delta z_{g(k)}
$$


$c_{g(k)}$ is the specific heat of the soil and is given as a parameter for each soil type. $c_{pw}$ is the specific heat of water and $w_{(k)}$ is the soil water content (volume moisture content). $\Delta z_{g(k)}$ is the thickness of the $k$ layer of soil. Thus, when the heat capacity of the soil is included in the heat capacity of the soil, the energy is not conserved unless the heat transport due to soil moisture transfer is taken into account. Since the heat transport associated with soil moisture transfer is not considered in MATGND, we are now discussing its introduction. However, it should be noted that the energy conservation is somehow broken unless the heat capacity of water vapor and precipitation in the atmosphere is taken into account.

The heat transfer flux $F_{g}$ is given by

$$
 F_{g(k+1/2)} =
\left\{
\begin{array}{ll}
F_{g(1/2)} - \Delta F_{conv}^* - \Delta F_{c,conv}^*
 (k=0)\\
\displaystyle{
k_{g(k+1/2)} \frac{T_{g(k+1)} - T_{g(k)}}{\Delta z_{g(k+1/2)}}
}
 (k=1,\ldots,K_{g}-1) \\
\displaystyle{
0
}
 (k=K_{g})
\end{array}
\right.
$$


where $k_{g(k+1/2)}$ is the thermal conductivity of the soil and is given as follows

$$
 k_{g(k+1/2)} = k_{g0(k+1/2)} [ 1 + f_{kg} \tanh( w_{(k)}/ w_{kg} ) ]
$$


$k_{g0(k+1/2)}$ is the thermal conductivity of the soil when the soil moisture content is $0$, and $f_{kg}=6$ and $w_{kg}=0.25$ are constants.

$\Delta z_{g(k+1/2)}$ is the thickness between the temperature definition point of the first $k$ layer and the soil temperature definition point of the $k+1$ layer (for $k=0$, it is the thickness between the temperature definition point of the first layer and the top of the soil, and for $k=K_g$, it is the thickness between the temperature definition point of the lowest layer and the bottom of the soil).

In (3), the boundary condition ($F_{g(1/2)}$) is obtained by adding the energy convergence at the bottom edge of the snowpack (including the heat flux at the bottom edge of the snowpack) and the assignment of the energy correction term to the snow-free surface due to the phase change of water content in the canopy. The fluxes are given. The fluxes are positive upward and are negative when adding the convergence amount. The boundary condition $F_{g(K_g+1/2)}$ at the lower edge of the soil is assumed to be zero flux.

### Solving the heat transfer equation.

These equations are solved in terms of soil temperature from the first to the lowest layer using the implicit method. In other words, for $k=1,\ldots,K_g-1$, the heat transfer fluxes are estimated by

$$
  F_{g(k+1/2)}^{*} = F_{g(k+1/2)}^{\tau}
+\frac{\partial {F}_{g(k+1/2)}}{\partial T_{g(k)}}
 \Delta T_{g(k)}
+\frac{\partial {F}_{g(k+1/2)}}{\partial T_{g(k+1)}}
 \Delta T_{g(k+1)}
$$


$$
  F_{g(k+1/2)}^{\tau} =
\frac{k_{g(k+1/2)}}{\Delta z_{g(k+1/2)}}(T_{g(k+1)}^{\tau} - T_{g(k)}^{\tau})
$$


$$
 \frac{\partial {F}_{g(k+1/2)}}{\partial T_{g(k)}} =
- \frac{k_{g(k+1/2)}}{\Delta z_{g(k+1/2)}}
$$


$$
 \frac{\partial {F}_{g(k+1/2)}}{\partial T_{g(k+1)}} =
\frac{k_{g(k+1/2)}}{\Delta z_{g(k+1/2)}}
$$


and then add (1) to

$$
C_{g(k)} \frac{\Delta T_{g(k)}}{\Delta t_L}
= F_{g(k+1/2)}^* - {F}_{g(k-1/2)}^*  \\
= {F}_{g(k+1/2)}^{\tau}
+\frac{\partial F_{g(k+1/2)}}{\partial T_{g(k)}}
 \Delta T_{g(k)}
+\frac{\partial F_{g(k+1/2)}}{\partial T_{g(k+1)}}
 \Delta T_{g(k+1)}  \\
- F_{g(k-1/2)}^{\tau}
-\frac{\partial F_{g(k-1/2)}}{\partial T_{g(k-1)}}
 \Delta T_{g(k-1)}
-\frac{\partial F_{g(k-1/2)}}{\partial T_{g(k-1)}}
 \Delta T_{g(k)}
$$




and solved by the LU decomposition method as a series of $K_{g}$ equations for $\Delta T_{g(k)}\ (k=1,\ldots,K_{g})$. Note that the fluxes at the top and bottom of the soil are fixed as boundary conditions.

$$
 T_{g(k)}^* = T_{g(k)}^{\tau} + \Delta T_{g(k)}
$$


 After correction for the phase change of soil moisture content, which will be described later, the soil temperature is completely updated.

## Calculation of soil moisture transfer

### Equation for Soil Moisture Transfer

The equation for soil moisture transfer (Richards' equation) is given by

$$
\rho_w \frac{w_{(k)}^{\tau+1} - w_{(k)}^{\tau}}{\Delta t_L} =
\frac{F_{w(k+1/2)} - F_{w(k-1/2)}}{\Delta z_{g(k)}} + S_{w(k)}
\qquad (k=1,\ldots,K_{g})
$$


Soil moisture flux $F_{w}$ is given by

$$
 F_{w(k+1/2)} =
\left\{
\begin{array}{ll}
Pr^{*** } - Et_{(1,1)}
 (k=0)\\
\displaystyle{
K_{(k+1/2)} \left(\frac{\psi_{(k+1)} - \psi_{(k)}}{\Delta z_{g(k+1/2)}} - 1 \right)
}
 (k=1,\ldots,K_{g}-1) \\
\displaystyle{
0
}
 (k=K_{g})
\end{array}
\right.
$$


where $K_{(k+1/2)}$ is the soil permeability coefficient based on Clapp and Hornberger (1978) and is given as follows

$$
 K_{(k+1/2)} = K_{s(k+1/2)} (\max(W_{(k)},W_{(k+1)}))^{2b(k)+3} f_i
$$


$K_{s(k+1/2)}$ is the saturated hydraulic conductivity and $b_{(k)}$ is the index of moisture potential curve as an external parameter for each soil type. $W_{(k)}$ is the saturation degree excluding freezing soil moisture and is given by

$$
 W_{(k)} = \frac{w_{(k)}-w_{i(k)}}{w_{sat(k)}-w_{i(k)}}
$$


$w_{sat(k)}$ is the porosity of soil, which is also given as a parameter for each soil type. $f_i$ is the parameter that indicates the suppression of soil moisture migration due to the presence of frozen soil, and is currently given as follows.

$$
 f_i = \left(1- W_{i(k)}\right)
       \left(1- W_{i(k+1)}\right)
$$


This parameter is $W_{i(k)} = w_{i(k)}/(w_{sat(k)}-w_{i(k)})$.

$\psi$ is the soil moisture potential given by Clapp and Hornberger as follows

$$
 \psi_{(k)} = \psi_{s(k)} W_{(k)}^{-b(k)}
$$


$\psi_{s(k)}$ is given as an external parameter for each soil type.

In (11), $S_{w(k)}$ is the source term and, considering the absorption and runoff by roots, is given by

$$
 S_{w(k)} = - F_{root(k)} - Ro_{(k)}
$$


In (12), the boundary condition $F_{w(1/2)}$ is the difference between the water flux ($P^{*** }$) and the evaporation flux ($Et_{(1,1)}$) at the top of the soil through the runoff process. Apart from this, the sublimation flux is subtracted from the frozen soil moisture in the first layer prior to the calculation of soil moisture transfer.

$$
 w_{i(k)}^{\tau} = w_{i(k)}^{\tau} - Et_{(2,1)} \Delta t_L /(\rho \Delta z_{g(1)})\\
 w_{(k)}^{\tau} = w_{(k)}^{\tau} - Et_{(2,1)} \Delta t_L /(\rho \Delta z_{g(1)})
$$



### Solving the soil moisture transfer equation

These equations are solved from the first to the lowest layer using the implicit method. In other words, for $k=1,\ldots,K_g-1$, the soil moisture fluxes are estimated by

$$
  F_{w(k+1/2)}^{\tau+1} = F_{w(k+1/2)}^{\tau}
+\frac{\partial {F}_{w(k+1/2)}}{\partial w_{(k)}}
 \Delta w_{(k)}
+\frac{\partial {F}_{w(k+1/2)}}{\partial w_{(k+1)}}
 \Delta w_{(k+1)}
$$


$$
  F_{w(k+1/2)}^{\tau} =
K_{(k+1/2)} \left(\frac{\psi_{(k+1)}^{\tau} - \psi_{(k)}^{\tau}}{\Delta z_{g(k+1/2)}} - 1 \right)
$$


$$
 \frac{\partial {F}_{w(k+1/2)}}{\partial w_{(k)}} =
- \frac{K_{(k+1/2)}}{\Delta z_{g(k+1/2)}}
\left[
-b_{(k)} \frac{\psi_{s(k)}}{w_{sat(k)}-w_{i(k)}}W_{(k)}^{-b(k)-1}
\right]
$$


$$
 \frac{\partial {F}_{w(k+1/2)}}{\partial w_{(k+1)}} =
 \frac{K_{(k+1/2)}}{\Delta z_{g(k+1/2)}}
\left[
-b_{(k)} \frac{\psi_{s(k+1)}}{w_{sat(k+1)}-w_{i(k+1)}}W_{(k+1)}^{-b(k)-1}
\right]
$$


and (11) as

$$
\rho_w \Delta z_{g(k)} \frac{\Delta w_{(k)}}{\Delta t_L}
= F_{w(k+1/2)}^{\tau+1} - {F}_{w(k-1/2)}^{\tau+1} + S_{w(k)} \Delta z_{g(k)}  \\
= {F}_{w(k+1/2)}^{\tau}
+\frac{\partial F_{w(k+1/2)}}{\partial w_{(k)}}
 \Delta w_{(k)}
+\frac{\partial F_{w(k+1/2)}}{\partial w_{(k+1)}}
 \Delta w_{(k+1)}  \\
- F_{w(k-1/2)}^{\tau}
-\frac{\partial F_{w(k-1/2)}}{\partial w_{(k-1)}}
 \Delta w_{(k-1)}
-\frac{\partial F_{w(k-1/2)}}{\partial w_{(k-1)}}
 \Delta w_{(k)} + S_{w(k)} \Delta z_{g(k)}
$$




The equations are treated as follows for $\Delta T_{g(k)}\ (k=1,\ldots,K_{g})$, and are solved by the LU decomposition method as a series of $K_{g}$ equations for $\Delta T_{g(k)}\ (k=1,\ldots,K_{g})$. Note that the fluxes at the top and bottom of the soil are fixed as boundary conditions.

$$
 w_{(k)}^{\tau+1} = w_{(k)}^{\tau} + \Delta w_{(k)}
$$

The soil moisture content is updated using the LU decomposition method.

If this calculation results in supersaturation of soil moisture, the supersaturation is removed by vertical adjustment. The supersaturation is not considered as runoff because this supersaturation is artificial and is caused by the solution of the vertical soil moisture transfer without information about the saturation. First, supersaturated soil moisture is applied from the second soil layer downward. Then, from the lowermost layer of soil to the uppermost layer, the supersaturated soil moisture is added to the uppermost layer. This operation results in the formation of a saturated layer near the bottom of the soil when soil moisture is sufficiently high to define the groundwater level (with a certain amount of water content of the ground surface in the vicinity of the lowest layer of soil (with a certain amount of water content of the ground surface in the vicinity of the lowest level of soil).

## Phase changes in soil moisture.

As a result of the heat conduction in the soil, the phase change of soil moisture content is calculated when the temperature of the layer with liquid moisture is below $T_{melt} =
0^{\circ}$ C or when the temperature of the layer with solid moisture is above $T_{melt}$. Assuming that the freezing rate of soil moisture in the $k$st layer is set to $\Delta w_{i(k)}$,

In case of $T_{g(k)}^*<T_{melt}$ and $w_{(k)}^{\tau+1}-w_{i(k)}^{\tau}>0$ (frozen)

$$
\Delta w_{i(k)} = \min\left(
\frac{C_{g(k)}(T_{melt}-T_{g(k)}^*)}{l_m \rho_w \Delta z_{g(k)}}, \
w_{(k)}^{\tau+1}-w_{i(k)}^{\tau}
\right)
$$


In case of $T_{g(k)}^*>T_{melt}$ and $w_{i(k)}^{\tau}>0$ (melting)

$$
\Delta w_{i(k)} = \max\left(
\frac{C_{g(k)}(T_{melt}-T_{g(k)}^*)}{l_m \rho_w \Delta z_{g(k)}}, \
-w_{i(k)}^{\tau}
\right)
$$


Update soil freezing moisture and soil temperature as follows.

$$
w_{i(k)}^{\tau+1} = w_{i(k)}^{\tau} + \Delta w_{i(k)} \\
T_{g(k)}^{\tau+1} = T_{g(k)}^* + l_m \rho_w \Delta z_{g(k)} \Delta w_{i(k)} / C_{g(k)}
$$



### Ice sheet process.

If land cover type is ice-cover, return to $T_{melt}$ when soil temperature exceeds $T_{melt}$.

$$
 T_{g(k)}^{\tau+1} = \min( T_{g(k)}^*, \ T_{melt} )
$$


The rate of change in the amount of ice cover, $F_{ice}$, is diagnosed as

$$
 F_{ice} = - Et_{(2,1)} - \frac{C_{g(k)}\max(T_{g(k)}^* - T_{melt},\ 0)}{l_m \Delta t_L}
$$
