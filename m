From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v5 00/18] thermal: exynos: Thermal code rework to use device
 tree
Date: Mon, 19 Jan 2015 12:20:44 +0100
Message-ID: <1421666462-7606-1-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:57848 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbbASLV2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 19 Jan 2015 06:21:28 -0500
In-reply-to: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>

1. Introduction

Following patches aim to clean up the current implementation of the thermal
framework on Exynos devices.

The main goal was to use a generic code for reading thermal configuration
(of-thermal.c). Due to that redundant exynos_thermal_common.[h|c] files
were removed.

Around 400 lines of code (LOC) were removed directly by this patch, which
is around 20% of the Exynos thermal code base.

This work should NOT bring any functional changes to Exynos thermal 
subsystem.

2. Patch-set structure

Then the cpu_cooling functionality has been preserved to allow cooling
devices by reducing operating frequency. Definition of trip points and
cpufreq's cooling properties were moved to device tree.

Then the rework of the way in which configuration data is provided to
the Exynos thermal subsystem was performed. Now device tree is used for
configuration.

3. Dead code removal

Thermal support for some SoCs, previously available in the exynos_tmu_data.c 
file, was removed since, as of (almost) 3.19-rc3, they didn't have TMU bindings.

Moreover, support for cpu_cooling devices was preserved only on those
SoCs which had available and working cpufreq driver.

4. Testing

Test devices:
- Exynos4210 - Trats (TMU zone + cpu_cooling)
- Exynos4412 - Trats2/Odroid U3 (TMU zone + cpu_cooling)
- Exynos5250 - Arndale (TMU zone + cpu_cooling)
- Exynos5420 - Arndale-octa (only TMU zones)

Unfortunately, I don't posses Exynos5440 for testing. Its functionality
has been preserved in the code, but not tested on the hardware. I would
be grateful for help in testing.


5. This work apply on the following tree:

kernel.org: 'linux-soc-thermal/next' - Eduardo Velentin's tree
SHA1: 1813d80874699145f04af6b05ebab0a6419001fb


Lukasz Majewski (18):
  thermal: exynos: cosmetic: Correct comment format
  thermal: exynos: Provide thermal_exynos.h file to be included in
    device tree files
  arm: dts: trats: Enable TMU on the Exynos4210 trats device
  arm: dts: odroid: Add LDO10 regulator node necessary for TMU on Odroid
  arm: dts: odroid: Enable TMU at Exynos4412 based Odroid U3 device
  arm: dts: Adding CPU cooling binding for Exynos SoCs
  thermal: exynos: Modify exynos thermal code to use device tree for cpu
    cooling configuration
  thermal: exynos: dts: Add default definition of the TMU sensor
    parameter
  dts: Documentation: Extending documentation entry for exynos-thermal
  thermal: dts: Default trip points definition for Exynos5420 SoCs
  thermal: exynos: dts: Define default thermal-zones for Exynos4
  thermal: dts: exynos: Trip points and sensor configuration data for
    Exynos5440
  dts: Documentation: Update exynos-thermal.txt example for Exynos5440
  thermal: exynos: dts: Provide device tree bindings identical to the
    one in exynos_tmu_data.c
  thermal: samsung: core: Exynos TMU rework to use device tree for
    configuration
  thermal: exynos: Remove exynos_thermal_common.[c|h] files
  thermal: exynos: Remove exynos_tmu_data.c file
  thermal: exynos: Remove not needed exynos_tmu_init_data declarations
    from exynos_tmu.h

 .../devicetree/bindings/thermal/exynos-thermal.txt |  17 +
 arch/arm/boot/dts/exynos3250.dtsi                  |   2 +
 arch/arm/boot/dts/exynos4-cpu-thermal.dtsi         |  52 +++
 arch/arm/boot/dts/exynos4.dtsi                     |   4 +
 arch/arm/boot/dts/exynos4210-trats.dts             |  19 +
 arch/arm/boot/dts/exynos4210.dtsi                  |  30 +-
 arch/arm/boot/dts/exynos4212.dtsi                  |   5 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |  27 ++
 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi  |  24 ++
 arch/arm/boot/dts/exynos4412-trats2.dts            |  15 +
 arch/arm/boot/dts/exynos4412.dtsi                  |   5 +-
 arch/arm/boot/dts/exynos4x12.dtsi                  |   1 +
 arch/arm/boot/dts/exynos5250.dtsi                  |  29 +-
 arch/arm/boot/dts/exynos5420-trip-points.dtsi      |  35 ++
 arch/arm/boot/dts/exynos5420.dtsi                  |  28 ++
 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi  |  24 ++
 arch/arm/boot/dts/exynos5440-trip-points.dtsi      |  25 ++
 arch/arm/boot/dts/exynos5440.dtsi                  |  18 +
 drivers/cpufreq/exynos-cpufreq.c                   |  30 +-
 drivers/thermal/samsung/Makefile                   |   2 -
 drivers/thermal/samsung/exynos_thermal_common.c    | 427 ---------------------
 drivers/thermal/samsung/exynos_thermal_common.h    | 106 -----
 drivers/thermal/samsung/exynos_tmu.c               | 348 +++++++++++------
 drivers/thermal/samsung/exynos_tmu.h               |  76 +---
 drivers/thermal/samsung/exynos_tmu_data.c          | 264 -------------
 include/dt-bindings/thermal/thermal_exynos.h       |  28 ++
 26 files changed, 632 insertions(+), 1009 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos4-cpu-thermal.dtsi
 create mode 100644 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
 create mode 100644 arch/arm/boot/dts/exynos5420-trip-points.dtsi
 create mode 100644 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi
 create mode 100644 arch/arm/boot/dts/exynos5440-trip-points.dtsi
 delete mode 100644 drivers/thermal/samsung/exynos_thermal_common.c
 delete mode 100644 drivers/thermal/samsung/exynos_thermal_common.h
 delete mode 100644 drivers/thermal/samsung/exynos_tmu_data.c
 create mode 100644 include/dt-bindings/thermal/thermal_exynos.h

-- 
2.0.0.rc2

