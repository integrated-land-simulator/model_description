<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

Modified

| Variable | Description | Unit | Name in code
|:---------|:------------|:------|:--------
| $Sn$                        | Amount of snowfall                     | $\mathrm{kg/m^2}$   | GLSNW
| $T\_{Sn(k)} \;\; (k=1,2,3)$ | Snow temperature of the $k$th layer    | $\mathrm{K}$        | GLTSN
| $\alpha\_b  \;\; (b=1,2,3)$ | Snow albedo for band $b$               | -                   | GLASN
| $A\_{Sn}$                   | Snow fraction                          | -                   | GLRSN
| -                           | Snow accumulation                      | $\mathrm{kg/m^2}$   | GLSDA
| $M\_{Sn}$                   | Accumulation of the snow melt          | $\mathrm{kg/m^2}$   | GLSDM
| -                           | Reset flag                             | -                   | SNRESET
| $P\_{r\_c}$                 | Convective precipitation flux          | $\mathrm{kg/m^2/s}$ | WINPC
| $P\_{r\_l}$                 | Layered precipitation flux             | $\mathrm{kg/m^2/s}$ | WINPL
| -                           | Flux balance (for budget check)        | $\mathrm{W/m^2}$    | SFLXBL
| -                           | Canopy flux balance (for budget check) | $\mathrm{W/m^2}$    | CFLXBL
| $\rho\_{(k)}$               | Dust density in the $k$th layer        | $\mathrm{ppmv}$     | CDST
| -                           | Dust density in the $k$th layer        | $\mathrm{kg/m^2}$   | CDSTM
| -                           | Index for $CV$                         | -                   | GRSNDX

Output
| Variable | Description | Unit | Name in code
|:---------|:------------|:------|:--------
| $Ro\_{gl}$ | Glacier formation | $\mathrm{kg/m^2/s} | GGLACR

Input 
| Variable | Description | Unit | Name in code
|:---------|:------------|:------|:--------
| $P\_{Sn}$      | Snow fall                           | $\mathrm{kg/m^2/s}$   | SNFAL
| $E\_{Sn}$      | Snow sublimation                    | $\mathrm{kg/m^2/s}$   | SNSUB
| $F\_{Sn(1/2)}$ | Snow surface heat flux              | $\mathrm{W/m^2}$      | SNFLXS
| $T\_{g(k)}$    | Soil temperature of the $k$th layer | $\mathrm{T}$          | GLG
| $w\_{g(k)}$    | Soil moisture                       | $\mathrm{m^3/m^3}$    | GLW
| $w\_c$         | Canopy water                        | $\mathrm{m}$          | GLWC
| $A\_{Snc}$     | Canopy snow ratio                   | -                     | SNRATC
| $D$            | Dust fall                           | $\mathrm{ppmv/s}$     | DSTFAL
| -              | Dust fall                           | $\mathrm{kg/m^2/s}$   | DSTFLM
| -              | Standard deviation of topography    | -                     | GRZSD
| -              | Annual mean temperature over the latest 30 years | $\mathrm{K}$ | T2HIST
| -              | Index of the surface condition      | -                     | ILSFC
| -              | Soil type                           | -                     | ILSOIL

