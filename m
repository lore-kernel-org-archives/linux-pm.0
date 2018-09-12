From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 1/2] dt-bindings: power: Add Spreadtrum SC27XX fuel gauge unit documentation
Date: Wed, 12 Sep 2018 15:29:38 +0800
Message-ID: <1b3f165e2a806dd3d4b7712160ee3bda72f7d675.1536736399.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, baolin.wang@linaro.org, broonie@kernel.org
List-Id: linux-pm@vger.kernel.org

This patch adds the binding documentation for Spreadtrum SC27XX series PMICs
fuel gauge unit device, which is used to calculate the battery capacity.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../devicetree/bindings/power/supply/sc27xx-fg.txt |   55 ++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt

diff --git a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
new file mode 100644
index 0000000..7447bae
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
@@ -0,0 +1,55 @@
+Spreadtrum SC27XX PMICs Fuel Gauge Unit Power Supply Bindings
+
+Required properties:
+- compatible: Should be one of the following:
+  "sprd,sc2720-fgu",
+  "sprd,sc2721-fgu",
+  "sprd,sc2723-fgu",
+  "sprd,sc2730-fgu",
+  "sprd,sc2731-fgu".
+- reg: The address offset of fuel gauge unit.
+- bat-detect-gpio: GPIO for battery detection.
+- io-channels: Specify the IIO ADC channel to get temperature.
+- io-channel-names: Should be "bat-temp".
+- sprd,inner-resist: Specify the the battery inner resistance (mOhm).
+- sprd,ocv-cap-table: Provide the battery capacity percent with corresponding
+  open circuit voltage (ocv) of the battery, which is used to look up current
+  battery capacity according to current baterry ocv values.
+- monitored-battery: Phandle of battery characteristics devicetree node.
+  The fuel gauge uses the following battery properties:
+- charge-full-design-microamp-hours: battery design capacity.
+- constant-charge-voltage-max-microvolt: maximum constant input voltage.
+  See Documentation/devicetree/bindings/power/supply/battery.txt
+
+Example:
+
+	bat: battery {
+		compatible = "simple-battery";
+		charge-full-design-microamp-hours = <1900000>;
+		constant-charge-voltage-max-microvolt = <4350000>;
+		......
+	};
+
+	sc2731_pmic: pmic@0 {
+		compatible = "sprd,sc2731";
+		reg = <0>;
+		spi-max-frequency = <26000000>;
+		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		fgu@a00 {
+			compatible = "sprd,sc2731-fgu";
+			reg = <0xa00>;
+			bat-detect-gpio = <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
+			io-channels = <&pmic_adc 5>;
+			io-channel-names = "bat-temp";
+			sprd,inner-resist = <250>;
+			sprd,ocv-cap-table = <4185 100>, <4113 95>, <4066 90>, <4022 85>, <3983 80>, <3949 75>, <3917 70>,
+				<3889 65>, <3864 60>, <3835 55>, <3805 50>, <3787 45>, <3777 40>, <3773 35>, <3770 30>,
+				<3765 25>, <3752 20>, <3724 15>, <3680 10>, <3605 5>, <3400 0>;
+			monitored-battery = <&bat>;
+		};
+	};
-- 
1.7.9.5
