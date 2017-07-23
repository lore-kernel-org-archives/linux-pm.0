From: Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 09/10] ARM: sun8i: h2+: add SY8113B regulator used by Orange Pi Zero board
Date: Sun, 23 Jul 2017 18:27:48 +0800
Message-ID: <20170723102749.17323-10-icenowy@aosc.io>
References: <20170723102749.17323-1-icenowy@aosc.io>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20170723102749.17323-1-icenowy@aosc.io>
Sender: linux-clk-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
List-Id: linux-pm@vger.kernel.org

Orange Pi Zero board has a SY8113B regulator, which is controlled via
GPIO and capable of outputing 1.1V when the PL6 GPIO is set to output 0
or 1.3V when the PL6 GPIO is set to input or output 1, and the output is
the power supply of the ARM cores in H2+ SoC.

Add the device tree node of this regulator and set the cpu's cpu-supply
property to it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
index 6713d0f2b3f4..28b4433bd7f7 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
@@ -94,6 +94,27 @@
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>;
 		post-power-on-delay-ms = <200>;
 	};
+
+	reg_sy8113b: gpio-regulator {
+		compatible = "regulator-gpio";
+
+		regulator-name = "vdd-cpux";
+		regulator-type = "voltage";
+		regulator-boot-on;
+		regulator-always-on;
+		regulator-min-microvolt = <1100000>;
+		regulator-max-microvolt = <1300000>;
+		regulator-ramp-delay = <50>; /* 4ms */
+
+		gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
+		gpios-states = <0x1>;
+		states = <1100000 0x0
+			  1300000 0x1>;
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&reg_sy8113b>;
 };
 
 &ehci0 {
-- 
2.13.0

