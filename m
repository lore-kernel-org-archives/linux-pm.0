From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 00/16] CPU Idle for Armada 370 and Armada 38x
Date: Fri, 27 Jun 2014 15:22:41 +0200
Message-ID: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:42027 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752367AbaF0NXp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Jun 2014 09:23:45 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

Hello,

This patch set adds the CPU Idle support for two mvebu SoCs: the
Armada 370 and the Armada 38x. As there are common parts with the
current support of cpuidle of the Armada XP. I made the code even more
generic. Thanks to this change, adding a new SoC is now only done in
the architecture specific part and we won't have to touch the cpuidle
driver anymore for this.

The first patch is a preliminary clean-up.

The patches 2 and 3 allow to use a common function for the boot
address work around.

The patches 4 and 5 use this function for SMP in the Armada 375 and
CPU idle for the Armada 370.

The patches 6 to 9 and 12 to 13 make the cpu idle support more
generic.

The patches 10 and 11 prepare the cpu idle support for the Armada 38x

The patches 14 and 15 are the ones which really add the cpuidle
support for the Armada 370 and the Armada38x.

And finally the patch 16 updates mvebu_v7_defconfig by selecting the
cpu idle support.

The patches 12 and 13 modify in the same time cpuidle driver and mvebu
code. I need to do this in order to be bisectable. It seems to me that
the easier would be to get the acked-by from the cpuidle maintainer for
this two patches and merged them through the mvebu tree as all the
other patches of the series should also go to the mvebu tree.

Thanks!

Gregory CLEMENT (16):
  ARM: mvebu: Sort the headers of pmsu.c in alphabetic order
  ARM: mvebu: Add a common function for the boot address work around
  ARM: mvebu: Add function to export the physical address of the boot
    register
  ARM: mvebu: Use the common function for Armada 375 SMP workaround
  ARM: mvebu: Add workaround for cpuidle support for Armada 370
  ARM: mvebu: Rename the armada_370_xp into mvebu_v7 in pmsu.c file
  ARM: mvebu: Make the CPU idle initialization more generic
  ARM: mvebu: Use a local variable to store the resume address
  ARM: mvebu: Make the snoop disable optional in
    mvebu_v7_pmsu_idle_prepare
  ARM: mvebu: Export the SCU address
  ARM: mvebu: dts: Add CA9 MPcore SoC Controller node
  cpuidle: mvebu: Rename the driver from armada-370-xp to mvebu-v7
  cpuidle: mvebu: Move the description of the cpuidle states in the
    platform part
  ARM: mvebu: Add CPU idle support for Armada 370
  ARM: mvebu: Add CPU idle support for Armada 38x
  ARM: mvebu: defconfig: Enable CPU Idle support in mvebu_v7_defconfig

 .../bindings/arm/armada-380-mpcore-soc-ctrl.txt    |  14 +
 arch/arm/boot/dts/armada-38x.dtsi                  |   5 +
 arch/arm/configs/mvebu_v7_defconfig                |   2 +
 arch/arm/mach-mvebu/board-v7.c                     |   9 +-
 arch/arm/mach-mvebu/common.h                       |   3 +
 arch/arm/mach-mvebu/headsmp-a9.S                   |  11 -
 arch/arm/mach-mvebu/platsmp-a9.c                   |  27 +-
 arch/arm/mach-mvebu/pmsu.c                         | 312 ++++++++++++++++++---
 arch/arm/mach-mvebu/pmsu.h                         |   1 +
 arch/arm/mach-mvebu/pmsu_ll.S                      |  33 +++
 arch/arm/mach-mvebu/system-controller.c            |  11 +
 drivers/cpuidle/Kconfig.arm                        |   6 +-
 drivers/cpuidle/Makefile                           |   2 +-
 drivers/cpuidle/cpuidle-armada-370-xp.c            |  93 ------
 drivers/cpuidle/cpuidle-mvebu-v7.c                 |  76 +++++
 include/linux/mvebu-v7-cpuidle.h                   |  24 ++
 16 files changed, 456 insertions(+), 173 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/armada-380-mpcore-soc-ctrl.txt
 delete mode 100644 drivers/cpuidle/cpuidle-armada-370-xp.c
 create mode 100644 drivers/cpuidle/cpuidle-mvebu-v7.c
 create mode 100644 include/linux/mvebu-v7-cpuidle.h

-- 
1.8.1.2

