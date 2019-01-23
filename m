From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal management updates for v5.0-rc4
Date: Wed, 23 Jan 2019 10:45:21 +0800
Message-ID: <1548211521.4006.10.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git for-rc

to receive the latest Thermal management updates for v5.0-rc4 with
top-most commit 129699bb8c7572106b5bbb2407c2daee4727ccad:

  drivers: thermal: int340x_thermal: Fix sysfs race condition (2019-01-
18 15:23:04 +0800)

on top of commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

Specifics:

- Fix a race condition that sysfs could be accessed before necessary
initialization in int340x thermal driver. (Aaron Hill)

- Fix a NULL vs IS_ERR() check in int340x thermal driver. (Dan
Carpenter)

thanks,
rui

----------------------------------------------------------------
Aaron Hill (1):
      drivers: thermal: int340x_thermal: Fix sysfs race condition

Dan Carpenter (1):
      thermal: int340x_thermal: Fix a NULL vs IS_ERR() check

 .../int340x_thermal/processor_thermal_device.c     | 30 ++++++++++++
----------
 1 file changed, 16 insertions(+), 14 deletions(-)
