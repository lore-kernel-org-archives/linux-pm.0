From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH for 3.10 0/4] thermal: Add Armada 370/XP support
Date: Mon, 25 Mar 2013 12:27:05 -0300
Message-ID: <1364225229-2857-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:47632 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758128Ab3CYP1Q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Mar 2013 11:27:16 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Lior Amsalem <alior@marvell.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Zhang Rui <rui.zhang@intel.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

After Andrew Lunn objected the single driver approach [1] that merged
all the Marvell EBU SoC thermal drivers, we have agreed to proceed step
by step. For the time being we are adding support for Armada 370/XP only.
Given both Armada 370 and Armada XP have a similar feature set, it
makes sense to provide a single driver for them.

In the future we can unify this with the other drivers,
if this proves to be worthwhile.

This driver has been influenced by the existing Kirkwood driver,
also taking account of suggestions made by Jason Gunthorpe.

Testing has been done on the following boards:

For Armada 370: Globalscale Mirabox and Marvell Armada 370 RD
For Armada XP:  Plat'home Openblocks AX3 and Marvell Armada XP DB-MV784MP-GP

This series is based in v3.9-rc2. To make testing easier this patchset
has been pushed on a github branch [2].

Any feedback or comments are welcome!

[1] http://permalink.gmane.org/gmane.linux.power-management.general/32123
[2] https://github.com/MISL-EBU-System-SW/mainline-public/tree/armada-thermal

Ezequiel Garcia (4):
  thermal: Add driver for Armada 370/XP SoC thermal management
  ARM: mvebu: Add thermal support to Armada XP device tree
  ARM: mvebu: Add thermal support to Armada 370 device tree
  ARM: configs: Update mvebu defconfig for thermal

 .../devicetree/bindings/thermal/armada-thermal.txt |   22 ++
 arch/arm/boot/dts/armada-370.dtsi                  |    6 +
 arch/arm/boot/dts/armada-xp.dtsi                   |    6 +
 arch/arm/configs/mvebu_defconfig                   |    2 +
 drivers/thermal/Kconfig                            |    8 +
 drivers/thermal/Makefile                           |    1 +
 drivers/thermal/armada_thermal.c                   |  236 ++++++++++++++++++++
 7 files changed, 281 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/armada-thermal.txt
 create mode 100644 drivers/thermal/armada_thermal.c

-- 
1.7.8.6

