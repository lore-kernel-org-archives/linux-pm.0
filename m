From: Brian Masney <masneyb@onstation.org>
Subject: [PATCH v2 7/7] ARM: dts: qcom: msm8974-hammerhead: add USB OTG support
Date: Wed, 31 Oct 2018 20:11:49 -0400
Message-ID: <20181101001149.13453-8-masneyb@onstation.org>
References: <20181101001149.13453-1-masneyb@onstation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181101001149.13453-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org, david.brown@linaro.org, bjorn.andersson@linaro.org, linus.walleij@linaro.org
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-gpio@vger.kernel.org, jonathan@marek.ca, masneyb@onstation.org
List-Id: linux-pm@vger.kernel.org

Add the device tree bindings for USB OTG support. Driver was tested
using on a LG Nexus 5 (hammerhead) phone. This patch is based on work
from Jonathan Marek and from the other msm8974 devices.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    | 60 +++++++++++++++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi           | 11 ++++
 2 files changed, 71 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index ed8f064d0895..f67ab43956dc 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -242,6 +242,16 @@
 			};
 		};
 
+		i2c1_pins: i2c1 {
+			mux {
+				pins = "gpio2", "gpio3";
+				function = "blsp_i2c1";
+
+				drive-strength = <2>;
+				bias-disable;
+			};
+		};
+
 		i2c3_pins: i2c3 {
 			mux {
 				pins = "gpio10", "gpio11";
@@ -343,6 +353,24 @@
 		};
 	};
 
+	i2c@f9923000 {
+		status = "ok";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c1_pins>;
+		clock-frequency = <100000>;
+		qcom,src-freq = <50000000>;
+
+		charger: bq24192@6b {
+			compatible = "ti,bq24192";
+			reg = <0x6b>;
+			interrupts-extended = <&spmi_bus 0 0xd5 0 IRQ_TYPE_EDGE_FALLING>;
+
+			omit-battery-class;
+
+			usb_otg_vbus: usb-otg-vbus { };
+		};
+	};
+
 	i2c@f9925000 {
 		status = "ok";
 		pinctrl-names = "default";
@@ -360,6 +388,31 @@
 			amstaos,proximity-diodes = <0>;
 		};
 	};
+
+	usb@f9a55000 {
+		status = "ok";
+
+		phys = <&usb_hs1_phy>;
+		phy-select = <&tcsr 0xb000 0>;
+
+		extcon = <&charger>, <&usb_id>;
+		vbus-supply = <&usb_otg_vbus>;
+
+		hnp-disable;
+		srp-disable;
+		adp-disable;
+
+		ulpi {
+			phy@a {
+				status = "ok";
+
+				v1p8-supply = <&pm8941_l6>;
+				v3p3-supply = <&pm8941_l24>;
+
+				qcom,init-seq = /bits/ 8 <0x1 0x64>;
+			};
+		};
+	};
 };
 
 &spmi_bus {
@@ -372,6 +425,13 @@
 				bias-pull-up;
 				power-source = <PM8941_GPIO_S3>;
 			};
+
+			otg {
+				gpio-hog;
+				gpios = <35 GPIO_ACTIVE_HIGH>;
+				output-high;
+				line-name = "otg-gpio";
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index aba159d5a95a..8294192db9eb 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -704,6 +704,17 @@
 			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		i2c@f9923000 {
+			status = "disabled";
+			compatible = "qcom,i2c-qup-v2.1.1";
+			reg = <0xf9923000 0x1000>;
+			interrupts = <0 95 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP1_I2C_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		i2c@f9924000 {
 			status = "disabled";
 			compatible = "qcom,i2c-qup-v2.1.1";
-- 
2.17.2
