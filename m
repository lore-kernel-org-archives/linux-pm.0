From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL V2] Thermal management updates for v4.17-rc1
Date: Fri, 13 Apr 2018 22:04:22 +0800
Message-ID: <1523628262.2142.4.camel@intel.com>
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

to receive the latest Thermal Management updates for v4.17-rc1 with
top-most commit b907b408ca64482989cd95dacef804ce509a3673:

  Merge branches 'thermal-core' and 'thermal-soc' into next (2018-04-13 
14:11:53 +0800)

on top of commit 0c8efd610b58cb23cefdfa12015799079aef94ae:

  Linux 4.16-rc5 (2018-03-11 17:25:09 -0700)

Differences in V2:
- Dropped all patches from thermal-soc tree, including the exynos patch
that introduces the compiler warnings.

Specifics:

- Fix race condition in imx_thermal_probe(). (Mikhail Lappo)

- Add cooling device's statistics in sysfs. (Viresh Kumar)

thanks,
rui

----------------------------------------------------------------
Mikhail Lappo (1):
      thermal: imx: Fix race condition in imx_thermal_probe()

Viresh Kumar (1):
      thermal: Add cooling device's statistics in sysfs

Zhang Rui (1):
      Merge branches 'thermal-core' and 'thermal-soc' into next

 Documentation/thermal/sysfs-api.txt |  31 +++++
 drivers/thermal/Kconfig             |   7 ++
 drivers/thermal/imx_thermal.c       |   6 +-
 drivers/thermal/thermal_core.c      |   3 +-
 drivers/thermal/thermal_core.h      |  10 ++
 drivers/thermal/thermal_helpers.c   |   5 +-
 drivers/thermal/thermal_sysfs.c     | 225
++++++++++++++++++++++++++++++++++++
 include/linux/thermal.h             |   1 +
 8 files changed, 283 insertions(+), 5 deletions(-)
