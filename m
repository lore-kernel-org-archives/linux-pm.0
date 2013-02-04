From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v4 4/4] Dove: Thermal: Add DT node and enable in defconfig
Date: Mon,  4 Feb 2013 20:19:20 +0100
Message-ID: <1360005560-21945-5-git-send-email-andrew@lunn.ch>
References: <1359946148.2250.47.camel@rzhang1-mobl4>
 <1360005560-21945-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:51674 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754652Ab3BDTTw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 4 Feb 2013 14:19:52 -0500
In-Reply-To: <1360005560-21945-1-git-send-email-andrew@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: jason@lakedaemon.net, rui.zhang@intel.com
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, linux ARM <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

Add a device tree node to instantiate the dove thermal driver.
Enable the driver and the thermal framework in dove_defconfig.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/dove.dtsi     |    5 +++++
 arch/arm/configs/dove_defconfig |    2 ++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 42eac1f..3584a00 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -50,6 +50,11 @@
 			#clock-cells = <1>;
 		};
 
+		thermal: thermal@d001c {
+			compatible = "marvell,dove-thermal";
+			reg = <0xd001c 0x0c>, <0xd005c 0x08>;
+		};
+
 		uart0: serial@12000 {
 			compatible = "ns16550a";
 			reg = <0x12000 0x100>;
diff --git a/arch/arm/configs/dove_defconfig b/arch/arm/configs/dove_defconfig
index 0b7ee92..9713b5b 100644
--- a/arch/arm/configs/dove_defconfig
+++ b/arch/arm/configs/dove_defconfig
@@ -80,6 +80,8 @@ CONFIG_I2C_MV64XXX=y
 CONFIG_SPI=y
 CONFIG_SPI_ORION=y
 # CONFIG_HWMON is not set
+CONFIG_THERMAL=y
+CONFIG_DOVE_THERMAL=y
 CONFIG_USB=y
 CONFIG_USB_DEVICEFS=y
 CONFIG_USB_EHCI_HCD=y
-- 
1.7.10.4

