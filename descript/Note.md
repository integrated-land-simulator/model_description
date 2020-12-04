# AR4 matrof.F (MATSIRO runoff submodel)
## 9.3 Calculation of runoff
$$
R_O=R_{O_s}+R_{O_i}+R_{O_o}+R_{O_b}
\tag{L227-228}
$$
definitions of the 4 types of runoff can be found in L52-55. The calculation of baseflow $R_{O_b}$ is illustrated in L135-156 and L178-193, and the calculation of surface flow including $R_{O_o}$ (L198-204, surface storage overflow), $R_{O_s}$ (L205-207, saturation excess runoff) and $R_{O_i}$ (L208-214, infiltration excess runoff) is illustrated in L195-215.
### 9.3.1 Estimation of mean water table depth (For future plan I suggest using figure to illustrate the condition)
$$
 \overline{z} = z_{g(k_{WT}-1/2)} - \psi_{k_{WT}} 
 \tag{L161-167}
$$
the mositure(matric) potential $\psi$ is defined in L58, the uppermost half-saturated (or staturated?) layer $k_{WT}$ is difined in L65, the mean water table depth $\overline{z}$ is defined in L165.
### 9.3.2 Calculation of groundwater runoff
$$
Ro_b = \frac{K_0 \tan\beta_s}{f L_s}\exp(1-f \overline{z}) 
 \tag{L139-142 & L181-184}
$$
$$
 Ro_b = \frac{K_0 \tan\beta_s}{f L_s}
  [ \exp(1-f \overline{z}) - \exp(1-f z_f) ] 
  \tag{L143-147 & L185-189}
$$
$$
 Ro_{(k_{WT})} = Ro_b
  \tag{L148-149 & L190-191}
$$
the saturated hydraulic conductivity $K_0$ is defined in L57, the tangent value of mean surface slope $\tan\beta_s$ is defined in L69, the mean length of surface slope $L_s$ is defined in L70, the critical water table depth $\frac{1}{f}$ is defined in L73 ($f$ is the attenuation coefficient), the depth of the frozen soil surface $z_f$ is defined in L146, $Ro_{(k_{WT})}$ denotes the runoff flux from the $k_{WT}$th soil layer and is defined in L28
### 9.3.3 Calculation of surface runoff
$$ 
Ro_s = (Pr_c + Pr_l) A_{sat} 
\tag{L206-207}
$$
the convective rain fall $Pr_c$ is defined in L32, the nonconvective precipitation $Pr_l$ in defined in L33, the fraction of the surface saturated area $A_{sat}$ is defined in L61.
$$
Ro_i^c = \max( Pr_c/A_c + Pr_l - K_{s(1)}, 0 ) (1 - A_{sat})
\tag{L209-210}
$$
$$
Ro_i^{nc} = \max( Pr_l - K_{s(1)}, 0 ) (1 - A_{sat})
\tag{L211}
$$
$$
Ro_i = A_c Ro_i^c + ( 1 - A_c ) Ro_i^{nc}
\tag{L212-214}
$$
the convective precipitation area $Ro_i^c$ is defined in L66, the nonconvective precipitation area $Ro_i^{nc}$ is defined in L66, the fraction of the precipitation area $A_c$ is defined in L77 (assumed to be uniform take 0.1 as standard value), the saturation hydraulic conductivity in the uppermost soil layer $K_{s(1)}$ is defined in L57.
$$
Ro_o = \max(w_{(1)} - w_{sat(1)} - w_{str}, 0) \rho_w \Delta z_{g(1)} / \Delta t_L
\tag{L204}
$$
soil moisture in uppermost layer $w_{(1)}$ is defined in L35, saturation soil moisture in uppermost layer $w_{sat(1)}$ is defined in L56, the small amount of ponding $w_{str}$ is defined in L200, $\rho_w$ is defined in L199 (physical meaning is unknown), land thickness $\Delta z_{g(1)}$ is defined in L1235 in another file matdrv.F, time step $\Delta t_L$ is defined in L38
$$
Ro_{(1)} = Ro_{(1)} + Ro_o
$$
the function somehow doesn't appear in the code file.

# AR6 matrof.F (MATSIRO runoff submodel)
## 9.3 Calculation of runoff
$$
R_O=R_{O_s}+R_{O_i}+R_{O_o}+R_{O_b}
\tag{L289-290 & L293-294 & L297-298}
$$
Or 
$$
R_O=(R_{O_s}+R_{O_i}+R_{O_o})\times?+R_{O_b}
\tag{L281-283}
$$
definitions of the 4 types of runoff can be found in L69-72. The calculation of baseflow $R_{O_b}$ is illustrated in L171-192 and L221-236, and the calculation of surface flow including $R_{O_o}$ (L249-255, surface storage overflow), $R_{O_s}$ (L256-258, saturation excess runoff) and $R_{O_i}$ (L259-266, infiltration excess runoff) is illustrated in L246-266.
### 9.3.1 Estimation of mean water table depth
$$
 \overline{z} = z_{g(k_{WT}-1/2)} - \psi_{k_{WT}}
 \tag{L197-206}
$$
the mositure(matric) potential $\psi$ is defined in L77, the uppermost half-saturated layer $k_{WT}$ is difined in L84, the mean water table depth $\overline{z}$ is calculated through above equation in L201
### 9.3.2 Calculation of groundwater runoff
$$
Ro_b = \frac{K_0 \tan\beta_s}{f L_s}\exp(1-f \overline{z}) 
 \tag{L175-178 & L224-227}
$$
$$
 Ro_b = \frac{K_0 \tan\beta_s}{f L_s}
  [ \exp(1-f \overline{z}) - \exp(1-f z_f) ] 
  \tag{L179-183 & L228-232}
$$
$$
 Ro_{(k_{WT})} = Ro_b
  \tag{L184-185 & L233-234}
$$
the saturated hydraulic conductivity $K_0$ is defined in L76, the tangent value of mean surface slope $\tan\beta_s$ is defined in L89, the mean length of surface slope $L_s$ is defined in L90, the critical water table depth $\frac{1}{f}$ is defined in L98 ($f$ is the attenuation coefficient), the depth of the frozen soil surface $z_f$ is defined in L182, $Ro_{(k_{WT})}$ denotes the runoff flux from the $k_{WT}$th soil layer and is defined in L40
### 9.3.3 Calculation of surface runoff
$$ 
Ro_s = (Pr_c + Pr_l) A_{sat} 
\tag{L257-258}
$$
the convective rain fall $Pr_c$ is defined in L44, the nonconvective precipitation $Pr_l$ in defined in L45, the fraction of the surface saturated area $A_{sat}$ is defined in L80.
$$
Ro_i^c = \max( Pr_c/A_c + Pr_l - K_{s(1)}, 0 ) (1 - A_{sat})
\tag{L260-261}
$$
$$
Ro_i^{nc} = \max( Pr_l - K_{s(1)}, 0 ) (1 - A_{sat})
\tag{L262}
$$
$$
Ro_i = A_c Ro_i^c + ( 1 - A_c ) Ro_i^{nc}
\tag{L263-265}
$$
the convective precipitation area $Ro_i^c$ is defined in L85, the nonconvective precipitation area $Ro_i^{nc}$ is defined in L85, the fraction of the precipitation area $A_c$ is defined in L102 (assumed to be uniform take 0.1 as standard value), the saturation hydraulic conductivity in the uppermost soil layer $K_{s(1)}$ is defined in L75.
$$
Ro_o = \max(w_{(1)} - w_{sat(1)} - w_{str}, 0) \rho_w \Delta z_{g(1)} / \Delta t_L
\tag{L255}
$$
soil moisture in uppermost layer $w_{(1)}$ is defined in L50, saturation soil moisture in uppermost layer $w_{sat(1)}$ is defined in L74, the small amount of ponding $w_{str}$ is defined in L251, $\rho_w$ is defined in L250 (physical meaning is unknown), land thickness $\Delta z_{g(1)}$ is defined in L3177 in another file matdrv.F, time step $\Delta t_L$ is defined in L53
$$
Ro_{(1)} = Ro_{(1)} + Ro_o
$$
the function somehow doesn't appear in the code file.
