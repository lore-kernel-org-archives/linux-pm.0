From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 00/14] thermal: exynos: pending fixes and cleanups
Date: Mon, 16 Apr 2018 12:11:51 +0200
Message-ID: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
References: <CGME20180416101225epcas2p42e345645d822cd869dbdb449becf1c7a@epcas2p4.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Hi Eduardo,

Per your request (https://marc.info/?l=linux-pm&m=152378232213070&w=2)
this patchset contains pending Exynos thermal driver fixes and cleanups.

It is based on:
- "[PATCH v3] thermal: exynos: Reading temperature makes sense only
  when TMU is turned on" from Marek Szyprowski
  (https://www.spinics.net/lists/linux-samsung-soc/msg62248.html)
- "[PATCH] thermal: exynos: Propagate error value from tmu_read()"
  from Marek Szyprowski
  (https://www.spinics.net/lists/linux-samsung-soc/msg62252.html)
- "[PATCH] thermal: exynos: Read soc_type from match data" from
  Maciej Purski
  (https://www.spinics.net/lists/linux-samsung-soc/msg62138.html)
- "[PATCH 00/12] thermal: exynos: sanitize DeviceTree support"
  (https://www.spinics.net/lists/linux-samsung-soc/msg62335.html)

Changes:
- fix warnings in "thermal: exynos: remove parsing of
  samsung,tmu_default_temp_offset property" patch
  (in a way suggested by Daniel Lezcano)
- split dts changes on ARM & ARM64 parts
  (as requested by Krzysztof Kozlowski)
- drop "dt-bindings: thermal: remove no longer needed samsung
  thermal properties" patch
  (the patch is already present in linux-soc-thermal-tree)
- drop "thermal: exynos: remove separate thermal_exynos.h header
  file" patch
  (to be resend once dts changes are merged)

Tested on Exynos4210 based Trats board and Exynos5422 based Odroid-XU3
Lite board.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (11):
  thermal: exynos: remove unused "type" field from struct
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
  ARM: dts: exynos: remove no longer needed samsung thermal properties
  arm64: dts: exynos: remove no longer needed samsung thermal properties

Maciej Purski (1):
  thermal: exynos: Read soc_type from match data

Marek Szyprowski (2):
  thermal: exynos: Reading temperature makes sense only when TMU is
    turned on
  thermal: exynos: Propagate error value from tmu_read()

 arch/arm/boot/dts/exynos3250.dtsi                  |   2 +-
 arch/arm/boot/dts/exynos4.dtsi                     |   2 +-
 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi  |  20 --
 arch/arm/boot/dts/exynos5250.dtsi                  |   2 +-
 arch/arm/boot/dts/exynos5410.dtsi                  |   8 +-
 arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi  |  21 --
 arch/arm/boot/dts/exynos5420.dtsi                  |  10 +-
 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi  |  20 --
 arch/arm/boot/dts/exynos5440.dtsi                  |   6 +-
 .../dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi |  20 --
 .../dts/exynos/exynos5433-tmu-sensor-conf.dtsi     |  19 --
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         |  10 +-
 .../boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi   |  21 --
 arch/arm64/boot/dts/exynos/exynos7.dtsi            |   2 +-
 drivers/thermal/samsung/exynos_tmu.c               | 294 ++++++++++-----------
 drivers/thermal/samsung/exynos_tmu.h               |  75 ------
 16 files changed, 165 insertions(+), 367 deletions(-)
 delete mode 100644 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
 delete mode 100644 arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi
 delete mode 100644 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi
 delete mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi
 delete mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi
 delete mode 100644 arch/arm64/boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi
 delete mode 100644 drivers/thermal/samsung/exynos_tmu.h

-- 
1.9.1
