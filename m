From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [GIT PULL 3/3] soc-thermal: refactoring exynos thermal driver (for 3.12)
Date: Mon, 8 Jul 2013 11:17:53 -0400
Message-ID: <1373296673-19295-3-git-send-email-eduardo.valentin@ti.com>
References: <1373296673-19295-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37824 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752104Ab3GHPSx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 8 Jul 2013 11:18:53 -0400
In-Reply-To: <1373296673-19295-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, Jonghwa Lee <jonghwa3.lee@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>

Rui,

Please pull the following changes for 3.12. This is a major rework of the
Exynos thermal driver by Amit D. Kachhap. We have been working on this
for a while and the code has really improved. Thanks Amit for this.

The changelog is as it follows:

. Several fixes on Exynos thermal driver.
. Refactoring Exynos thermal driver to split code and data.
. Support for multiple thermal instances on Exynos thermal driver.
. Add thermal support for Exynos 5440 TMU sensor.
. Updated documentation of Exynos thermal driver.

Cc: Jonghwa Lee <jonghwa3.lee@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>

This pull request contains obviously only the part that touches the thermal area.
Platform code changes were already submitted to the corresponding trees.

The following changes since commit 9d1968fdabc69981ea98ea82082de1cc12a60385:

  Merge branch 'cpu-package-thermal' of .git into next (2013-06-18 07:26:49 +0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git for_3.12/exynos

for you to fetch changes up to 72a23f5881b4cf073ebc96869e6c38f4619ec3c9:

  Documentation: thermal: Explain the exynos thermal driver model (2013-07-08 11:06:52 -0400)

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

 .../devicetree/bindings/thermal/exynos-thermal.txt |   55 +
 Documentation/thermal/exynos_thermal               |   43 +-
 drivers/thermal/Kconfig                            |   13 +-
 drivers/thermal/Makefile                           |    2 +-
 drivers/thermal/exynos_thermal.c                   | 1058 --------------------
 drivers/thermal/samsung/Kconfig                    |   18 +
 drivers/thermal/samsung/Makefile                   |    7 +
 drivers/thermal/samsung/exynos_thermal_common.c    |  432 ++++++++
 drivers/thermal/samsung/exynos_thermal_common.h    |  107 ++
 drivers/thermal/samsung/exynos_tmu.c               |  752 ++++++++++++++
 drivers/thermal/samsung/exynos_tmu.h               |  309 ++++++
 drivers/thermal/samsung/exynos_tmu_data.c          |  250 +++++
 drivers/thermal/samsung/exynos_tmu_data.h          |  155 +++
 include/linux/platform_data/exynos_thermal.h       |  119 ---
 14 files changed, 2125 insertions(+), 1195 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/exynos-thermal.txt
 delete mode 100644 drivers/thermal/exynos_thermal.c
 create mode 100644 drivers/thermal/samsung/Kconfig
 create mode 100644 drivers/thermal/samsung/Makefile
 create mode 100644 drivers/thermal/samsung/exynos_thermal_common.c
 create mode 100644 drivers/thermal/samsung/exynos_thermal_common.h
 create mode 100644 drivers/thermal/samsung/exynos_tmu.c
 create mode 100644 drivers/thermal/samsung/exynos_tmu.h
 create mode 100644 drivers/thermal/samsung/exynos_tmu_data.c
 create mode 100644 drivers/thermal/samsung/exynos_tmu_data.h
 delete mode 100644 include/linux/platform_data/exynos_thermal.h
