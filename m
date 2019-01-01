From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal-SoC management updates for v4.21-rc1
Date: Tue, 1 Jan 2019 08:05:04 -0800
Message-ID: <20190101160503.GA3306@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Rui Zhang <rui.zhang@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello Linus,

Please consider pulling from

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal linus

to receive Thermal-SoC Management updates for v4.21-rc1 with top-most

055ddb633a35845f106fb732a07c90862e0a43e5:

  thermal: generic-adc: Fix adc to temp interpolation (2018-12-25 14:44:45 -0800)

on top of commit 0072a0c14d5b7cb72c611d396f143f5dcd73ebe2:

  Merge tag 'media/v4.20-4' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media (2018-12-03 11:29:20 -0800)

Specifics:
- Tegra DT binding documentation for Tegra194
- Armada now supports ap806 and cp110
- RCAR thermal now supports R8A774C0 and R8A77990
- Fixes on IMX, generic-ADC, ST, RCAR, Broadcom, Uniphier, QCOM, Tegra, 
  PowerClamp, and Armada

CI:
Full Boot Summary: https://kernelci.org/boot/all/job/evalenti/branch/for-kernelci/kernel/v4.20-rc5-42-g055ddb633a35/
Full Build Summary: https://kernelci.org/build/evalenti/branch/for-kernelci/kernel/v4.20-rc5-42-g055ddb633a35/

BR,
Eduardo

----------------------------------------------------------------
Anson Huang (2):
      thermal: imx: fix for dependency on cpu-freq
      thermal: imx: save one condition block for normal case of nvmem initialization

Arnd Bergmann (1):
      thermal: st: fix Makefile typo

Bjorn Andersson (1):
      thermal: generic-adc: Fix adc to temp interpolation

Fabrizio Castro (2):
      dt-bindings: thermal: rcar-thermal: add R8A774C0 support
      thermal: rcar_thermal: add R8A774C0 support

Geert Uytterhoeven (1):
      dt-bindings: thermal: rcar-gen3-thermal: All variants use 3 interrupts

Julia Lawall (1):
      thermal: broadcom: use devm_thermal_zone_of_sensor_register

Kunihiko Hayashi (1):
      thermal: uniphier: Convert to SPDX identifier

Matthias Brugger (1):
      thermal: bcm2835: enable hwmon explicitly

Miquel Raynal (4):
      thermal: armada: add overheat interrupt support
      MAINTAINERS: thermal: add entry for Marvell MVEBU thermal driver
      dt-bindings: ap806: document the thermal interrupt capabilities
      dt-bindings: cp110: document the thermal interrupt capabilities

Srinivas Kandagatla (1):
      thermal: tsens: qcom: do not create duplicate regmap debugfs entries

Thierry Reding (1):
      dt-bindings: thermal: tegra-bpmp: Add Tegra194 support

Yangtao Li (2):
      thermal: tegra: soctherm: Change to use DEFINE_SHOW_ATTRIBUTE macro
      thermal/intel_powerclamp: Change to use DEFINE_SHOW_ATTRIBUTE macro

Yoshihiro Kaneko (2):
      dt-bindings: thermal: rcar-thermal: add R8A77990 support
      thermal: rcar_thermal: add R8A77990 support

YueHaibing (1):
      thermal: armada: Use PTR_ERR_OR_ZERO in armada_thermal_probe_legacy()

 .../arm/marvell/ap806-system-controller.txt        |   7 +
 .../arm/marvell/cp110-system-controller.txt        |   9 +
 .../thermal/nvidia,tegra186-bpmp-thermal.txt       |   3 +-
 .../bindings/thermal/rcar-gen3-thermal.txt         |   3 +-
 .../devicetree/bindings/thermal/rcar-thermal.txt   |   6 +-
 MAINTAINERS                                        |   5 +
 drivers/thermal/Kconfig                            |   2 +-
 drivers/thermal/armada_thermal.c                   | 280 ++++++++++++++++++++-
 drivers/thermal/broadcom/bcm2835_thermal.c         |  11 +
 drivers/thermal/broadcom/brcmstb_thermal.c         |  24 +-
 drivers/thermal/imx_thermal.c                      |  52 ++--
 drivers/thermal/intel_powerclamp.c                 |  14 +-
 drivers/thermal/qcom/tsens-common.c                |  12 +-
 drivers/thermal/rcar_thermal.c                     |   8 +
 drivers/thermal/st/Makefile                        |   2 +-
 drivers/thermal/tegra/soctherm.c                   |  12 +-
 drivers/thermal/thermal-generic-adc.c              |  12 +-
 drivers/thermal/uniphier_thermal.c                 |  13 +-
 .../dt-bindings/thermal/tegra194-bpmp-thermal.h    |  15 ++
 19 files changed, 398 insertions(+), 92 deletions(-)
 create mode 100644 include/dt-bindings/thermal/tegra194-bpmp-thermal.h
