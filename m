From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v2 00/17] thermal: exynos: Thermal code rework to use
 device tree
Date: Wed, 10 Dec 2014 06:27:16 -0400
Message-ID: <20141210102712.GA2919@developer>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1418213396-743-1-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1418213396-743-1-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2014 at 01:09:39PM +0100, Lukasz Majewski wrote:
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

Very good! Thanks for cleaning the code.

Given the decision to be DT only, my only question now is if you need to
support non-DT booting systems. Do you (Exynos platforms in general) care
about booting without DT?

If not, then removing makes completely sense to me.


> Around 400 lines of code (LOC) were removed directly by this patch, which
> is around 20% of the Exynos thermal code base.
>=20

Great!

> This work should NOT bring any functional changes to Exynos thermal=20
> subsystem.
>=20

OK.

> 2. Patch-set structure
>=20
> Then the cpu_cooling functionality has been preserved to allow cooling
> devices by reducing operating frequency. Definition of trip points and
> cpufreq's cooling properties were moved to device tree.
>=20

uhh.. OK. but, by supporting of-thermal that means drivers should never
care about loading cpu cooling. That is done via cpufreq-dt. That is why
we had the cycle with cpufreq folks, remember?

(I will have a look in your patches)

> Then the rework of the way in which configuration data is provided to
> the Exynos thermal subsystem was performed. Now device tree is used for
> configuration.

This is very good. Do you care sending feedback if you need extra
configuration or does of-thermal cover your scenarios (a part from the
amendments you already did)?

I know people (tegra and rockchip) are interested in hw trip points,
which I believe should be of your interest too. Of course, that is maybe
an off-topic for this series.


>=20
> Patch series end with removing exynos5250/exynos3250 TMU compatibles.
> Both SoCs have thermal management unit (TMU) compatible with the one firs=
t=20
> introduced at Exynos4412.

OK. I will have a look in DT changes you did. But in general, removing
support needs to be done carefully for backward compatibility :-(.

>=20
> 3. Dead code removal
>=20
> Thermal support for some SoCs, previously available in the exynos_tmu_dat=
a.c=20
> file, was removed since, as of (almost) 3.19-rc1, they didn't have TMU bi=
ndings.
>=20
> Moreover, support for cpu_cooling devices was preserved only on those
> SoCs which had available and working cpufreq driver.


Have you tried your series with cpufreq-dt?

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
> 5. This work apply on the following tree:
>=20
> kernel.org: 'linux-soc-thermal/next' - Eduardo Velentin's tree
> SHA1: c42c7a44c7a543dcb388c1ee1a798e6ed76ad8cf
>=20
>=20
> Lukasz Majewski (17):
>   thermal: exynos: cosmetic: Correct comment format
>   thermal: exynos: Provide thermal_exynos.h file to be included in
>     device tree files
>   thermal: dts: trats: Enable TMU on the Exynos4210 trats device
>   thermal: dts: exynos: Add LD010 regulator node necessary for TMU on
>     Odroid
>   thermal: dts: Enable TMU at Exynos4412 based Odroid U3 device
>   thermal: cpu_cooling: dts: Define device tree bindings for Exynos cpu
>     cooling functionality
>   thermal: cpu_cooling: Modify exynos thermal code to use device tree
>     for cpu cooling configuration
>   thermal: exynos: dts: Add default definition of the TMU sensor
>     parameter
>   thermal: dts: Default trip points definition for Exynos5420 SoCs
>   thermal: exynos: dts: Define default thermal-zones for Exynos4
>   thermal: dts: exynos: Trip points and sensor configuration data for
>     Exynos5440
>   thermal: exynos: dts: Provide device tree bindings identical to one in
>     exynos_tmu_data.c
>   thermal: samsung: core: Exynos TMU rework to use device tree for
>     configuration
>   thermal: exynos: Remove exynos_thermal_common.[c|h] files
>   thermal: exynos: Remove exynos_tmu_data.c file
>   thermal: exynos: Make Exynos5250 TMU compatible with Exynos4412
>   thermal: exynos: Make Exynos3250 TMU compatible with Exynos4412
>=20
>  arch/arm/boot/dts/exynos3250.dtsi                 |   6 +-
>  arch/arm/boot/dts/exynos4-cpu-thermal.dtsi        |  52 +++
>  arch/arm/boot/dts/exynos4.dtsi                    |   5 +
>  arch/arm/boot/dts/exynos4210-trats.dts            |  19 +
>  arch/arm/boot/dts/exynos4210.dtsi                 |  43 ++-
>  arch/arm/boot/dts/exynos4212.dtsi                 |  20 +
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi   |  27 ++
>  arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi |  24 ++
>  arch/arm/boot/dts/exynos4412-trats2.dts           |  15 +
>  arch/arm/boot/dts/exynos4412.dtsi                 |  32 ++
>  arch/arm/boot/dts/exynos4x12.dtsi                 |   3 +
>  arch/arm/boot/dts/exynos5250.dtsi                 |  29 +-
>  arch/arm/boot/dts/exynos5420-trip-points.dtsi     |  35 ++
>  arch/arm/boot/dts/exynos5420.dtsi                 |  33 ++
>  arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi |  25 ++
>  arch/arm/boot/dts/exynos5440-trip-points.dtsi     |  25 ++
>  arch/arm/boot/dts/exynos5440.dtsi                 |  18 +
>  drivers/cpufreq/exynos-cpufreq.c                  |  23 +-
>  drivers/thermal/samsung/Makefile                  |   2 -
>  drivers/thermal/samsung/exynos_thermal_common.c   | 427 ----------------=
------
>  drivers/thermal/samsung/exynos_thermal_common.h   | 106 ------
>  drivers/thermal/samsung/exynos_tmu.c              | 337 ++++++++++-------
>  drivers/thermal/samsung/exynos_tmu.h              |  80 +---
>  drivers/thermal/samsung/exynos_tmu_data.c         | 264 -------------
>  include/dt-bindings/thermal/thermal_exynos.h      |  37 ++
>  25 files changed, 669 insertions(+), 1018 deletions(-)

Good!

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

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUiB/2AAoJEMLUO4d9pOJWcWwH/RJlJY56PaRr7PnQalZWByXq
GUKcwiExYgWHBGir3peiWb0vwfujRKMZybTghtCOwixax4c6RzZQcWJsrHiv71e2
qEagdzKXSyoKxJvKtvd5LUPcbMMjH5u6sctXRcIWX9fhNodRMK+2QnCfdgrbou4c
royd9liYXqJM711DDtaByfF4elCo41Y+ZLlUD8A12FB2JeXFBUj6qauCrpt4epkL
YAF96Xvj7rpxCuAXWLwYQfOFQoiD99u0FDNp/5TRomOU01d2fMA0tBLgSUgDqU9S
gqpkQx898GNdxPuTYXABwApjQbfNOq+saJQzlnEp+tHfKUyAPGawudCXQQYRRCQ=
=blQN
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
