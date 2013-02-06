From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v5 2/4] ARM: Kirkwood: Add support thermal sensor for 88F6282 and 88F6283
Date: Wed,  6 Feb 2013 07:35:25 +0100
Message-ID: <1360132527-22860-3-git-send-email-andrew@lunn.ch>
References: <1360132527-22860-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:52990 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751719Ab3BFGf6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 6 Feb 2013 01:35:58 -0500
In-Reply-To: <1360132527-22860-1-git-send-email-andrew@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>, rui.zhang@intel.com
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, linux ARM <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Andrew Lunn <andrew@lunn.ch>

From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

Kirkwood 88F6282 and 88F6283 have a thermal sensor.
This patch adds a DT node and enables the driver in the kernel config.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-6282.dtsi |    6 ++++++
 arch/arm/configs/kirkwood_defconfig  |    2 ++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood-6282.dtsi b/arch/arm/boot/dts/kirkwood-6282.dtsi
index 4ccea21..bd168b6 100644
--- a/arch/arm/boot/dts/kirkwood-6282.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6282.dtsi
@@ -32,6 +32,12 @@
 			};
 		};
 
+		thermal@10078 {
+			compatible = "marvell,kirkwood-thermal";
+			reg = <0x10078 0x4>;
+			status = "okay";
+		};
+
 		i2c@11100 {
 			compatible = "marvell,mv64xxx-i2c";
 			reg = <0x11100 0x20>;
diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
index 93f3794..3d8667f 100644
--- a/arch/arm/configs/kirkwood_defconfig
+++ b/arch/arm/configs/kirkwood_defconfig
@@ -118,6 +118,8 @@ CONFIG_SPI=y
 CONFIG_SPI_ORION=y
 CONFIG_GPIO_SYSFS=y
 # CONFIG_HWMON is not set
+CONFIG_THERMAL=y
+CONFIG_KIRKWOOD_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_ORION_WATCHDOG=y
 CONFIG_HID_DRAGONRISE=y
-- 
1.7.10.4

