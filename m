From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal SoC management updates for v4.11-rc1 #1
Date: Sat, 18 Feb 2017 17:53:31 -0800
Message-ID: <20170219015330.GC20845@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Rui Zhang <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

Hello Rui,

Please pull the following changes to get the Thermal SoC updates
for 4.11-rc1. Here we have:
- thermal support for zx2967. thanks to Baoyou Xie.
- new driver support for rcar-gen3.
- a couple of fixes on TI, exynos, and IMX drivers.

I might also send a second pull, depending if we get new versions
of other two drivers that have been on review for some time.

BR,

The following changes since commit cdb98c2698b4af287925abcba4d77d92af82a0c3:

  Revert "nvme: add support for the Write Zeroes command" (2016-12-13 19:53:37 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal linus

for you to fetch changes up to 992edf395b8a8411c506f4345bc04451eba95976:

  thermal: mtk_thermal: Staticise a number of data variables (2017-02-18 17:44:29 -0800)

----------------------------------------------------------------
Baoyou Xie (2):
      dt: bindings: add documentation for zx2967 family thermal sensor
      thermal: zx2967: add thermal driver for ZTE's zx2967 family

Keerthy (3):
      thermal: ti-soc-thermal: Remove CPU_THERMAL Dependency from TI_THERMAL
      thermal: arm: dra752: Remove TSHUT configuration
      thermal: arm: dra752: Remove all TSHUT related definitions

Krzysztof Kozlowski (1):
      thermal: exynos: Remove parsing unused samsung,tmu_cal_mode property

Shailendra Verma (1):
      thermal: imx: Fix possible NULL dereference.

Vivek Gautam (1):
      thermal: mtk_thermal: Staticise a number of data variables

Wolfram Sang (2):
      thermal: rcar_gen3_thermal: Document the R-Car Gen3
      thermal: rcar_gen3_thermal: Add R-Car Gen3 thermal driver

 .../bindings/thermal/rcar-gen3-thermal.txt         |  56 ++++
 .../devicetree/bindings/thermal/zx2967-thermal.txt | 116 +++++++
 drivers/thermal/Kconfig                            |  17 ++
 drivers/thermal/Makefile                           |   2 +
 drivers/thermal/imx_thermal.c                      |   4 +
 drivers/thermal/mtk_thermal.c                      |  16 +-
 drivers/thermal/rcar_gen3_thermal.c                | 335 +++++++++++++++++++++
 drivers/thermal/samsung/exynos_tmu.c               |   1 -
 drivers/thermal/samsung/exynos_tmu.h               |   1 -
 drivers/thermal/ti-soc-thermal/Kconfig             |   1 -
 drivers/thermal/ti-soc-thermal/dra752-bandgap.h    |  19 --
 .../thermal/ti-soc-thermal/dra752-thermal-data.c   |  28 +-
 drivers/thermal/zx2967_thermal.c                   | 258 ++++++++++++++++
 13 files changed, 797 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/zx2967-thermal.txt
 create mode 100644 drivers/thermal/rcar_gen3_thermal.c
 create mode 100644 drivers/thermal/zx2967_thermal.c
