From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal Management updates for 3.20-rc1 #2
Date: Fri, 20 Feb 2015 09:36:50 +0800
Message-ID: <1424396210.2885.25.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:22292 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753017AbbBTBgy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 19 Feb 2015 20:36:54 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, "Zhang, Rui" <rui.zhang@intel.com>

Hi, Linus,

Please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git fixes

to receive Thermal SoC Management updates for v3.20 with top-most

6c247393cfdd6695717f80ff31f9fd9af8c2c525:

  thermal: exynos: Add TMU support for Exynos7 SoC (2015-01-31 15:20:45
-0400)

on top of commit b97f880c8342fd6e49a02c9ef7507a678722b2b3:

  Merge branch 'for-3.19-fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata (2015-01-21
07:54:16 +1200)

Specifics:

- Exynos thermal driver refactoring. Several cleanups, code
optimization, unused symbols removal, and unused feature removal in
Exynos thermal driver. Thanks Lukasz for this effort.
- Exynos thermal driver support to OF thermal. After the code
refactoring, the driver earned the support to OF thermal. Chip thermal
data were moved from driver code to DTS, reducing the code footprint.
Thanks Lukasz for this.
- After receiving the OF thermal support, the exynos thermal driver now
must allow modular build. Thanks Arnd for detecting, reporting and
fixing this.
- Exynos thermal driver support to Exynos 7 SoC. Thanks Abhilash for
this.
- Accurate temperature reporting on Rockchip thermal driver, thanks to
Caesar.
- Fix on how OF thermal enables its zones, thanks Lukasz for fixing.
- Fixes in OF thermal examples under Documentation/. Thanks Srinivas for
fixing.

Thanks,
rui

----------------------------------------------------------------
Abhilash Kesavan (2):
      dts: Documentation: Add documentation for Exynos7 SoC thermal
bindings
      thermal: exynos: Add TMU support for Exynos7 SoC

Arnd Bergmann (1):
      cpufreq: exynos: allow modular build

Caesar Wang (1):
      thermal: rockchip: make temperature reporting much more accurate

Lukasz Majewski (12):
      thermal: of: Enable thermal_zoneX when sensor is correctly added
      thermal: exynos: cosmetic: Correct comment format
      thermal: exynos: Provide thermal_exynos.h file to be included in
device tree files
      thermal: exynos: Modify exynos thermal code to use device tree for
cpu cooling configuration
      cpufreq: exynos: Use device tree to determine if cpufreq cooling
should be registered
      dts: Documentation: Extending documentation entry for
exynos-thermal
      dts: Documentation: Update exynos-thermal.txt example for
Exynos5440
      thermal: samsung: core: Exynos TMU rework to use device tree for
configuration
      thermal: exynos: Remove exynos_thermal_common.[c|h] files
      thermal: exynos: Remove exynos_tmu_data.c file
      thermal: Kconfig: Remove config for not used EXYNOS_THERMAL_CORE
      thermal: exynos: Correct sanity check at exynos_report_trigger()
function

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
 drivers/thermal/samsung/exynos_thermal_common.c    | 427
----------------
 drivers/thermal/samsung/exynos_thermal_common.h    | 106 ----
 drivers/thermal/samsung/exynos_tmu.c               | 553
++++++++++++++++-----
 drivers/thermal/samsung/exynos_tmu.h               |  77 +--
 drivers/thermal/samsung/exynos_tmu_data.c          | 264 ----------
 include/dt-bindings/thermal/thermal_exynos.h       |  28 ++
 15 files changed, 596 insertions(+), 1090 deletions(-)
 delete mode 100644 drivers/thermal/samsung/exynos_thermal_common.c
 delete mode 100644 drivers/thermal/samsung/exynos_thermal_common.h
 delete mode 100644 drivers/thermal/samsung/exynos_tmu_data.c
 create mode 100644 include/dt-bindings/thermal/thermal_exynos.h

