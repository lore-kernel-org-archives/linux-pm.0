From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal SoC management updates for v4.7
Date: Mon, 16 May 2016 20:18:58 -0700
Message-ID: <20160517031857.GA3318@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Rui Zhang <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

Hello Rui,

Here is material for 4.7 on thermal SoC. I have rebased this branch on
top of latest linus tree. But this material have been tested and on
linux-next for several weeks.

The following changes since commit b6ae4055f4ab55c05df31cc1b6a7ea8c85eb525d:

  Merge tag 'arm64-perf' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux (2016-05-16 17:39:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal work-linus-4.7

for you to fetch changes up to 17c403d8ba287212102c9d72696e2666d4516478:

  thermal: tango: initialize TEMPSI_CFG (2016-05-16 18:00:40 -0700)

In this pull you get:
- Rockchip driver support for RK3399, RK3366, and some fixes.
- Mediatek CPU power model
- Wider usage of dev_thermal_zone_of_sensor_register
- A generic ADC thermal driver, based on OF thermal
- TI thermal driver gained a new maintainer (Keerthy)
- New thermal driver for Tango chips
- Various fixes on OF thermal, Tegra, and RCAR

BR,


Eduardo Valentin


----------------------------------------------------------------
Andy Champ (1):
      thermal: Syntactic and factual errors in the API document

Arnd Bergmann (1):
      thermal: tegra: mark PM functions __maybe_unused

Caesar Wang (5):
      thermal: rockchip: fixes the code_to_temp for tsadc driver
      thermal: rockchip: update the tsadc table for rk3399
      thermal: rockchip: handle the power sequence for tsadc controller
      thermal: rockchip: add the notes for better reading
      thermal: rockchip: use the usleep_range instead of udelay

Dawei Chien (1):
      thermal: mediatek: Add cpu dynamic power cooling model.

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

Elaine Zhang (1):
      thermal: rockchip: Support RK3366 SoCs in the thermal driver

Keerthy (1):
      MAINTAINERS: ti-soc-thermal: add a co-maintainer and update the entry

Laxman Dewangan (2):
      thermal: generic-adc: Add DT binding for ADC based thermal sensor
      thermal: generic-adc: Add ADC based thermal sensor driver

Leo Yan (2):
      thermal: hisilicon: support to use any sensor
      thermal: hisilicon: fix IRQ imbalance enabling

Marc Gonzalez (2):
      thermal: add temperature sensor support for tango SoC
      thermal: tango: initialize TEMPSI_CFG

Shawn Lin (1):
      thermal: rockchip: disable thermal->clk in err case

Simon Horman (1):
      thermal: rcar: Remove binding docs for r8a7794

Ulises Brindis (1):
      thermal: of: fix cleanup when building a thermal zone

Wei Ni (14):
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
      thermal: tegra: fix static checker warning
      thermal: tegra: add Tegra132 specific SOC_THERM driver

kbuild test robot (1):
      thermal: fix ptr_ret.cocci warnings

 .../devicetree/bindings/thermal/rcar-thermal.txt   |   1 -
 .../devicetree/bindings/thermal/tango-thermal.txt  |  17 +
 .../devicetree/bindings/thermal/tegra-soctherm.txt |  12 +
 .../bindings/thermal/thermal-generic-adc.txt       |  89 +++
 Documentation/thermal/sysfs-api.txt                |  44 +-
 MAINTAINERS                                        |   1 +
 drivers/cpufreq/mt8173-cpufreq.c                   |  11 +-
 drivers/hwmon/lm75.c                               |  10 +-
 drivers/hwmon/ntc_thermistor.c                     |  12 +-
 drivers/hwmon/scpi-hwmon.c                         |  48 +-
 drivers/hwmon/tmp102.c                             |   8 +-
 drivers/input/touchscreen/sun4i-ts.c               |   9 +-
 drivers/thermal/Kconfig                            |  31 +-
 drivers/thermal/Makefile                           |   4 +-
 drivers/thermal/hisi_thermal.c                     |  45 +-
 drivers/thermal/mtk_thermal.c                      |  12 +-
 drivers/thermal/of-thermal.c                       |  10 +-
 drivers/thermal/qcom-spmi-temp-alarm.c             |   3 +-
 drivers/thermal/rcar_thermal.c                     |   2 +-
 drivers/thermal/rockchip_thermal.c                 | 280 ++++++---
 drivers/thermal/tango_thermal.c                    | 109 ++++
 drivers/thermal/tegra/Kconfig                      |  13 +
 drivers/thermal/tegra/Makefile                     |   6 +
 drivers/thermal/tegra/soctherm-fuse.c              | 169 +++++
 drivers/thermal/tegra/soctherm.c                   | 685 +++++++++++++++++++++
 drivers/thermal/tegra/soctherm.h                   | 127 ++++
 drivers/thermal/tegra/tegra124-soctherm.c          | 196 ++++++
 drivers/thermal/tegra/tegra132-soctherm.c          | 196 ++++++
 drivers/thermal/tegra/tegra210-soctherm.c          | 197 ++++++
 drivers/thermal/tegra_soctherm.c                   | 476 --------------
 drivers/thermal/thermal-generic-adc.c              | 182 ++++++
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |   5 +-
 include/dt-bindings/thermal/tegra124-soctherm.h    |   1 +
 include/linux/thermal.h                            |   1 +
 34 files changed, 2320 insertions(+), 692 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/tango-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt
 create mode 100644 drivers/thermal/tango_thermal.c
 create mode 100644 drivers/thermal/tegra/Kconfig
 create mode 100644 drivers/thermal/tegra/Makefile
 create mode 100644 drivers/thermal/tegra/soctherm-fuse.c
 create mode 100644 drivers/thermal/tegra/soctherm.c
 create mode 100644 drivers/thermal/tegra/soctherm.h
 create mode 100644 drivers/thermal/tegra/tegra124-soctherm.c
 create mode 100644 drivers/thermal/tegra/tegra132-soctherm.c
 create mode 100644 drivers/thermal/tegra/tegra210-soctherm.c
 delete mode 100644 drivers/thermal/tegra_soctherm.c
 create mode 100644 drivers/thermal/thermal-generic-adc.c
