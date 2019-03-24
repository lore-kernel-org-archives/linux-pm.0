From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal management updates for v5.1-rc2
Date: Sun, 24 Mar 2019 18:28:03 +0800
Message-ID: <1553423283.14989.6.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

to receive the latest Thermal management updates for v5.1-rc2 with
top-most commit 2d7c4e17811f766321b9c054609551fa40f0b445:

  Merge branches 'fixes' and 'thermal-intel' into next (2019-03-18
22:37:44 +0800)

on top of commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

Specifics:

- Fix a wrong __percpu structure declaration in intel_powerclamp
driver. (Luc Van Oostenryck)

- Fix truncated name of the idle injection kthreads created by
intel_powerclamp driver. (Zhang Rui)

- Fix the missing UUID supports in int3400 thermal driver. (Matthew
Garrett)

- Fix a crash when accessing the debugfs of bcm2835 SoC thermal driver.
(Phil Elwell)

- A couple of trivial fixes/cleanups in some SoC thermal drivers.

thanks,
rui

----------------------------------------------------------------
Luc Van Oostenryck (1):
      thermal/intel_powerclamp: fix __percpu declaration of worker_data

Marek Szyprowski (1):
      thermal: samsung: Fix incorrect check after code merge

Matthew Garrett (2):
      thermal/int340x_thermal: Add additional UUIDs
      thermal/int340x_thermal: fix mode setting

Phil Elwell (1):
      thermal: bcm2835: Fix crash in bcm2835_thermal_debugfs

Pi-Hsun Shih (1):
      thermal: mtk: Allocate enough space for mtk_thermal.

Shaokun Zhang (1):
      thermal: cpu_cooling: Remove unused cur_freq variable

Zhang Rui (2):
      thermal/intel_powerclamp: fix truncated kthread name
      Merge branches 'fixes' and 'thermal-intel' into next

 drivers/thermal/broadcom/bcm2835_thermal.c          |  9 ++++-----
 drivers/thermal/cpu_cooling.c                       |  3 +--
 .../thermal/intel/int340x_thermal/int3400_thermal.c | 21
+++++++++++++++++----
 drivers/thermal/intel/intel_powerclamp.c            |  4 ++--
 drivers/thermal/mtk_thermal.c                       |  7 +++++--
 drivers/thermal/samsung/exynos_tmu.c                |  2 +-
 6 files changed, 30 insertions(+), 16 deletions(-)
