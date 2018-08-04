From: Emmanuel Vadot <manu@freebsd.org>
Subject: [PATCH 5/7] ARM: dts: sun8i: h3: Enable the THS on H3 boards
Date: Sat,  4 Aug 2018 09:03:53 +0200
Message-ID: <20180804070355.14857-5-manu@freebsd.org>
References: <20180804070355.14857-1-manu@freebsd.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180804070355.14857-1-manu@freebsd.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org, catalin.marinas@arm.com, will.deacon@arm.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Emmanuel Vadot <manu@freebsd.org>
List-Id: linux-pm@vger.kernel.org

Enable the Thermal Sensor Controller on all H3 boards.

Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
---
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts | 4 ++++
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts       | 4 ++++
 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts   | 4 ++++
 arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts        | 4 ++++
 arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts   | 4 ++++
 arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts       | 4 ++++
 arch/arm/boot/dts/sun8i-h3-nanopi.dtsi          | 4 ++++
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts       | 4 ++++
 arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts    | 4 ++++
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts     | 4 ++++
 arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts | 4 ++++
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts      | 4 ++++
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts    | 4 ++++
 arch/arm/boot/dts/sun8i-h3-orangepi-plus2e.dts  | 4 ++++
 14 files changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
index 30540dc8e0c5..e6cf879f7324 100644
--- a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
@@ -211,6 +211,10 @@
 	status = "okay";
 };
 
+&ths {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
index 5d23667dc2d2..d95269df8dca 100644
--- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
@@ -197,6 +197,10 @@
 	status = "okay";
 };
 
+&ths {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
index 65cba1050802..9858ca42a826 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
@@ -135,6 +135,10 @@
 	status = "okay";
 };
 
+&ths {
+	status = "okay";
+};
+
 &uart3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart3_pins>, <&uart3_rts_cts_pins>;
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts
index 9412668bb888..ad9df48f86fa 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts
@@ -104,3 +104,7 @@
 &ohci2 {
 	status = "okay";
 };
+
+&ths {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
index 6246d3eff39d..2a21dfedfc31 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
@@ -103,6 +103,10 @@
 	};
 };
 
+&ths {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
index 9f33f6fae595..1122ac363f55 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
@@ -62,6 +62,10 @@
 	status = "okay";
 };
 
+&ths {
+	status = "okay";
+};
+
 &usb_otg {
 	status = "okay";
 	dr_mode = "peripheral";
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi b/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi
index f110ee382239..7166f6af530b 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi
@@ -123,6 +123,10 @@
 	};
 };
 
+&ths {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
index f1fc6bdca8be..0aa15832e9a1 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
@@ -208,6 +208,10 @@
 	status = "okay";
 };
 
+&ths {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts
index 476ae8e387ca..f78aaec27a8f 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts
@@ -179,6 +179,10 @@
 	};
 };
 
+&ths {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
index 245fd658defb..221d130b4153 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
@@ -190,6 +190,10 @@
 	status = "okay";
 };
 
+&ths {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts
index 71fb73208939..d07f3d3db344 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts
@@ -89,3 +89,7 @@
 	/* eMMC is missing pull-ups */
 	bias-pull-up;
 };
+
+&ths {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
index 46240334128f..53bc681ca0ca 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
@@ -227,6 +227,10 @@
 	status = "okay";
 };
 
+&ths {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
index b403e5d787cb..8213481e262a 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
@@ -119,6 +119,10 @@
 	};
 };
 
+&ths {
+	status = "okay";
+};
+
 &usbphy {
 	usb3_vbus-supply = <&reg_usb3_vbus>;
 };
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-plus2e.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-plus2e.dts
index 6dbf7b2e0c13..b744bc26b8a6 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-plus2e.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-plus2e.dts
@@ -77,3 +77,7 @@
 		reg = <1>;
 	};
 };
+
+&ths {
+	status = "okay";
+};
-- 
2.18.0
