From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal management updates for v4.20-rc1
Date: Wed, 31 Oct 2018 09:24:43 +0800
Message-ID: <1540949083.2254.62.camel@intel.com>
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

to receive the latest Thermal management updates for v4.20-rc1 with
top-most commit c2b59d279dbbac750958f6a1bc4841e431d934e3:

  thermal: core: using power_efficient_wq for thermal worker (2018-10-
10 21:48:50 +0800)

on top of commit 0238df646e6224016a45505d2c111a24669ebe21:

  Linux 4.19-rc7 (2018-10-07 17:26:02 +0200)

Specifics:
- Fix a use-after-free issue when unregistering a thermal cooling
device.(Dmitry Osipenko)

- use power_efficient_wq for thermal worker to save more power. (Jeson
Gao)

thanks,
rui

----------------------------------------------------------------
Dmitry Osipenko (1):
      thermal: core: Fix use-after-free in
thermal_cooling_device_destroy_sysfs

Jeson Gao (1):
      thermal: core: using power_efficient_wq for thermal worker

 drivers/thermal/thermal_core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)
