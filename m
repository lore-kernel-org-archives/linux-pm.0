From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal SoC management updates for v4.6-rc2
Date: Sat, 2 Apr 2016 18:04:38 -0700
Message-ID: <20160403010436.GA10468@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Rui Zhang <rui.zhang@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello Linus,

Please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

to receive Thermal-SoC Management updates for v4.6-rc2 with top-most

c960fe12d00275c52dffc0013d64c5a50538a74c:

  thermal: hisilicon: fix IRQ imbalance enabling (2016-03-29 08:43:02 -0700)

on top of commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

Specifics in this pull request:
- Fixes in thermal sysfs API documentation
- Rework of OF thermal users to migrate to devm_ helper
- Adding Keerthy as maintainer of TI thermal SoC
- Minor fixes on Hisilicon, RCAR, and OF thermal.
- Code refactoring and reorganization on tegra thermal driver.
- These change have been CI tested using KernelCI bot [1,2]. \o/

[1] - https://kernelci.org/boot/all/job/evalenti/kernel/v4.6-rc1-30-gc960fe12d002/
[2] - https://kernelci.org/build/evalenti/kernel/v4.6-rc1-30-gc960fe12d002/

BR,

Eduardo Valentin

----------------------------------------------------------------
Andy Champ (1):
      thermal: Syntactic and factual errors in the API document

Eduardo Valentin (12):
      hwmon: convert lm75 to use devm_thermal_zone_of_sensor_register
      hwmon: convert ntc_thermistor to use devm_thermal_zone_of_sensor_register
      hwmon: convert tmp102 to use devm_thermal_zone_of_sensor_register
      hwmon: convert scpi-hwmon to use devm_thermal_zone_of_sensor_register
      input: convert sun4i-ts to use devm_thermal_zone_of_sensor_register
      thermal: convert hisi_thermal to use devm_thermal_zone_of_sensor_register
      thermal: convert mtk_thermal to use devm_thermal_zone_of_sensor_register
      thermal: convert qcom-spmi to use devm_thermal_zone_of_sensor_register
      thermal: convert rcar_thermal to use devm_thermal_zone_of_sensor_register
      thermal: convert rockchip_thermal to use devm_thermal_zone_of_sensor_register
      thermal: convert tegra_thermal to use devm_thermal_zone_of_sensor_register
      thermal: convert ti-thermal to use devm_thermal_zone_of_sensor_register

Keerthy (1):
      MAINTAINERS: ti-soc-thermal: add a co-maintainer and update the entry

Leo Yan (2):
      thermal: hisilicon: support to use any sensor
      thermal: hisilicon: fix IRQ imbalance enabling

Simon Horman (1):
      thermal: rcar: Remove binding docs for r8a7794

Ulises Brindis (1):
      thermal: of: fix cleanup when building a thermal zone

Wei Ni (12):
      thermal: tegra: move tegra thermal files into tegra directory
      thermal: tegra: combine sensor group-related data
      thermal: tegra: get rid of PDIV/HOTSPOT hack
      thermal: tegra: split tegra_soctherm driver
      thermal: tegra: add Tegra210 specific SOC_THERM driver
      thermal: tegra: add a debugfs to show registers
      thermal: of-thermal: allow setting trip_temp on hardware
      of: add notes of critical trips for soctherm
      thermal: tegra: add thermtrip function
      thermal: tegra: handle clocks in one function
      thermal: tegra: handle HW initialization in one funcotion
      thermal: tegra: add PM support

 .../devicetree/bindings/thermal/rcar-thermal.txt   |   1 -
 .../devicetree/bindings/thermal/tegra-soctherm.txt |  12 +
 Documentation/thermal/sysfs-api.txt                |  44 +-
 MAINTAINERS                                        |   1 +
 drivers/hwmon/lm75.c                               |  10 +-
 drivers/hwmon/ntc_thermistor.c                     |  12 +-
 drivers/hwmon/scpi-hwmon.c                         |  48 +-
 drivers/hwmon/tmp102.c                             |   8 +-
 drivers/input/touchscreen/sun4i-ts.c               |   9 +-
 drivers/thermal/Kconfig                            |  12 +-
 drivers/thermal/Makefile                           |   2 +-
 drivers/thermal/hisi_thermal.c                     |  45 +-
 drivers/thermal/mtk_thermal.c                      |  12 +-
 drivers/thermal/of-thermal.c                       |  10 +-
 drivers/thermal/qcom-spmi-temp-alarm.c             |   3 +-
 drivers/thermal/rcar_thermal.c                     |   2 +-
 drivers/thermal/rockchip_thermal.c                 |  17 +-
 drivers/thermal/tegra/Kconfig                      |  13 +
 drivers/thermal/tegra/Makefile                     |   5 +
 drivers/thermal/tegra/soctherm-fuse.c              | 169 +++++
 drivers/thermal/tegra/soctherm.c                   | 682 +++++++++++++++++++++
 drivers/thermal/tegra/soctherm.h                   | 123 ++++
 drivers/thermal/tegra/tegra124-soctherm.c          | 196 ++++++
 drivers/thermal/tegra/tegra210-soctherm.c          | 197 ++++++
 drivers/thermal/tegra_soctherm.c                   | 476 --------------
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |   5 +-
 include/dt-bindings/thermal/tegra124-soctherm.h    |   1 +
 include/linux/thermal.h                            |   1 +
 28 files changed, 1488 insertions(+), 628 deletions(-)
 create mode 100644 drivers/thermal/tegra/Kconfig
 create mode 100644 drivers/thermal/tegra/Makefile
 create mode 100644 drivers/thermal/tegra/soctherm-fuse.c
 create mode 100644 drivers/thermal/tegra/soctherm.c
 create mode 100644 drivers/thermal/tegra/soctherm.h
 create mode 100644 drivers/thermal/tegra/tegra124-soctherm.c
 create mode 100644 drivers/thermal/tegra/tegra210-soctherm.c
 delete mode 100644 drivers/thermal/tegra_soctherm.c
