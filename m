From: Emmanuel Vadot <manu@freebsd.org>
Subject: [PATCH 4/7] arm64: dts: allwinner: a64: Add thermal sensor controller node
Date: Sat,  4 Aug 2018 09:03:52 +0200
Message-ID: <20180804070355.14857-4-manu@freebsd.org>
References: <20180804070355.14857-1-manu@freebsd.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180804070355.14857-1-manu@freebsd.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org, catalin.marinas@arm.com, will.deacon@arm.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Emmanuel Vadot <manu@freebsd.org>
List-Id: linux-pm@vger.kernel.org

This add the ths controller for the A64 and the nvmem cell for the
calibration data on the sid node.

Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 925bf38fb536..ad72a6fcdd7c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -273,6 +273,25 @@
 		sid: eeprom@1c14000 {
 			compatible = "allwinner,sun50i-a64-sid";
 			reg = <0x1c14000 0x400>;
+
+			ths_calib: calib@234 {
+				reg = <0x234 0x6>;
+			};
+		};
+
+		ths: thermal_sensor@1c25000 {
+			compatible = "allwinner,sun50i-a64-ths";
+			reg = <0x01c25000 0x100>;
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_THS>;
+			clock-names = "apb", "ths";
+			resets = <&ccu RST_BUS_THS>;
+			reset-names = "apb";
+			#thermal-sensor-cells = <2>;
+			status = "disabled";
+
+			nvmem-cells = <&ths_calib>;
+			nvmem-cell-names = "ths-calib";
 		};
 
 		usb_otg: usb@1c19000 {
-- 
2.18.0
