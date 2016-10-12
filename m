From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal management updates for v4.9-rc1
Date: Wed, 12 Oct 2016 20:13:04 +0800
Message-ID: <1476274384.3070.54.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:2147 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753362AbcJLMNH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Oct 2016 08:13:07 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

to receive the latest Thermal Management updates for v4.9-rc1 with
top-most commit 43720df96023b762843e7ddcc319fc99989ba3c2:

  thermal: int3403: Process trip change notification (2016-09-27
14:37:17 +0800)

on top of commit c6935931c1894ff857616ff8549b61236a19148f:

  Linux 4.8-rc5 (2016-09-04 14:31:46 -0700)

Specifics:

- Enhance thermal "userspace" governor to export the reason when a
 
thermal event is triggered and delivered to user space.
  From: Srinivas
Pandruvada.

- Introduce a single TSENS thermal driver for the different versions
  of the TSENS IP that exist, on different qcom msm/apq SoCs'. Support
  for msm8916, msm8960, msm8974 and msm8996 families is also added. 
  From: Rajendra Nayak.

- Introduce hardware-tracked trip points support to the device tree
  thermal sensor framework. The framework supports an arbitrary number 
  of trip points. Whenever the current temperature is changed, the trip
  points immediately below and above the current temperature are found,
  driver callback is invoked to program the hardware to get notified 
  when either of the two trip points are triggered. Hardware-tracked 
  trip points support for rockchip thermal driver is also added at the 
  same time. From: Sascha Hauer, Caesar Wang.

- Introduce a new thermal driver, which enables TMU (Thermal Monitor
  Unit) on QorIQ platform. From: Jia Hongtao.

- Introduce a new thermal driver for Maxim MAX77620. From: Laxman
  Dewangan.

- Introduce a new thermal driver for Intel platforms using WhiskeyCove 
  PMIC. From: Bin Gao.

- Add mt2701 chip support to MTK thermal driver. From: Dawei Chien.

- Enhance Tegra thermal driver to enable soctherm node and set 
  "critical", "hot" trips, for Tegra124, Tegra132, Tegra210.
  From Wei Ni.

- Add resume support for tango thermal driver. From: Marc Gonzalez.

- several small fixes and improvements for rockchip, qcom, imx, rcar,
  mtk thermal drivers and thermal core code. From: Caesar Wang,
  Keerthy, Rocky Hao, Wei Yongjun,  Peter Robinson,  Bui Duc Phuc,
  Axel Lin, Hugh  Kang, 

thanks,
rui

----------------------------------------------------------------
Arnd Bergmann (1):
      thermal: qcom: tsens-8916: mark PM functions __maybe_unused

Axel Lin (1):
      thermal: mtk_thermal: Check return value of
devm_thermal_zone_of_sensor_register

Bin Gao (1):
      thermal: add Intel BXT WhiskeyCove PMIC thermal driver

Bui Duc Phuc (1):
      thermal: rcar_thermal: don't call thermal_zone_device_unregister
when USE_OF_THERMAL

Caesar Wang (3):
      thermal: rockchip: add the set_trips function
      thermal: rockchip: fixes the period time for tsadc
      thermal: rockchip: fixes the exception interrupts

Eduardo Valentin (1):
      thermal: qcom: remove declare local symbols as static

Hugh Kang (1):
      thermal: cpu_cooling: Fix wrong comment call function name

Jia Hongtao (1):
      thermal: qoriq: Add thermal management support

Keerthy (1):
      thermal: of-thermal: Fix setting of set_emul_temp hook

Kuninori Morimoto (1):
      thermal: rcar-thermal: enable hwmon when
thermal_zone_of_sensor_register is used

Laxman Dewangan (2):
      thermal: max77620: Add DT binding doc for thermal driver
      thermal: max77620: Add thermal driver for reporting junction temp

Marc Gonzalez (1):
      thermal: tango: add resume support

Peter Robinson (1):
      thermal: imx: depend on imx SoC arch

Rajendra Nayak (6):
      thermal: qcom: tsens: Add a skeletal TSENS drivers
      thermal: qcom: tsens-8916: Add support for 8916 family of SoCs
      thermal: qcom: tsens-8974: Add support for 8974 family of SoCs
      thermal: core: export apis to get slope and offset
      thermal: qcom: tsens-8960: Add support for 8960 family of SoCs
      thermal: qcom: tsens-8996: Add support for 8996 family of SoCs

Rocky Hao (2):
      thermal: rockchip: enhance the tsadc's bandgap feature for rk3399
      thermal: rockchip: optimize sensor auto accessing period

Sascha Hauer (4):
      thermal: Add support for hardware-tracked trip points
      thermal: of: implement .set_trips for device tree thermal zones
      thermal: streamline get_trend callbacks
      thermal: bang-bang governor: act on lower trip boundary

Shawn Lin (1):
      devfreq_cooling: no need to check state with negative number

Srinivas Pandruvada (4):
      thermal: Enhance thermal_zone_device_update for events
      thermal: user_space gov: Add additional information in uevent
      thermal: int340x: New Interface to read trip and notify
      thermal: int3403: Process trip change notification

Wei Ni (11):
      of: Add bindings of hw throttle for Tegra soctherm
      thermal: tegra: add hw-throttle function
      thermal: tegra: add hw-throttle for Tegra132
      arm: tegra: set critical trips for Tegra124
      arm: tegra: set hot trips for Tegra124
      arm64: tegra: use tegra132-soctherm for Tegra132
      arm64: tegra: set critical trips for Tegra132
      arm64: tegra: set hot trips for Tegra132
      arm64: tegra: add soctherm node for Tegra210
      arm64: tegra: set critical trips for Tegra210
      arm64: tegra: set hot trips for Tegra210

Wei Yongjun (1):
      thermal: qcom: tsens: Fix return value check in init_common()

Zhang Rui (2):
      Thermal: of thermal: typo fix
      Merge branches 'thermal-soc', 'thermal-core', 'thermal-intel' and
'thermal-tegra-hw-throttle' into next

dawei.chien@mediatek.com (2):
      dt-bindings: thermal: Add binding document for Mediatek thermal
controller
      thermal: Add Mediatek thermal driver for mt2701.

 .../bindings/thermal/max77620_thermal.txt          |  70 ++
 .../bindings/thermal/mediatek-thermal.txt          |   4 +-
 .../bindings/thermal/nvidia,tegra124-soctherm.txt  | 121 ++-
 .../devicetree/bindings/thermal/qcom-tsens.txt     |  21 +
 Documentation/thermal/sysfs-api.txt                |  19 +
 arch/arm/boot/dts/tegra124-jetson-tk1.dts          |  18 +-
 arch/arm/boot/dts/tegra124.dtsi                    |  83 +-
 arch/arm64/boot/dts/nvidia/tegra132.dtsi           | 119 ++-
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           | 127 ++++
 drivers/acpi/thermal.c                             |   3 +-
 drivers/platform/x86/acerhdf.c                     |   2 +-
 drivers/regulator/max8973-regulator.c              |   3 +-
 drivers/thermal/Kconfig                            |  37 +-
 drivers/thermal/Makefile                           |   4 +
 drivers/thermal/cpu_cooling.c                      |   2 +-
 drivers/thermal/db8500_thermal.c                   |   2 +-
 drivers/thermal/devfreq_cooling.c                  |   2 +-
 drivers/thermal/gov_bang_bang.c                    |   2 +-
 drivers/thermal/hisi_thermal.c                     |   3 +-
 drivers/thermal/imx_thermal.c                      |   4 +-
 drivers/thermal/int340x_thermal/int3402_thermal.c  |   3 +-
 drivers/thermal/int340x_thermal/int3403_thermal.c  |   9 +-
 .../thermal/int340x_thermal/int340x_thermal_zone.c |  60 +-
 .../thermal/int340x_thermal/int340x_thermal_zone.h |   6 +-
 .../int340x_thermal/processor_thermal_device.c     |   3 +-
 drivers/thermal/intel_bxt_pmic_thermal.c           | 300 ++++++++
 drivers/thermal/intel_soc_dts_iosf.c               |   3 +-
 drivers/thermal/max77620_thermal.c                 | 166 ++++
 drivers/thermal/mtk_thermal.c                      | 226 ++++--
 drivers/thermal/of-thermal.c                       |  46 +-
 drivers/thermal/qcom-spmi-temp-alarm.c             |   2 +-
 drivers/thermal/qcom/Kconfig                       |  11 +
 drivers/thermal/qcom/Makefile                      |   2 +
 drivers/thermal/qcom/tsens-8916.c                  | 113 +++
 drivers/thermal/qcom/tsens-8960.c                  | 292 +++++++
 drivers/thermal/qcom/tsens-8974.c                  | 244 ++++++
 drivers/thermal/qcom/tsens-8996.c                  |  84 ++
 drivers/thermal/qcom/tsens-common.c                | 141 ++++
 drivers/thermal/qcom/tsens.c                       | 200 +++++
 drivers/thermal/qcom/tsens.h                       |  94 +++
 drivers/thermal/qoriq_thermal.c                    | 328 ++++++++
 drivers/thermal/rcar_thermal.c                     |  26 +-
 drivers/thermal/rockchip_thermal.c                 | 107 ++-
 drivers/thermal/samsung/exynos_tmu.c               |   2 +-
 drivers/thermal/st/st_thermal_memmap.c             |   3 +-
 drivers/thermal/tango_thermal.c                    |  19 +-
 drivers/thermal/tegra/soctherm.c                   | 842
++++++++++++++++++++-
 drivers/thermal/tegra/soctherm.h                   |  10 +
 drivers/thermal/tegra/tegra124-soctherm.c          |  18 +
 drivers/thermal/tegra/tegra132-soctherm.c          |  18 +
 drivers/thermal/tegra/tegra210-soctherm.c          |  18 +
 drivers/thermal/thermal_core.c                     | 106 ++-
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  29 +-
 drivers/thermal/user_space.c                       |  15 +-
 drivers/thermal/x86_pkg_temp_thermal.c             |   3 +-
 include/dt-bindings/thermal/tegra124-soctherm.h    |   5 +
 include/linux/thermal.h                            |  43 +-
 57 files changed, 4021 insertions(+), 222 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/thermal/max77620_thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom-
tsens.txt
 create mode 100644 drivers/thermal/intel_bxt_pmic_thermal.c
 create mode 100644 drivers/thermal/max77620_thermal.c
 create mode 100644 drivers/thermal/qcom/Kconfig
 create mode 100644 drivers/thermal/qcom/Makefile
 create mode 100644 drivers/thermal/qcom/tsens-8916.c
 create mode 100644 drivers/thermal/qcom/tsens-8960.c
 create mode 100644 drivers/thermal/qcom/tsens-8974.c
 create mode 100644 drivers/thermal/qcom/tsens-8996.c
 create mode 100644 drivers/thermal/qcom/tsens-common.c
 create mode 100644 drivers/thermal/qcom/tsens.c
 create mode 100644 drivers/thermal/qcom/tsens.h
 create mode 100644 drivers/thermal/qoriq_thermal.c
