From: Nicolas Saenz Julienne <nicolas.saenz@prodys.net>
Subject: [PATCH v3 2/2] dt-bindings: power: add bindings for sbs-charger
Date: Thu, 24 Nov 2016 13:33:43 +0100
Message-ID: <1479990823-25841-3-git-send-email-nicolas.saenz@prodys.net>
References: <1479990823-25841-1-git-send-email-nicolas.saenz@prodys.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1479990823-25841-1-git-send-email-nicolas.saenz@prodys.net>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, nicolas.saenz@prodys.net
List-Id: linux-pm@vger.kernel.org

Adds device tree documentation for SBS charger compilant devices as defined
here: http://sbs-forum.org/specs/sbc110.pdf

Signed-off-by: Nicolas Saenz Julienne <nicolas.saenz@prodys.net>
---
v2 -> v3:
- add part number as compatible

 .../bindings/power/supply/sbs_sbs-charger.txt      | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/sbs_sbs-charger.txt

diff --git a/Documentation/devicetree/bindings/power/supply/sbs_sbs-charger.txt b/Documentation/devicetree/bindings/power/supply/sbs_sbs-charger.txt
new file mode 100644
index 0000000..f6b6027
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/sbs_sbs-charger.txt
@@ -0,0 +1,24 @@
+SBS sbs-charger
+~~~~~~~~~~
+
+Required properties:
+ - compatible: should contain one of the following:
+	- "lltc,ltc4100"
+	- "sbs,sbs-charger"
+
+Optional properties:
+- interrupt-parent: Should be the phandle for the interrupt controller. Use in
+    conjunction with "interrupts".
+- interrupts: Interrupt mapping for GPIO IRQ. Use in conjunction with
+    "interrupt-parent". If an interrupt is not provided the driver will switch
+    automatically to polling.
+
+Example:
+
+	ltc4100@9 {
+		compatible = "sbs,sbs-charger";
+		reg = <0x9>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+	};
+
-- 
2.7.4
