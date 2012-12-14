From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 0/2] Thermal sensor for Orion/Kirkwood
Date: Fri, 14 Dec 2012 12:03:04 +0100
Message-ID: <1355482986-885-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:46140 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756314Ab2LNLDV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 14 Dec 2012 06:03:21 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux ARM <linux-arm-kernel@lists.infradead.org>, iwamatsu@nigauri.org, linux-pm@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, jgunthorpe@obsidianresearch.com, Andrew Lunn <andrew@lunn.ch>

This patchset adds thermal support for Orion Kirkwood devices, based
on code from Nobuhiro Iwamatsu. This provides a framework to later add
support for the thermal sensor on Dove.

The comments raised when the code was first posted have now been
addressed:

* Temperature Reading in milligrad
* marvel -> marvell
* generalized to Orion
* Compatibility string marvell,kirkwood-thermal
* Arithmetic using unsigned long

Nobuhiro Iwamatsu (2):
  thermal: Add support for thermal sensor for Orion SoC
  ARM: Kirkwood: Add support thermal sensor for 88F6282 and 88F6283

 .../devicetree/bindings/thermal/orion-thermal.txt  |   16 +++
 arch/arm/boot/dts/kirkwood-6282.dtsi               |    7 ++
 arch/arm/configs/kirkwood_defconfig                |    2 +
 drivers/thermal/Kconfig                            |    7 ++
 drivers/thermal/Makefile                           |    1 +
 drivers/thermal/orion_thermal.c                    |  133 ++++++++++++++++++++
 6 files changed, 166 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/orion-thermal.txt
 create mode 100644 drivers/thermal/orion_thermal.c

-- 
1.7.10.4

