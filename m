From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: power: Add Spreadtrum SC2731 charger documentation
Date: Mon,  3 Sep 2018 16:55:45 +0800
Message-ID: <a582871f84c4dd588ae1651d1d9192cc80e2b272.1535964281.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, baolin.wang@linaro.org, broonie@kernel.org, krzk@kernel.org
List-Id: linux-pm@vger.kernel.org

This patch adds the binding documentation for Spreadtrum SC2731 charger
device.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v1:
 - Add parent node.
 - Add some battery standard properties.
---
 .../bindings/power/supply/sc2731_charger.txt       |   40 ++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/sc2731_charger.txt

diff --git a/Documentation/devicetree/bindings/power/supply/sc2731_charger.txt b/Documentation/devicetree/bindings/power/supply/sc2731_charger.txt
new file mode 100644
index 0000000..5266fab
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/sc2731_charger.txt
@@ -0,0 +1,40 @@
+Spreadtrum SC2731 PMIC battery charger binding
+
+Required properties:
+ - compatible: Should be "sprd,sc2731-charger".
+ - reg: Address offset of charger register.
+ - phys: Contains a phandle to the USB phy.
+
+Optional Properties:
+- monitored-battery: phandle of battery characteristics devicetree node.
+  The charger uses the following battery properties:
+- charge-term-current-microamp: current for charge termination phase.
+- constant-charge-voltage-max-microvolt: maximum constant input voltage.
+  See Documentation/devicetree/bindings/power/supply/battery.txt
+
+Example:
+
+	bat: battery {
+		compatible = "simple-battery";
+		charge-term-current-microamp = <120000>;
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
+		charger@0 {
+			compatible = "sprd,sc2731-charger";
+			reg = <0x0>;
+			phys = <&ssphy>;
+			monitored-battery = <&bat>;
+		};
+	};
-- 
1.7.9.5
