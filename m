From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 00/15] ARM: cpuidle: code consolidation
Date: Mon, 25 Mar 2013 18:55:25 +0100
Message-ID: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:51420 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758819Ab3CYRzk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Mar 2013 13:55:40 -0400
Received: by mail-we0-f169.google.com with SMTP id x43so965987wey.28
        for <linux-pm@vger.kernel.org>; Mon, 25 Mar 2013 10:55:39 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl, tglx@linutronix.de
Cc: patches@linaro.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, lenb@kernel.org, nsekhar@ti.com, kevin.hilman@linaro.org, horms@verge.net.au, magnus.damm@gmail.com, kernel@pengutronix.de, ben-linux@fluff.org, kgene.kim@samsung.com, rob.herring@calxeda.com, jason@lakedaemon.net, andrew@lunn.ch, linus.walleij@linaro.org, linux@arm.linux.org.uk

The flag CPUIDLE_FLAG_TIMER_STOP has been introduced in the commit
89878baa73f0f1c679355006bd8632e5d78f96c2.

The flag tells the cpuidle framework the local timer will stop in the
idle state.

It is now easy to know if the cpuidle driver will use or not the broadcast
timer by looking at the different states for this flag and then setup
the broadcast timer consequently.

When we remove the timer initialization duplicated code in the different
drivers, we have most of the drivers with the same init function. This
init function is changed to be generic and moved in the ARM cpuidle driver
and used from the drivers. That cleanups code and removes a lot of annoying
duplicated code.

There is still some modification in OMAP4, tegra2, tegra3 and imx, especially
around the coupled idle states, but we are more and more closer to a common
squeleton for all the ARM drivers.

Daniel Lezcano (15):
  timer: move enum definition out of ifdef section
  cpuidle: initialize the broadcast timer framework
  cpuidle: ux500: remove timer broadcast initialization
  cpuidle: OMAP4: remove timer broadcast initialization
  cpuidle: imx6: remove timer broadcast initialization
  ARM: cpuidle: remove useless declaration
  ARM: cpuidle: add init/exit routine
  ARM: ux500: cpuidle: use init/exit common routine
  ARM: at91: cpuidle: use init/exit common routine
  ARM: OMAP3: cpuidle: use init/exit common routine
  ARM: s3c64xx: cpuidle: use init/exit common routine
  ARM: tegra1: cpuidle: use init/exit common routine
  ARM: shmobile: pm: fix init sections
  ARM: shmobile: cpuidle: remove useless WFI function
  ARM: shmobile: cpuidle: use init/exit common routine

 arch/arm/include/asm/cpuidle.h         |   11 +++---
 arch/arm/kernel/cpuidle.c              |   57 +++++++++++++++++++++++++++++++-
 arch/arm/mach-at91/cpuidle.c           |   17 ++--------
 arch/arm/mach-imx/cpuidle-imx6q.c      |   15 ---------
 arch/arm/mach-omap2/cpuidle34xx.c      |   18 ++--------
 arch/arm/mach-omap2/cpuidle44xx.c      |   14 --------
 arch/arm/mach-s3c64xx/cpuidle.c        |   15 ++-------
 arch/arm/mach-shmobile/cpuidle.c       |   22 ++----------
 arch/arm/mach-shmobile/pm-sh7372.c     |    4 +--
 arch/arm/mach-tegra/cpuidle-tegra114.c |   27 +--------------
 arch/arm/mach-ux500/cpuidle.c          |   50 +---------------------------
 drivers/cpuidle/driver.c               |   35 ++++++++++++++++++--
 include/linux/clockchips.h             |   22 ++++++------
 include/linux/cpuidle.h                |    2 ++
 14 files changed, 120 insertions(+), 189 deletions(-)

-- 
1.7.9.5

