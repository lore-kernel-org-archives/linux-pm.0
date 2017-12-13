From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v3 0/4] Add CPU Frequency scaling support on Armada 37xx
Date: Wed, 13 Dec 2017 18:51:15 +0100
Message-ID: <20171213175119.9441-1-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:43194 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753051AbdLMRvh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Dec 2017 12:51:37 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@free-electrons.com>, =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Wilson Ding <dingwei@marvell.com>, Hua Jing <jinghua@marvell.com>, Neta Zur Hershkovits <neta@marvell.com>, Evan Wang <xswang@marvell.com>, Andre Heider <a.heider@gmail.com>

Hi,

This is the third version of a series adding the CPU Frequency support
on Armada 37xx using DVFS. It is based on the initial work of Evan
Wang and Victor Gu.

As requested all the patches not directly related to the Armada 37xx
support had been sent in separate series.

The only other changes is replacing tab by space in the define as it
should have be already done in the v2.

The last patch is for arm-soc the arm-soc subsystem through mvebu and
update the device tree to support the CPU frequency scaling.

An update on the CPU clock driver is needed in order to take into
account the DVFS setting. It's the purpose of an other series already
sent, but is no dependencies between the series (for building or at
runtime).

Thanks,

Gregory

Changelog:

v1 -> v2:

 - using syscon instead of nb_pm for the binding of the North bridge
   power management unit: reported by Rob Herring

 - fix sorting inside the big LITTLE section for the Kconfig: reported
   by Viresh Kumar

 - fix the bogus freq calculation in armada37xx_cpufreq_driver_init,
   bug reported by Andre Heider

 - use dev_pm_opp_remove() on the previous opp if dev_pm_opp_add()
   failed, reported by Viresh Kumar

 - add the Tested-by flag from Andre Heider on "cpufreq: Add DVFS
   support for Armada 37xx" patch

v2 -> v3:

 - move patches "cpufreq: ARM: sort the Kconfig menu", " cpufreq:
   sort the drivers in ARM part", "cpufreq: mvebu: Use
   dev_pm_opp_remove()" in separate series

- add reviewed-by and acked-by flags on the commits

- use space instead of tab in the #define in the armada-37xx-cpufreq.c file.

Gregory CLEMENT (4):
  dt-bindings: marvell: Add documentation for the North Bridge PM on
    Armada 37xx
  MAINTAINERS: add new entries for Armada 37xx cpufreq driver
  cpufreq: Add DVFS support for Armada 37xx
  arm64: dts: marvell: armada-37xx: add nodes allowing cpufreq support

 .../bindings/arm/marvell/armada-37xx.txt           |  19 ++
 MAINTAINERS                                        |   1 +
 arch/arm64/boot/dts/marvell/armada-372x.dtsi       |   1 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |   7 +
 drivers/cpufreq/Kconfig.arm                        |   7 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/armada-37xx-cpufreq.c              | 241 +++++++++++++++++++++
 7 files changed, 277 insertions(+)
 create mode 100644 drivers/cpufreq/armada-37xx-cpufreq.c

-- 
2.15.1
