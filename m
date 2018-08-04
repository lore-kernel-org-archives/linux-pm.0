From: Emmanuel Vadot <manu@freebsd.org>
Subject: [PATCH 7/7] arm64: dts: allwinner: H5: Enable the THS on H5 boards
Date: Sat,  4 Aug 2018 09:03:55 +0200
Message-ID: <20180804070355.14857-7-manu@freebsd.org>
References: <20180804070355.14857-1-manu@freebsd.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180804070355.14857-1-manu@freebsd.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org, catalin.marinas@arm.com, will.deacon@arm.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Emmanuel Vadot <manu@freebsd.org>
List-Id: linux-pm@vger.kernel.org

Enable the Thermal Sensor Controller on all H5 boards.

Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts  | 4 ++++
 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts       | 4 ++++
 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts      | 4 ++++
 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts    | 4 ++++
 .../arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts | 4 ++++
 .../boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts      | 4 ++++
 6 files changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
index 506e25ba028a..767826684d2a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
@@ -189,6 +189,10 @@
 	status = "okay";
 };
 
+&ths {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
index cc268a69786c..dc49cc942fa9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
@@ -140,6 +140,10 @@
 	status = "okay";
 };
 
+&ths {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
index 3e0d5a9c096d..6ffd048c0d93 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
@@ -219,6 +219,10 @@
 	};
 };
 
+&ths {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
index b75ca4d7d001..07819747a731 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
@@ -222,6 +222,10 @@
 	status = "okay";
 };
 
+&ths {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
index 1238de25a969..405440fedd1e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
@@ -125,6 +125,10 @@
 	status = "okay";
 };
 
+&ths {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
index 53c8c11620e0..09d2bbefcefa 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
@@ -132,6 +132,10 @@
 	status = "okay";
 };
 
+&ths {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.18.0
