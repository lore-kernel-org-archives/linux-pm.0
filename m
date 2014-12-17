From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal Management updates for 3.19-rc1
Date: Wed, 17 Dec 2014 17:05:45 +0800
Message-ID: <1418807145.5983.27.camel@rzhang1-toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11956 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254AbaLQJFx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 17 Dec 2014 04:05:53 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

Hi, Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

to receive Thermal Management changes for 3.19-rc1 with top-most commit
2707dbd09a859b7205917f9baf9d0192944ac46c:

  Merge branches 'thermal-core-fix', 'thermal-soc' and 'thermal-int340x'
into next (2014-12-13 12:25:19 +0800)

on top of commit 009d0431c3914de64666bec0d350e54fdd59df6a:

  Linux 3.18-rc7 (2014-11-30 16:42:27 -0800)


Specifics:

- of-thermal extension to allow drivers to register and use its
functionality in a better way, without exploiting thermal core. From:
Lukasz Majewski.
- Fix a bug in intel_soc_dts_thermal driver which calls a sleep function
in interrupt handler. From: Maurice Petallo.
- add a thermal UAPI header file for exporting the thermal generic
netlink information to user-space. From: Florian Fainelli.
- First round of refactoring in Exynos driver. Bartlomiej and Lukasz are
attempting to make it lean and easier to understand.
- New thermal driver for Rockchip (rk3288), with support for DT thermal.
>From Caesar Wang.
- New thermal driver for Nvidia, Tegra124 SOCTHERM driver, with support
for DT thermal. From: Mikko Perttunen.
- New cooling device, based on common clock framework. from: Eduardo
Valentin.
- a couple of small fixes in thermal core framework. From: Srinivas
Pandruvada, Javi Merino, Luis Henriques.
- Dropping Armada A375-Z1 SoC thermal support as the chip is not
in the market, armada folks decided to drop its support.
- a couple of small fixes and cleanups in int340x thermal driver.

thanks,
rui

----------------------------------------------------------------

Bartlomiej Zolnierkiewicz (33):
      thermal: exynos: remove needless triminfo_data abstraction
      thermal: exynos: remove needless tmu_status abstraction
      thermal: exynos: remove needless threshold_temp abstraction
      thermal: exynos: remove needless triminfo_ctrl abstraction
      thermal: exynos: remove needless test_mux_addr_shift abstraction
      thermal: exynos: remove needless therm_trip_[mode,mask]_shift
abstractions
      thermal: exynos: remove needless therm_trip_en_shift abstraction
      thermal: exynos: remove needless emul_temp_shift abstraction
      thermal: exynos: remove needless emul_time_shift abstraction
      thermal: exynos: replace tmu_irqstatus check by Exynos5440 one
      thermal: exynos: replace tmu_pmin check by Exynos5440 one
      thermal: exynos: simplify HW_TRIP level setting
      thermal: exynos: replace threshold_falling check by Exynos SoC
type one
      thermal: exynos: remove TMU_SUPPORT_READY_STATUS flag
      thermal: exynos: remove TMU_SUPPORT_TRIM_RELOAD flag
      thermal: exynos: add sanitize_temp_error() helper
      thermal: exynos: add get_th_reg() helper
      thermal: exynos: add ->tmu_initialize method
      thermal: exynos: add get_con_reg() helper
      thermal: exynos: add ->tmu_control method
      thermal: exynos: add ->tmu_read method
      thermal: exynos: add get_emul_con_reg() helper
      thermal: exynos: add ->tmu_set_emulation method
      thermal: exynos: add ->tmu_clear_irqs method
      thermal: exynos: remove TMU_SUPPORT_FALLING_TRIP flag
      thermal: exynos: remove TMU_SUPPORT_EMUL_TIME flag
      thermal: exynos: remove TMU_SUPPORT_EMULATION flag
      thermal: exynos: remove TMU_SUPPORT_ADDRESS_MULTIPLE flag
      thermal: exynos: remove TMU_SUPPORT_MULTI_INST flag
      thermal: exynos: remove test_mux pdata field
      thermal: exynos: remove SoC type ifdefs
      thermal: exynos: remove __EXYNOS5420_TMU_DATA macro
      thermal: exynos: remove exynos_tmu_data.h include

Caesar Wang (2):
      dt-bindings: document Rockchip thermal
      thermal: rockchip: add driver for thermal

Eduardo Valentin (2):
      thermal: introduce clock cooling device
      thermal: of: improve of-thermal sensor registration API

Ezequiel Garcia (1):
      thermal: armada: Remove support for A375-Z1 SoC

Florian Fainelli (1):
      thermal: provide an UAPI header file

Ilkka Koskinen (1):
      Thermal/int340x: Clear the error value of the last
acpi_bus_get_device() call

Jacob Pan (2):
      Thermal/int340x: avoid unnecessary pointer casting
      thermal/powerclamp: add id for braswell cpu

Javi Merino (1):
      thermal: lock the thermal zone when switching governors

Luis Henriques (1):
      thermal: Fix error path in thermal_init()

Lukasz Majewski (5):
      thermal: of: Extend of-thermal.c to provide number of trip points
      thermal: of: Extend of-thermal.c to provide check if trip point is
valid
      thermal: of: Rename struct __thermal_trip to struct thermal_trip
      thermal: of: Extend of-thermal to export table of trip points
      thermal: of: Extend current of-thermal.c code to allow setting
emulated temp

Markus Elfring (1):
      thermal: int3403: Delete a check before
thermal_zone_device_unregister()

Maurice Petallo (1):
      thermal: Intel SoC DTS: Don't do thermal zone update inside
spin_lock

Mikko Perttunen (4):
      of: Add bindings for nvidia,tegra124-soctherm
      ARM: tegra: Add soctherm and thermal zones to Tegra124 device tree
      ARM: tegra: Add thermal trip points for Jetson TK1
      thermal: Add Tegra SOCTHERM thermal management driver

Srinivas Pandruvada (2):
      thermal: core: ignore invalid trip temperature
      thermal/int3400: export uuids

Wu Fengguang (1):
      Thermal: fix platform_no_drv_owner.cocci warnings

Zhang Rui (3):
      Merge branch 'linus' of
git://git.kernel.org/.../evalenti/linux-soc-thermal into
eduardo-soc-thermal
      Merge branch 'eduardo-soc-thermal' into thermal-soc
      Merge branches 'thermal-core-fix', 'thermal-soc' and
'thermal-int340x' into next

 Documentation/devicetree/bindings/thermal/armada-thermal.txt   |   8 --
 Documentation/devicetree/bindings/thermal/rockchip-thermal.txt |  68
++++++++++++++
 Documentation/devicetree/bindings/thermal/tegra-soctherm.txt   |  53
+++++++++++
 MAINTAINERS                                                    |   1 +
 arch/arm/boot/dts/tegra124-jetson-tk1.dts                      |  44
+++++++++
 arch/arm/boot/dts/tegra124.dtsi                                |  47
++++++++++
 drivers/hwmon/lm75.c                                           |   9 +-
 drivers/hwmon/ntc_thermistor.c                                 |   6 +-
 drivers/hwmon/tmp102.c                                         |   6 +-
 drivers/thermal/Kconfig                                        |  32
+++++++
 drivers/thermal/Makefile                                       |   5 +
 drivers/thermal/armada_thermal.c                               |  20
----
 drivers/thermal/clock_cooling.c                                | 485
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/thermal/int340x_thermal/acpi_thermal_rel.c             |  12
++-
 drivers/thermal/int340x_thermal/int3400_thermal.c              |  80
+++++++++++++++-
 drivers/thermal/int340x_thermal/int3403_thermal.c              |   4 +-
 drivers/thermal/intel_powerclamp.c                             |   1 +
 drivers/thermal/intel_soc_dts_thermal.c                        |  12
++-
 drivers/thermal/of-thermal.c                                   | 148
+++++++++++++++++++++--------
 drivers/thermal/rockchip_thermal.c                             | 693
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/thermal/samsung/exynos_thermal_common.h                |   1 -
 drivers/thermal/samsung/exynos_tmu.c                           | 692
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------
 drivers/thermal/samsung/exynos_tmu.h                           | 123
++----------------------
 drivers/thermal/samsung/exynos_tmu_data.c                      | 239
++--------------------------------------------
 drivers/thermal/samsung/exynos_tmu_data.h                      | 159
-------------------------------
 drivers/thermal/tegra_soctherm.c                               | 476
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/thermal/thermal_core.c                                 |   8 +-
 drivers/thermal/thermal_core.h                                 |  18
++++
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c             |   8 +-
 include/dt-bindings/thermal/tegra124-soctherm.h                |  13
+++
 include/linux/clock_cooling.h                                  |  65
+++++++++++++
 include/linux/thermal.h                                        |  73
++++++++-------
 include/uapi/linux/Kbuild                                      |   1 +
 include/uapi/linux/thermal.h                                   |  35
+++++++
 34 files changed, 2787 insertions(+), 858 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
 create mode 100644
Documentation/devicetree/bindings/thermal/tegra-soctherm.txt
 create mode 100644 drivers/thermal/clock_cooling.c
 create mode 100644 drivers/thermal/rockchip_thermal.c
 delete mode 100644 drivers/thermal/samsung/exynos_tmu_data.h
 create mode 100644 drivers/thermal/tegra_soctherm.c
 create mode 100644 include/dt-bindings/thermal/tegra124-soctherm.h
 create mode 100644 include/linux/clock_cooling.h
 create mode 100644 include/uapi/linux/thermal.h


