From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v2 00/17] thermal: exynos: Thermal code rework to use device
 tree
Date: Wed, 10 Dec 2014 13:09:39 +0100
Message-ID: <1418213396-743-1-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-pm@vger.kernel.org

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

Patch series end with removing exynos5250/exynos3250 TMU compatibles.
Both SoCs have thermal management unit (TMU) compatible with the one first 
introduced at Exynos4412.

3. Dead code removal

Thermal support for some SoCs, previously available in the exynos_tmu_data.c 
file, was removed since, as of (almost) 3.19-rc1, they didn't have TMU bindings.

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
SHA1: c42c7a44c7a543dcb388c1ee1a798e6ed76ad8cf


Lukasz Majewski (17):
  thermal: exynos: cosmetic: Correct comment format
  thermal: exynos: Provide thermal_exynos.h file to be included in
    device tree files
  thermal: dts: trats: Enable TMU on the Exynos4210 trats device
  thermal: dts: exynos: Add LD010 regulator node necessary for TMU on
    Odroid
  thermal: dts: Enable TMU at Exynos4412 based Odroid U3 device
  thermal: cpu_cooling: dts: Define device tree bindings for Exynos cpu
    cooling functionality
  thermal: cpu_cooling: Modify exynos thermal code to use device tree
    for cpu cooling configuration
  thermal: exynos: dts: Add default definition of the TMU sensor
    parameter
  thermal: dts: Default trip points definition for Exynos5420 SoCs
  thermal: exynos: dts: Define default thermal-zones for Exynos4
  thermal: dts: exynos: Trip points and sensor configuration data for
    Exynos5440
  thermal: exynos: dts: Provide device tree bindings identical to one in
    exynos_tmu_data.c
  thermal: samsung: core: Exynos TMU rework to use device tree for
    configuration
  thermal: exynos: Remove exynos_thermal_common.[c|h] files
  thermal: exynos: Remove exynos_tmu_data.c file
  thermal: exynos: Make Exynos5250 TMU compatible with Exynos4412
  thermal: exynos: Make Exynos3250 TMU compatible with Exynos4412

 arch/arm/boot/dts/exynos3250.dtsi                 |   6 +-
 arch/arm/boot/dts/exynos4-cpu-thermal.dtsi        |  52 +++
 arch/arm/boot/dts/exynos4.dtsi                    |   5 +
 arch/arm/boot/dts/exynos4210-trats.dts            |  19 +
 arch/arm/boot/dts/exynos4210.dtsi                 |  43 ++-
 arch/arm/boot/dts/exynos4212.dtsi                 |  20 +
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi   |  27 ++
 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi |  24 ++
 arch/arm/boot/dts/exynos4412-trats2.dts           |  15 +
 arch/arm/boot/dts/exynos4412.dtsi                 |  32 ++
 arch/arm/boot/dts/exynos4x12.dtsi                 |   3 +
 arch/arm/boot/dts/exynos5250.dtsi                 |  29 +-
 arch/arm/boot/dts/exynos5420-trip-points.dtsi     |  35 ++
 arch/arm/boot/dts/exynos5420.dtsi                 |  33 ++
 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi |  25 ++
 arch/arm/boot/dts/exynos5440-trip-points.dtsi     |  25 ++
 arch/arm/boot/dts/exynos5440.dtsi                 |  18 +
 drivers/cpufreq/exynos-cpufreq.c                  |  23 +-
 drivers/thermal/samsung/Makefile                  |   2 -
 drivers/thermal/samsung/exynos_thermal_common.c   | 427 ----------------------
 drivers/thermal/samsung/exynos_thermal_common.h   | 106 ------
 drivers/thermal/samsung/exynos_tmu.c              | 337 ++++++++++-------
 drivers/thermal/samsung/exynos_tmu.h              |  80 +---
 drivers/thermal/samsung/exynos_tmu_data.c         | 264 -------------
 include/dt-bindings/thermal/thermal_exynos.h      |  37 ++
 25 files changed, 669 insertions(+), 1018 deletions(-)
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
