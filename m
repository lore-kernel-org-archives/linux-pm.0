From: Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Subject: [PATCH v4 2/5] devicetree: power: Add docs for TI BQ24190 battery charger
Date: Mon, 28 Aug 2017 14:23:46 -0700
Message-ID: <20170828212349.19037-3-liam@networkimprov.net>
References: <20170828212349.19037-1-liam@networkimprov.net>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170828212349.19037-1-liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>

Document monitored-battery and ti,system-minimum-microvolt properties.

Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 .../devicetree/bindings/power/supply/bq24190.txt   | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq24190.txt

diff --git a/Documentation/devicetree/bindings/power/supply/bq24190.txt b/Documentation/devicetree/bindings/power/supply/bq24190.txt
new file mode 100644
index 00000000..9e517d30
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/bq24190.txt
@@ -0,0 +1,51 @@
+TI BQ24190 Li-Ion Battery Charger
+
+Required properties:
+- compatible: contains one of the following:
+    * "ti,bq24190"
+    * "ti,bq24192i"
+- reg: integer, I2C address of the charger.
+- interrupts[-extended]: configuration for charger INT pin.
+
+Optional properties:
+- monitored-battery: phandle of battery characteristics devicetree node
+  The charger uses the following battery properties:
+    + precharge-current-microamp: maximum charge current during precharge
+      phase (typically 20% of battery capacity).
+    + charge-term-current-microamp: a charge cycle terminates when the
+      battery voltage is above recharge threshold, and the current is below
+      this setting (typically 10% of battery capacity).
+  See also Documentation/devicetree/bindings/power/supply/battery.txt
+- ti,system-minimum-microvolt: when power is connected and the battery is below
+  minimum system voltage, the system will be regulated above this setting.
+
+Notes:
+- Some circuit boards wire the chip's "OTG" pin high (enabling 500mA default
+  charge current on USB SDP ports, among other features). To simulate this on
+  boards that wire the pin to a GPIO, set a gpio-hog.
+
+Example:
+
+	bat: battery {
+		compatible = "simple-battery";
+		precharge-current-microamp = <256000>;
+		charge-term-current-microamp = <128000>;
+		// etc.
+	};
+
+	bq24190: charger@6a {
+		compatible = "ti,bq24190";
+		reg = <0x6a>;
+		interrupts-extended = <&gpiochip 10 IRQ_TYPE_EDGE_FALLING>;
+		monitored-battery = <&bat>;
+		ti,system-minimum-microvolt = <3200000>;
+	};
+
+	&twl_gpio {
+		otg {
+			gpio-hog;
+			gpios = <6 0>;
+			output-high;
+			line-name = "otg-gpio";
+		};
+	};
-- 
2.13.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
