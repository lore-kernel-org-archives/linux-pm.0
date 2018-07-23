From: Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH 3/4] dt-bindings: power: supply: Max17040: Add low level SOC alert threshold
Date: Mon, 23 Jul 2018 00:08:15 -0400
Message-ID: <20180723040816.19455-4-matheus@castello.eng.br>
References: <20180723040816.19455-1-matheus@castello.eng.br>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180723040816.19455-1-matheus@castello.eng.br>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Matheus Castello <matheus@castello.eng.br>
List-Id: linux-pm@vger.kernel.org

For configure low level state of charge threshold alert signaled from
max17040 we add "maxim,alert-soc-level" property.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 .../bindings/power/supply/max17040_battery.txt     | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/max17040_battery.txt

diff --git a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
new file mode 100644
index 000000000000..e6e4e46c03c4
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
@@ -0,0 +1,24 @@
+max17040_battery
+~~~~~~~~~~~~~~~~
+
+Required properties :
+ - compatible : "maxim,max17040"
+
+Optional threshold properties :
+ If skipped the power up default value will be used
+ - maxim,alert-soc-level :	The alert threshold that sets the state of
+ 				charge level where an interrupt is generated.
+                          	max17040 can be configured from 1 up to 32.
+
+Remembering that for the interrupt to be handled it must also be described the
+information of the interruption in the node.
+
+Example:
+
+	battery-charger@36 {
+		compatible = "maxim,max17040";
+		reg = <0x36>;
+		maxim,alert-soc-level = <10>;
+		interrupt-parent = <&gpio>;
+		interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
+	};
-- 
2.13.3
