From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH 0/6] thermal: Add Armada 375 SoC support
Date: Wed, 16 Apr 2014 11:15:14 -0300
Message-ID: <1397657720-10893-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:48860 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161272AbaDPOPy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Apr 2014 10:15:54 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, Jason Cooper <jason@lakedaemon.net>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

This patchset adds the support for the thermal sensor in the recently
introduced Armada 375 SoC.

The first three patches are preparation work. They add a generic
infrastructure that allows to support similar thermal sensors in
a non-intrusive way.

Patch four uses the infrastructure to support the Armada 375 SoC
thermal sensor.

Since there are some issues in the Z1 SoC thermal sensor, patch five
adds a quirk to workaround such issues. The Z1 stepping is detected
and the compatible string is updated, so the driver can perform
a special sensor initialization. Also, the quirk moves the offset of
the thermal control register, and allows to specifiy the correct
(A0 stepping) offset in the devicetree.

This quirk is applied only for the A375-DB board, being the only
board with the problematic Z1 SoC.

Finally, the last patch enables the thermal sensor in the devicetree.
for the Armada 375 A0 stepping SoC.

The series applies on v3.15-rc1, and has been tested on A375-DB board and
A370-RD board.

Feedback and comments are welcome!

Ezequiel Garcia (6):
  thermal: armada: Rename armada_thermal_ops struct
  thermal: armada: Add infrastructure to support generic formulas
  thermal: armada: Add generic infrastructure to handle the sensor
  thermal: armada: Support Armada 375 SoC
  ARM: mvebu: Add thermal quirk for the Armada 375 DB board
  ARM: mvebu: Enable the thermal sensor in Armada 375 SoC

 .../devicetree/bindings/thermal/armada-thermal.txt |   7 ++
 arch/arm/boot/dts/armada-375.dtsi                  |   6 +
 arch/arm/mach-mvebu/board-v7.c                     |  57 +++++++++
 arch/arm/mach-mvebu/mvebu-soc-id.h                 |   3 +
 drivers/thermal/armada_thermal.c                   | 140 ++++++++++++++++++---
 5 files changed, 197 insertions(+), 16 deletions(-)

-- 
1.9.1

