From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 1/2] dt-bindings: power: Add Spreadtrum SC2731 charger documentation
Date: Tue, 28 Aug 2018 17:02:22 +0800
Message-ID: <5fcd93bbbcd55a5c23f1c75effdc3670ce7a811b.1535446321.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, baolin.wang@linaro.org, broonie@kernel.org
List-Id: linux-pm@vger.kernel.org

This patch adds the binding documentation for Spreadtrum SC2731 charger
device.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../bindings/power/supply/sc2731_charger.txt       |   14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/sc2731_charger.txt

diff --git a/Documentation/devicetree/bindings/power/supply/sc2731_charger.txt b/Documentation/devicetree/bindings/power/supply/sc2731_charger.txt
new file mode 100644
index 0000000..02b616c
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/sc2731_charger.txt
@@ -0,0 +1,14 @@
+Spreadtrum SC2731 PMIC battery charger binding
+
+Required properties:
+ - compatible: Should be "sprd,sc2731-charger".
+ - reg: Address offset of charger register.
+ - phys: Contains a phandle to the USB phy.
+
+Example:
+
+	charger@0 {
+		compatible = "sprd,sc2731-charger";
+		reg = <0x0>;
+		phys = <&ssphy>;
+	};
-- 
1.7.9.5
