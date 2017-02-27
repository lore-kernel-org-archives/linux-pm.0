From: Icenowy Zheng <icenowy@aosc.xyz>
Subject: [PATCH 3/3] ARM: dts: sun8i: add device node for H3 thermal sensor
Date: Tue, 28 Feb 2017 03:40:54 +0800
Message-ID: <20170227194054.51951-3-icenowy@aosc.xyz>
References: <20170227194054.51951-1-icenowy@aosc.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170227194054.51951-1-icenowy@aosc.xyz>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Ondrej Jirman <megous@megous.com>
Cc: devicetree@vger.kernel.org, Icenowy Zheng <icenowy@aosc.xyz>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Allwinner H3 features a new "sun8i-ths" thermal sensor.

Add the device node for it, as well as the eFUSE cell for its
calibration data.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---

This patch depends on the H3 SID dtsi patch [1].

If this patch is merged before that one, the hunk about SID controller and the
two nvmem properties in THS node can just be dropped.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-February/490300.html

 arch/arm/boot/dts/sun8i-h3.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index ed2eede5f1f0..fdf7f20b1526 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -79,6 +79,14 @@
 		};
 	};
 
+	thermal-zones {
+		cpu_thermal: cpu_thermal {
+			polling-delay-passive = <330>;
+			polling-delay = <1000>;
+			thermal-sensors = <&ths 0>;
+		};
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
@@ -209,6 +217,12 @@
 		sid: eeprom@01c14000 {
 			compatible = "allwinner,sun8i-h3-sid";
 			reg = <0x01c14000 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			ths_cal: ths-calibration@34 {
+				reg = <0x34 0x4>;
+			};
 		};
 
 		usbphy: phy@01c19400 {
@@ -429,6 +443,19 @@
 			clocks = <&osc24M>;
 		};
 
+		ths: ths@01c25000 {
+			compatible = "allwinner,sun8i-h3-ths";
+			reg = <0x01c25000 0x400>;
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&ccu RST_BUS_THS>;
+			reset-names = "ahb";
+			clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_THS>;
+			clock-names = "ahb", "ths";
+			nvmem-cells = <&ths_cal>;
+			nvmem-cell-names = "cal";
+			#thermal-sensor-cells = <1>;
+		};
+
 		spi0: spi@01c68000 {
 			compatible = "allwinner,sun8i-h3-spi";
 			reg = <0x01c68000 0x1000>;
-- 
2.11.1
