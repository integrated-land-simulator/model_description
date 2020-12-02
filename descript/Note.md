# AR4 matrof.F (MATSIRO runoff submodel)
## 9.3 Calculation of runoff
$$
R_O=R_{O_s}+R_{O_i}+R_{O_o}+R_{O_b}
$$
definitions of the 4 types of runoff can be found in L52-55. The calculation of baseflow $R_{O_b}$ is illustrated in L135-156 and L174-193, and the calculation of surface flow including $R_{O_o}$ (L198-204, surface storage overflow), $R_{O_s}$ (L205-207, saturation excess runoff) and $R_{O_i}$ (L208-214, infiltration excess runoff) is illustrated in L195-215, and the equation for $R_O$  is expressed in L227-228.
### 9.3.1 Estimation of mean water table depth
$$
 \overline{z} = z_{g(k_{WT}-1/2)} - \psi_{k_{WT}}
$$
### 9.3.2 Calculation of groundwater runoff

# AR6 matrof.F (MATSIRO runoff submodel)
## 9.3
$$
R_O=R_{O_s}+R_{O_i}+R_{O_o}+R_{O_b}
$$
Or 
$$
R_O=(R_{O_s}+R_{O_i}+R_{O_o})\times?+R_{O_b}
$$
definitions of the 4 types of runoff can be found in L69-72. The calculation of baseflow $R_{O_b}$ is illustrated in L171-192 and L217-236, and the calculation of surface flow including $R_{O_o}$ (L249-255, surface storage overflow), $R_{O_s}$ (L256-258, saturation excess runoff) and $R_{O_i}$ (L259-266, infiltration excess runoff) is illustrated in L246-266, and the equation for $R_O$ is expressed in L279-298.
### 9.3.1 Estimation of mean water table depth
$$
 \overline{z} = z_{g(k_{WT}-1/2)} - \psi_{k_{WT}}
$$
### 9.3.2 Calculation of groundwater runoff
