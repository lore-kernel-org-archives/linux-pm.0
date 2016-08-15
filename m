From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL]  Thermal management updates for v4.8-rc2
Date: Mon, 15 Aug 2016 09:52:20 +0800
Message-ID: <1471225940.2859.4.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

to receive the latest Thermal Management updates for v4.8-rc2 with
top-most commit 1577ddfac75ff9690ebd0d210bc7f1345c9d29ef:

  Merge branches 'thermal-intel' and 'thermal-core' into next (2016-08-
08 10:59:35 +0800)

on top of commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

Specifics:
- Fix a race condition when updating cooling device, which may lead to
a situation where a thermal governor never updates the cooling device.
From Michele Di Giorgio.
- Fix a zero division error when disabling the forced idle injection
from the intel powerclamp. From: Petr Mladek.
- Add suspend/resume callback for intel_pch_thermal thermal driver.
From Srinivas Pandruvada.
- Another two fixes for clocking cooling driver and hwmon sysfs I/F.
>From Michele Di Giorgio and Kuninori Morimoto.

thanks,
rui

----------------------------------------------------------------
Kuninori Morimoto (1):
      thermal: hwmon: EXPORT_SYMBOL_GPL for thermal hwmon sysfs

Michele Di Giorgio (1):
      thermal: fix race condition when updating cooling device

Petr Mladek (1):
      thermal/powerclamp: Prevent division by zero when counting
interval

Srinivas Pandruvada (1):
      thermal: intel_pch_thermal: Add suspend/resume callback

Wei Yongjun (1):
      thermal: clock_cooling: Fix missing mutex_init()

Zhang Rui (1):
      Merge branches 'thermal-intel' and 'thermal-core' into next

 drivers/thermal/clock_cooling.c     |  1 +
 drivers/thermal/fair_share.c        |  2 ++
 drivers/thermal/gov_bang_bang.c     |  2 ++
 drivers/thermal/intel_pch_thermal.c | 60
++++++++++++++++++++++++++++++++++++-
 drivers/thermal/intel_powerclamp.c  | 11 ++++---
 drivers/thermal/power_allocator.c   |  2 ++
 drivers/thermal/step_wise.c         |  2 ++
 drivers/thermal/thermal_core.c      | 10 +++++--
 drivers/thermal/thermal_hwmon.c     |  2 ++
 9 files changed, 84 insertions(+), 8 deletions(-)
