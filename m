From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal Management updates for v4.5-rc1
Date: Sun, 24 Jan 2016 08:44:09 +0800
Message-ID: <1453596249-17447-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28502 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751520AbcAXAjl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 23 Jan 2016 19:39:41 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: linux-pm@vger.kernel.org, rui.zhang@intel.com

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

to receive the latest Thermal Management updates for 4.5-rc1 with top-most
commit 98d94507e10c3c0a5cfc1c3ac4df23e761f1b874:

  Merge branches 'thermal-intel', 'thermal-suspend-fix' and 'thermal-soc' into next (2016-01-23 11:43:27 +0800)

on top of commit 74bf8efb5fa6e958d2d7c7917b8bb672085ec0c6:

  Linux 4.4-rc7 (2015-12-27 18:17:37 -0800)


The merge commit is generated yesterday because two topic branches were dropped from this pull request in the last minute due to some unaddressed comments. All the other material has been in linux-next for quite a while.

Specifics:

- Enhance thermal core to handle unexpected device cooling states after fresh boot and system resume. From: Zhang Rui, Chen Yu.

- Several fixes and cleanups on Rockchip and RCAR thermal drivers. From: Caesar Wang and Kuninori Morimoto.

- Add Broxton support for Intel processor thermal reporting device driver. From: Amy Wiles.

thanks,
rui

----------------------------------------------------------------

Amy Wiles (1):
      Thermal: Enable Broxton SoC thermal reporting device

Caesar Wang (4):
      thermal: rockchip: fix a trivial typo
      dt-bindings: rockchip-thermal: Support the RK3228/RK3399 SoCs compatible
      thermal: rockchip: Support the RK3228 SoCs in thermal driver
      thermal: rockchip: Support the RK3399 SoCs in thermal driver

Chen Yu (1):
      Thermal: do thermal zone update after a cooling device registered

Julia Lawall (1):
      thermal: constify pch_dev_ops structure

Kuninori Morimoto (5):
      thermal: rcar: move rcar_thermal_dt_ids to upside
      thermal: rcar: check every rcar_thermal_update_temp() return value
      thermal: rcar: check irq possibility in rcar_thermal_irq_xxx()
      thermal: rcar: rcar_thermal_get_temp() return error if strange temp
      thermal: trip_point_temp_store() calls thermal_zone_device_update()

Zhang Rui (3):
      Thermal: initialize thermal zone device correctly
      Thermal: handle thermal zone device properly during system sleep
      Merge branches 'thermal-intel', 'thermal-suspend-fix' and 'thermal-soc' into next

 .../bindings/thermal/rockchip-thermal.txt          |   2 +
 .../int340x_thermal/processor_thermal_device.c     |  10 ++
 drivers/thermal/intel_pch_thermal.c                |   2 +-
 drivers/thermal/rcar_thermal.c                     |  53 ++++---
 drivers/thermal/rockchip_thermal.c                 | 172 +++++++++++++++++++--
 drivers/thermal/step_wise.c                        |  17 +-
 drivers/thermal/thermal_core.c                     |  81 +++++++++-
 drivers/thermal/thermal_core.h                     |   1 +
 include/linux/thermal.h                            |   5 +
 9 files changed, 304 insertions(+), 39 deletions(-)
