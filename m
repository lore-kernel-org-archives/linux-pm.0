From: Chris Lapa <chris@lapa.com.au>
Subject: [PATCH v3 1/7] max8903: adds documentation for device tree bindings.
Date: Fri, 17 Jun 2016 15:00:20 +1000
Message-ID: <1466139626-51434-2-git-send-email-chris@lapa.com.au>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
 <1466139626-51434-1-git-send-email-chris@lapa.com.au>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466139626-51434-1-git-send-email-chris@lapa.com.au>
In-Reply-To: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: k.kozlowski@samsung.com, dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chris Lapa <chris@lapa.com.au>
List-Id: linux-pm@vger.kernel.org

From: Chris Lapa <chris@lapa.com.au>

Signed-off-by: Chris Lapa <chris@lapa.com.au>
---
 .../devicetree/bindings/power/max8903-charger.txt  | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/max8903-charger.txt

diff --git a/Documentation/devicetree/bindings/power/max8903-charger.txt b/Documentation/devicetree/bindings/power/max8903-charger.txt
new file mode 100644
index 0000000..aea1dd2a
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/max8903-charger.txt
@@ -0,0 +1,25 @@
+Maxim Semiconductor MAX8903 Battery Charger bindings
+
+Required properties:
+- compatible: "maxim,max8903-charger" for MAX8903 Battery Charger
+- dok-gpios: Valid DC power has been detected, optional if uok-gpios is provided
+- uok-gpios: Valid USB power has been detected, optional if dok-gpios is provided
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
+		status = "okay";
+	};
-- 
1.9.1
