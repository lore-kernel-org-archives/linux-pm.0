From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 7/7] ARM: dts: ux500: declare GPADC IIO ADC channels
Date: Wed, 11 Jan 2017 00:47:45 +0100
Message-ID: <20170110234745.29691-8-linus.walleij@linaro.org>
References: <20170110234745.29691-1-linus.walleij@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:35590 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758579AbdAJXsG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jan 2017 18:48:06 -0500
Received: by mail-lf0-f52.google.com with SMTP id m78so104816178lfg.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Jan 2017 15:48:05 -0800 (PST)
In-Reply-To: <20170110234745.29691-1-linus.walleij@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Cc: Mboumba Cedric Madianga <cedric.madianga@gmail.com>, linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

This adds the IIO channels for the GPADC after converting it
to using the standard IIO ADC bindings and moving the driver
over to the IIO subsystem. We also add IIO hwmon standard
driver node to support reading channels in a standard manner.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi | 102 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 101 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index d309314f3a36..172c81e98ad0 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -44,6 +44,20 @@
 		};
 	};
 
+	/* Essential housekeeping hardware monitors */
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&gpadc 0x02>, /* Battery temperature */
+			    <&gpadc 0x03>, /* Main charger voltage */
+			    <&gpadc 0x08>, /* Main battery voltage */
+			    <&gpadc 0x09>, /* VBUS */
+			    <&gpadc 0x0a>, /* Main charger current */
+			    <&gpadc 0x0b>, /* USB charger current *
+			    <&gpadc 0x0c>, /* Backup battery voltage */
+			    <&gpadc 0x0d>, /* Die temperature */
+			    <&gpadc 0x12>; /* Crystal temperature */
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -616,12 +630,84 @@
 					interrupt-names = "60S", "ALARM";
 				};
 
-				ab8500-gpadc {
+				gpadc: ab8500-gpadc {
 					compatible = "stericsson,ab8500-gpadc";
 					interrupts = <32 IRQ_TYPE_LEVEL_HIGH
 						      39 IRQ_TYPE_LEVEL_HIGH>;
 					interrupt-names = "HW_CONV_END", "SW_CONV_END";
 					vddadc-supply = <&ab8500_ldo_tvout_reg>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#io-channel-cells = <1>;
+
+					/* GPADC channels */
+					bat_ctrl: adc-channel@01 {
+						reg = <0x01>;
+					};
+					btemp_ball: adc-channel@02 {
+						reg = <0x02>;
+					};
+					main_charger_v: adc-channel@03 {
+						reg = <0x03>;
+					};
+					acc_detect1: adc-channel@04 {
+						reg = <0x04>;
+					};
+					acc_detect2: adc-channel@05 {
+						reg = <0x05>;
+					};
+					adc_aux1: adc-channel@06 {
+						reg = <0x06>;
+					};
+					adc_aux2: adc-channel@07 {
+						reg = <0x07>;
+					};
+					main_batt_v: adc-channel@08 {
+						reg = <0x08>;
+					};
+					vbus_v: adc-channel@09 {
+						reg = <0x09>;
+					};
+					main_charger_c: adc-channel@0a {
+						reg = <0x0a>;
+					};
+					usb_charger_c: adc-channel@0b {
+						reg = <0x0b>;
+					};
+					bk_bat_v: adc-channel@0c {
+						reg = <0x0c>;
+					};
+					die_temp: adc-channel@0d {
+						reg = <0x0d>;
+					};
+					usb_id: adc-channel@0e {
+						reg = <0x0e>;
+					};
+					xtal_temp: adc-channel@12 {
+						reg = <0x12>;
+					};
+					vbat_true_meas: adc-channel@13 {
+						reg = <0x13>;
+					};
+					bat_ctrl_and_ibat: adc-channel@1c {
+						reg = <0x1c>;
+					};
+					vbat_meas_and_ibat: adc-channel@1d {
+						reg = <0x1d>;
+					};
+					vbat_true_meas_and_ibat: adc-channel@1e {
+						reg = <0x1e>;
+					};
+					bat_temp_and_ibat: adc-channel@1f {
+						reg = <0x1f>;
+					};
+				};
+
+				ab8500_temp {
+					compatible = "stericsson,abx500-temp";
+					io-channels = <&gpadc 0x06>,
+						      <&gpadc 0x07>;
+					io-channel-name = "aux1", "aux2";
 				};
 
 				ab8500_battery: ab8500_battery {
@@ -632,17 +718,31 @@
 				ab8500_fg {
 					compatible = "stericsson,ab8500-fg";
 					battery	   = <&ab8500_battery>;
+					io-channels = <&gpadc 0x08>;
+					io-channel-name = "main_bat_v";
 				};
 
 				ab8500_btemp {
 					compatible = "stericsson,ab8500-btemp";
 					battery	   = <&ab8500_battery>;
+					io-channels = <&gpadc 0x02>,
+						      <&gpadc 0x01>;
+					io-channel-name = "btemp_ball",
+							"bat_ctrl";
 				};
 
 				ab8500_charger {
 					compatible	= "stericsson,ab8500-charger";
 					battery		= <&ab8500_battery>;
 					vddadc-supply	= <&ab8500_ldo_tvout_reg>;
+					io-channels = <&gpadc 0x03>,
+						      <&gpadc 0x0a>,
+						      <&gpadc 0x09>,
+						      <&gpadc 0x0b>;
+					io-channel-name = "main_charger_v",
+							"main_charger_c",
+							"vbus_v",
+							"usb_charger_c";
 				};
 
 				ab8500_chargalg {
-- 
2.9.3

