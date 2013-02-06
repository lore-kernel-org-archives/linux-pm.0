From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v5 0/4] Kirkwood and Dove Thermal drivers
Date: Wed,  6 Feb 2013 07:35:23 +0100
Message-ID: <1360132527-22860-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:52965 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088Ab3BFGfn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 6 Feb 2013 01:35:43 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>, rui.zhang@intel.com
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, linux ARM <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

This patchset adds thermal support for Kirkwood and Dove SoCs.

Changes since v4
* Remove redundant dev_err() after devm_kzalloc() failure. 

Changes since v3
* Added dependency on OF

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
 drivers/thermal/Kconfig                            |   16 ++
 drivers/thermal/Makefile                           |    2 +
 drivers/thermal/dove_thermal.c                     |  209 ++++++++++++++++++++
 drivers/thermal/kirkwood_thermal.c                 |  134 +++++++++++++
 10 files changed, 409 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/dove-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/kirkwood-thermal.txt
 create mode 100644 drivers/thermal/dove_thermal.c
 create mode 100644 drivers/thermal/kirkwood_thermal.c

-- 
1.7.10.4

