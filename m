From: Laurentiu Palcu <laurentiu.palcu@intel.com>
Subject: [PATCH 1/2] Documentation: devicetree: Add TI BQ25890 bindings
Date: Fri, 15 May 2015 17:06:17 +0300
Message-ID: <1431698778-29462-2-git-send-email-laurentiu.palcu@intel.com>
References: <1431698778-29462-1-git-send-email-laurentiu.palcu@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:49396 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422938AbbEOOJx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 15 May 2015 10:09:53 -0400
In-Reply-To: <1431698778-29462-1-git-send-email-laurentiu.palcu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Laurentiu Palcu <laurentiu.palcu@intel.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@intel.com>
---
 .../devicetree/bindings/power/bq25890.txt          | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/bq25890.txt

diff --git a/Documentation/devicetree/bindings/power/bq25890.txt b/Documentation/devicetree/bindings/power/bq25890.txt
new file mode 100644
index 0000000..44f50a7
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/bq25890.txt
@@ -0,0 +1,45 @@
+Binding for TI bq25890 Li-Ion Charger
+
+Required properties:
+- compatible: Should contain one of the following:
+    * "ti,bq25890"
+- reg: integer, i2c address of the device.
+- ti,battery-regulation-voltage: integer, maximum charging voltage (in uV);
+- ti,charge-current: integer, maximum charging current (in uA);
+- ti,termination-current: integer, charge will be terminated when current in
+    constant-voltage phase drops below this value (in uA);
+- ti,precharge-current: integer, maximum charge current during precharge
+    phase (in uA);
+- ti,minimum-sys-voltage: integer, when battery is charging and it is below
+    minimum system voltage, the system will be regulated above
+    minimum-sys-voltage setting (in uV);
+- ti,boost-voltage: integer, VBUS voltage level in boost mode (in uV);
+- ti,boost-max-current: integer, maximum allowed current draw in boost mode
+    (in uA).
+
+Optional properties:
+- ti,boost-low-freq: boolean, if present boost mode frequency will be 500kHz,
+    otherwise 1.5MHz;
+- ti,use-ilim-pin: boolean, if present the ILIM resistor will be used and the
+    input current will be the lower between the resistor setting and the IINLIM
+    register setting;
+- ti,thermal-regulation-threshold: integer, temperature above which the charge
+    current is lowered, to avoid overheating (in degrees Celsius);
+
+Example:
+
+bq25890 {
+        compatible = "ti,bq25890";
+        reg = <0x6a>;
+
+        ti,battery-regulation-voltage = <4200000>;
+        ti,charge-current = <1000000>;
+        ti,termination-current = <50000>;
+        ti,precharge-current = <128000>;
+        ti,minimum-sys-voltage = <3600000>;
+        ti,boost-voltage = <5000000>;
+        ti,boost-max-current = <1000000>;
+
+        ti,use-ilim-pin;
+        ti,thermal-regulation-threshold = <120>;
+};
-- 
1.9.1

