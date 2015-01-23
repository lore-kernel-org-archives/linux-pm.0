From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v4 00/17] thermal: exynos: Thermal code rework to use
 device tree
Date: Fri, 23 Jan 2015 10:45:42 -0400
Message-ID: <20150123144540.GF13468@developer.hsd1.ca.comcast.net>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1421407861-25099-1-git-send-email-l.majewski@samsung.com>
 <0dad01d036e0$2f376c80$8da64580$@kernel.org>
 <20150123105944.457d6d07@amdc2363>
 <0e1401d036fb$c00a3510$401e9f30$@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uTRFFR9qmiCqR05s"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0e1401d036fb$c00a3510$401e9f30$@kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>
Cc: 'Lukasz Majewski' <l.majewski@samsung.com>, 'Zhang Rui' <rui.zhang@intel.com>, 'Linux PM list' <linux-pm@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, 'Bartlomiej Zolnierkiewicz' <b.zolnierkie@samsung.com>, 'Lukasz Majewski' <l.majewski@majess.pl>, 'Amit Daniel Kachhap' <amit.daniel@samsung.com>, 'Abhilash Kesavan' <kesavan.abhilash@gmail.com>, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Chanwoo Choi' <cw00.choi@samsung.com>, 'Abhilash Kesavan' <a.kesavan@samsung.com>
List-Id: linux-pm@vger.kernel.org


--uTRFFR9qmiCqR05s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kukjin,

On Fri, Jan 23, 2015 at 08:00:07PM +0900, Kukjin Kim wrote:
> Lukasz Majewski wrote:
> >=20
> > Hi Kukjin,
> >=20
> Hi,
>=20
> > > Lukasz Majewski wrote:
> > > >
> > > Hi,
> > >
> > > > 1. Introduction
> > > >
> > > > Following patches aim to clean up the current implementation of the
> > > > thermal framework on Exynos devices.
> > > >
> > > > The main goal was to use a generic code for reading thermal
> > > > configuration (of-thermal.c). Due to that redundant
> > > > exynos_thermal_common.[h|c] files were removed.
> > > >
> > > > Around 400 lines of code (LOC) were removed directly by this patch,
> > > > which is around 20% of the Exynos thermal code base.
> > > >
> > > > This work should NOT bring any functional changes to Exynos thermal
> > > > subsystem.
> > > >
> > > Sounds great to use generic some framework in kernel.
> > >
> > > > 2. Patch-set structure
> > > >
> > > > Then the cpu_cooling functionality has been preserved to allow
> > > > cooling devices by reducing operating frequency. Definition of trip
> > > > points and cpufreq's cooling properties were moved to device tree.
> > > >
> > > > Then the rework of the way in which configuration data is provided
> > > > to the Exynos thermal subsystem was performed. Now device tree is
> > > > used for configuration.
> > > >
> > > > 3. Dead code removal
> > > >
> > > > Thermal support for some SoCs, previously available in the
> > > > exynos_tmu_data.c file, was removed since, as of (almost) 3.19-rc3,
> > > > they didn't have TMU bindings.
> > > >
> > > > Moreover, support for cpu_cooling devices was preserved only on
> > > > those SoCs which had available and working cpufreq driver.
> > > >
> > > > 4. Testing
> > > >
> > > > Test devices:
> > > > - Exynos4210 - Trats (TMU zone + cpu_cooling)
> > > > - Exynos4412 - Trats2/Odroid U3 (TMU zone + cpu_cooling)
> > > > - Exynos5250 - Arndale (TMU zone + cpu_cooling)
> > > > - Exynos5420 - Arndale-octa (only TMU zones)
> > > >
> > > Thanks for your check on the boards...
> > >
> > > > Unfortunately, I don't posses Exynos5440 for testing. Its
> > > > functionality has been preserved in the code, but not tested on the
> > > > hardware. I would be grateful for help in testing.
> > > >
> > > I think, Amit can do it on exynos5440 ;)
> > >
> > > >
> > > > 5. This work apply on the following tree:
> > > >
> > > > kernel.org: 'linux-soc-thermal/next' - Eduardo Velentin's tree
> > > > SHA1: 1813d80874699145f04af6b05ebab0a6419001fb
> > > >
> > > >
> > > > Lukasz Majewski (17):
> > > >   thermal: exynos: cosmetic: Correct comment format
> > > >   thermal: exynos: Provide thermal_exynos.h file to be included in
> > > >     device tree files
> > > >   arm: dts: trats: Enable TMU on the Exynos4210 trats device
> > > >   arm: dts: odroid: Add LD010 regulator node necessary for TMU on
> > > > Odroid arm: dts: odroid: Enable TMU at Exynos4412 based Odroid U3
> > > > device arm: dts: Adding CPU cooling binding for Exynos SoCs
> > > >   thermal: exynos: Modify exynos thermal code to use device tree
> > > > for cpu cooling configuration
> > > >   thermal: exynos: dts: Add default definition of the TMU sensor
> > > >     parameter
> > > >   dts: Documentation: Extending documentation entry for
> > > > exynos-thermal thermal: dts: Default trip points definition for
> > > > Exynos5420 SoCs thermal: exynos: dts: Define default thermal-zones
> > > > for Exynos4 thermal: dts: exynos: Trip points and sensor
> > > > configuration data for Exynos5440
> > > >   dts: Documentation: Update exynos-thermal.txt example for
> > > > Exynos5440 thermal: exynos: dts: Provide device tree bindings
> > > > identical to the one in exynos_tmu_data.c
> > > >   thermal: samsung: core: Exynos TMU rework to use device tree for
> > > >     configuration
> > > >   thermal: exynos: Remove exynos_thermal_common.[c|h] files
> > > >   thermal: exynos: Remove exynos_tmu_data.c file
> > > >
> > > >  .../devicetree/bindings/thermal/exynos-thermal.txt |  17 +
> > > >  arch/arm/boot/dts/exynos3250.dtsi                  |   2 +
> > > >  arch/arm/boot/dts/exynos4-cpu-thermal.dtsi         |  52 +++
> > > >  arch/arm/boot/dts/exynos4.dtsi                     |   4 +
> > > >  arch/arm/boot/dts/exynos4210-trats.dts             |  19 +
> > > >  arch/arm/boot/dts/exynos4210.dtsi                  |  30 +-
> > > >  arch/arm/boot/dts/exynos4212.dtsi                  |   5 +-
> > > >  arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |  27 ++
> > > >  arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi  |  24 ++
> > > >  arch/arm/boot/dts/exynos4412-trats2.dts            |  15 +
> > > >  arch/arm/boot/dts/exynos4412.dtsi                  |   5 +-
> > > >  arch/arm/boot/dts/exynos4x12.dtsi                  |   1 +
> > > >  arch/arm/boot/dts/exynos5250.dtsi                  |  29 +-
> > > >  arch/arm/boot/dts/exynos5420-trip-points.dtsi      |  35 ++
> > > >  arch/arm/boot/dts/exynos5420.dtsi                  |  28 ++
> > > >  arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi  |  24 ++
> > > >  arch/arm/boot/dts/exynos5440-trip-points.dtsi      |  25 ++
> > > >  arch/arm/boot/dts/exynos5440.dtsi                  |  18 +
> > > >  drivers/cpufreq/exynos-cpufreq.c                   |  30 +-
> > > >  drivers/thermal/samsung/Makefile                   |   2 -
> > > >  drivers/thermal/samsung/exynos_thermal_common.c    | 427
> > > > ---------------------
> > > > drivers/thermal/samsung/exynos_thermal_common.h    | 106 -----
> > > > drivers/thermal/samsung/exynos_tmu.c               | 354
> > > > +++++++++++------
> > > > drivers/thermal/samsung/exynos_tmu.h               |  68 +---
> > > > drivers/thermal/samsung/exynos_tmu_data.c          | 264
> > > > ------------- include/dt-bindings/thermal/thermal_exynos.h       |
> > > > 28 ++ 26 files changed, 638 insertions(+), 1001 deletions(-) create
> > > > mode 100644 arch/arm/boot/dts/exynos4-cpu-thermal.dtsi create mode
> > > > 100644 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi create
> > > > mode 100644 arch/arm/boot/dts/exynos5420-trip-points.dtsi create
> > > > mode 100644 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi
> > > > create mode 100644 arch/arm/boot/dts/exynos5440-trip-points.dtsi
> > > > delete mode 100644 drivers/thermal/samsung/exynos_thermal_common.c
> > > > delete mode 100644 drivers/thermal/samsung/exynos_thermal_common.h
> > > > delete mode 100644 drivers/thermal/samsung/exynos_tmu_data.c create
> > > > mode 100644 include/dt-bindings/thermal/thermal_exynos.h
> > > >
> > > > --
> > >
> > > I hope will apply DT changes in Samsung tree. Is it OK to thermal
> > > tree?
> >=20
> > I think that it is up to you and Eduardo to decide :-).
> >=20
> > I'd personally prefer to add this patch set at once to Eduardo's tree
> > (of course with your ACKs).
> >=20
> If so, we could see too many useless merge conflicts. Because your patches
> touch most of exynos DT stuff and that's why DT changes should be handled=
 in
> Samsung tree if there is no problem ;) Let's wait for thermal guys.

Let's target the latest version (v6) of this series. You can add my
Acked-by: Eduardo Valentin <edubezval@gmail.com>

in the DTS changes. And add them via your tree. I believe we will avoid
merge conflicts this way. I will handle the patches touching drivers/.

Thanks.

>=20
> - Kukjin
>=20

--uTRFFR9qmiCqR05s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUwl6KAAoJEMLUO4d9pOJWv6YH/i7qsTZoEcoHAbdbDcn9vx0M
xvK1lG1a31AEdiQ88+Y0ceCcTBkO+2FmekFDpv1hLPaE1eB7VNuBqDz7CkRio8zq
hEgekxg7Nsji76ImrXQJHdwI7fBfHNj4ORnNUTcG0WQrHRX8Om8xLPya961RFu4o
+Kn08tsp8BNBJeA89c8Dj6UyVDDBj6bEWM+T4WcWsbLM+iKWH8/XGRbenijFmeGM
LgC85kQQncw3AsVtbxn3Z0a6Tp3jHPeQEwLRzIYB45yx5lFwqc7fp1cSgP2VD8w+
0sGz9TrMWM6Dmp6uHsIhX4u57dzv2WWdWHd8P+9DwHPaQUDWkAWoTVDmL3+fOE4=
=IGfP
-----END PGP SIGNATURE-----

--uTRFFR9qmiCqR05s--
