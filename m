From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal management updates for v4.6-rc6
Date: Sat, 30 Apr 2016 16:05:31 -0700
Message-ID: <20160430230530.GA11246@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Rui Zhang <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

Hello Linus,

Here are only a couple of minor fixes on thermal subsystem.

Please consider pulling from

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

to receive Thermal Management updates for v4.6-rc6 with top-most

15333e3af1de37b1b214b28c85fe9a7b257fb92c:

  thermal: use %d to print S32 parameters (2016-04-27 15:54:51 -0700)

on top of commit 913f201083c81cf021f050d041352ac854c4b526:

  Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal (2016-04-23 17:15:39 -0700)

Specifics in this pull request:
- Fixes in hisilicon thermal driver
- More fixes of unsigned to int type change in thermal_core.c.
- These change have been CI tested using KernelCI bot [1,2]. \o/

[1] - https://kernelci.org/boot/all/job/evalenti/kernel/v4.6-rc4-285-gddc8fdc6e2f0/
[2] - https://kernelci.org/build/evalenti/kernel/v4.6-rc4-285-gddc8fdc6e2f0/

BR,

Eduardo Valentin

----------------------------------------------------------------
Leo Yan (2):
      thermal: hisilicon: increase temperature resolution
      thermal: use %d to print S32 parameters

 drivers/thermal/hisi_thermal.c | 4 ++--
 drivers/thermal/thermal_core.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)
