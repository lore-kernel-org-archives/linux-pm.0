From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH v4 5/5] power: supply: ds2760_battery: add devicetree probing
Date: Fri,  6 Jul 2018 07:35:52 +0200
Message-ID: <20180706053552.11438-6-daniel@zonque.org>
References: <20180706053552.11438-1-daniel@zonque.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180706053552.11438-1-daniel@zonque.org>
Sender: linux-kernel-owner@vger.kernel.org
To: zbr@ioremap.net, robh+dt@kernel.org, mark.rutland@arm.com, szabolcs.gyurko@tlt.hu
Cc: sre@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, robert.jarzmik@free.fr, Daniel Mack <daniel@zonque.org>
List-Id: linux-pm@vger.kernel.org

Add a matching table for devicetree probing, and optionally set the module
parameter variables from DT properties.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 drivers/power/supply/ds2760_battery.c | 29 ++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/ds2760_battery.c b/drivers/power/supply/ds2760_battery.c
index aa406a7c65a1..11bed88a89fa 100644
--- a/drivers/power/supply/ds2760_battery.c
+++ b/drivers/power/supply/ds2760_battery.c
@@ -29,6 +29,7 @@
 #include <linux/power_supply.h>
 #include <linux/suspend.h>
 #include <linux/w1.h>
+#include <linux/of.h>
 
 static unsigned int cache_time = 1000;
 module_param(cache_time, uint, 0644);
@@ -705,6 +706,24 @@ static int w1_ds2760_add_slave(struct w1_slave *sl)
 
 	psy_cfg.drv_data = di;
 
+	if (dev->of_node) {
+		u32 tmp;
+
+		psy_cfg.of_node = dev->of_node;
+
+		if (!of_property_read_bool(dev->of_node, "maxim,pmod-enabled"))
+			pmod_enabled = true;
+
+		if (!of_property_read_u32(dev->of_node,
+					  "maxim,cache-time-ms", &tmp))
+			cache_time = tmp;
+
+		if (!of_property_read_u32(dev->of_node,
+					  "rated-capacity-microamp-hours",
+					  &tmp))
+			rated_capacity = tmp / 10; /* property is in mAh */
+	}
+
 	di->charge_status = POWER_SUPPLY_STATUS_UNKNOWN;
 
 	sl->family_data = di;
@@ -719,7 +738,7 @@ static int w1_ds2760_add_slave(struct w1_slave *sl)
 
 	ds2760_battery_write_status(di, status);
 
-	/* set rated capacity from module param */
+	/* set rated capacity from module param or device tree */
 	if (rated_capacity)
 		ds2760_battery_write_rated_capacity(di, rated_capacity);
 
@@ -769,6 +788,13 @@ static void w1_ds2760_remove_slave(struct w1_slave *sl)
 	power_supply_unregister(di->bat);
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id w1_ds2760_of_ids[] = {
+	{ .compatible = "maxim,ds2760" },
+	{}
+};
+#endif
+
 static struct w1_family_ops w1_ds2760_fops = {
 	.add_slave	= w1_ds2760_add_slave,
 	.remove_slave	= w1_ds2760_remove_slave,
@@ -778,6 +804,7 @@ static struct w1_family_ops w1_ds2760_fops = {
 static struct w1_family w1_ds2760_family = {
 	.fid		= W1_FAMILY_DS2760,
 	.fops		= &w1_ds2760_fops,
+	.of_match_table	= of_match_ptr(w1_ds2760_of_ids),
 };
 module_w1_family(w1_ds2760_family);
 
-- 
2.17.1
