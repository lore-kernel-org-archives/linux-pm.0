From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal-SoC management updates for v4.4-rc3
Date: Tue, 24 Nov 2015 09:29:55 -0800
Message-ID: <20151124172953.GB14845@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35485 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483AbbKXR37 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2015 12:29:59 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Rui Zhang <rui.zhang@intel.com>

Hello Rui,

Please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

to receive Thermal-SoC Management updates for v4.4-rc3 with top-most

a2291badc355d58ead5c19ae0609468947416040:

  imx: thermal: use CPU temperature grade info for thresholds (2015-11-23 16:38:40 -0800)

on top of commit 5d50ac70fe98518dbf620bfba8184254663125eb:

  Merge tag 'xfs-for-linus-4.4' of git://git.kernel.org/pub/scm/linux/kernel/git/dgc/linux-xfs (2015-11-11 20:18:48 -0800)

Specifics in this pull request:
- Several fixes and cleanups on Rockchip thermal drivers.
- On top of fixes, Rockchip driver also learned how to handle RK3368.
- Small fixes on: of-thermal, power_allocator, rcar driver, IMX, and QCOM drivers.
  Also, compilation fixes, on thermal.h, when thermal is not selected.
- Build/boot tests powered by KernelCI [1,2] \o/

This pull request contains extra fixes on top of the rc pull request. Essentially
the same pull, with a couple of extra fixes. The reason is because the content
of my pull for rc2 was not merged, so resending.

[1] - http://kernelci.org/boot/all/job/evalenti/kernel/v4.3-11641-ge07efb9b60d4/
[2] - http://kernelci.org/build/evalenti/kernel/v4.3-11641-ge07efb9b60d4/

BR,

Eduardo Valentin
----------------------------------------------------------------
Arnd Bergmann (2):
      Revert "thermal: qcom_spmi: allow compile test"
      thermal: fix thermal_zone_bind_cooling_device prototype

Caesar Wang (7):
      dt-bindings: rockchip-thermal: Support the RK3368 SoCs compatible
      thermal: rockchip: better to compatible the driver for different SoCs
      thermal: rockchip: trivial: fix typo in commit
      thermal: rockchip: improve the conversion function
      thermal: rockchip: Add the sort mode for adc value increment or decrement
      thermal: rockchip: consistently use int for temperatures
      thermal: rockchip: Support the RK3368 SoCs in thermal driver

Jiada Wang (1):
      thermal: of-thermal: Reduce log level for message when can't fine thermal zone

Kapileshwar Singh (1):
      thermal: power_allocator: Use temperature reading from tz

Kuninori Morimoto (1):
      thermal: rcar_thermal: remove redundant operation

Tim Harvey (1):
      imx: thermal: use CPU temperature grade info for thresholds

 .../bindings/thermal/rockchip-thermal.txt          |   4 +-
 drivers/thermal/Kconfig                            |   2 +-
 drivers/thermal/imx_thermal.c                      |  56 +++-
 drivers/thermal/of-thermal.c                       |   2 +-
 drivers/thermal/power_allocator.c                  |  24 +-
 drivers/thermal/rcar_thermal.c                     |  49 ++-
 drivers/thermal/rockchip_thermal.c                 | 328 +++++++++++++++------
 include/linux/thermal.h                            |   3 +-
 8 files changed, 316 insertions(+), 152 deletions(-)
