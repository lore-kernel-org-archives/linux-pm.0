From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v5 00/18] thermal: exynos: Thermal code rework to use
 device tree
Date: Tue, 20 Jan 2015 21:55:51 -0400
Message-ID: <20150121015549.GD5830@developer.hsd1.ca.comcast.net>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1421666462-7606-1-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J5MfuwkIyy7RmF4Q"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1421666462-7606-1-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org


--J5MfuwkIyy7RmF4Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Arnd,

On Mon, Jan 19, 2015 at 12:20:44PM +0100, Lukasz Majewski wrote:
> 1. Introduction
>=20
> Following patches aim to clean up the current implementation of the therm=
al
> framework on Exynos devices.
>=20
> The main goal was to use a generic code for reading thermal configuration
> (of-thermal.c). Due to that redundant exynos_thermal_common.[h|c] files
> were removed.
>=20
> Around 400 lines of code (LOC) were removed directly by this patch, which
> is around 20% of the Exynos thermal code base.
>=20
> This work should NOT bring any functional changes to Exynos thermal=20
> subsystem.
>=20
> 2. Patch-set structure
>=20
> Then the cpu_cooling functionality has been preserved to allow cooling
> devices by reducing operating frequency. Definition of trip points and
> cpufreq's cooling properties were moved to device tree.
>=20
> Then the rework of the way in which configuration data is provided to
> the Exynos thermal subsystem was performed. Now device tree is used for
> configuration.
>=20
> 3. Dead code removal
>=20
> Thermal support for some SoCs, previously available in the exynos_tmu_dat=
a.c=20
> file, was removed since, as of (almost) 3.19-rc3, they didn't have TMU bi=
ndings.
>=20
> Moreover, support for cpu_cooling devices was preserved only on those
> SoCs which had available and working cpufreq driver.
>=20
> 4. Testing
>=20
> Test devices:
> - Exynos4210 - Trats (TMU zone + cpu_cooling)
> - Exynos4412 - Trats2/Odroid U3 (TMU zone + cpu_cooling)
> - Exynos5250 - Arndale (TMU zone + cpu_cooling)
> - Exynos5420 - Arndale-octa (only TMU zones)
>=20
> Unfortunately, I don't posses Exynos5440 for testing. Its functionality
> has been preserved in the code, but not tested on the hardware. I would
> be grateful for help in testing.
>=20
>=20
> 5. This work apply on the following tree:
>=20
> kernel.org: 'linux-soc-thermal/next' - Eduardo Velentin's tree
> SHA1: 1813d80874699145f04af6b05ebab0a6419001fb
>=20
>=20

This series contains changes under drivers/thermal that I can pick up,
but it also contains changes under arch/arm/boot/dts that depend on a
header file provided by the driver. The header is introduced in this
series.

How do you prefer to preceed in such sitation? Are you OK if I pick the
complete series, changes under drivers/thermal and the DTS changes?

Cheers,

Eduardo

> Lukasz Majewski (18):
>   thermal: exynos: cosmetic: Correct comment format
>   thermal: exynos: Provide thermal_exynos.h file to be included in
>     device tree files
>   arm: dts: trats: Enable TMU on the Exynos4210 trats device
>   arm: dts: odroid: Add LDO10 regulator node necessary for TMU on Odroid
>   arm: dts: odroid: Enable TMU at Exynos4412 based Odroid U3 device
>   arm: dts: Adding CPU cooling binding for Exynos SoCs
>   thermal: exynos: Modify exynos thermal code to use device tree for cpu
>     cooling configuration
>   thermal: exynos: dts: Add default definition of the TMU sensor
>     parameter
>   dts: Documentation: Extending documentation entry for exynos-thermal
>   thermal: dts: Default trip points definition for Exynos5420 SoCs
>   thermal: exynos: dts: Define default thermal-zones for Exynos4
>   thermal: dts: exynos: Trip points and sensor configuration data for
>     Exynos5440
>   dts: Documentation: Update exynos-thermal.txt example for Exynos5440
>   thermal: exynos: dts: Provide device tree bindings identical to the
>     one in exynos_tmu_data.c
>   thermal: samsung: core: Exynos TMU rework to use device tree for
>     configuration
>   thermal: exynos: Remove exynos_thermal_common.[c|h] files
>   thermal: exynos: Remove exynos_tmu_data.c file
>   thermal: exynos: Remove not needed exynos_tmu_init_data declarations
>     from exynos_tmu.h
>=20
>  .../devicetree/bindings/thermal/exynos-thermal.txt |  17 +
>  arch/arm/boot/dts/exynos3250.dtsi                  |   2 +
>  arch/arm/boot/dts/exynos4-cpu-thermal.dtsi         |  52 +++
>  arch/arm/boot/dts/exynos4.dtsi                     |   4 +
>  arch/arm/boot/dts/exynos4210-trats.dts             |  19 +
>  arch/arm/boot/dts/exynos4210.dtsi                  |  30 +-
>  arch/arm/boot/dts/exynos4212.dtsi                  |   5 +-
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |  27 ++
>  arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi  |  24 ++
>  arch/arm/boot/dts/exynos4412-trats2.dts            |  15 +
>  arch/arm/boot/dts/exynos4412.dtsi                  |   5 +-
>  arch/arm/boot/dts/exynos4x12.dtsi                  |   1 +
>  arch/arm/boot/dts/exynos5250.dtsi                  |  29 +-
>  arch/arm/boot/dts/exynos5420-trip-points.dtsi      |  35 ++
>  arch/arm/boot/dts/exynos5420.dtsi                  |  28 ++
>  arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi  |  24 ++
>  arch/arm/boot/dts/exynos5440-trip-points.dtsi      |  25 ++
>  arch/arm/boot/dts/exynos5440.dtsi                  |  18 +
>  drivers/cpufreq/exynos-cpufreq.c                   |  30 +-
>  drivers/thermal/samsung/Makefile                   |   2 -
>  drivers/thermal/samsung/exynos_thermal_common.c    | 427 ---------------=
------
>  drivers/thermal/samsung/exynos_thermal_common.h    | 106 -----
>  drivers/thermal/samsung/exynos_tmu.c               | 348 +++++++++++----=
--
>  drivers/thermal/samsung/exynos_tmu.h               |  76 +---
>  drivers/thermal/samsung/exynos_tmu_data.c          | 264 -------------
>  include/dt-bindings/thermal/thermal_exynos.h       |  28 ++
>  26 files changed, 632 insertions(+), 1009 deletions(-)
>  create mode 100644 arch/arm/boot/dts/exynos4-cpu-thermal.dtsi
>  create mode 100644 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
>  create mode 100644 arch/arm/boot/dts/exynos5420-trip-points.dtsi
>  create mode 100644 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi
>  create mode 100644 arch/arm/boot/dts/exynos5440-trip-points.dtsi
>  delete mode 100644 drivers/thermal/samsung/exynos_thermal_common.c
>  delete mode 100644 drivers/thermal/samsung/exynos_thermal_common.h
>  delete mode 100644 drivers/thermal/samsung/exynos_tmu_data.c
>  create mode 100644 include/dt-bindings/thermal/thermal_exynos.h
>=20
> --=20
> 2.0.0.rc2
>=20

--J5MfuwkIyy7RmF4Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUvwcZAAoJEMLUO4d9pOJWzv4H/3cBJd1YvN8mrUZXBp+kmz0s
H82dqfDLz4GTrXGLa42iGde3+j0i3F6hE3uQpiPIG43Z333Po8/+QFWuBqNO1dSi
15Vw2PsSwysS9m7Bj1SyUwU/Z2hcb8l1X8kPC6ckAzKCuMinXMyL1Rshsh7FtTFG
/2YdhAISkPA9OAEkDgzhvhF1aU9JSGfYSQNqpN1m++Qr970U3aJy1zkiukjyvNzE
pq/Qfiv+25+vhIy8OyhhC0rXobgVPd4EHHRDTdZCWFM08V9NXI2sBACtP+rQ0FiB
BENvYSSkcxjP9XADYIQQ5+msScD1PpJfauQfxfUwQoPbYZW8G+WpcTPbiaXpm4g=
=7E7f
-----END PGP SIGNATURE-----

--J5MfuwkIyy7RmF4Q--
