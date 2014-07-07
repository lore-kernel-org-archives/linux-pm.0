From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCHv2 0/8] cpufreq support for Marvell Armada XP
Date: Mon,  7 Jul 2014 16:51:34 +0200
Message-ID: <1404744702-32010-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:57763 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753457AbaGGOvq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Jul 2014 10:51:46 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Mike, Viresh, Rafael, Jason, Gregory, Andrew, Sebastian,

This series of commits adds cpufreq support for the Marvell Armada XP
processor.

Changes since v1
================

 - Rework the patch series to use the generalized cpufreq-cpu0
   (renamed cpufreq-generic) driver instead of having an Armada XP
   specific cpufreq driver. This was suggested by Viresh
   Kumar. Basically, it only involved adding a "clock-latency"
   property in the DT, and changing the PMSU code to register the two
   OPPs supported by each CPU, and registering the "cpufreq-generic"
   platform device instead of the "armadaxp-cpufreq" one.

Details of the patches
======================

 - The core clock framework, to add a new clk_set_rate() notifier. See
   below for the explanation. This should go through Mike Turquette's
   tree. This is PATCH 01/08.

 - Improvements to the existing Armada XP cpu-clock driver. This
   should also go through Mike Turquette's tree, probably thanks to a
   pull request to be sent by the mvebu platform maintainers. This is
   PATCH 02/08.

 - Extension of the Marvell EBU PMSU code in arch/arm/mach-mvebu/ to
   implement a clock notifier needed for the dynamic frequency change
   procedure. This patch should go through the mvebu maintainers
   tree. This is PATCH 04/08. Note that this patch has a build
   dependency on PATCH 01/08, while all other patches don't have any
   other build dependency.

 - Misc other small changes (defconfigs, Device Tree, SMP
   initialization code) that are specific to the mvebu platform, also
   to be handled by the mvebu maintainers. Those are patches 3, 5, 6,
   7 and 8.

The only tricky part in this series is the addition of the
APPLY_RATE_CHANGE clock notifier. All the details about why a new
clock notifier is needed are exposed in the commit log of the first
patch, "clk: add an APPLY_RATE_CHANGE notifier event during
clk_set_rate()". Please read carefully this commit log to understand
the reasons for this proposed clock notifier.

Basically, the issue is that the procedure to change the CPU clock
frequency involves touching registers managed by the CPU clock driver,
but also registers from the PMSU which is used for a wide range of
power management activities, and is therefore handled by platform
specific code in mach-mvebu.

Jason, this patch series is based on 3.16-rc3, but it applies fine
even with mvebu/fixes and mvebu/soc merged (which contain some PMSU
changes), so I haven't based the patch series on those branches. To
_work_, the code needs the new cpufreq-generic driver which is pending
in Viresh Kumar's tree for 3.17, but there is no build dependency.

Thanks,

Thomas

Thomas Petazzoni (8):
  clk: add an APPLY_RATE_CHANGE notifier event during clk_set_rate()
  clk: mvebu: extend clk-cpu for dynamic frequency scaling
  ARM: mvebu: ensure CPU clocks are enabled
  ARM: mvebu: extend PMSU code to support dynamic frequency scaling
  ARM: mvebu: update Armada XP DT for dynamic frequency scaling
  ARM: mvebu: allow enabling of cpufreq on Armada XP
  ARM: mvebu: update mvebu_v7_defconfig with cpufreq support
  ARM: configs: add cpufreq-generic in multi_v7_defconfig

 .../devicetree/bindings/clock/mvebu-cpu-clock.txt  |   5 +-
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           |   2 +
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |   2 +
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           |   4 +
 arch/arm/boot/dts/armada-xp.dtsi                   |   2 +-
 arch/arm/configs/multi_v7_defconfig                |   1 +
 arch/arm/configs/mvebu_v7_defconfig                |   2 +
 arch/arm/mach-mvebu/Kconfig                        |   1 +
 arch/arm/mach-mvebu/platsmp.c                      |   1 +
 arch/arm/mach-mvebu/pmsu.c                         | 184 +++++++++++++++++++++
 drivers/clk/clk.c                                  |   3 +
 drivers/clk/mvebu/clk-cpu.c                        |  79 ++++++++-
 include/linux/clk.h                                |   4 +
 13 files changed, 282 insertions(+), 8 deletions(-)

-- 
2.0.0

