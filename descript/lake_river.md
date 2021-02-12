## 11.5 lake river coupling

The inflow rate from the river to the lake, $R_{in}$ $[cm/s]$, is calculated as follws.

$$
	R_{in} = H_{riv} / (\tau_{riv} * 86400)
$$

where $H_{riv}$ $[cm]$ is grid average river water depth, $\tau_{riv}$ is a time constant, and 86400 is a unit conversion coefficient. $\tau_{riv}$ is set to 1 day by default. $H_{riv}$ is derived the following equation.

$$
	H_{riv} = w_{riv} / \rho_w * 100
$$

where $w_{riv}$ is the river water volume $[kg/m^2]$, $\rho_w$ is the density of water, and 100 is the coefficient for unit conversion.

When water depth $H [cm]$ of a lake becomes deeper than the upper limit $H_{max}$, water flows into a river. The outflow rate to the river, $R_{out} [cm/s]$, is diagnosed as follows.

$$
	R_{out} = (H - H_{max}) / ( \tau_{lake} * 86400 )
$$

The $H_{max} [cm]$ is, by default, the climatology of lake depth + 10 m. $\tau_{lake}$ is a time constant, which is also set to 1 day.

Finally, $R_{out}$ is added to runoff from land and given to the river.
