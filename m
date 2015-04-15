From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal-SoC management updates for v4.1-rc1
Date: Tue, 14 Apr 2015 22:48:20 -0700
Message-ID: <20150415054819.GA16396@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, lklm@localhost.localdomain
List-Id: linux-pm@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Rui,

Please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal linus

to receive Thermal-SoC Management updates for v4.1-rc1 with top-most

55920e072776533fd314fb3d9b69c866ed90b3df:

  thermal: exynos: Add the support for Exynos5433 TMU (2015-04-14 22:31:17 -0700)

on top of commit f8b3d8a5af7559a58613384cd23fc03a3c787acf:

  Merge tag 'usb-4.0-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb (2015-04-04 12:26:28 -0700)

Specifics:
- Exynos thermal driver learns how to handle Exynos5433 TMU. Thanks to Chanwoo C.;
- Thermal Framework now supports QPNP PMIC temperature alarm as a new thermal
  driver. Thanks to Ivan T. I.;
- TI thermal driver now has a better implementation for EOCZ bit. Thanks to Pavel M.;
- Thermal Framework now has learned several new capabilities:
  . use power estimates
  . compute weights with relative integers instead of percentages
  . allow governors to have private data in thermal zones
  . export thermal zone parameters through sysfs
  Thanks to the ARM thermal team (Javi M., Punit A., and KP).
- Thermal Framework earns a new thermal governor: power allocator. First in kernel
  closed loop PI(D) controller for thermal control. Thanks to ARM thermal team.
- OF thermal now allows thermal zones to have sustainable power HW specification.
  Thanks to Punit.


BR,

Eduardo Valentin
----------------------------------------------------------------
Chanwoo Choi (1):
      thermal: exynos: Add the support for Exynos5433 TMU

Ivan T. Ivanov (1):
      thermal: Add QPNP PMIC temperature alarm driver

Javi Merino (13):
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

 .../bindings/thermal/qcom-spmi-temp-alarm.txt      |  57 ++
 .../devicetree/bindings/thermal/thermal.txt        |   9 +
 Documentation/thermal/cpu-cooling-api.txt          | 156 +++++-
 Documentation/thermal/power_allocator.txt          | 247 +++++++++
 Documentation/thermal/sysfs-api.txt                |  83 ++-
 drivers/acpi/thermal.c                             |   9 +-
 drivers/platform/x86/acerhdf.c                     |   3 +-
 drivers/thermal/Kconfig                            |  36 ++
 drivers/thermal/Makefile                           |   2 +
 drivers/thermal/cpu_cooling.c                      | 585 ++++++++++++++++++++-
 drivers/thermal/db8500_thermal.c                   |   2 +-
 drivers/thermal/fair_share.c                       |  41 +-
 drivers/thermal/imx_thermal.c                      |   3 +-
 drivers/thermal/of-thermal.c                       |  15 +-
 drivers/thermal/power_allocator.c                  | 538 +++++++++++++++++++
 drivers/thermal/qcom-spmi-temp-alarm.c             | 309 +++++++++++
 drivers/thermal/samsung/exynos_tmu.c               | 187 ++++++-
 drivers/thermal/samsung/exynos_tmu.h               |   1 +
 drivers/thermal/thermal_core.c                     | 310 ++++++++++-
 drivers/thermal/thermal_core.h                     |  11 +
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        | 104 ++--
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |   5 +-
 drivers/thermal/x86_pkg_temp_thermal.c             |   2 +-
 include/linux/cpu_cooling.h                        |  39 ++
 include/linux/thermal.h                            |  86 ++-
 include/trace/events/thermal.h                     |  58 ++
 include/trace/events/thermal_power_allocator.h     |  87 +++
 27 files changed, 2850 insertions(+), 135 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
 create mode 100644 Documentation/thermal/power_allocator.txt
 create mode 100644 drivers/thermal/power_allocator.c
 create mode 100644 drivers/thermal/qcom-spmi-temp-alarm.c
 create mode 100644 include/trace/events/thermal_power_allocator.h

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVLfubAAoJEMLUO4d9pOJWOnoH/AjT/vH9Ysplf0ydzpLpluvY
elQmKeMTsJRtBuSkL5VWswrFKYyy3dhzxluiTGESJaY5+wZBvfrEUCOSV2L2SjcY
y4OJz0EW/jspwiW4AcIgRrePdP8gahcce/zp4KqeJ7mZxiRIDVBA7Hyt+0dqZsat
UWlY+psjcjO5cV+gPoH6QyUJ99RQJDQO3JW4cX/dPpoeyTmrWFhi/WuP4fAjvnen
yV2po9Hd52H6fNm+Pxzqp6HJBqD8Yg0CvHUXfYMV//ht/vTMALRov9Djn6IZGjhz
6mncgyOSqNPM+blerB0fEde7DILikGybCgrxMCWDdCV7e7lcVNSokAChkFxVxyU=
=ZjbH
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
