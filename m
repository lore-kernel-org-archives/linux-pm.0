From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal management updates for v4.15-rc1
Date: Fri, 17 Nov 2017 09:30:06 +0800
Message-ID: <1510882206.19523.17.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:58042 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753929AbdKQBaJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Nov 2017 20:30:09 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

to receive the latest Thermal Management updates for v4.15-rc1 with
top-most commit 1e032393d9680c1f3b5238ec0f3f4eb006ee83d2:

  Merge branches 'thermal-core', 'thermal-tool', 'thermal-intel' and
'thermal-soc' into next (2017-11-02 16:32:25 +0800)

on top of commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

Specifics:

- Introduce brcmstb AVS TMON thermal driver. (Brian Norris)
- Add Rockchip RV1108 support in rockchip thermal driver.
  (Rocky Hao)
- Major rework on HISI driver plus additional support of hisi3660.
  (Daniel Lezcano)
- Add nvmem-cells binding on imx6sx. (Leonard Crestez)
- Fix a NULL pointer dereference on ti thermal driver unloading.
  (Tony Lindgren)
- improve tmon tool to make it easier to cross-compile tmon.
  (Markus Mayer)
- Add Coffee Lake and Cannon Lake support for intel processor and pch
  thermal drivers. (Srinivas Pandruvada)
- Other small fixes and cleanups. (Arvind Yadav, Colin Ian King, Allen
  Wild, Nicolin Chen, Baruch SiachNiklas Söderlund, Arnd Bergmann)

thanks,
rui

----------------------------------------------------------------
Allen Wild (1):
      thermal: enable broadcom menu for arm64 bcm2835

Arnd Bergmann (1):
      thermal: imx: add NVMEM dependency

Arvind Yadav (3):
      thermal : Remove const to make same prototype
      thermal/intel_powerclamp: pr_err()/pr_info() strings should end
with newlines
      thermal: cpu_cooling: pr_err() strings should end with newlines

Baruch Siach (1):
      thermal: armada: fix formula documentation comment

Brian Norris (2):
      Documentation: devicetree: add binding for Broadcom STB AVS TMON
      thermal: add brcmstb AVS TMON driver

Colin Ian King (1):
      thermal: bxt: remove redundant variable trip

Daniel Lezcano (16):
      thermal/drivers/hisi: Fix missing interrupt enablement
      thermal/drivers/hisi: Remove the multiple sensors support
      thermal/drivers/hisi: Fix kernel panic on alarm interrupt
      thermal/drivers/hisi: Simplify the temperature/step computation
      thermal/drivers/hisi: Fix multiple alarm interrupts firing
      thermal/drivers/hisi: Remove pointless lock
      thermal/drivers/hisi: Encapsulate register writes into helpers
      thermal/drivers/hisi: Fix configuration register setting
      thermal/drivers/hisi: Remove costly sensor inspection
      thermal/drivers/hisi: Rename and remove unused field
      thermal/drivers/hisi: Convert long to int
      thermal/drivers/hisi: Remove thermal data back pointer
      thermal/drivers/hisi: Remove mutex_lock in the code
      thermal/drivers/step_wise: Fix temperature regulation misbehavior
      thermal/drivers/generic-iio-adc: Switch tz request to devm
version
      thermal/drivers/qcom-spmi: Use devm_iio_channel_get

Kevin Wangtao (6):
      thermal/drivers/hisi: Move the clk setup in the corresponding
functions
      thermal/drivers/hisi: Use round up step value
      thermal/drivers/hisi: Put platform code together
      thermal/drivers/hisi: Add platform prefix to function name
      thermal/drivers/hisi: Prepare to add support for other hisi
platforms
      thermal/drivers/hisi: Add support for hi3660 SoC

Leonard Crestez (2):
      thermal: imx: Add nvmem-cells alternate binding for OCOTP access
      thermal: imx: Add support for reading OCOTP through nvmem

Markus Mayer (3):
      tools/thermal: tmon: use "-fstack-protector" only if supported
      tools/thermal: tmon: allow $(CC) to be defined externally
      tools/thermal: tmon: use $(PKG_CONFIG) instead of hard-coding
pkg-config

Nicolin Chen (1):
      thermal: tegra: remove null check for dev pointer

Niklas Söderlund (1):
      thermal: rcar_gen3_thermal: fix initialization sequence for H3
ES2.0

Rocky Hao (2):
      dt-bindings: rockchip-thermal: Support the RV1108 SoC compatible
      thermal: rockchip: Support the RV1108 SoC in thermal driver

Srinivas Pandruvada (3):
      thermal: int340x: processor_thermal: Add Cannon Lake support
      thermal: int340x: processor_thermal: Add Coffee Lake support
      thermal: pch: Add Cannon Lake support

Tony Lindgren (1):
      thermal: ti-soc-thermal: Fix ti_thermal_unregister_cpu_cooling
NULL pointer on unload

Zhang Rui (2):
      Merge branch 'imx-nvmem' into thermal-soc
      Merge branches 'thermal-core', 'thermal-tool', 'thermal-intel'
and 'thermal-soc' into next

 .../devicetree/bindings/thermal/brcm,avs-tmon.txt  |  20 +
 .../devicetree/bindings/thermal/imx-thermal.txt    |   7 +
 .../bindings/thermal/rockchip-thermal.txt          |   1 +
 MAINTAINERS                                        |   8 +
 drivers/thermal/Kconfig                            |   3 +-
 drivers/thermal/armada_thermal.c                   |   2 +-
 drivers/thermal/broadcom/Kconfig                   |   7 +
 drivers/thermal/broadcom/Makefile                  |   1 +
 drivers/thermal/broadcom/brcmstb_thermal.c         | 387 +++++++++++++
 drivers/thermal/cpu_cooling.c                      |   2 +-
 drivers/thermal/hisi_thermal.c                     | 612
++++++++++++++-------
 drivers/thermal/imx_thermal.c                      | 104 +++-
 .../int340x_thermal/processor_thermal_device.c     |   6 +
 drivers/thermal/intel_bxt_pmic_thermal.c           |   3 +-
 drivers/thermal/intel_pch_thermal.c                |  11 +
 drivers/thermal/intel_powerclamp.c                 |   4 +-
 drivers/thermal/qcom-spmi-temp-alarm.c             |  43 +-
 drivers/thermal/rcar_gen3_thermal.c                |  34 +-
 drivers/thermal/rockchip_thermal.c                 |  67 +++
 drivers/thermal/step_wise.c                        |  11 +-
 drivers/thermal/tegra/soctherm.c                   |   2 +-
 drivers/thermal/thermal-generic-adc.c              |  24 +-
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |   3 +-
 include/linux/thermal.h                            |   2 +-
 tools/thermal/tmon/Makefile                        |  18 +-
 25 files changed, 1055 insertions(+), 327 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,avs-
tmon.txt
 create mode 100644 drivers/thermal/broadcom/brcmstb_thermal.c
