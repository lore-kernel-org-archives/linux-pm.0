From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal management updates for v4.3-rc3
Date: Fri, 25 Sep 2015 09:48:15 +0800
Message-ID: <1443145695.6491.5.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:5503 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753190AbbIYBsZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 24 Sep 2015 21:48:25 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, "Zhang, Rui" <rui.zhang@intel.com>

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

to receive the latest Thermal Management updates for 4.3-rc3 with
top-most commit 97584d1838b7e2545c3b10aacef3327fcaa9531b:

  thermal: power_allocator: exit early if there are no cooling devices
(2015-09-20 15:37:16 +0800)

on top of commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)


Specifics:

- Power allocator governor changes to allow binding on thermal zones
with missing power estimates information. From: Javi Merino.

- Add compile test flags on thermal drivers that allow it without
producing compilation errors. From: Eduardo Valentin.

- Fixes around memory allocation on cpu_cooling. From: Javi Merino.

- Fix on db8500 cpufreq code to allow autoload. From: Luis de
Bethencourt.

- Maintainer entries for cpu cooling device.

thanks,
rui

----------------------------------------------------------------
Eduardo Valentin (10):
      thermal: hisi: allow compile test
      thermal: spear: allow compile test
      thermal: rockchip: allow compile test
      thermal: kirkwood: allow compile test
      thermal: dove: allow compile test
      thermal: armada: allow compile test
      thermal: exynos: allow compile test
      thermal: qcom_spmi: allow compile test
      thermal: ti-soc: allow compile test
      thermal: ti-soc: Kconfig fix to avoid menu showing wrongly

Javi Merino (7):
      thermal: cpu_cooling: don't call kcalloc() under rcu_read_lock
      thermal: cpu_cooling: free power table on error or when
unregistering
      thermal: Add a function to get the minimum power
      thermal: power_allocator: relax the requirement of a
sustainable_power in tzp
      thermal: power_allocator: relax the requirement of two passive
trip points
      thermal: power_allocator: don't require tzp to be present for the
thermal zone
      thermal: power_allocator: exit early if there are no cooling
devices

Luis de Bethencourt (1):
      thermal: db8500_cpufreq_cooling: Fix module autoload for OF
platform driver

Punit Agrawal (1):
      thermal: Fix thermal_zone_of_sensor_register to match
documentation

Viresh Kumar (1):
      thermal: cpu_cooling: Add MAINTAINERS entry

 Documentation/thermal/power_allocator.txt |   2 +-
 MAINTAINERS                               |  10 ++
 drivers/thermal/Kconfig                   |  17 ++-
 drivers/thermal/cpu_cooling.c             |  52 ++++---
 drivers/thermal/db8500_cpufreq_cooling.c  |   1 +
 drivers/thermal/power_allocator.c         | 243
++++++++++++++++++++++--------
 drivers/thermal/thermal_core.c            |  28 ++++
 drivers/thermal/ti-soc-thermal/Kconfig    |   8 +-
 include/linux/thermal.h                   |   8 +-
 9 files changed, 269 insertions(+), 100 deletions(-)


