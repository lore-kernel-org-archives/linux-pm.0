From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v3 0/4] Kirkwood and Dove Thermal drivers
Date: Sat,  2 Feb 2013 15:35:45 +0100
Message-ID: <1359815749-27705-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:48332 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755557Ab3BBOgL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 2 Feb 2013 09:36:11 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>, rui.zhang@intel.com
Cc: linux ARM <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

This patchset adds thermal support for Kirkwood and Dove SoCs.

Changes since v2
* More marvel -> marvell
* Dove driver. Debugged by Sebastian Hesselbarth

Changes since v1
* Temperature Reading in milligrad
* marvel -> marvell
* generalized to Orion
* Compatibility string marvell,kirkwood-thermal
* Arithmetic using unsigned long

Andrew Lunn (2):
  Thermal: Dove: Add Themal sensor support for Dove.
  Dove: Thermal: Add DT node and enable in defconfig

Nobuhiro Iwamatsu (2):
  thermal: Add support for the thermal sensor on Kirkwood SoCs
  ARM: Kirkwood: Add support thermal sensor for 88F6282 and 88F6283

 .../devicetree/bindings/thermal/dove-thermal.txt   |   18 ++
 .../bindings/thermal/kirkwood-thermal.txt          |   15 ++
 arch/arm/boot/dts/dove.dtsi                        |    5 +
 arch/arm/boot/dts/kirkwood-6282.dtsi               |    6 +
 arch/arm/configs/dove_defconfig                    |    2 +
 arch/arm/configs/kirkwood_defconfig                |    2 +
 drivers/thermal/Kconfig                            |   14 ++
 drivers/thermal/Makefile                           |    2 +
 drivers/thermal/dove_thermal.c                     |  211 ++++++++++++++++++++
 drivers/thermal/kirkwood_thermal.c                 |  136 +++++++++++++
 10 files changed, 411 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/dove-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/kirkwood-thermal.txt
 create mode 100644 drivers/thermal/dove_thermal.c
 create mode 100644 drivers/thermal/kirkwood_thermal.c

-- 
1.7.10.4

