
## 11.4 Physical formulation & processes `[LAKEPO]`

`lakepo.F`
<!---
Dimensions of the lake scheme is defined in `include/zkg21c.F`. `KLMAX` is the number of vertical layers set to 5 in MIROC6/MATSIRO6. `NLTDIM` is the number of tracers, 1:temperature 2:salt. Since the vertical layers are actually from `KLSTR=2` to `KLEND=KLMAX+1`, `NLZDIM = KLMAX+KLSTR` exists as a parameter for management.
--->

### 11.4.1 Diffusion tracer flux `[VDIFFL]`

- Inputs

Though several valuables are written, they are not used here.


- Outputs

| Meaning                        | Presentation | Variable | dimension      | unit |
|:-------------------------------|:-------------|:---------|:---------------|:-----|
| vertical diffusion coefficient | $K_V$        | AHV      | IJLDIM, NLZDIM | --   |

- Parameters

| Meaning                                             | Presentation | Variable        | unit | value         |
|:----------------------------------------------------|:-------------|:----------------|:-----|:--------------|
| vertical diffusion coefficient at the surface layer | $K_{V0}$     | AHVL0(NZ=KLMAX) | --   | $k\times 1.0$ |


The case considered in COCO4 is that( [Hasumi, 2015, Section 1.2](https://ccsr.aori.u-tokyo.ac.jp/~hasumi/COCO/coco4.pdf)):
1. Diffusive flux of tracer follows the Fick's law.
2. Diffusuion coefficient tensor is diagonal, and its horizontal component is identical.

Here, the vertical diffusion coefficent $K_V$ is simply set as

$$
	K_V(k) = K_{V0} k
$$

### 11.4.2 Estimate the advection and diffusion terms of the tracer equations `[FLXTRCL]`

- Inputs

| Meaning                        | Presentation | Variable | dimension              | unit |
|:-------------------------------|:-------------|:---------|:-----------------------|:-----|
| vertical diffusion coefficient | $K_V$        | AHV      | IJLDIM, NLZDIM         | --   |
| water temperature              | $T$          | TX       | IJLDIM, NLZDIM, NLTDIM | --   |
| water depth                    | $h$          | HX       | IJLDIM                 | --   |

- Outputs

| Meaning                                     | Presentation                   | Variable | dimension              | unit |
|:--------------------------------------------|:-------------------------------|:---------|:-----------------------|:-----|
| vertical component of diffusive tracer flux | $F_D$                          | ADT      | IJLDIM, NLZDIM, NLTDIM | --   |
|                                             | $\frac{F_D}{D(k-\frac{1}{2})}$ | DIFFZ    | IJLDIM, NLZDIM         | --   |

- Internal variables

| Meaning | Presentation | Variable | dimension              | unit |
|:--------|:-------------|:---------|:-----------------------|:-----|
| --      | --           | TH       | IJLDIM, NLZDIM, NLTDIM | --   |
| --      | $h'$         | HZBOT    | IJLDIM                 | --   |

<!--
-Parameters

| Meaning                                                      | Presentation | Variable      | unit          | value                              |
|:-------------------------------------------------------------|:-------------|:--------------|:--------------|:-----------------------------------|
| thickness of each lake level                                 | $D$          | DZ(NLZDIM)    | $\mathrm{cm}$ | $0, S_0(1), S_0(2), S_0(3),S_0(4)$ |
|                                                              | $S$          | DS(NLZDIM)    | $\mathrm{ND}$ |                                    |
| thickness of the lake model’s top level                      | $D_1$        | DZ1           | $\mathrm{cm}$ | $1.0\times 10^2$                   |
| Ratio of the thickness of the each layer in sigma coordinate | $S_0$        | DS0(NLZDIM-1) | $\mathrm{ND}$ | $0.1, 0.1, 0.2, 0.6$               |
-->

Supposing that the thickness of the 1st top layer ($k=2$) is $D_1$,

$$
	D(2) = D_1
$$

 the thickness of the remaining water column ($h'$) is presented by

$$
	h' = h - D_1
$$

The thickness of each remaining layer ($k=3,4,5,6$) is

$$
	D(k) = S(k) {h'}
$$

Then, the component of the diffusive tracer flux is represented by

$$
	F_D = K_V \frac{\partial T}{\partial z}
$$

practically,

$$
	F_D(k) = K_V(k) \frac{T(k-1)-T(k)}{\frac{D(k-1)+D(k)}{2}} - K_V(k+1) \frac{T(k)-T(k+1)}{\frac{D(k)+D(k+1)}{2}}
$$



### 11.4.3 `[SLVTRCL]`

- Inputs

| Meaning                                     | Presentation                   | Variable | dimension              | unit                    |
|:--------------------------------------------|:-------------------------------|:---------|:-----------------------|:------------------------|
| vertical component of diffusive tracer flux | $F_D$                          | ADT      | IJLDIM, NLZDIM, NLTDIM | --                      |
|                                             | $\frac{F_D}{D(k-\frac{1}{2})}$ | DIFFZ    | IJLDIM, NLZDIM         | --                      |
| minimum depth of lake                       | --                             | HXMIN    |                        | $\mathrm{cm}$           |
| heat flux                                   | --                             | FT       |                        | $\mathrm{K cm/s}$       |
| absorbed shortwave                          | --                             | SWABS    |                        | $\mathrm{erg/cm^2/sec}$ |
|                                             | --                             | FS       |                        | --                      |
| time step                                   | $\Delta t$                     | TS       |                        | --                      |
| surface-type fraction (lake)                | $$                             | LKFRAC   | IJLDIM                 | [-]                     |

- Outputs

| Meaning              | Presentation | Variable | dimension | unit          |
|:---------------------|:-------------|:---------|:----------|:--------------|
| lake water deficient | --           | XHD      | IJLDIM    | $\mathrm{cm}$ |

$$
	A_A(k) = -\frac{K_V(k)}{\frac{D(k-1)+D(k)}{2}} \Delta t
$$

$$
	A_C(k) = -\frac{K_V(k+1)}{\frac{D(k)+D(k+1)}{2}} \Delta t
$$

$$
	A_B(k) = D)k-A_A(k)-A(k)
$$

Solve the linear equations expressed by tri-diagonal matrix in `MODULE: THOASL`. (original files ./ocean/utrdg.F)

Then,
$$
	T(k)=T(k)+ F_D(k)\Delta t
$$

$$
	h_D = -F_T \Delta t
$$

$$
	V_D = \mathrm{max}(h_{min}-h - h_D, 0) R_{lake}
$$

$$
	h_D = \mathrm{max}(h_D,h_{min}-h)
$$

Then, the deficient water is added.

$$
	h = h + h_D
$$

$$
	h_{BOT}=h-D_1
$$



$$
	T(k) = T(k) + \frac{  T(k-1) D^{top}}{h_{BOT}S(k)}
$$

### 11.4.4 `[OVTURNL]`


Reference: [Hasumi, 2015, Section 4.1](https://ccsr.aori.u-tokyo.ac.jp/~hasumi/COCO/coco4.pdf)


Let us consider finite difference discretization of a flux-form, one-dimensional advection equation for tracer $\psi$.

$$
	\frac{\partial \psi}{\partial t} + \frac{\partial}{\partial z} (w\psi) = 0
$$

- Inputs

| Meaning                 | Presentation | Variable | dimension | unit |
|:------------------------|:-------------|:---------|:----------|:-----|
| $depth of water column$ | $h$          | H        | --        | --   |
| time step               | $\Delta t$   | TS       | --        | --   |

- Outputs

| Meaning | Presentation | Variable | dimension | unit |
|:--------|:-------------|:---------|:----------|:-----|
| --      | --           | R        | --        | --   |


The unit of XHD will be changed to $\mathrm{kg/m2}$ after this module (in `MATDRV`).
