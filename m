From: Chris Lapa <chris@lapa.com.au>
Subject: [PATCH v2 1/4] max8903: adds documentation for device tree bindings.
Date: Fri, 10 Jun 2016 22:32:47 +1000
Message-ID: <1465561970-18377-2-git-send-email-chris@lapa.com.au>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
 <1465561970-18377-1-git-send-email-chris@lapa.com.au>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465561970-18377-1-git-send-email-chris@lapa.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: k.kozlowski@samsung.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chris Lapa <chris@lapa.com.au>
List-Id: linux-pm@vger.kernel.org

From: Chris Lapa <chris@lapa.com.au>

Signed-off-by: Chris Lapa <chris@lapa.com.au>
---
 .../devicetree/bindings/power/max8903-charger.txt  | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/max8903-charger.txt

diff --git a/Documentation/devicetree/bindings/power/max8903-charger.txt b/Documentation/devicetree/bindings/power/max8903-charger.txt
new file mode 100644
index 0000000..e0b5366
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/max8903-charger.txt
@@ -0,0 +1,30 @@
+Maxim Semiconductor MAX8903 Battery Charger bindings
+
+Required properties:
+- compatible: "maxim,max8903-charger" for MAX8903 Battery Charger
+- dc_valid: Specifies that the DC portion of the MAX8903 has been connected up
+		and that dok-gpios should be specified
+	- dok-gpios: Valid DC power has been detected
+- usb_valid: Specifies that the USB portion of the MAX8903 has been connected up
+		and that uok-gpios should be specified
+	- uok-gpios: Valid USB power has been detected
+
+Optional properties:
+- cen-gpios: Charge enable pin
+- chg-gpios: Charger status pin
+- flt-gpios: Fault pin
+- dcm-gpios: Current limit mode setting (DC or USB)
+- usus-gpios: USB suspend pin
+
+
+Example:
+
+	max8903-charger {
+		compatible = "maxim,max8903-charger";
+		dok-gpios = <&gpio2 3 GPIO_ACTIVE_LOW>;
+		flt-gpios = <&gpio2 2 GPIO_ACTIVE_LOW>;
+		chg-gpios = <&gpio3 15 GPIO_ACTIVE_LOW>;
+		cen-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>;
+		dc_valid;
+		status = "okay";
+	};
-- 
1.9.1
