From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [GIT PULL] Thermal SoC management updates for v3.20 #1
Date: Mon, 16 Feb 2015 23:19:28 -0400
Message-ID: <20150217031926.GA3952@developer.amazonguestwifi.org>
References: <20150206033952.GE3486@developer.amazonguestwifi.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150206033952.GE3486@developer.amazonguestwifi.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Rui,

On Thu, Feb 05, 2015 at 11:39:56PM -0400, Eduardo Valentin wrote:
> Hello Rui,
>=20
> Please pull from
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-therma=
l.git fixes
>=20
> to receive Thermal SoC Management updates for v3.20 with top-most
>=20
> 6c247393cfdd6695717f80ff31f9fd9af8c2c525:
>=20
>   thermal: exynos: Add TMU support for Exynos7 SoC (2015-01-31 15:20:45 -=
0400)
>=20
> on top of commit b97f880c8342fd6e49a02c9ef7507a678722b2b3:
>=20
>   Merge branch 'for-3.19-fixes' of git://git.kernel.org/pub/scm/linux/ker=
nel/git/tj/libata (2015-01-21 07:54:16 +1200)
>=20
> Specifics:
>=20
> - Exynos thermal driver refactoring. Several cleanups, code optimization,=
 unused
> symbols removal, and unused feature removal in Exynos thermal driver. Tha=
nks
> Lukasz for this effort.
> - Exynos thermal driver support to OF thermal. After the code refactoring,
> the driver earned the support to OF thermal. Chip thermal data were moved
> from driver code to DTS, reducing the code footprint. Thanks Lukasz for t=
his.
> - After receiving the OF thermal support, the exynos thermal driver now m=
ust
> allow modular build. Thanks Arnd for detecting, reporting and fixing this.
> - Exynos thermal driver support to Exynos 7 SoC. Thanks Abhilash for this.
> - Accurate temperature reporting on Rockchip thermal driver, thanks to Ca=
esar.
> - Fix on how OF thermal enables its zones, thanks Lukasz for fixing.
> - Fixes in OF thermal examples under Documentation/. Thanks Srinivas for =
fixing.
>=20

A gentle reminder. Please pull this one.

>=20
> PS: I might be sending more changes regarding Thermal Zone Binding
> Parameters and how we represent weights. I need to finish a couple of
> testing on that code. But it should make 3.20 too.

These patches won't be sent now. They are still under review. Please
consider only the current pull request.

>=20
> BR,
>=20
> Eduardo Valentin
> ----------------------------------------------------------------
> Abhilash Kesavan (2):
>       dts: Documentation: Add documentation for Exynos7 SoC thermal bindi=
ngs
>       thermal: exynos: Add TMU support for Exynos7 SoC
>=20
> Arnd Bergmann (1):
>       cpufreq: exynos: allow modular build
>=20
> Caesar Wang (1):
>       thermal: rockchip: make temperature reporting much more accurate
>=20
> Lukasz Majewski (12):
>       thermal: of: Enable thermal_zoneX when sensor is correctly added
>       thermal: exynos: cosmetic: Correct comment format
>       thermal: exynos: Provide thermal_exynos.h file to be included in de=
vice tree files
>       thermal: exynos: Modify exynos thermal code to use device tree for =
cpu cooling configuration
>       cpufreq: exynos: Use device tree to determine if cpufreq cooling sh=
ould be registered
>       dts: Documentation: Extending documentation entry for exynos-thermal
>       dts: Documentation: Update exynos-thermal.txt example for Exynos5440
>       thermal: samsung: core: Exynos TMU rework to use device tree for co=
nfiguration
>       thermal: exynos: Remove exynos_thermal_common.[c|h] files
>       thermal: exynos: Remove exynos_tmu_data.c file
>       thermal: Kconfig: Remove config for not used EXYNOS_THERMAL_CORE
>       thermal: exynos: Correct sanity check at exynos_report_trigger() fu=
nction
>=20
> Srinivas Kandagatla (1):
>       thermal: Fix examples in DT documentation
>=20
>  .../devicetree/bindings/thermal/exynos-thermal.txt |  21 +
>  .../devicetree/bindings/thermal/thermal.txt        |  74 +--
>  drivers/cpufreq/Kconfig.arm                        |  44 +-
>  drivers/cpufreq/Makefile                           |   9 +-
>  drivers/cpufreq/exynos-cpufreq.c                   |  33 +-
>  drivers/thermal/of-thermal.c                       |   3 +
>  drivers/thermal/rockchip_thermal.c                 |  36 +-
>  drivers/thermal/samsung/Kconfig                    |   9 -
>  drivers/thermal/samsung/Makefile                   |   2 -
>  drivers/thermal/samsung/exynos_thermal_common.c    | 427 ----------------
>  drivers/thermal/samsung/exynos_thermal_common.h    | 106 ----
>  drivers/thermal/samsung/exynos_tmu.c               | 553 +++++++++++++++=
+-----
>  drivers/thermal/samsung/exynos_tmu.h               |  77 +--
>  drivers/thermal/samsung/exynos_tmu_data.c          | 264 ----------
>  include/dt-bindings/thermal/thermal_exynos.h       |  28 ++
>  15 files changed, 596 insertions(+), 1090 deletions(-)
>  delete mode 100644 drivers/thermal/samsung/exynos_thermal_common.c
>  delete mode 100644 drivers/thermal/samsung/exynos_thermal_common.h
>  delete mode 100644 drivers/thermal/samsung/exynos_tmu_data.c
>  create mode 100644 include/dt-bindings/thermal/thermal_exynos.h



--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU4rM1AAoJEMLUO4d9pOJWINUH/Aw/8GQytj0bh2t+7QZ4hV+I
2vvZnmn6oaO3YU4F29GJ1KQo9H8cPiXbWGAPU2pQoHUJyq8j1lBB8pPOiBo1gvvx
j2X8eDVFZewcxJwouHuIvi10mv3MjNzYjaV9LS/RgpFwRArOdIH2QXDZRhvtTR9W
FxCgoHRSFHu/fp3S9O6gRdTyjs8MT4glmDplF5eFStJzGzBNAj8WbvqPdetUvY+J
SlddfMPEQsNX5vNeVZMg+Svg/7eFfpY4RNY9R0HHrNxrlC/FWAnPR5ATdrZQMyUf
nsTRK2nm2M7mL41maslVRbT4z69HSrIUs4/tzHRxf4hv8nQo7II5IXMP5PaG288=
=oMMM
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
