From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal management updates for v4.17-rc5
Date: Sun, 13 May 2018 00:15:02 +0800
Message-ID: <1526141702.2067.4.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, "Zhang, Rui" <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

to receive the latest Thermal Management updates for v4.17-rc5 with
top-most commit 60abce9f43d812dfec6687a10ca30be380f6f97a:

  Merge branch 'thermal-soc' into next (2018-05-11 09:37:21 +0800)

on top of commit 6d08b06e67cd117f6992c46611dfb4ce267cd71e:

  Linux 4.17-rc2 (2018-04-22 19:20:09 -0700)

Specifics:

- Fix NULL pointer deref on module load/probe, for int3403_thermal
driver.

- Fix an emergency shutdown issue on exynos thermal driver.


thanks,
rui

----------------------------------------------------------------
Hans de Goede (1):
      thermal: int3403_thermal: Fix NULL pointer deref on module load /
probe

Marek Szyprowski (2):
      thermal: exynos: Reading temperature makes sense only when TMU is
turned on
      thermal: exynos: Propagate error value from tmu_read()

Zhang Rui (1):
      Merge branch 'thermal-soc' into next

 drivers/thermal/int340x_thermal/int3403_thermal.c |  3 +--
 drivers/thermal/samsung/exynos_tmu.c              | 14 +++++++++++---
 2 files changed, 12 insertions(+), 5 deletions(-)
