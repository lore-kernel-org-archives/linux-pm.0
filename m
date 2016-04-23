From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal management updates for v4.6-rc5
Date: Sat, 23 Apr 2016 16:09:55 -0700
Message-ID: <20160423230954.GA23345@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34833 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbcDWXJ5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 23 Apr 2016 19:09:57 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Rui Zhang <rui.zhang@intel.com>

Hello Linus,

Here are a set of fixes on thermal subsystem.

Please consider pulling from

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

to receive Thermal Management updates for v4.6-rc5 with top-most

a6f4850dbca66e46a73b8774e85aaf9fc0caf265:

  thermal: fix Mediatek thermal controller build (2016-04-20 21:13:21 -0700)

on top of commit 55f058e7574c3615dea4615573a19bdb258696c6:

  Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6 (2016-04-20 12:00:07 -0700)

Specifics in this pull request:
- Fixes in mediatek and OF thermal drivers
- Fixes in power_allocator governor
- More fixes of unsigned to int type change in thermal_core.c.
- These change have been CI tested using KernelCI bot [1,2]. \o/

[1] - https://kernelci.org/boot/all/job/evalenti/kernel/v4.6-rc4-63-g58b76ffa037f/
[2] - https://kernelci.org/build/evalenti/kernel/v4.6-rc4-63-g58b76ffa037f/

BR,

Eduardo Valentin

----------------------------------------------------------------
Javi Merino (1):
      thermal: power_allocator: req_range multiplication should be a 64 bit type

Johannes Berg (1):
      thermal: fix Mediatek thermal controller build

Julia Lawall (1):
      thermal: of: add __init attribute

Randy Dunlap (2):
      thermal: minor mtk_thermal.c cleanups
      thermal: fix mtk_thermal build dependency

Wei Ni (1):
      thermal: consistently use int for trip temp

 drivers/thermal/Kconfig           | 2 ++
 drivers/thermal/mtk_thermal.c     | 3 +--
 drivers/thermal/of-thermal.c      | 4 ++--
 drivers/thermal/power_allocator.c | 2 +-
 drivers/thermal/thermal_core.c    | 8 ++++----
 include/linux/thermal.h           | 4 ++--
 6 files changed, 12 insertions(+), 11 deletions(-)
