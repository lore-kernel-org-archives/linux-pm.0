From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 4/4] arm64: dts: uniphier: add nodes of thermal monitor and thermal zone for LD20
Date: Mon, 29 May 2017 18:15:45 +0900
Message-ID: <1496049345-14649-5-git-send-email-hayashi.kunihiko@socionext.com>
References: <1496049345-14649-1-git-send-email-hayashi.kunihiko@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1496049345-14649-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, yamada.masahiro@socionext.com, masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
List-Id: linux-pm@vger.kernel.org

Add nodes of thermal monitor and thermal zone for UniPhier LD20 SoC.
The thermal monitor is included in sysctrl.

Furthermore, since SoC installed in the reference board doesn't have a
calibrated value of thermal monitor, this patch gives the default value
for LD20 Reference board via device-tree property.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../arm64/boot/dts/socionext/uniphier-ld20-ref.dts | 25 ++++++++++++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   |  6 ++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
index 609162a..79e1363 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
@@ -73,6 +73,27 @@
 		i2c4 = &i2c4;
 		i2c5 = &i2c5;
 	};
+
+	thermal-zones {
+		cpu_thermal {
+			polling-delay-passive = <250>;	/* 250ms */
+			polling-delay = <1000>;		/* 1000ms */
+			thermal-sensors = <&pvtctl>;
+
+			trips {
+				cpu_crit: cpu_crit {
+					temperature = <95000>;	/* 95C */
+					hysteresis = <2000>;
+					type = "critical";
+				};
+				cpu_alert: cpu_alert {
+					temperature = <85000>;	/* 85C */
+					hysteresis = <2000>;
+					type = "passive";
+				};
+			};
+		};
+	};
 };
 
 &ethsc {
@@ -86,3 +107,7 @@
 &i2c0 {
 	status = "okay";
 };
+
+&pvtctl {
+	socionext,tmod-calibration = <0x0f22 0x68ee>;
+};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index a6b3a70..effa2e3 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -417,6 +417,12 @@
 				compatible = "socionext,uniphier-ld20-reset";
 				#reset-cells = <1>;
 			};
+
+			pvtctl: pvtctl {
+				compatible = "socionext,uniphier-ld20-thermal";
+				interrupts = <0 3 1>;
+				#thermal-sensor-cells = <0>;
+			};
 		};
 	};
 };
-- 
2.7.4
