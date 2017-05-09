From: Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>
Subject: [PATCH v2] dt-bindings: power: New bindings for ltc3651-charger
Date: Tue,  9 May 2017 07:36:30 +0200
Message-ID: <1494308190-3687-1-git-send-email-mike.looijmans@topic.nl>
References: <1493966315-15893-1-git-send-email-mike.looijmans@topic.nl> <20170508171206.ajxjbw5mybvrpwss@rob-hp-laptop>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170508171206.ajxjbw5mybvrpwss@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This adds the devicetree bindings documentation for the LTC3651 battery charger.

Signed-off-by: Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>
---
v2: Add "lltc," vendor prefix to gpios
    Expand irq paragraph

 .../bindings/power/supply/ltc3651-charger.txt      | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/ltc3651-charger.txt

diff --git a/Documentation/devicetree/bindings/power/supply/ltc3651-charger.txt b/Documentation/devicetree/bindings/power/supply/ltc3651-charger.txt
new file mode 100644
index 0000000..71f2840
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/ltc3651-charger.txt
@@ -0,0 +1,27 @@
+ltc3651-charger
+
+Required properties:
+ - compatible: "lltc,ltc3651-charger"
+ - lltc,acpr-gpios: Connect to ACPR output. See remark below.
+
+Optional properties:
+ - lltc,fault-gpios: Connect to FAULT output. See remark below.
+ - lltc,chrg-gpios: Connect to CHRG output. See remark below.
+
+The ltc3651 outputs are open-drain type and active low. The driver assumes the
+GPIO reports "active" when the output is asserted, so if the pins have been
+connected directly, the GPIO flags should be set to active low also.
+
+The driver will attempt to aquire interrupts for all GPIOs to detect changes in
+line state. If the system is not capabale of providing interrupts, the driver
+cannot report changes and userspace will need to periodically read the sysfs
+attributes to detect changes.
+
+Example:
+
+	charger: battery-charger {
+		compatible = "lltc,ltc3651-charger";
+		lltc,acpr-gpios = <&gpio0 68 GPIO_ACTIVE_LOW>;
+		lltc,fault-gpios = <&gpio0 64 GPIO_ACTIVE_LOW>;
+		lltc,chrg-gpios = <&gpio0 63 GPIO_ACTIVE_LOW>;
+	};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
