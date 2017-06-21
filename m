From: Peter Chen <peter.chen@nxp.com>
Subject: [PATCH v16 7/7] ARM: dts: imx6q-evi: Fix onboard hub reset line
Date: Wed, 21 Jun 2017 14:42:08 +0800
Message-ID: <1498027328-25078-8-git-send-email-peter.chen@nxp.com>
References: <1498027328-25078-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-cys01nam02on0069.outbound.protection.outlook.com ([104.47.37.69]:29728
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752551AbdFUGoA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Jun 2017 02:44:00 -0400
In-Reply-To: <1498027328-25078-1-git-send-email-peter.chen@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org, rjw@rjwysocki.net, dbaryshkov@gmail.com
Cc: heiko@sntech.de, linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, linux-usb@vger.kernel.org, arnd@arndb.de, s.hauer@pengutronix.de, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, festevam@gmail.com, oscar@naiandei.net, stephen.boyd@linaro.org, linux-pm@vger.kernel.org, stillcompiling@gmail.com, linux-kernel@vger.kernel.org, mka@chromium.org, vaibhav.hiremath@linaro.org, gary.bisson@boundarydevices.com, hverkuil@xs4all.nl, krzk@kernel.org, frank.li@nxp.com, jun.li@nxp.com, Peter Chen <peter.chen@nxp.com>

From: Joshua Clayton <stillcompiling@gmail.com>

Previously the onboard hub was made to work by treating its
reset gpio as a regulator enable.
Get rid of that kludge now that pwseq has added reset gpio support
Move pin muxing the hub reset pin into the usbh1 group

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 arch/arm/boot/dts/imx6q-evi.dts | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-evi.dts b/arch/arm/boot/dts/imx6q-evi.dts
index fd2220a..24fe093 100644
--- a/arch/arm/boot/dts/imx6q-evi.dts
+++ b/arch/arm/boot/dts/imx6q-evi.dts
@@ -54,18 +54,6 @@
 		reg = <0x10000000 0x40000000>;
 	};
 
-	reg_usbh1_vbus: regulator-usbhubreset {
-		compatible = "regulator-fixed";
-		regulator-name = "usbh1_vbus";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		enable-active-high;
-		startup-delay-us = <2>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_usbh1_hubreset>;
-		gpio = <&gpio7 12 GPIO_ACTIVE_HIGH>;
-	};
-
 	reg_usb_otg_vbus: regulator-usbotgvbus {
 		compatible = "regulator-fixed";
 		regulator-name = "usb_otg_vbus";
@@ -204,12 +192,18 @@
 };
 
 &usbh1 {
-	vbus-supply = <&reg_usbh1_vbus>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usbh1>;
 	dr_mode = "host";
 	disable-over-current;
 	status = "okay";
+
+	usb2415host: hub@1 {
+		compatible = "usb424,2513";
+		reg = <1>;
+		reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
+		reset-duration-us = <3000>;
+	};
 };
 
 &usbotg {
@@ -465,11 +459,6 @@
 			MX6QDL_PAD_GPIO_3__USB_H1_OC 0x1b0b0
 			/* usbh1_b OC */
 			MX6QDL_PAD_GPIO_0__GPIO1_IO00 0x1b0b0
-		>;
-	};
-
-	pinctrl_usbh1_hubreset: usbh1hubresetgrp {
-		fsl,pins = <
 			MX6QDL_PAD_GPIO_17__GPIO7_IO12 0x1b0b0
 		>;
 	};
-- 
2.7.4
