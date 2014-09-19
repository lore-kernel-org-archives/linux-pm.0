From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH 0/5] i.MX53 cpufreq support
Date: Fri, 19 Sep 2014 18:16:16 +0200
Message-ID: <1411143381-10516-1-git-send-email-l.stach@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48970 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756797AbaISQQq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Sep 2014 12:16:46 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, kernel@pengutronix.de

This series implements cpufreq support for the i.MX53 SoC
using the generic cpufreq-cpu0 driver. The design is based
on feedback I got on the last round of patches.

Basically this implements a CPU clock type that abstracts away
all the clock handling required for reprogramming the PLL
feeding the CPU, so we don't have to worry about this in the
cpufreq driver. For now this is only used on MX53, but looking
forward the same approach (and code) could be used on MX6.

The first patch allows cpufreq-cpu0 to deactivate OPPs where
the regulator isn't able to provide the required voltage. This
has been tested on custom a MX53 board.

Lucas Stach (5):
  cpufreq: cpu0: disable unsupported OPPs
  clk: imx5: add step clock, used when reprogramming PLL1
  clk: imx: add CPU clock type
  arm: imx53: clk: add ARM clock
  ARM: imx53: add cpufreq support

 arch/arm/boot/dts/imx53.dtsi           |  13 ++++-
 arch/arm/mach-imx/Makefile             |   2 +-
 arch/arm/mach-imx/clk-cpu.c            | 104 +++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/clk-imx51-imx53.c    |  14 ++++-
 arch/arm/mach-imx/clk.h                |   4 ++
 arch/arm/mach-imx/mach-imx53.c         |   4 ++
 drivers/cpufreq/cpufreq-cpu0.c         |  60 +++++++++++--------
 include/dt-bindings/clock/imx5-clock.h |   5 +-
 8 files changed, 179 insertions(+), 27 deletions(-)
 create mode 100644 arch/arm/mach-imx/clk-cpu.c

-- 
2.1.0

