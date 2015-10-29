From: Ramakrishna Pallala <ramakrishna.pallala@intel.com>
Subject: [PATCH 1/2] dt: power: Add support for TI BQ24261 charger
Date: Thu, 29 Oct 2015 22:04:14 +0530
Message-ID: <1446136455-20752-2-git-send-email-ramakrishna.pallala@intel.com>
References: <1446136455-20752-1-git-send-email-ramakrishna.pallala@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446136455-20752-1-git-send-email-ramakrishna.pallala@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Cc: Pallala Ramakrishna <ramakrishna.pallala@intel.com>, Jenny Tc <jenny.tc@intel.com>, Andreas Dannenberg <dannenberg@ti.com>
List-Id: linux-pm@vger.kernel.org

This patch adds the device tree documentation for TI BQ24261 charger.

Signed-off-by: Ramakrishna Pallala <ramakrishna.pallala@intel.com>
Signed-off-by: Jennt TC <jenny.tc@intel.com>
---
 .../devicetree/bindings/power/bq24261.txt          |   34 ++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/bq24261.txt

diff --git a/Documentation/devicetree/bindings/power/bq24261.txt b/Documentation/devicetree/bindings/power/bq24261.txt
new file mode 100644
index 0000000..e18f6dc
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/bq24261.txt
@@ -0,0 +1,34 @@
+Binding for TI bq24261 Li-Ion Charger
+
+Required properties:
+- compatible: Should contain one of the following:
+    * "ti,bq24261"
+- reg: integer, i2c address of the device.
+- ti,battery-regulation-voltage: integer, maximum charging voltage in uV.
+- ti,charge-current: integer, maximum charging current in uA.
+- ti,termination-current: integer, charge will be terminated when current in
+    constant-voltage phase drops below this value (in uA).
+
+Optional properties:
+- ti,max-charge-current: integer, maximum charging current (in uA);
+- ti,max-charge-voltage: integer, maximum charging voltage (in uV);
+- ti,min-charge-temperature: integer, minimum charging temperature (in DegC);
+- ti,max-charge-temperature: integer, maximum charging temperature (in DegC).
+- ti,thermal-sensing: integer, enable(1) or disable(0) JEITA thermal control.
+
+Example:
+
+bq24261 {
+        compatible = "ti,bq24261";
+        reg = <0x6b>;
+
+        ti,battery-regulation-voltage = <4200>;
+        ti,charge-current = <1000>;
+        ti,termination-current = <128>;
+
+        ti,max-charge-current = <3000>;
+        ti,max-charge-voltage = <4350>;
+        ti,min-charge-temperature = <0>;
+        ti,max-charge-temperature = <60>;
+        ti,thermal-sensing = <1>;
+};
-- 
1.7.9.5
