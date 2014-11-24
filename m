From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 2/3] ARM: shmobile: kzm9g-reference dts: Move Ethernet node to BSC
Date: Mon, 24 Nov 2014 21:10:07 +0100
Message-ID: <1416859808-18503-3-git-send-email-geert+renesas@glider.be>
References: <1416859808-18503-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from xavier.telenet-ops.be ([195.130.132.52]:59909 "EHLO
	xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754353AbaKXUKV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 24 Nov 2014 15:10:21 -0500
In-Reply-To: <1416859808-18503-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Move the Ethernet node from the root of the device tree to the BSC node,
as it is connected to the Bus State Controller.  This allows the system
to know the right position of the Ethernet node in the clock and PM
domain hierarchy.

Also rename the node's name from "lan9220" to "ethernet", to confirm to
ePAPR generic name recomendations.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/sh73a0-kzm9g.dts | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 45e2bc60ba9676ff..f80d411696da6b40 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -84,19 +84,6 @@
 		enable-active-high;
 	};
 
-	lan9220@10000000 {
-		compatible = "smsc,lan9220", "smsc,lan9115";
-		reg = <0x10000000 0x100>;
-		phy-mode = "mii";
-		interrupt-parent = <&irqpin0>;
-		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
-		reg-io-width = <4>;
-		smsc,irq-push-pull;
-		smsc,save-mac-address;
-		vddvario-supply = <&reg_1p8v>;
-		vdd33a-supply = <&reg_3p3v>;
-	};
-
 	leds {
 		compatible = "gpio-leds";
 		led1 {
@@ -179,6 +166,21 @@
 	};
 };
 
+&bsc {
+	ethernet@10000000 {
+		compatible = "smsc,lan9220", "smsc,lan9115";
+		reg = <0x10000000 0x100>;
+		phy-mode = "mii";
+		interrupt-parent = <&irqpin0>;
+		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
+		reg-io-width = <4>;
+		smsc,irq-push-pull;
+		smsc,save-mac-address;
+		vddvario-supply = <&reg_1p8v>;
+		vdd33a-supply = <&reg_3p3v>;
+	};
+};
+
 &cmt1 {
 	status = "ok";
 };
-- 
1.9.1

