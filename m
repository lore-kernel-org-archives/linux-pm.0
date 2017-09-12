From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal management updates for v4.14-rc1
Date: Tue, 12 Sep 2017 10:50:19 +0800
Message-ID: <1505184619.3596.20.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:52230 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750969AbdILCuW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 Sep 2017 22:50:22 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

to receive the latest Thermal Management updates for v4.14-rc1 with
top-most commit b32b5e14b4e0d40e06f094d2593b447e00acdf37:

  Merge branches 'thermal-core', 'thermal-soc', 'thermal-intel' and
'const-thermal-zone-structure' into next (2017-09-08 11:20:04 +0800)

on top of commit 16f73eb02d7e1765ccab3d2018e0bd98eb93d973:

  Linux 4.13-rc3 (2017-07-30 12:40:36 -0700)

Specifics:

- Fix resources release in error paths when registering thermal zone.
(Christophe Jaillet)

- Introduce a new thermal driver for on-chip PVT (Process, Voltage and
Temperature) monitoring unit implemented on UniPhier SoCs. This driver
supports temperature monitoring and alert function. (Kunihiko Hayashi)

- Add support for mt2712 chip in the mtk_thermal driver. (Louis Yu)

- Add support for RK3328 SOC in rockchip_thermal driver. (Rocky Hao)

- cleanup a couple of platform thermal drivers to constify
thermal_zone_of_device_ops structures. (Julia Lawall)

- a couple of fixes in int340x and intel_pch_thermal thermal
driver.(Arvind Yadav, Sumeet Pawnikar, Brian Bian, Ed Swierk, Zhang
Rui)

thanks,
rui

----------------------------------------------------------------
Arnd Bergmann (1):
      thermal: fix INTEL_SOC_DTS_IOSF_CORE dependencies

Arvind Yadav (3):
      thermal: int340x: constify attribute_group structures.
      thermal: int340x_thermal: Constify attribute_group structures.
      thermal: intel_pch_thermal: constify pci_device_id.

Brian Bian (1):
      thermal: int3400_thermal: process "thermal table changed" event

Christophe Jaillet (3):
      thermal: core: Add some new helper functions to free resources
      thermal: core: Use the new 'thermal_zone_destroy_device_groups()'
helper function
      thermal: core: Fix resources release in error paths in
thermal_zone_device_register()

Ed Swierk (2):
      thermal: intel_pch_thermal: Read large temp values correctly
      thermal: intel_pch_thermal: Fix enable check on Broadwell-DE

Icenowy Zheng (1):
      thermal: core: fix some format issues on critical shutdown string

Julia Lawall (6):
      thermal: hisilicon: constify thermal_zone_of_device_ops
structures
      thermal: qoriq: constify thermal_zone_of_device_ops structures
      thermal: rcar_gen3_thermal: constify thermal_zone_of_device_ops
structures
      thermal: zx2967: constify thermal_zone_of_device_ops structures
      thermal: exynos: constify thermal_zone_of_device_ops structures
      thermal: bcm2835: constify thermal_zone_of_device_ops structures

Kunihiko Hayashi (2):
      dt-bindings: thermal: add binding documentation for UniPhier
thermal monitor
      thermal: uniphier: add UniPhier thermal driver

Louis Yu (4):
      dt-bindings: thermal: Add binding document for Mediatek thermal
controller
      thermal: mediatek: add Mediatek thermal driver for mt2712
      thermal: mediatek: extend calibration data for mt2712 chip
      thermal: mediatek: minor mtk_thermal.c cleanups

Rocky Hao (2):
      dt-bindings: rockchip-thermal: Support the RK3328 SoC compatible
      thermal: rockchip: Support the RK3328 SOC in thermal driver

Sumeet Pawnikar (1):
      Thermal/int340x: Fix few typos and kernel warn message

Zhang Rui (3):
      Thermal: int3406_thermal: fix thermal sysfs I/F
      Merge branches 'mediatek-mt2712', 'rockchip-rk3328' and
'uniphier-thermal' into thermal-soc
      Merge branches 'thermal-core', 'thermal-soc', 'thermal-intel' and
'const-thermal-zone-structure' into next

 .../bindings/thermal/mediatek-thermal.txt          |   1 +
 .../bindings/thermal/rockchip-thermal.txt          |   1 +
 .../bindings/thermal/uniphier-thermal.txt          |  64 ++++
 drivers/thermal/Kconfig                            |  12 +-
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/broadcom/bcm2835_thermal.c         |   2 +-
 drivers/thermal/hisi_thermal.c                     |   2 +-
 drivers/thermal/int340x_thermal/acpi_thermal_rel.c |   2 +-
 drivers/thermal/int340x_thermal/acpi_thermal_rel.h |   8 +-
 drivers/thermal/int340x_thermal/int3400_thermal.c  |  43 ++-
 drivers/thermal/int340x_thermal/int3406_thermal.c  |  96 ++----
 .../int340x_thermal/processor_thermal_device.c     |   2 +-
 drivers/thermal/intel_pch_thermal.c                |  12 +-
 drivers/thermal/mtk_thermal.c                      |  88 ++++-
 drivers/thermal/qoriq_thermal.c                    |   2 +-
 drivers/thermal/rcar_gen3_thermal.c                |   2 +-
 drivers/thermal/rockchip_thermal.c                 |  65 ++++
 drivers/thermal/samsung/exynos_tmu.c               |   2 +-
 drivers/thermal/thermal_core.c                     |  31 +-
 drivers/thermal/thermal_core.h                     |   1 +
 drivers/thermal/thermal_sysfs.c                    |  29 ++
 drivers/thermal/uniphier_thermal.c                 | 384
+++++++++++++++++++++
 drivers/thermal/zx2967_thermal.c                   |   2 +-
 include/linux/thermal.h                            |   1 +
 24 files changed, 747 insertions(+), 106 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/uniphier-
thermal.txt
 create mode 100644 drivers/thermal/uniphier_thermal.c
