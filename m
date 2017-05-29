From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 3/4] ARM: dts: uniphier: add nodes of thermal monitor and thermal zone for PXs2
Date: Mon, 29 May 2017 18:15:44 +0900
Message-ID: <1496049345-14649-4-git-send-email-hayashi.kunihiko@socionext.com>
References: <1496049345-14649-1-git-send-email-hayashi.kunihiko@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1496049345-14649-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, yamada.masahiro@socionext.com, masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
List-Id: linux-pm@vger.kernel.org

Add nodes of thermal monitor and thermal zone for UniPhier PXs2 SoC.
The thermal monitor is included in sysctrl.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm/boot/dts/uniphier-pxs2-gentil.dts | 21 +++++++++++++++++++++
 arch/arm/boot/dts/uniphier-pxs2-vodka.dts  | 21 +++++++++++++++++++++
 arch/arm/boot/dts/uniphier-pxs2.dtsi       |  6 ++++++
 3 files changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-pxs2-gentil.dts b/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
index 373818a..89ccb88 100644
--- a/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
+++ b/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
@@ -70,6 +70,27 @@
 		i2c5 = &i2c5;
 		i2c6 = &i2c6;
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
 
 &serial2 {
diff --git a/arch/arm/boot/dts/uniphier-pxs2-vodka.dts b/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
index 51a3eac..0201584 100644
--- a/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
+++ b/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
@@ -68,6 +68,27 @@
 		i2c5 = &i2c5;
 		i2c6 = &i2c6;
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
 
 &serial2 {
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index e9e031d..072e3b4 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -387,6 +387,12 @@
 				compatible = "socionext,uniphier-pxs2-reset";
 				#reset-cells = <1>;
 			};
+
+			pvtctl: pvtctl {
+				compatible = "socionext,uniphier-pxs2-thermal";
+				interrupts = <0 3 1>;
+				#thermal-sensor-cells = <0>;
+			};
 		};
 	};
 };
-- 
2.7.4
