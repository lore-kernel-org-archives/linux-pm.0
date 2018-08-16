From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal-SoC management updates for v4.19-rc1
Date: Thu, 16 Aug 2018 08:47:03 -0700
Message-ID: <20180816154702.GA5033@localhost.localdomain>
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

to receive Thermal-SoC Management updates for v4.19-rc1 with top-most

84b64de597bcc26549a7cbfe2fa8022bbc142daa:

  thermal: armada: fix copy-paste error in armada_thermal_probe() (2018-08-01 09:56:12 -0700)

on top of commit 021c91791a5e7e85c567452f1be3e4c2c6cb6063:

  Linux 4.18-rc3 (2018-07-01 16:04:53 -0700)

Specifics:
- Rework of tsens driver to add support for tsens-v2 (Amit Kucheria)
- Rework of armada thermal driver to use syscon and multichannel support (Miquel Raynal)
- Fixes on following drivers: TI SoC, IMX, Exynos, RCar, thermal hwmon

KernelCI bot testing links:
Full Boot Summary:
https://kernelci.org/boot/all/job/evalenti/branch/for-kernelci/kernel/v4.18-rc3-34-g84b64de597bc/
Full Build Summary:
https://kernelci.org/build/evalenti/branch/for-kernelci/kernel/v4.18-rc3-34-g84b64de597bc/

BR,

Eduardo Valentin

----------------------------------------------------------------
Amit Kucheria (8):
      thermal: tsens: Get rid of unused fields in structure
      dt: thermal: tsens: Document the fallback DT property for v2 of TSENS IP
      thermal: tsens: Add support to split up register address space into two
      thermal: tsens: Rename tsens-8996 to tsens-v2 for reuse
      thermal: tsens: Add generic support for TSENS v2 IP
      thermal: tsens: Rename variable
      thermal: tsens: switch from of_iomap() to devm_ioremap_resource()
      thermal: tsens: Fix negative temperature reporting

Bartlomiej Zolnierkiewicz (1):
      thermal: ti-soc-thermal: remove dead code

Jean-Christophe Dubois (1):
      thermal: i.MX: Allow thermal probe to fail gracefully in case of bad calibration.

Krzysztof Kozlowski (1):
      thermal: samsung: Remove Exynos5440 clock handling left-overs

Marc Zyngier (2):
      thermal_hwmon: Sanitize attribute name passed to hwmon
      thermal_hwmon: Pass the originating device down to hwmon_device_register_with_info

Miquel Raynal (19):
      thermal: armada: add a function that sanitizes the thermal zone name
      thermal: armada: remove useless register accesses
      thermal: armada: remove misleading comments
      thermal: armada: rename the initialization routine
      thermal: armada: dissociate a380 and cp110 ->init() hooks
      thermal: armada: average over samples to avoid glitches
      thermal: armada: convert driver to syscon register accesses
      thermal: armada: use the resource managed registration helper alternative
      thermal: armada: add multi-channel sensors support
      thermal: armada: remove sensors validity from the IP initialization
      thermal: armada: move validity check out of the read function
      thermal: armada: get rid of the ->is_valid() pointer
      dt-bindings: cp110: rename cp110 syscon file
      dt-bindings: ap806: prepare the syscon file to list other syscons nodes
      dt-bindings: cp110: prepare the syscon file to list other syscons nodes
      dt-bindings: ap806: add the thermal node in the syscon file
      dt-bindings: cp110: update documentation since DT de-duplication
      dt-bindings: cp110: add the thermal node in the syscon file
      dt-bindings: thermal: armada: add reference to new bindings

Simon Horman (1):
      thermal: rcar_thermal: avoid NULL dereference in absence of IRQ resources

Wei Yongjun (1):
      thermal: armada: fix copy-paste error in armada_thermal_probe()

 .../arm/marvell/ap806-system-controller.txt        |  48 +-
 ...controller0.txt => cp110-system-controller.txt} |  61 ++-
 .../devicetree/bindings/thermal/armada-thermal.txt |   5 +
 .../devicetree/bindings/thermal/qcom-tsens.txt     |  31 +-
 drivers/thermal/armada_thermal.c                   | 534 ++++++++++++++++-----
 drivers/thermal/imx_thermal.c                      |   5 +-
 drivers/thermal/qcom/Makefile                      |   2 +-
 drivers/thermal/qcom/tsens-8996.c                  |  84 ----
 drivers/thermal/qcom/tsens-common.c                |  29 +-
 drivers/thermal/qcom/tsens-v2.c                    |  77 +++
 drivers/thermal/qcom/tsens.c                       |   3 +
 drivers/thermal/qcom/tsens.h                       |   8 +-
 drivers/thermal/rcar_thermal.c                     |   2 +-
 drivers/thermal/samsung/exynos_tmu.c               |   5 -
 drivers/thermal/thermal_hwmon.c                    |   3 +-
 drivers/thermal/ti-soc-thermal/dra752-bandgap.h    |  68 ---
 .../thermal/ti-soc-thermal/dra752-thermal-data.c   |  65 ---
 .../thermal/ti-soc-thermal/omap3-thermal-data.c    |   6 -
 .../thermal/ti-soc-thermal/omap4-thermal-data.c    |  10 -
 drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h  |  10 -
 .../thermal/ti-soc-thermal/omap5-thermal-data.c    |  46 +-
 drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h  |  41 --
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        | 370 --------------
 drivers/thermal/ti-soc-thermal/ti-bandgap.h        |  43 +-
 24 files changed, 649 insertions(+), 907 deletions(-)
 rename Documentation/devicetree/bindings/arm/marvell/{cp110-system-controller0.txt => cp110-system-controller.txt} (85%)
 delete mode 100644 drivers/thermal/qcom/tsens-8996.c
 create mode 100644 drivers/thermal/qcom/tsens-v2.c
