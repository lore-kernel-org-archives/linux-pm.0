From: Peter Chen <peter.chen@nxp.com>
Subject: [PATCH v7 7/8] ARM: dts: imx6qdl-udoo.dtsi: fix onboard USB HUB property
Date: Tue, 20 Sep 2016 11:36:46 +0800
Message-ID: <1474342607-27512-8-git-send-email-peter.chen@nxp.com>
References: <1474342607-27512-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-co1nam03on0082.outbound.protection.outlook.com ([104.47.40.82]:64608
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753778AbcITDh5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Sep 2016 23:37:57 -0400
In-Reply-To: <1474342607-27512-1-git-send-email-peter.chen@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org, dbaryshkov@gmail.com, dwmw3@infradead.org
Cc: k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, linux-usb@vger.kernel.org, arnd@arndb.de, s.hauer@pengutronix.de, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, festevam@gmail.com, oscar@naiandei.net, stephen.boyd@linaro.org, linux-pm@vger.kernel.org, stillcompiling@gmail.com, linux-kernel@vger.kernel.org, mka@chromium.org, vaibhav.hiremath@linaro.org, Peter Chen <peter.chen@nxp.com>

The current dts describes USB HUB's property at USB controller's
entry, it is improper. The USB HUB should be the child node
under USB controller, and power sequence properties are under
it. Besides, using gpio pinctrl setting for USB2415's reset pin.

Signed-off-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 arch/arm/boot/dts/imx6qdl-udoo.dtsi | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-udoo.dtsi b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
index 3bee2f9..87fe31f 100644
--- a/arch/arm/boot/dts/imx6qdl-udoo.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
@@ -9,6 +9,8 @@
  *
  */
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	aliases {
 		backlight = &backlight;
@@ -58,17 +60,6 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		reg_usb_h1_vbus: regulator@0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "usb_h1_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			enable-active-high;
-			startup-delay-us = <2>; /* USB2415 requires a POR of 1 us minimum */
-			gpio = <&gpio7 12 0>;
-		};
-
 		reg_panel: regulator@1 {
 			compatible = "regulator-fixed";
 			reg = <1>;
@@ -188,7 +179,7 @@
 
 		pinctrl_usbh: usbhgrp {
 			fsl,pins = <
-				MX6QDL_PAD_GPIO_17__GPIO7_IO12 0x80000000
+				MX6QDL_PAD_GPIO_17__GPIO7_IO12	0x1b0b0
 				MX6QDL_PAD_NANDF_CS2__CCM_CLKO2 0x130b0
 			>;
 		};
@@ -259,9 +250,16 @@
 &usbh1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usbh>;
-	vbus-supply = <&reg_usb_h1_vbus>;
-	clocks = <&clks IMX6QDL_CLK_CKO>;
 	status = "okay";
+
+	usb2415: hub@1 {
+		compatible = "usb424,2514";
+		reg = <1>;
+
+		clocks = <&clks IMX6QDL_CLK_CKO>;
+		reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
+		reset-duration-us = <3000>;
+	};
 };
 
 &usdhc3 {
-- 
2.7.4

