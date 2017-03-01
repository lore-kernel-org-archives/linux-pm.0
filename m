From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal management updates for v4.11-rc1
Date: Wed, 01 Mar 2017 17:12:58 +0800
Message-ID: <1488359578.11661.16.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:20725 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751565AbdCAJNm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Mar 2017 04:13:42 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

to receive the latest Thermal Management updates for v4.11-rc1 with
top-most commit 6fefe19f583625ca4ea3ecc9128baa51c31c60a4:

  Merge branches 'thermal-core', 'thermal-soc', 'thermal-intel' and
'ida-conversion' into next (2017-02-22 15:35:06 +0800)

on top of commit d5adbfcd5f7bcc6fa58a41c5c5ada0e5c826ce2c:

  Linux 4.10-rc7 (2017-02-05 15:10:58 -0800)

Specifics:

- Add thermal driver for R-Car Gen3 thermal sensors.

- Add thermal driver for ZTE' zx2967 family thermal sensors.

- convert thermal ID allocation from IDR to IDA.

- fix a possible NULL dereference in imx thermal driver.

- fix a ti-soc-thermal driver dependency issue so that critical thermal
control is still available when CPU_THERMAL is not defined.

- update binding information for QorIQ thermal driver.

- A couple of cleanups in thermal core, intel_powerclamp, exynos,
dra752-thermal, mtk-thermal driver.

thanks,
rui


----------------------------------------------------------------
Arnd Bergmann (1):
      thermal: use cpumask_var_t for on-stack cpu masks

Augusto Mecking Caringi (1):
      thermal/intel_powerclamp: Remove set-but-not-used variables

Baoyou Xie (2):
      dt: bindings: add documentation for zx2967 family thermal sensor
      thermal: zx2967: add thermal driver for ZTE's zx2967 family

Hongtao Jia (2):
      powerpc/mpc85xx: Update TMU device tree node for T1040/T1042
      powerpc/mpc85xx: Update TMU device tree node for T1023/T1024

Jia Hongtao (1):
      dt-bindings: Update QorIQ TMU thermal bindings

Keerthy (3):
      thermal: ti-soc-thermal: Remove CPU_THERMAL Dependency from
TI_THERMAL
      thermal: arm: dra752: Remove TSHUT configuration
      thermal: arm: dra752: Remove all TSHUT related definitions

Krzysztof Kozlowski (1):
      thermal: exynos: Remove parsing unused samsung,tmu_cal_mode
property

Matthew Wilcox (4):
      thermal core: convert ID allocation to IDA
      thermal: convert clock cooling to use an IDA
      thermal: convert cpu_cooling to use an IDA
      thermal: convert devfreq_cooling to use an IDA

Shailendra Verma (1):
      thermal: imx: Fix possible NULL dereference.

Vivek Gautam (1):
      thermal: mtk_thermal: Staticise a number of data variables

Wolfram Sang (2):
      thermal: rcar_gen3_thermal: Document the R-Car Gen3
      thermal: rcar_gen3_thermal: Add R-Car Gen3 thermal driver

Zhang Rui (2):
      Merge branch 'linus' of git://git.kernel.org/.../evalenti/linux-
soc-thermal into thermal-soc
      Merge branches 'thermal-core', 'thermal-soc', 'thermal-intel' and
'ida-conversion' into next

 .../devicetree/bindings/thermal/qoriq-thermal.txt  |   7 +
 .../bindings/thermal/rcar-gen3-thermal.txt         |  56 ++++
 .../devicetree/bindings/thermal/zx2967-thermal.txt | 116 +++++++
 arch/powerpc/boot/dts/fsl/t1023si-post.dtsi        |   4 +-
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi        |   4 +-
 drivers/thermal/Kconfig                            |  17 ++
 drivers/thermal/Makefile                           |   2 +
 drivers/thermal/clock_cooling.c                    |  50 +--
 drivers/thermal/cpu_cooling.c                      | 102 +++----
 drivers/thermal/devfreq_cooling.c                  |  53 +---
 drivers/thermal/imx_thermal.c                      |   4 +
 drivers/thermal/intel_powerclamp.c                 |   4 -
 drivers/thermal/mtk_thermal.c                      |  16 +-
 drivers/thermal/rcar_gen3_thermal.c                | 335
+++++++++++++++++++++
 drivers/thermal/samsung/exynos_tmu.c               |   1 -
 drivers/thermal/samsung/exynos_tmu.h               |   1 -
 drivers/thermal/thermal_core.c                     |  75 ++---
 drivers/thermal/ti-soc-thermal/Kconfig             |   1 -
 drivers/thermal/ti-soc-thermal/dra752-bandgap.h    |  19 --
 .../thermal/ti-soc-thermal/dra752-thermal-data.c   |  28 +-
 drivers/thermal/zx2967_thermal.c                   | 258
++++++++++++++++
 include/linux/thermal.h                            |   4 +-
 22 files changed, 890 insertions(+), 267 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/rcar-
gen3-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/zx2967-
thermal.txt
 create mode 100644 drivers/thermal/rcar_gen3_thermal.c
 create mode 100644 drivers/thermal/zx2967_thermal.c
