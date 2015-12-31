From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal-SoC management updates for v4.4-rc8
Date: Thu, 31 Dec 2015 10:07:11 -0800
Message-ID: <20151231180709.GA13780@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Rui Zhang <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

Hello Rui,

Please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

to receive Thermal-SoC Management updates for v4.4-rc8 with top-most

ebe580748d7c33bfd308f09b825dff15fa2eccf2:

  thermal: trip_point_temp_store() calls thermal_zone_device_update() (2015-12-31 09:41:52 -0800)

on top of commit c6169202e40868fd00de7ce35ee16c81b1f9e123:

  Merge branch 'for-linus' of git://git.kernel.dk/linux-block (2015-12-30 10:26:20 -0800)

Specifics in this pull request:
- Several fixes and cleanups on Rockchip thermal drivers.
- Several fixes and cleanups on RCAR thermal drivers.
- Build/boot tests powered by KernelCI [1,2] \o/

BTW, I have rebase my -fixes branch on top of linus master branch, as you reported
merge conflict. Please let me know if this branch causes troubles for you.

[1] - https://kernelci.org/boot/all/job/evalenti/kernel/v4.4-rc5-27-gce0265dd6f8e/
[2] - https://kernelci.org/build/evalenti/kernel/v4.4-rc5-27-gce0265dd6f8e/

BR,

Eduardo Valentin

----------------------------------------------------------------
Caesar Wang (4):
      thermal: rockchip: fix a trivial typo
      dt-bindings: rockchip-thermal: Support the RK3228/RK3399 SoCs compatible
      thermal: rockchip: Support the RK3228 SoCs in thermal driver
      thermal: rockchip: Support the RK3399 SoCs in thermal driver

Kuninori Morimoto (5):
      thermal: rcar: move rcar_thermal_dt_ids to upside
      thermal: rcar: check every rcar_thermal_update_temp() return value
      thermal: rcar: check irq possibility in rcar_thermal_irq_xxx()
      thermal: rcar: rcar_thermal_get_temp() return error if strange temp
      thermal: trip_point_temp_store() calls thermal_zone_device_update()

 .../bindings/thermal/rockchip-thermal.txt          |   2 +
 drivers/thermal/rcar_thermal.c                     |  53 ++++---
 drivers/thermal/rockchip_thermal.c                 | 172 +++++++++++++++++++--
 drivers/thermal/thermal_core.c                     |   6 +-
 4 files changed, 200 insertions(+), 33 deletions(-)
