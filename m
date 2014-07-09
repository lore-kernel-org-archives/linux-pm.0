From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCHv3 0/7] cpufreq support for Marvell Armada XP
Date: Wed,  9 Jul 2014 17:45:08 +0200
Message-ID: <1404920715-19834-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:49239 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756142AbaGIPpU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jul 2014 11:45:20 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Mike, Viresh, Rafael, Jason, Gregory, Andrew, Sebastian,

Here is the third version of the patches adding cpufreq support for
the Marvell Armada XP processor.

Changes since v2
================

 - As suggested by Stephen Boyd, instead of using a new clock notifier
   that somewhat "hides" the dependency of the clk-cpu clock driver on
   the PMSU, use a direct call from the clk-cpu driver to the PMSU
   driver.

 - Add a comment that explains why the OPP are not removed on failure
   in the PMSU code initializing the cpufreq logic, in answer to the
   review from Ezequiel Garcia.

Changes since v1
================

 - Rework the patch series to use the generalized cpufreq-cpu0
   (renamed cpufreq-generic) driver instead of having an Armada XP
   specific cpufreq driver. This was suggested by Viresh
   Kumar. Basically, it only involved adding a "clock-latency"
   property in the DT, and changing the PMSU code to register the two
   OPPs supported by each CPU, and registering the "cpufreq-generic"
   platform device instead of the "armadaxp-cpufreq" one.

Jason, this patch series is based on 3.16-rc3, but it applies fine
even with mvebu/fixes and mvebu/soc merged (which contain some PMSU
changes), so I haven't based the patch series on those branches. To
_work_, the code needs the new cpufreq-generic driver which is pending
in Viresh Kumar's tree for 3.17, but there is no build dependency.

Thanks,

Thomas

Thomas Petazzoni (7):
  ARM: mvebu: ensure CPU clocks are enabled
  ARM: mvebu: extend PMSU code to support dynamic frequency scaling
  clk: mvebu: extend clk-cpu for dynamic frequency scaling
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
 arch/arm/mach-mvebu/pmsu.c                         | 162 +++++++++++++++++++++
 drivers/clk/mvebu/clk-cpu.c                        |  80 +++++++++-
 include/linux/mvebu-pmsu.h                         |  20 +++
 12 files changed, 274 insertions(+), 8 deletions(-)
 create mode 100644 include/linux/mvebu-pmsu.h

-- 
2.0.0

