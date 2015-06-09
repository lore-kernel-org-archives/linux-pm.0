From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 8/8] ARM: dts: sun7i: Enable USB DRC on Bananapi
Date: Tue,  9 Jun 2015 23:38:01 +0200
Message-ID: <1433885881-19809-9-git-send-email-hdegoede@redhat.com>
References: <1433885881-19809-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49181 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753866AbbFIVik (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 9 Jun 2015 17:38:40 -0400
In-Reply-To: <1433885881-19809-1-git-send-email-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Kishon Vijay Abraham I <kishon@ti.com>, Felipe Balbi <balbi@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: =?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, linux-sunxi@googlegroups.com, Hans de Goede <hdegoede@redhat.com>

Enable the otg/drc usb controller on the Bananapi.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20-bananapi.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
index 2a1188102..d268c78 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
@@ -161,7 +161,18 @@
 	status = "okay";
 };
 
+&otg_sram {
+	status = "okay";
+};
+
 &pio {
+	usb0_id_detect_pin: usb0_id_detect_pin@0 {
+		allwinner,pins = "PH4";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+	};
+
 	mmc0_cd_pin_bananapi: mmc0_cd_pin@0 {
 		allwinner,pins = "PH10";
 		allwinner,function = "gpio_in";
@@ -209,6 +220,10 @@
 	regulator-name = "avcc";
 };
 
+&reg_usb0_vbus {
+	status = "okay";
+};
+
 &reg_usb1_vbus {
 	status = "okay";
 };
@@ -243,11 +258,21 @@
 	status = "okay";
 };
 
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
 &usb_power_supply {
 	status = "okay";
 };
 
 &usbphy {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_id_detect_pin>;
+	usb0_id_det-gpio = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
+	usb0_vbus_power-supply = <&usb_power_supply>;
+	usb0_vbus-supply = <&reg_usb0_vbus>;
 	usb1_vbus-supply = <&reg_usb1_vbus>;
 	usb2_vbus-supply = <&reg_usb2_vbus>;
 	status = "okay";
-- 
2.3.6

