From: Oskari Lemmela <oskari@lemmela.net>
Subject: [PATCH v7 3/9] arm64: dts: allwinner: axp803: add AC and battery power supplies
Date: Sat,  8 Dec 2018 19:36:12 +0200
Message-ID: <20181208173618.31395-4-oskari@lemmela.net>
References: <20181208173618.31395-1-oskari@lemmela.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181208173618.31395-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Lee Jones <lee.jones@linaro.org>
Cc: Quentin Schulz <quentin.schulz@bootlin.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Oskari Lemmela <oskari@lemmela.net>
List-Id: linux-pm@vger.kernel.org

Parts of the AXP803 are compatible with their counterparts on the AXP813.
Add DT nodes ADC, GPIO, AC and battery power supplies.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm64/boot/dts/allwinner/axp803.dtsi | 33 +++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/axp803.dtsi b/arch/arm64/boot/dts/allwinner/axp803.dtsi
index e5eae8bafc42..c3a618e1279a 100644
--- a/arch/arm64/boot/dts/allwinner/axp803.dtsi
+++ b/arch/arm64/boot/dts/allwinner/axp803.dtsi
@@ -49,6 +49,39 @@
 	interrupt-controller;
 	#interrupt-cells = <1>;
 
+	ac_power_supply: ac-power-supply {
+		compatible = "x-powers,axp803-ac-power-supply",
+			     "x-powers,axp813-ac-power-supply";
+		status = "disabled";
+	};
+
+	axp_adc: adc {
+		compatible = "x-powers,axp803-adc", "x-powers,axp813-adc";
+		#io-channel-cells = <1>;
+	};
+
+	axp_gpio: gpio {
+		compatible = "x-powers,axp803-gpio", "x-powers,axp813-gpio";
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio0_ldo: gpio0-ldo {
+			pins = "GPIO0";
+			function = "ldo";
+		};
+
+		gpio1_ldo: gpio1-ldo {
+			pins = "GPIO1";
+			function = "ldo";
+		};
+	};
+
+	battery_power_supply: battery-power-supply {
+		compatible = "x-powers,axp803-battery-power-supply",
+			     "x-powers,axp813-battery-power-supply";
+		status = "disabled";
+	};
+
 	regulators {
 		/* Default work frequency for buck regulators */
 		x-powers,dcdc-freq = <3000>;
-- 
2.17.1
