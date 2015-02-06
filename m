From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal SoC management updates for v3.20 #1
Date: Thu, 5 Feb 2015 23:39:56 -0400
Message-ID: <20150206033952.GE3486@developer.amazonguestwifi.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qftxBdZWiueWNAVY"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--qftxBdZWiueWNAVY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Rui,

Please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.=
git fixes

to receive Thermal SoC Management updates for v3.20 with top-most

6c247393cfdd6695717f80ff31f9fd9af8c2c525:

  thermal: exynos: Add TMU support for Exynos7 SoC (2015-01-31 15:20:45 -04=
00)

on top of commit b97f880c8342fd6e49a02c9ef7507a678722b2b3:

  Merge branch 'for-3.19-fixes' of git://git.kernel.org/pub/scm/linux/kerne=
l/git/tj/libata (2015-01-21 07:54:16 +1200)

Specifics:

- Exynos thermal driver refactoring. Several cleanups, code optimization, u=
nused
symbols removal, and unused feature removal in Exynos thermal driver. Thanks
Lukasz for this effort.
- Exynos thermal driver support to OF thermal. After the code refactoring,
the driver earned the support to OF thermal. Chip thermal data were moved
=66rom driver code to DTS, reducing the code footprint. Thanks Lukasz for t=
his.
- After receiving the OF thermal support, the exynos thermal driver now must
allow modular build. Thanks Arnd for detecting, reporting and fixing this.
- Exynos thermal driver support to Exynos 7 SoC. Thanks Abhilash for this.
- Accurate temperature reporting on Rockchip thermal driver, thanks to Caes=
ar.
- Fix on how OF thermal enables its zones, thanks Lukasz for fixing.
- Fixes in OF thermal examples under Documentation/. Thanks Srinivas for fi=
xing.


PS: I might be sending more changes regarding Thermal Zone Binding
Parameters and how we represent weights. I need to finish a couple of
testing on that code. But it should make 3.20 too.

BR,

Eduardo Valentin
----------------------------------------------------------------
Abhilash Kesavan (2):
      dts: Documentation: Add documentation for Exynos7 SoC thermal bindings
      thermal: exynos: Add TMU support for Exynos7 SoC

Arnd Bergmann (1):
      cpufreq: exynos: allow modular build

Caesar Wang (1):
      thermal: rockchip: make temperature reporting much more accurate

Lukasz Majewski (12):
      thermal: of: Enable thermal_zoneX when sensor is correctly added
      thermal: exynos: cosmetic: Correct comment format
      thermal: exynos: Provide thermal_exynos.h file to be included in devi=
ce tree files
      thermal: exynos: Modify exynos thermal code to use device tree for cp=
u cooling configuration
      cpufreq: exynos: Use device tree to determine if cpufreq cooling shou=
ld be registered
      dts: Documentation: Extending documentation entry for exynos-thermal
      dts: Documentation: Update exynos-thermal.txt example for Exynos5440
      thermal: samsung: core: Exynos TMU rework to use device tree for conf=
iguration
      thermal: exynos: Remove exynos_thermal_common.[c|h] files
      thermal: exynos: Remove exynos_tmu_data.c file
      thermal: Kconfig: Remove config for not used EXYNOS_THERMAL_CORE
      thermal: exynos: Correct sanity check at exynos_report_trigger() func=
tion

Srinivas Kandagatla (1):
      thermal: Fix examples in DT documentation

 .../devicetree/bindings/thermal/exynos-thermal.txt |  21 +
 .../devicetree/bindings/thermal/thermal.txt        |  74 +--
 drivers/cpufreq/Kconfig.arm                        |  44 +-
 drivers/cpufreq/Makefile                           |   9 +-
 drivers/cpufreq/exynos-cpufreq.c                   |  33 +-
 drivers/thermal/of-thermal.c                       |   3 +
 drivers/thermal/rockchip_thermal.c                 |  36 +-
 drivers/thermal/samsung/Kconfig                    |   9 -
 drivers/thermal/samsung/Makefile                   |   2 -
 drivers/thermal/samsung/exynos_thermal_common.c    | 427 ----------------
 drivers/thermal/samsung/exynos_thermal_common.h    | 106 ----
 drivers/thermal/samsung/exynos_tmu.c               | 553 ++++++++++++++++-=
----
 drivers/thermal/samsung/exynos_tmu.h               |  77 +--
 drivers/thermal/samsung/exynos_tmu_data.c          | 264 ----------
 include/dt-bindings/thermal/thermal_exynos.h       |  28 ++
 15 files changed, 596 insertions(+), 1090 deletions(-)
 delete mode 100644 drivers/thermal/samsung/exynos_thermal_common.c
 delete mode 100644 drivers/thermal/samsung/exynos_thermal_common.h
 delete mode 100644 drivers/thermal/samsung/exynos_tmu_data.c
 create mode 100644 include/dt-bindings/thermal/thermal_exynos.h

--qftxBdZWiueWNAVY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU1Dd/AAoJEMLUO4d9pOJW+w0H/3gnOSBES3becR0KzI2BNCxK
rYX1RyxPAs5WW8Efr1O8Q6T9t30HbRk913rSCXG/lRMqGeJ3XJ556/5D3DbiKQmI
khJ5zWSEZXArPFSvp6AXWiAhdAcA5pqUDJEBKyEhf5898LdlTWoT0hfharwhKn3r
pTaG7vg6a+AdcUGwesBwtOXE7J55T/Pduq3ohozsDkbEQr28FDeom8KIJns1vGcw
xn3IZaqIKfxpv5J+87qaJEQ1PDTkxBskI84+HoPuPXMZFg9KGyad/hs26bEnvopu
aDZ0UHb2VLgrwx12GdQYxZl24yE+V4JOsEE0MbQ25/Dc/zPbCuVrE/DZy4s3hak=
=u9hm
-----END PGP SIGNATURE-----

--qftxBdZWiueWNAVY--
