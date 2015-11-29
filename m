From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal Management fixes for v4.4-rc3
Date: Sun, 29 Nov 2015 09:37:19 +0800
Message-ID: <1448761039.15355.6.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12628 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752788AbbK2Bh2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 28 Nov 2015 20:37:28 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

to receive the latest Thermal Management updates for 4.4-rc3 with
top-most commit a2291badc355d58ead5c19ae0609468947416040:

  imx: thermal: use CPU temperature grade info for thresholds
(2015-11-23 16:38:40 -0800)

on top of commit 5d50ac70fe98518dbf620bfba8184254663125eb:

  Merge tag 'xfs-for-linus-4.4' of
git://git.kernel.org/pub/scm/linux/kernel/git/dgc/linux-xfs (2015-11-11
20:18:48 -0800)


Specifics:

- Several fixes and cleanups on Rockchip thermal drivers.
- Add the missing support of RK3368 SoCs in Rockchip driver.
- Small fixes on of-thermal, power_allocator, rcar driver, IMX, and QCOM
drivers, and also compilation fixes, on thermal.h, when thermal is not
selected.

thanks,
rui

----------------------------------------------------------------
Arnd Bergmann (2):
      Revert "thermal: qcom_spmi: allow compile test"
      thermal: fix thermal_zone_bind_cooling_device prototype

Caesar Wang (7):
      dt-bindings: rockchip-thermal: Support the RK3368 SoCs compatible
      thermal: rockchip: better to compatible the driver for different
SoCs
      thermal: rockchip: trivial: fix typo in commit
      thermal: rockchip: improve the conversion function
      thermal: rockchip: Add the sort mode for adc value increment or
decrement
      thermal: rockchip: consistently use int for temperatures
      thermal: rockchip: Support the RK3368 SoCs in thermal driver

Jiada Wang (1):
      thermal: of-thermal: Reduce log level for message when can't fine
thermal zone

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
 drivers/thermal/rockchip_thermal.c                 | 328
+++++++++++++++------
 include/linux/thermal.h                            |   3 +-
 8 files changed, 316 insertions(+), 152 deletions(-)


