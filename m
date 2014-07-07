From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal Management updates for v3.16-rc5
Date: Mon, 07 Jul 2014 22:56:14 +0800
Message-ID: <1404744974.2291.67.camel@rzhang1-toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:3499 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752941AbaGGO4R (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 7 Jul 2014 10:56:17 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Please pull from the git repository at

  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git for-rc

to receive Thermal management updates for v3.16-rc5 with
top-most commit 4adccf9fc84aaf5e4d18442e163d549e0b603075:

  tmon: set umask to a reasonable value (2014-07-01 22:00:51 +0800)

on top of commit a497c3ba1d97fc69c1e78e7b96435ba8c2cb42ee:

  Linux 3.16-rc2 (2014-06-21 19:02:54 -1000)

Specifics:

- Update Email address of Thermal subsystem maintainer Eduardo Valentin.

- Fix a problem that unloading thermal module results in kernel crash
because a non-exist device file is removed on thermal unload.

- Fix a problem that critical trip point is set wrongly on latest i.MX6
SOC and results in system critical shutdown.

- a couple of fixes to Tmon tool, of-thermal code and ti thermal driver.

thanks,
rui

----------------------------------------------------------------
Aaron Lu (1):
      thermal: hwmon: Make the check for critical temp valid consistent

Anson Huang (1):
      Thermal: imx: correct critical trip temperature setting

Javi Merino (1):
      tools/thermal: tmon: fix compilation errors when building
statically

Lee Jones (1):
      MAINTAINERS: Update Eduardo Valentin's email address

Neil Horman (2):
      tmon: Check log file for common secuirty issues
      tmon: set umask to a reasonable value

Punit Agrawal (1):
      thermal: Bind cooling devices with the correct arguments

Rickard Strandqvist (1):
      thermal: ti-soc-thermal: ti-bandgap.c: Cleaning up wrong address
is checked

Stephen Boyd (1):
      thermal: Add braces around suspect code

 MAINTAINERS                                 |  4 ++--
 drivers/thermal/imx_thermal.c               | 18 +++++++-----------
 drivers/thermal/of-thermal.c                |  7 ++++---
 drivers/thermal/thermal_hwmon.c             | 33
++++++++++++++++++---------------
 drivers/thermal/ti-soc-thermal/ti-bandgap.c |  2 +-
 tools/thermal/tmon/Makefile                 |  2 +-
 tools/thermal/tmon/tmon.c                   | 26
+++++++++++++++++++++++++-
 7 files changed, 58 insertions(+), 34 deletions(-)


