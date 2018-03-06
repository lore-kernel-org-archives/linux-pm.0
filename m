From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 00/12] thermal: exynos: sanitize DeviceTree support
Date: Tue, 06 Mar 2018 15:43:43 +0100
Message-ID: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
References: <CGME20180306144427epcas1p3bd260e382c61ab5176a50aa95084b542@epcas1p3.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Hi,

Values passed through DT properties specific to Exynos thermal
driver ("samsung,*") are SoC (not platform) specific so just
define them in struct exynos_tmu_data instance (or just use
constants where values are identical for all SoCs) and remove
"samsung," DT properties altogether.

The patchset should not cause any functionality changes.  This
means that unless there are some bugs in the patches itself there
should be no behavior changes for the driver (this also includes
lack of changes in the way hardware is accessed by the driver).

Tested on Exynos5422 based Odroid-XU3 Lite board.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (12):
  thermal: exynos: remove unused type field from struct
    exynos_tmu_platform_data
  thermal: exynos: remove parsing of samsung,tmu_default_temp_offset
    property
  thermal: exynos: remove parsing of
    samsung,tmu_[first,second]_point_trim properties
  thermal: exynos: remove parsing of samsung,tmu_noise_cancel_mode
    property
  thermal: exynos: remove parsing of samsung,tmu[_min,_max]_efuse_value
    properties
  thermal: exynos: remove parsing of samsung,tmu_reference_voltage
    property
  thermal: exynos: remove parsing of samsung,tmu_gain property
  thermal: exynos: remove parsing of samsung,tmu_cal_type property
  thermal: exynos: remove separate exynos_tmu.h header file
  ARM: dts: remove no longer needed samsung thermal properties
  dt-bindings: thermal: remove no longer needed samsung thermal
    properties
  thermal: exynos: remove separate thermal_exynos.h header file

 .../devicetree/bindings/thermal/exynos-thermal.txt |  23 +--
 arch/arm/boot/dts/exynos3250.dtsi                  |   2 +-
 arch/arm/boot/dts/exynos4.dtsi                     |   2 +-
 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi  |  20 ---
 arch/arm/boot/dts/exynos5250.dtsi                  |   2 +-
 arch/arm/boot/dts/exynos5410.dtsi                  |   8 +-
 arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi  |  21 ---
 arch/arm/boot/dts/exynos5420.dtsi                  |  10 +-
 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi  |  20 ---
 arch/arm/boot/dts/exynos5440.dtsi                  |   6 +-
 .../dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi |  20 ---
 .../dts/exynos/exynos5433-tmu-sensor-conf.dtsi     |  19 ---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         |  10 +-
 .../boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi   |  21 ---
 arch/arm64/boot/dts/exynos/exynos7.dtsi            |   2 +-
 drivers/thermal/samsung/exynos_tmu.c               | 181 +++++++++++----------
 drivers/thermal/samsung/exynos_tmu.h               |  75 ---------
 include/dt-bindings/thermal/thermal_exynos.h       |  28 ----
 18 files changed, 124 insertions(+), 346 deletions(-)
 delete mode 100644 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
 delete mode 100644 arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi
 delete mode 100644 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi
 delete mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi
 delete mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi
 delete mode 100644 arch/arm64/boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi
 delete mode 100644 drivers/thermal/samsung/exynos_tmu.h
 delete mode 100644 include/dt-bindings/thermal/thermal_exynos.h

-- 
1.9.1
