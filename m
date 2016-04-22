From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 0/9] cpufreq: dt: Don't create platform-device from platform code
Date: Fri, 22 Apr 2016 16:58:38 +0530
Message-ID: <cover.1461324267.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34973 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626AbcDVL3K (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Apr 2016 07:29:10 -0400
Received: by mail-pf0-f177.google.com with SMTP id n1so40710413pfn.2
        for <linux-pm@vger.kernel.org>; Fri, 22 Apr 2016 04:29:10 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu Tsai <wens@csie.org>, Leo Yan <leo.yan@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Michal Simek <michal.simek@xilinx.com>, Sascha Hauer <kernel@pengutronix.de>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Simon Horman <horms@verge.net.au>, =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>, Tony Lindgren <tony@atomide.com>

Hi Rafael,

This migrates rest of the platforms to use cpufreq-dt-platdev.c. There
are few exceptions though:
- mvebu: it uses platform data and its problem will be solved in a
  separate series.
- highbank, s5pv210, sti, tegra124: these platforms already have cpufreq
  drivers in drivers/cpufreq/, which does some other stuff and finally
  create the device. There are sequencing issues, and so they will be
  left as it is.

V1->V2:
- Acks from Arnd for all the patches and from few other maintainers
- Finley sent his patch for rockchip 2 minutes before I sent mine :), and so I
  picked his patch instead of mine.
- First patch is new based on suggestions from Geert.
- Arnd suggested to get rid of a init routine in imx patch, that's done as well.

I think we can push this series now that its been Acked by Arnd..

Finley Xiao (1):
  cpufreq: rockchip: Use generic platdev driver

Viresh Kumar (8):
  cpufreq: dt: Mark platdev machines array as __initconst
  cpufreq: berlin: Use generic platdev driver
  cpufreq: imx: Use generic platdev driver
  cpufreq: omap: Use generic platdev driver
  cpufreq: shmobile: Use generic platdev driver
  cpufreq: sunxi: Use generic platdev driver
  cpufreq: zynq: Use generic platdev driver
  cpufreq: hisilicon: Use generic platdev driver

 arch/arm/mach-berlin/berlin.c        |  6 ----
 arch/arm/mach-imx/imx27-dt.c         | 10 -------
 arch/arm/mach-imx/mach-imx51.c       |  3 --
 arch/arm/mach-imx/mach-imx53.c       |  2 --
 arch/arm/mach-imx/mach-imx7d.c       |  6 ----
 arch/arm/mach-omap2/pm.c             |  7 ++---
 arch/arm/mach-rockchip/rockchip.c    |  1 -
 arch/arm/mach-shmobile/Makefile      |  1 -
 arch/arm/mach-shmobile/common.h      |  7 -----
 arch/arm/mach-shmobile/cpufreq.c     | 19 -------------
 arch/arm/mach-sunxi/sunxi.c          |  9 ------
 arch/arm/mach-zynq/common.c          |  2 --
 drivers/cpufreq/Kconfig.arm          |  9 ------
 drivers/cpufreq/Makefile             |  1 -
 drivers/cpufreq/cpufreq-dt-platdev.c | 53 +++++++++++++++++++++++++++++++++++-
 drivers/cpufreq/hisi-acpu-cpufreq.c  | 42 ----------------------------
 16 files changed, 54 insertions(+), 124 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/cpufreq.c
 delete mode 100644 drivers/cpufreq/hisi-acpu-cpufreq.c

-- 
2.7.1.410.g6faf27b

