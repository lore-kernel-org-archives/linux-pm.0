From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v5 3/6] Documentation: Add sbs-manager device tree node documentation
Date: Wed, 21 Sep 2016 16:41:11 +0800
Message-ID: <1474447274-90821-4-git-send-email-preid@electromag.com.au>
References: <1474447274-90821-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from 203-59-230-133.perm.iinet.net.au ([203.59.230.133]:37052 "EHLO
        preid-centos7.electromag.com.au" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754576AbcIUIlZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Sep 2016 04:41:25 -0400
In-Reply-To: <1474447274-90821-1-git-send-email-preid@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, andrea.merello@gmail.com, preid@electromag.com.au, karl-heinz@schneider-inet.de, arnd@arndb.de, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

From: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>

This patch adds device tree documentation for the sbs-manager

Reviewed-by: Phil Reid <preid@electromag.com.au>
Signed-off-by: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 .../bindings/power/supply/sbs,sbs-manager.txt      | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.txt

diff --git a/Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.txt b/Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.txt
new file mode 100644
index 0000000..2a04b30
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.txt
@@ -0,0 +1,62 @@
+Binding for sbs-manager
+
+Required properties:
+- compatible: should be "lltc,ltc1760" or use "sbs,sbs-manager" as fallback.
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
+batteries. See Documentation/devicetree/bindings/i2c/i2c-mux.txt for more
+information on i2c-mux nodes. Channels will be numerated starting from 1 to 4.
+
+Example:
+
+batman@0a {
+    compatible = "lltc,ltc1760";
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
+            reg = <0xb>;
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
+            reg = <0xb>;
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
+            reg = <0xb>;
+        };
+    };
+};
-- 
1.8.3.1

