From: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Subject: [PATCH v2 2/3] devicetree: bq27425: add documentation for bq27425 fuel gauge
Date: Wed,  4 Jan 2017 18:10:06 -0800
Message-ID: <20170105021007.22088-3-matt@ranostay.consulting>
References: <20170105021007.22088-1-matt@ranostay.consulting>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170105021007.22088-1-matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
---
 .../devicetree/bindings/power/bq27425.txt          | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/bq27425.txt

diff --git a/Documentation/devicetree/bindings/power/bq27425.txt b/Documentation/devicetree/bindings/power/bq27425.txt
new file mode 100644
index 000000000000..5d33b61cf9b7
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/bq27425.txt
@@ -0,0 +1,25 @@
+* TI BQ27425 Fuel Gauge
+
+http://www.ti.com/lit/ds/symlink/bq27425-g2a.pdf
+
+Please note that if any of the optional properties are defined
+then all settings must be.
+
+Required properties:
+- compatible: Should be "ti,bq27425"
+- reg: integer, I2C address of the device
+
+Optional properties:
+- ti,design-microamp-hours: integer of mAh of the battery
+- ti,design-microvolt-hours: integer of the mWh of the battery
+- ti,terminate-microvolt: integer of mV of the dead voltage of
+		the battery
+
+bq27425 {
+	compatible = "ti,bq27425";
+	reg = <0x55>;
+
+	ti,design-microamp-hours = <1360>;
+	ti,design-microwatt-hours = <4970>;
+	ti,terminate-microvolt = <3200>;
+};
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
