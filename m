From: Peter Chen <peter.chen@nxp.com>
Subject: [PATCH v10 6/8] ARM: dts: imx6qdl: Enable usb node children with <reg>
Date: Mon, 14 Nov 2016 09:35:57 +0800
Message-ID: <1479087359-7547-7-git-send-email-peter.chen@nxp.com>
References: <1479087359-7547-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-by2nam03on0040.outbound.protection.outlook.com ([104.47.42.40]:59374
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752263AbcKNBg4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 13 Nov 2016 20:36:56 -0500
In-Reply-To: <1479087359-7547-1-git-send-email-peter.chen@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org, rjw@rjwysocki.net, dbaryshkov@gmail.com
Cc: heiko@sntech.de, linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, linux-usb@vger.kernel.org, arnd@arndb.de, s.hauer@pengutronix.de, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, festevam@gmail.com, oscar@naiandei.net, stephen.boyd@linaro.org, linux-pm@vger.kernel.org, stillcompiling@gmail.com, linux-kernel@vger.kernel.org, mka@chromium.org, vaibhav.hiremath@linaro.org, gary.bisson@boundarydevices.com, Peter Chen <peter.chen@nxp.com>

From: Joshua Clayton <stillcompiling@gmail.com>

Give usb nodes #address and #size attributes, so that a child node
representing a permanently connected device such as an onboard hub may
be addressed with a <reg> attribute

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index b13b0b2..8fc66e1 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -935,6 +935,8 @@
 
 			usbh1: usb@02184200 {
 				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x02184200 0x200>;
 				interrupts = <0 40 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6QDL_CLK_USBOH3>;
@@ -949,6 +951,8 @@
 
 			usbh2: usb@02184400 {
 				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x02184400 0x200>;
 				interrupts = <0 41 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6QDL_CLK_USBOH3>;
@@ -962,6 +966,8 @@
 
 			usbh3: usb@02184600 {
 				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x02184600 0x200>;
 				interrupts = <0 42 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6QDL_CLK_USBOH3>;
-- 
2.7.4

