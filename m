From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 5/7] mfd: ab8500: augment DT bindings
Date: Wed, 11 Jan 2017 00:47:43 +0100
Message-ID: <20170110234745.29691-6-linus.walleij@linaro.org>
References: <20170110234745.29691-1-linus.walleij@linaro.org>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170110234745.29691-1-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Mboumba Cedric Madianga <cedric.madianga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

As we migrate the AB8500 GPADC driver to use IIO, we need to augment
the bindings to account for defining the ADC channels in the device
tree.

Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/mfd/ab8500.txt | 119 +++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/ab8500.txt b/Documentation/devicetree/bindings/mfd/ab8500.txt
index cd9e90c5d171..05d4b473c7c8 100644
--- a/Documentation/devicetree/bindings/mfd/ab8500.txt
+++ b/Documentation/devicetree/bindings/mfd/ab8500.txt
@@ -69,6 +69,18 @@ Required child device properties:
 - compatible             : "stericsson,ab8500-[bm|btemp|charger|fg|gpadc|gpio|ponkey|
                                                pwm|regulator|rtc|sysctrl|usb]";
 
+  A few child devices require ADC channels from the GPADC node. Those follow the
+  standard bindings from iio/iio-bindings.txt
+
+  abx500-temp		 : io-channels "aux1" and "aux2" for measuring external
+			   temperatures
+  ab8500_fg		 : io-channel "main_bat_v" for measuring main battery voltage
+  ab8500_btemp		 : io-channels "btemp_ball" and "bat_ctrl" for measuring the
+			   battery voltage
+  ab8500_charger	 : io-channels "main_charger_v", "main_charger_c", "vbus_v",
+			   "usb_charger_c" for measuring voltage and current of the
+			   different charging supplies
+
 Optional child device properties:
 - interrupts             : contains the device IRQ(s) using the 2-cell format (see above)
 - interrupt-names        : contains names of IRQ resource in the order in which they were
@@ -102,8 +114,115 @@ ab8500 {
                               39 0x4>;
                 interrupt-names = "HW_CONV_END", "SW_CONV_END";
                 vddadc-supply = <&ab8500_ldo_tvout_reg>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#io-channel-cells = <1>;
+
+		/* GPADC channels */
+		bat_ctrl: adc-channel@01 {
+			reg = <0x01>;
+		};
+		btemp_ball: adc-channel@02 {
+			reg = <0x02>;
+		};
+		main_charger_v: adc-channel@03 {
+			reg = <0x03>;
+		};
+		acc_detect1: adc-channel@04 {
+			reg = <0x04>;
+		};
+		acc_detect2: adc-channel@05 {
+			reg = <0x05>;
+		};
+		adc_aux1: adc-channel@06 {
+			reg = <0x06>;
+		};
+		adc_aux2: adc-channel@07 {
+			reg = <0x07>;
+		};
+		main_batt_v: adc-channel@08 {
+			reg = <0x08>;
+		};
+		vbus_v: adc-channel@09 {
+			reg = <0x09>;
+		};
+		main_charger_c: adc-channel@0a {
+			reg = <0x0a>;
+		};
+		usb_charger_c: adc-channel@0b {
+			reg = <0x0b>;
+		};
+		bk_bat_v: adc-channel@0c {
+			reg = <0x0c>;
+		};
+		die_temp: adc-channel@0d {
+			reg = <0x0d>;
+		};
+		usb_id: adc-channel@0e {
+			reg = <0x0e>;
+		};
+		xtal_temp: adc-channel@12 {
+			reg = <0x12>;
+		};
+		vbat_true_meas: adc-channel@13 {
+			reg = <0x13>;
+		};
+		bat_ctrl_and_ibat: adc-channel@1c {
+			reg = <0x1c>;
+		};
+		vbat_meas_and_ibat: adc-channel@1d {
+			reg = <0x1d>;
+		};
+		vbat_true_meas_and_ibat: adc-channel@1e {
+			reg = <0x1e>;
+		};
+		bat_temp_and_ibat: adc-channel@1f {
+			reg = <0x1f>;
+		};
         };
 
+	ab8500_temp {
+		compatible = "stericsson,abx500-temp";
+		io-channels = <&gpadc 0x06>,
+			      <&gpadc 0x07>;
+		io-channel-name = "aux1", "aux2";
+	};
+
+	ab8500_battery: ab8500_battery {
+		stericsson,battery-type = "LIPO";
+		thermistor-on-batctrl;
+	};
+
+	ab8500_fg {
+		compatible = "stericsson,ab8500-fg";
+		battery	   = <&ab8500_battery>;
+		io-channels = <&gpadc 0x08>;
+		io-channel-name = "main_bat_v";
+	};
+
+	ab8500_btemp {
+		compatible = "stericsson,ab8500-btemp";
+		battery	   = <&ab8500_battery>;
+		io-channels = <&gpadc 0x02>,
+			      <&gpadc 0x01>;
+		io-channel-name = "btemp_ball",
+				"bat_ctrl";
+	};
+
+	ab8500_charger {
+		compatible	= "stericsson,ab8500-charger";
+		battery		= <&ab8500_battery>;
+		vddadc-supply	= <&ab8500_ldo_tvout_reg>;
+		io-channels = <&gpadc 0x03>,
+			      <&gpadc 0x0a>,
+			      <&gpadc 0x09>,
+			      <&gpadc 0x0b>;
+		io-channel-name = "main_charger_v",
+				"main_charger_c",
+				"vbus_v",
+				"usb_charger_c";
+	};
+
         ab8500-usb {
                 compatible = "stericsson,ab8500-usb";
                 interrupts = < 90 0x4
-- 
2.9.3
