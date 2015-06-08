From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 1/2] power_supply: max17042: Add OF support for setting
 thresholds
Date: Mon, 08 Jun 2015 10:11:38 +0900
Message-ID: <1433725899-13849-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

The commit edd4ab055931 ("power: max17042_battery: add HEALTH and TEMP_*
properties support") added support for setting voltage and temperature
thresholds with platform data. For DeviceTree default of 0 was always
used.

This caused reporting battery health always as over voltage or
over heated.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Fixes: edd4ab055931 ("power: max17042_battery: add HEALTH and TEMP_* properties support")
---
 .../devicetree/bindings/power_supply/max17042_battery.txt   | 13 +++++++++++++
 drivers/power/max17042_battery.c                            |  9 +++++++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/power_supply/max17042_battery.txt b/Documentation/devicetree/bindings/power_supply/max17042_battery.txt
index 5bc9b685cf8a..3f3894aaeebc 100644
--- a/Documentation/devicetree/bindings/power_supply/max17042_battery.txt
+++ b/Documentation/devicetree/bindings/power_supply/max17042_battery.txt
@@ -9,10 +9,23 @@ Optional properties :
                          (datasheet-recommended value is 10000).
    Defining this property enables current-sense functionality.
 
+Optional threshold properties :
+ If skipped the condition won't be reported.
+ - maxim,cold-temp :      Temperature threshold to report battery
+                          as cold (in tenths of degree Celsius).
+ - maxim,over-heat-temp : Temperature threshold to report battery
+                          as over heated (in tenths of degree Celsius).
+ - maxim,dead-volt :      Voltage threshold to report battery
+                          as dead (in mV).
+ - maxim,over-volt :      Voltage threshold to report battery
+                          as over voltage (in mV).
+
 Example:
 
 	battery-charger@36 {
 		compatible = "maxim,max17042";
 		reg = <0x36>;
 		maxim,rsns-microohm = <10000>;
+		maxim,over-heat-temp = <600>;
+		maxim,over-volt = <4300>;
 	};
diff --git a/drivers/power/max17042_battery.c b/drivers/power/max17042_battery.c
index 62908eba2763..a8e16364c2aa 100644
--- a/drivers/power/max17042_battery.c
+++ b/drivers/power/max17042_battery.c
@@ -818,6 +818,15 @@ max17042_get_pdata(struct device *dev)
 		pdata->enable_current_sense = true;
 	}
 
+	if (of_property_read_s32(np, "maxim,cold-temp", &pdata->temp_min))
+		pdata->temp_min = INT_MIN;
+	if (of_property_read_s32(np, "maxim,over-heat-temp", &pdata->temp_max))
+		pdata->temp_max = INT_MAX;
+	if (of_property_read_s32(np, "maxim,dead-volt", &pdata->vmin))
+		pdata->vmin = INT_MIN;
+	if (of_property_read_s32(np, "maxim,over-volt", &pdata->vmax))
+		pdata->vmax = INT_MAX;
+
 	return pdata;
 }
 #else
-- 
1.9.1
