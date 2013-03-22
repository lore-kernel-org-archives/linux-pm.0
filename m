From: Rickard Andersson <rickard.andersson@stericsson.com>
Subject: [RFC PATCH 0/8] ux500 suspend-resume
Date: Fri, 22 Mar 2013 17:20:04 +0100
Message-ID: <1363969212-14864-1-git-send-email-rickard.andersson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu1sys200aog124.obsmtp.com ([207.126.144.157]:53076 "EHLO
	eu1sys200aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161005Ab3CVQjZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Mar 2013 12:39:25 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl, linux-pm@vger.kernel.org
Cc: daniel.lezcano@linaro.org, hongbo.zhang@linaro.org, khilman@linaro.org, ulf.hansson@linaro.org, linus.walleij@stericsson.com, rickard.andersson@stericsson.com

This patch series adds support for ux500 suspend/resume
operations with the sleep state ApSleep. (That is sleeping
with APE power domain turned off and ARM power domain in
retention).
Also this series adds the APE power domain to genpd and
introduces a new type of genpd notifiers that are used
for the special case when the context of a device needs to
be restored directly after a CPU coupled power domain (APE)
is turned on. An example of a device that needs to be
restored in such a way are also included in this series. The
example device is the PRCC clock device.


Rickard Andersson (8):
  mfd: db8500: Add IO force function
  ARM: ux500: Add platform suspend ops
  PM / Domains: Add on-off notifiers
  PM / Domains: Lookup domain by name
  ARM: ux500: Create APE generic power domain
  clk: ux500: Add PRCC power management
  Create u8500-clk device and add to genpd
  ARM: ux500: Add ApSleep state to suspend

 arch/arm/mach-ux500/Kconfig          |    1 +
 arch/arm/mach-ux500/Makefile         |    1 +
 arch/arm/mach-ux500/board-mop500.c   |   25 +++++++++-
 arch/arm/mach-ux500/cpu-db8500.c     |    1 +
 arch/arm/mach-ux500/devices-db8500.c |    5 ++
 arch/arm/mach-ux500/devices-db8500.h |    1 +
 arch/arm/mach-ux500/suspend.c        |   90 ++++++++++++++++++++++++++++++++++
 drivers/base/power/domain.c          |   65 +++++++++++++++++++++++-
 drivers/clk/ux500/clk-prcc.c         |   59 +++++++++++++++++++++-
 drivers/clk/ux500/clk.h              |    4 ++
 drivers/clk/ux500/u8500_clk.c        |   82 +++++++++++++++++++++++++++++++
 drivers/mfd/db8500-prcmu.c           |    9 ++++
 include/linux/mfd/db8500-prcmu.h     |    1 +
 include/linux/mfd/dbx500-prcmu.h     |    5 ++
 include/linux/pm_domain.h            |   28 ++++++++++-
 15 files changed, 373 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-ux500/suspend.c

-- 
1.7.9.4

