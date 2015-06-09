From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal-SoC management updates for v4.2-rc1
Date: Tue, 9 Jun 2015 15:36:21 -0700
Message-ID: <20150609223619.GA10847@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Rui,

Please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal linus

to receive Thermal-SoC Management updates for v4.2-rc1 with top-most

9a5238a9c6c33dd31525f2bba4aa1af4f8374ae1:

  thermal: hisilicon: add new hisilicon thermal sensor driver (2015-06-03 15:58:52 -0700)

on top of commit 5ebe6afaf0057ac3eaeb98defd5456894b446d22:

  Linux 4.1-rc2 (2015-05-03 19:22:23 -0700)

Specifics:
- Exynos thermal driver learns how to handle Exynos5433 TMU. Thanks to Chanwoo C.;
- Thermal Framework now supports QPNP PMIC temperature alarm as a new thermal
  driver. Thanks to Ivan T. I.;
- TI thermal driver now has a better implementation for EOCZ bit. Thanks to Pavel M.;
- New thermal driver for Hisilicon hi6220;
- Thermal Framework now has learned several new capabilities:
  . use power estimates
  . compute weights with relative integers instead of percentages
  . allow governors to have private data in thermal zones
  . export thermal zone parameters through sysfs
  Thanks to the ARM thermal team (Javi, Punit, KP).
- Thermal Framework earns a new thermal governor: power allocator. First in kernel
  closed loop PI(D) controller for thermal control. Thanks to ARM thermal team.
- OF thermal now allows thermal zones to have sustainable power HW specification.
  Thanks to Punit.
- Thermal zones now have representations of slope and offset constants for
hotspot extrapolation linear equations. For now, supports only per sensor
extrapolation.


BR,

Eduardo Valentin
----------------------------------------------------------------
Chanwoo Choi (1):
      thermal: exynos: Add the support for Exynos5433 TMU

Eduardo Valentin (2):
      thermal: support slope and offset coefficients
      thermal: of-thermal: add support for reading coefficients property

Ivan T. Ivanov (1):
      thermal: Add QPNP PMIC temperature alarm driver

Javi Merino (14):
      thermal: fair_share: use the weight from the thermal instance
      thermal: fair_share: fix typo
      thermal: export weight to sysfs
      thermal: fair_share: generalize the weight concept
      thermal: let governors have private data for each thermal zone
      thermal: extend the cooling device API to include power information
      thermal: cpu_cooling: implement the power cooling device API
      thermal: introduce the Power Allocator governor
      thermal: add trace events to the power allocator governor
      thermal: x86_pkg_temp: drop const for thermal_zone_parameters
      thermal: remove stale THERMAL_POWER_ACTOR select
      thermal: cpu_cooling: Check memory allocation of power_table
      thermal: export thermal_zone_parameters to sysfs
      thermal: power_allocator: round the division when divvying up power

Kapileshwar Singh (3):
      thermal: of: fix cooling device weights in device tree
      thermal: cpu_cooling: Remove cpu_dev update on policy CPU update
      thermal: cpu_cooling: Fix power calculation when CPUs are offline

Pavel Machek (3):
      cleanup ti-soc-thermal
      ti-soc-thermal: implement eocz bit to make driver useful on omap3
      ti-soc-thermal: request temperature periodically if hw can't do that itself

Punit Agrawal (3):
      of: thermal: Introduce sustainable power for a thermal zone
      thermal: core: Add Kconfig option to enable writable trips
      thermal: Default OF created trip points to writable

kongxinwei (2):
      dt-bindings: Document the hi6220 thermal sensor bindings
      thermal: hisilicon: add new hisilicon thermal sensor driver

 .../bindings/thermal/hisilicon-thermal.txt         |  23 +
 .../bindings/thermal/qcom-spmi-temp-alarm.txt      |  57 ++
 .../devicetree/bindings/thermal/thermal.txt        |   9 +
 Documentation/thermal/cpu-cooling-api.txt          | 156 +++++-
 Documentation/thermal/power_allocator.txt          | 247 +++++++++
 Documentation/thermal/sysfs-api.txt                |  99 +++-
 drivers/acpi/thermal.c                             |   9 +-
 drivers/platform/x86/acerhdf.c                     |   3 +-
 drivers/thermal/Kconfig                            |  44 ++
 drivers/thermal/Makefile                           |   3 +
 drivers/thermal/cpu_cooling.c                      | 585 ++++++++++++++++++++-
 drivers/thermal/db8500_thermal.c                   |   2 +-
 drivers/thermal/fair_share.c                       |  41 +-
 drivers/thermal/hisi_thermal.c                     | 421 +++++++++++++++
 drivers/thermal/imx_thermal.c                      |   3 +-
 drivers/thermal/of-thermal.c                       |  41 +-
 drivers/thermal/power_allocator.c                  | 539 +++++++++++++++++++
 drivers/thermal/qcom-spmi-temp-alarm.c             | 309 +++++++++++
 drivers/thermal/samsung/exynos_tmu.c               | 187 ++++++-
 drivers/thermal/samsung/exynos_tmu.h               |   1 +
 drivers/thermal/thermal_core.c                     | 314 ++++++++++-
 drivers/thermal/thermal_core.h                     |  11 +
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        | 104 ++--
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |   5 +-
 drivers/thermal/x86_pkg_temp_thermal.c             |   2 +-
 include/linux/cpu_cooling.h                        |  39 ++
 include/linux/thermal.h                            |  97 +++-
 include/trace/events/thermal.h                     |  58 ++
 include/trace/events/thermal_power_allocator.h     |  87 +++
 29 files changed, 3359 insertions(+), 137 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
 create mode 100644 Documentation/thermal/power_allocator.txt
 create mode 100644 drivers/thermal/hisi_thermal.c
 create mode 100644 drivers/thermal/power_allocator.c
 create mode 100644 drivers/thermal/qcom-spmi-temp-alarm.c
 create mode 100644 include/trace/events/thermal_power_allocator.h

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVd2pcAAoJEMLUO4d9pOJWu94H/iSvJvWsQl6LRNH0FwALWz7e
/s3tUpgLbrtaFGBQlig9d+j+vcRw827oZxOFs5voY1VcBsYwBZXRuLzUE1eStnKQ
gWyRVKyTsfPeZIryxrqgTDzDIOzdfFwPKYglv1ElbSOnnDbS97JYGpbWeMJOEs5p
OBIpdzNfvJSFxT1GHQeRBSbT+5s7uC9g36to+GHW5UT8zW536bURfnKBXR5f7ohI
OD+A5AIgkKZq5RhNe51euKhmKWuFi++rg4jIxyAuGxBLW21kGRArQmCBcf4WQJFq
LJaQzEiLaudCLBM+zOocHJvFhXid5LdFgyVUW/EkZD2iYbyY5rPoby+hkOO/3Xc=
=stZ4
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
