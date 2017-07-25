From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v10 07/10] Documentation: Add sbs-manager device tree node documentation
Date: Tue, 25 Jul 2017 11:40:21 +0800
Message-ID: <1500954024-6860-8-git-send-email-preid@electromag.com.au>
References: <1500954024-6860-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1500954024-6860-1-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, jdelvare@suse.com, jglauber@cavium.com, david.daney@cavium.com, peda@axentia.se, preid@electromag.com.au, benjamin.tissoires@redhat.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
List-Id: linux-pm@vger.kernel.org

From: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>

This patch adds device tree documentation for the sbs-manager

Signed-off-by: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
Signed-off-by: Phil Reid <preid@electromag.com.au>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 .../bindings/power/supply/sbs,sbs-manager.txt      | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.txt

diff --git a/Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.txt b/Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.txt
new file mode 100644
index 0000000..4b219557
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.txt
@@ -0,0 +1,66 @@
+Binding for sbs-manager
+
+Required properties:
+- compatible: "<vendor>,<part-number>", "sbs,sbs-charger" as fallback. The part
+  number compatible string might be used in order to take care of vendor
+  specific registers.
+- reg: integer, i2c address of the device. Should be <0xa>.
+Optional properties:
+- gpio-controller: Marks the port as GPIO controller.
+  See "gpio-specifier" in .../devicetree/bindings/gpio/gpio.txt.
+- #gpio-cells: Should be <2>. The first cell is the pin number, the second cell
+  is used to specify optional parameters:
+  See "gpio-specifier" in .../devicetree/bindings/gpio/gpio.txt.
+
+From OS view the device is basically an i2c-mux used to communicate with up to
+four smart battery devices at address 0xb. The driver actually implements this
+behaviour. So standard i2c-mux nodes can be used to register up to four slave
+batteries. Channels will be numerated starting from 1 to 4.
+
+Example:
+
+batman@a {
+    compatible = "lltc,ltc1760", "sbs,sbs-manager";
+    reg = <0x0a>;
+    #address-cells = <1>;
+    #size-cells = <0>;
+
+    gpio-controller;
+    #gpio-cells = <2>;
+
+    i2c@1 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        reg = <1>;
+
+        battery@b {
+            compatible = "ti,bq2060", "sbs,sbs-battery";
+            reg = <0x0b>;
+            sbs,battery-detect-gpios = <&batman 1 1>;
+        };
+    };
+
+    i2c@2 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        reg = <2>;
+
+        battery@b {
+            compatible = "ti,bq2060", "sbs,sbs-battery";
+            reg = <0x0b>;
+            sbs,battery-detect-gpios = <&batman 2 1>;
+        };
+    };
+
+    i2c@3 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        reg = <3>;
+
+        battery@b {
+            compatible = "ti,bq2060", "sbs,sbs-battery";
+            reg = <0x0b>;
+            sbs,battery-detect-gpios = <&batman 3 1>;
+        };
+    };
+};
-- 
1.8.3.1
