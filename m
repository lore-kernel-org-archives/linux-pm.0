From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal Management updates for v3.11-rc1
Date: Wed, 10 Jul 2013 10:33:13 +0800
Message-ID: <1373423593.2122.22.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:29587 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755439Ab3GJCdS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 9 Jul 2013 22:33:18 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, eduardo <eduardo.valentin@ti.com>

Hi, Linus,

Please pull from the git repository at

  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

to receive Thermal Management updates for v3.11 with top-most commit
e8d39240d635ed9bcaddbec898b1c9f063c5dbb2:

  thermal: cpu_cooling: fix stub function

on top of commit c240a539df4e2d50f86e2f31813ff6b7334cd493:

  Merge tag 'trace-fixes-v3.10-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace

There are not too many changes this time, except two new platform
thermal drivers, ti-soc-thermal driver and  x86_pkg_temp_thermal driver,
and a couple of small fixes.

Highlights:

- move the ti-soc-thermal driver out of the staging tree to the thermal
tree.

- introduce the x86_pkg_temp_thermal driver. This driver registers CPU
digital temperature package level sensor as a thermal zone.

- small fixes/cleanups including removing redundant use of
platform_set_drvdata() and of_match_ptr for all platform thermal
drivers.

Thanks!

----------------------------------------------------------------
Andy Shevchenko (1):
      thermal: cut the spaces when user sets policy

Arnd Bergmann (1):
      thermal: cpu_cooling: fix stub function

Eduardo Valentin (12):
      thermal: introduce TI SoC thermal driver
      MAINTAINERS: update TI SoC thermal driver entry
      thermal: ti-soc-thermal: update DT reference for OMAP5430
      thermal: ti-soc-thermal: remove external heat while extrapolating
hotspot
      thermal: ti-soc-thermal: freeze FSM while computing trend
      thermal: ti-soc-thermal: remove usage of IS_ERR_OR_NULL
      thermal: ti-soc-thermal: add thermal data for DRA752 chips
      thermal: ti-soc-thermal: add dra752 chip to device table
      thermal: ti-soc-thermal: add DT example for DRA752 chip
      thermal: consider emul_temperature while computing trend
      thermal: MAINTAINERS: Add git tree path for SoC specific updates
      thermal: ti-soc-thermal: use standard GPIO DT bindings

Jonghwa Lee (1):
      Thermal: core: Ask .get_trip_temp() to register thermal zone
device.

Laurent Pinchart (1):
      thermal: rcar: Fix typo in probe information message

Randy Dunlap (1):
      thermal: fix x86_pkg_temp_thermal.c build and Kconfig

Sachin Kamat (10):
      Thermal: armada_thermal: Remove redundant platform_set_drvdata()
      Thermal: dove_thermal: Remove redundant platform_set_drvdata()
      Thermal: exynos: Remove redundant platform_set_drvdata()
      Thermal: kirkwood: Remove redundant platform_set_drvdata()
      Thermal: rcar: Remove redundant platform_set_drvdata()
      Thermal: spear: Remove redundant platform_set_drvdata()
      Thermal: armada: Remove redundant use of of_match_ptr
      Thermal: dove: Remove redundant use of of_match_ptr
      Thermal: kirkwood: Remove redundant use of of_match_ptr
      Thermal: spear: Remove redundant use of of_match_ptr

Shawn Guo (1):
      thermal: cpu_cooling: fix 'descend' check in get_property()

Srinivas Pandruvada (3):
      x86, mcheck, therm_throt: Process package thresholds
      Thermal: CPU Package temperature thermal
      Thermal: Documentation for x86 package temperature thermal driver

Wolfram Sang (1):
      drivers/thermal: don't check resource with devm_ioremap_resource

Zhang Rui (6):
      Thermal: spear_thermal: convert to devm_ioremap_resource
      Thermal: don't check resource with devm_ioremap_resource
      Merge branches 'misc', 'drv_cleanup', 'devm-cleanup' and 'ti-soc'
of .git into next
      Merge branches 'for-rc' and 'ti-soc' of .git into next
      Merge branch 'cpu-package-thermal' of .git into next
      Merge branch 'cpu-package-thermal' of .git into next

 .../bindings/thermal}/ti_soc_thermal.txt           |   22 +-
 Documentation/thermal/x86_pkg_temperature_thermal  |   47 ++
 MAINTAINERS                                        |    5 +-
 arch/x86/include/asm/mce.h                         |    7 +
 arch/x86/kernel/cpu/mcheck/therm_throt.c           |   63 +-
 drivers/staging/Kconfig                            |    2 -
 drivers/staging/Makefile                           |    1 -
 drivers/thermal/Kconfig                            |   15 +
 drivers/thermal/Makefile                           |    3 +-
 drivers/thermal/armada_thermal.c                   |   13 +-
 drivers/thermal/cpu_cooling.c                      |    2 +-
 drivers/thermal/dove_thermal.c                     |   14 +-
 drivers/thermal/exynos_thermal.c                   |    8 -
 drivers/thermal/kirkwood_thermal.c                 |   10 +-
 drivers/thermal/rcar_thermal.c                     |   10 +-
 drivers/thermal/spear_thermal.c                    |   20 +-
 drivers/thermal/thermal_core.c                     |   11 +-
 .../{staging => thermal}/ti-soc-thermal/Kconfig    |   12 +
 .../{staging => thermal}/ti-soc-thermal/Makefile   |    1 +
 drivers/{staging => thermal}/ti-soc-thermal/TODO   |    0
 drivers/thermal/ti-soc-thermal/dra752-bandgap.h    |  280 +++++++++
 .../thermal/ti-soc-thermal/dra752-thermal-data.c   |  476
+++++++++++++++
 .../ti-soc-thermal/omap4-thermal-data.c            |    0
 .../ti-soc-thermal/omap4xxx-bandgap.h              |    0
 .../ti-soc-thermal/omap5-thermal-data.c            |    0
 .../ti-soc-thermal/omap5xxx-bandgap.h              |    0
 .../ti-soc-thermal/ti-bandgap.c                    |   36 +-
 .../ti-soc-thermal/ti-bandgap.h                    |    5 +
 .../ti-soc-thermal/ti-thermal-common.c             |   43 +-
 .../ti-soc-thermal/ti-thermal.h                    |    6 +
 drivers/thermal/x86_pkg_temp_thermal.c             |  642
++++++++++++++++++++
 include/linux/cpu_cooling.h                        |    4 +-
 32 files changed, 1647 insertions(+), 111 deletions(-)
 rename {drivers/staging/ti-soc-thermal =>
Documentation/devicetree/bindings/thermal}/ti_soc_thermal.txt (77%)
 create mode 100644 Documentation/thermal/x86_pkg_temperature_thermal
 rename drivers/{staging => thermal}/ti-soc-thermal/Kconfig (81%)
 rename drivers/{staging => thermal}/ti-soc-thermal/Makefile (80%)
 rename drivers/{staging => thermal}/ti-soc-thermal/TODO (100%)
 create mode 100644 drivers/thermal/ti-soc-thermal/dra752-bandgap.h
 create mode 100644 drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
 rename drivers/{staging => thermal}/ti-soc-thermal/omap4-thermal-data.c
(100%)
 rename drivers/{staging => thermal}/ti-soc-thermal/omap4xxx-bandgap.h
(100%)
 rename drivers/{staging => thermal}/ti-soc-thermal/omap5-thermal-data.c
(100%)
 rename drivers/{staging => thermal}/ti-soc-thermal/omap5xxx-bandgap.h
(100%)
 rename drivers/{staging => thermal}/ti-soc-thermal/ti-bandgap.c (98%)
 rename drivers/{staging => thermal}/ti-soc-thermal/ti-bandgap.h (99%)
 rename drivers/{staging => thermal}/ti-soc-thermal/ti-thermal-common.c
(91%)
 rename drivers/{staging => thermal}/ti-soc-thermal/ti-thermal.h (95%)
 create mode 100644 drivers/thermal/x86_pkg_temp_thermal.c

