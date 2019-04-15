From: Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v2 2/4] dt-bindings: power: supply: Max17040: Add low level SOC alert threshold
Date: Sun, 14 Apr 2019 22:26:33 -0300
Message-ID: <20190415012635.6369-3-matheus@castello.eng.br>
References: <CAJKOXPfvs=uETF0-xpwCWc5khSpWjpz2zz354Jcx1bVjm9cG2A@mail.gmail.com>
 <20190415012635.6369-1-matheus@castello.eng.br>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415012635.6369-1-matheus@castello.eng.br>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org
Cc: mark.rutland@arm.com, cw00.choi@samsung.com, b.zolnierkie@samsung.com, lee.jones@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Matheus Castello <matheus@castello.eng.br>
List-Id: linux-pm@vger.kernel.org

For configure low level state of charge threshold alert signaled from
max17040 we add "maxim,alert-soc-level" property.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 .../power/supply/max17040_battery.txt         | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/max17040_battery.txt

diff --git a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
new file mode 100644
index 000000000000..9b2cc67d556f
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
@@ -0,0 +1,24 @@
+max17040_battery
+~~~~~~~~~~~~~~~~
+
+Required properties :
+ - compatible : "maxim,max17040" or "maxim,max77836-battery"
+
+Optional properties :
+- maxim,alert-soc-level :	The alert threshold that sets the state of
+ 				charge level where an interrupt is generated.
+                          	Can be configured from 1 up to 32. If skipped
+				the power up default value of 4 will be used.
+- interrupt-parent : 		The GPIO bank from the interrupt line.
+- interrupts : 			Interrupt line see Documentation/devicetree/
+				bindings/interrupt-controller/interrupts.txt
+
+Example:
+
+	battery-charger@36 {
+		compatible = "maxim,max17040";
+		reg = <0x36>;
+		maxim,alert-soc-level = <10>;
+		interrupt-parent = <&gpio7>;
+		interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
+	};
-- 
2.17.0
