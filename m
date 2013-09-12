From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal Management updates for v3.12-rc1
Date: Thu, 12 Sep 2013 16:22:59 +0800
Message-ID: <1378974179.9109.3.camel@rzhang-lenovo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:42889 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753348Ab3ILIVU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 12 Sep 2013 04:21:20 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pm <linux-pm@vger.kernel.org>

Hi, Linus,

Please pull from the git repository at

  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

to receive Thermal updates for v3.12 with top-most commit
50e66c7ed8a1cd7e933628f9f5y2ycf2617394adf5a

  drivers: thermal: add check when unregistering cpu cooling (2013-09-03 09:10:34 -0400)

on top of commit 584d88b2cd3b60507e708d2452651e4d3caa1b81:

  Merge branch 'for-next' of git://git.samba.org/sfrench/cifs-2.6 (2013-08-12 15:02:53 -0700)


We have a lot of SOC changes and a few thermal core fixes this time.

The biggest change is about exynos thermal driver restructure.
The patch set adds TMU(Thermal management Unit) driver support for
exynos5440 platform. There are 3 instances of the TMU controllers so
necessary cleanup/re-structure is done to handle multiple thermal zone.

The next biggest change is the introduction of the imx thermal driver.
It adds the imx thermal support using Temperature Monitor (TEMPMON)
block found on some Freescale i.MX SoCs.  The driver uses syscon regmap
interface to access TEMPMON control registers and calibration data, and
supports cpufreq as the cooling device.

Highlights:

- restructure exynos thermal driver.

- introduce new imx thermal driver.

- fix a bug in thermal core, which powers on the fans unexpectedly
  after resume from suspend.

Thanks,
Rui
----------------------------------------------------------------
Amit Daniel Kachhap (28):
      thermal: exynos: Moving exynos thermal files into samsung directory
      thermal: exynos: Use ARCH_HAS_BANDGAP config to know the supported soc's
      thermal: exynos: Remove un-necessary CPU_THERMAL dependency
      thermal: exynos: Bifurcate exynos thermal common and tmu controller code
      thermal: exynos: Rename exynos_thermal.c to exynos_tmu.c
      thermal: exynos: Move exynos_thermal.h from include/* to driver/* folder
      thermal: exynos: Bifurcate exynos tmu driver and configuration data
      thermal: exynos: Add missing definations and code cleanup
      thermal: exynos: Add extra entries in the tmu platform data
      thermal: exynos: Move register definitions from driver to data file
      thermal: exynos: Support thermal tripping
      thermal: exynos: Fix to clear only the generated interrupts
      thermal: exynos: Add support for instance based register/unregister
      thermal: exynos: Modify private_data to appropriate name driver_data
      thermal: exynos: Return success even if no cooling data supplied
      thermal: exynos: Make the zone handling use trip information
      thermal: exynos: Remove non DT based support
      thermal: exynos: Add support to handle many instances of TMU
      thermal: exynos: Add TMU features to check instead of using SOC type
      thermal: exynos: use device resource management infrastructure
      thermal: exynos: Add support to access common register for multistance
      thermal: exynos: Add driver support for exynos5440 TMU sensor
      thermal: exynos: Add thermal configuration data for exynos5440 TMU sensor
      thermal: exynos: Fix to set the second point correction value
      thermal: exynos: Add hardware mode thermal calibration support
      thermal: exynos: Support for TMU regulator defined at device tree
      ARM: dts: thermal: exynos: Add documentation for Exynos SoC thermal bindings
      Documentation: thermal: Explain the exynos thermal driver model

Eduardo Valentin (6):
      thermal: step_wise: return instance->target by default
      thermal: hwmon: move hwmon support to single file
      drivers: thermal: parent virtual hwmon with thermal zone
      drivers: thermal: make usage of CONFIG_THERMAL_HWMON optional
      thermal: thermal_core: allow binding with limits on bind_params
      drivers: thermal: add check when unregistering cpu cooling

Lan Tianyu (1):
      Thermal/cpu_cooling: Return directly for the cpu out of allowed_cpus in the cpufreq_thermal_notifier()

Naveen Krishna Chatradhi (1):
      thermal: exynos_tmu: fix wrong error check for mapped memory

Philipp Zabel (2):
      thermal: imx: dynamic passive and SoC specific critical trip points
      thermal: imx: implement thermal alarm interrupt handling

Ranganath Krishnan (3):
      thermal: ti-soc-thermal: Initialize counter_delay field for TI DRA752 sensors
      thermal: ti-soc-thermal: Set the bandgap mask counter delay value
      thermal: ti-soc-thermal: Ensure to compute thermal trend

Sachin Kamat (3):
      thermal: exynos: Fix typos in Kconfig
      thermal: exynos: Fix potential NULL pointer dereference
      thermal: exynos: Clean up non-DT remnants

Shawn Guo (2):
      thermal: add imx thermal driver support
      thermal: step_wise: cdev only needs update on a new target state

Zhang Rui (4):
      Merge branch 'for_3.12/exynos' of git://git.kernel.org/.../evalenti/linux-soc-thermal into exynos
      Merge branch 'for_3.12/imx' of git://git.kernel.org/.../evalenti/linux-soc-thermal into imx
      Merge branches 'exynos', 'imx' and 'fixes' of .git into next
      Merge branch 'fixes' of .git into next

 .../devicetree/bindings/thermal/exynos-thermal.txt |   55 +
 .../devicetree/bindings/thermal/imx-thermal.txt    |   17 +
 Documentation/thermal/exynos_thermal               |   43 +-
 Documentation/thermal/sysfs-api.txt                |   12 +
 drivers/thermal/Kconfig                            |   33 +-
 drivers/thermal/Makefile                           |    6 +-
 drivers/thermal/cpu_cooling.c                      |    8 +-
 drivers/thermal/exynos_thermal.c                   | 1059 --------------------
 drivers/thermal/imx_thermal.c                      |  541 ++++++++++
 drivers/thermal/samsung/Kconfig                    |   18 +
 drivers/thermal/samsung/Makefile                   |    7 +
 drivers/thermal/samsung/exynos_thermal_common.c    |  432 ++++++++
 drivers/thermal/samsung/exynos_thermal_common.h    |  107 ++
 drivers/thermal/samsung/exynos_tmu.c               |  762 ++++++++++++++
 drivers/thermal/samsung/exynos_tmu.h               |  311 ++++++
 drivers/thermal/samsung/exynos_tmu_data.c          |  250 +++++
 drivers/thermal/samsung/exynos_tmu_data.h          |  155 +++
 drivers/thermal/step_wise.c                        |   32 +-
 drivers/thermal/thermal_core.c                     |  282 +-----
 drivers/thermal/thermal_hwmon.c                    |  269 +++++
 drivers/thermal/thermal_hwmon.h                    |   49 +
 .../thermal/ti-soc-thermal/dra752-thermal-data.c   |    5 +
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        |    6 +-
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |    7 +
 include/linux/platform_data/exynos_thermal.h       |  119 ---
 include/linux/thermal.h                            |   18 +
 26 files changed, 3133 insertions(+), 1470 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/exynos-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/imx-thermal.txt
 delete mode 100644 drivers/thermal/exynos_thermal.c
 create mode 100644 drivers/thermal/imx_thermal.c
 create mode 100644 drivers/thermal/samsung/Kconfig
 create mode 100644 drivers/thermal/samsung/Makefile
 create mode 100644 drivers/thermal/samsung/exynos_thermal_common.c
 create mode 100644 drivers/thermal/samsung/exynos_thermal_common.h
 create mode 100644 drivers/thermal/samsung/exynos_tmu.c
 create mode 100644 drivers/thermal/samsung/exynos_tmu.h
 create mode 100644 drivers/thermal/samsung/exynos_tmu_data.c
 create mode 100644 drivers/thermal/samsung/exynos_tmu_data.h
 create mode 100644 drivers/thermal/thermal_hwmon.c
 create mode 100644 drivers/thermal/thermal_hwmon.h
 delete mode 100644 include/linux/platform_data/exynos_thermal.h


