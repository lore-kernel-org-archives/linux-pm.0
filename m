From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal management fixes for v3.9-rc4
Date: Wed, 20 Mar 2013 15:09:15 +0800
Message-ID: <1363763355.2278.7.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:10755 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750850Ab3CTHJj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 20 Mar 2013 03:09:39 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>

Hi, Linus,

Please pull from the git repository at

  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

to get the thermal management fixes for 3.9-rc4 with top-most commit
043e4652bf3378883e7c0db38fa47fa8e2558f9c:

  thermal: exynos_thermal: return a proper error code while
thermal_zone_device_register fail. (2013-03-11 23:09:29 +0800)

on top of commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9:

  Linux 3.9-rc2 (2013-03-10 16:54:19 -0700)

thanks,
rui

----------------------------------------------------------------
Devendra Naga (2):
      thermal: rcar_thermal: propagate return value of
thermal_zone_device_register
      thermal: exynos_thermal: return a proper error code while
thermal_zone_device_register fail.

Sachin Kamat (3):
      Thermal: dove: Convert to devm_ioremap_resource()
      Thermal: rcar: Convert to devm_ioremap_resource()
      Thermal: kirkwood: Convert to devm_ioremap_resource()

Wei Yongjun (1):
      thermal: rcar: fix missing unlock on error in
rcar_thermal_update_temp()

 drivers/thermal/dove_thermal.c     |   16 ++++++----------
 drivers/thermal/exynos_thermal.c   |    2 +-
 drivers/thermal/kirkwood_thermal.c |    8 +++-----
 drivers/thermal/rcar_thermal.c     |   29 ++++++++++++++---------------
 4 files changed, 24 insertions(+), 31 deletions(-)


