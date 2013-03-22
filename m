From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v2 00/14] Marvell EBU thermal sensor consolidation
Date: Fri, 22 Mar 2013 19:25:00 -0300
Message-ID: <1363991114-4225-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:33388 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423359Ab3CVWZX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Mar 2013 18:25:23 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jason Cooper <jason@lakedaemon.net>, Lior Amsalem <alior@marvell.com>, Zhang Rui <rui.zhang@intel.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Given Armada 370/XP and the other Marvell SoC with thermal support,
namely Kirkwood and Dove, have fairly similar thermal devices it
makes sense to integrate all of them into a single driver: mvebu-thermal.

The patches have been carefully splitted to make the changeset
as less invasive as possible. These changes can be divided in five stages:

 1. Rename 'kirkwood' driver to 'mvebu'
 2. Some fixes inherited from kirkwood driver applied to new mvebu driver
 3. Prepare mvebu driver to support multiple SoC
 4. Add thermal support for each Marvell SoC on top of mvebu driver
 5. Add device tree nodes for Armada 370 and Armada XP
 6. Fix defconfigs for all the platforms involved

Testing have been done on the following boards:

Kirkwood:   Plat'home Openblocks A6
Armada 370: Globalscale Mirabox and Marvell Armada 370 RD
Armada XP:  Plat'home Openblocks AX3 and Marvell Armada XP DB-MV784MP-GP

Dove is *not* tested due to lack of hardware.

Also, please note that the defconfigs for involved platforms have been fixed
deliberately in a single patch, to ease maintainer's job as the defconfigs
file goes through one tree and the thermal driver should go through another.

Since I'm merging two existing drivers into a new driver, I retained authorship
and copyright of the merged drivers and added my own. For this reason, I'd like
to have Andrew and Nobuhiro Acked (or Nacked, of course).

This series is based in v3.9-rc2 with the following patches applied:

  Dove: Thermal: Add DT node and enable in defconfig
  ARM: Kirkwood: Add support thermal sensor for 88F6282 and 88F6283

Also it depends on the following fixes that I recently sent for v3.9:

  thermal: dove: Fix thermal sensor formula
  thermal: kirkwood: Fix thermal sensor formula
  thermal: mvebu: Fix valid check for thermal register

To make testing easier I've pushed a github branch:

  https://github.com/MISL-EBU-System-SW/mainline-public/commits/mvebu-thermal-v2

Changes from v1:

  * Fixed devm_ioremap_resource() API usage, as pointed out by Andrew,
    Rusell and Sergei.

  * The fixes that corresponded to be applied on v3.9 were removed
    from this patchset and sent as independent patches, as requested
    by Jason Cooper.

  * The formulas for thermal sensor were replaced by better ones,
    confirmed by Lior Amsalem.

  * The infrastructure for multiple SoC was reworked to drop switches,
    using function pointers instead as suggested by Jason Gunthorpe.

Any feedback or comments are welcome!

Ezequiel Garcia (14):
  thermal: Rename driver 'kirkwood' -> 'mvebu'
  thermal: mvebu: Rename symbols 'kirkwood' -> 'mvebu'
  thermal: mvebu: Move MODULE_DEVICE_TABLE upwards
  thermal: mvebu: Remove unneeded variable initialization
  thermal: mvebu: Convert to devm_ioremap_resource()
  thermal: mvebu: Fix license declaration
  thermal: mvebu: Rename kirkwood definitions to mvebu
  thermal: mvebu: Add infrastructure to support more multiple SoC
    variants
  thermal: mvebu: Add support for Armada XP thermal sensor
  thermal: mvebu: Add support for Armada 370 thermal sensor
  thermal: mvebu: Add support for Marvell Dove SoC family
  ARM: mvebu: Add thermal support to Armada XP device tree
  ARM: mvebu: Add thermal support to Armada 370 device tree
  ARM: configs: Update mvebu, dove and kirkwood defconfigs for thermal

 .../devicetree/bindings/thermal/dove-thermal.txt   |   18 -
 .../bindings/thermal/kirkwood-thermal.txt          |   15 -
 .../devicetree/bindings/thermal/mvebu-thermal.txt  |   31 ++
 arch/arm/boot/dts/armada-370.dtsi                  |    6 +
 arch/arm/boot/dts/armada-xp.dtsi                   |    6 +
 arch/arm/configs/dove_defconfig                    |    2 +-
 arch/arm/configs/kirkwood_defconfig                |    2 +-
 arch/arm/configs/mvebu_defconfig                   |    2 +
 drivers/thermal/Kconfig                            |   18 +-
 drivers/thermal/Makefile                           |    3 +-
 drivers/thermal/dove_thermal.c                     |  210 ------------
 drivers/thermal/kirkwood_thermal.c                 |  134 --------
 drivers/thermal/mvebu_thermal.c                    |  347 ++++++++++++++++++++
 13 files changed, 400 insertions(+), 394 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/dove-thermal.txt
 delete mode 100644 Documentation/devicetree/bindings/thermal/kirkwood-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/mvebu-thermal.txt
 delete mode 100644 drivers/thermal/dove_thermal.c
 delete mode 100644 drivers/thermal/kirkwood_thermal.c
 create mode 100644 drivers/thermal/mvebu_thermal.c

-- 
1.7.8.6

