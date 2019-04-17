From: Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH 2/2] power: supply: fix leaked of_node refs in power_supply_get_battery_info
Date: Wed, 17 Apr 2019 10:43:03 +0800
Message-ID: <1555468983-34952-3-git-send-email-wen.yang99@zte.com.cn>
References: <1555468983-34952-1-git-send-email-wen.yang99@zte.com.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1555468983-34952-1-git-send-email-wen.yang99@zte.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The call to of_parse_phandle returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./drivers/power/supply/power_supply_core.c:601:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 595, but without a corresponding object release within this function.
./drivers/power/supply/power_supply_core.c:604:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 595, but without a corresponding object release within this function.
./drivers/power/supply/power_supply_core.c:632:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 595, but without a corresponding object release within this function.
./drivers/power/supply/power_supply_core.c:635:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 595, but without a corresponding object release within this function.
./drivers/power/supply/power_supply_core.c:653:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 595, but without a corresponding object release within this function.
./drivers/power/supply/power_supply_core.c:664:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 595, but without a corresponding object release within this function.
./drivers/power/supply/power_supply_core.c:673:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 595, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/power/supply/power_supply_core.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 65c619c..874495c 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -598,10 +598,12 @@ int power_supply_get_battery_info(struct power_supply *psy,
 
 	err = of_property_read_string(battery_np, "compatible", &value);
 	if (err)
-		return err;
+		goto out_put_node;
 
-	if (strcmp("simple-battery", value))
-		return -ENODEV;
+	if (strcmp("simple-battery", value)) {
+		err = -ENODEV;
+		goto out_put_node;
+	}
 
 	/* The property and field names below must correspond to elements
 	 * in enum power_supply_property. For reasoning, see
@@ -629,10 +631,12 @@ int power_supply_get_battery_info(struct power_supply *psy,
 
 	len = of_property_count_u32_elems(battery_np, "ocv-capacity-celsius");
 	if (len < 0 && len != -EINVAL) {
-		return len;
+		err = len;
+		goto out_put_node;
 	} else if (len > POWER_SUPPLY_OCV_TEMP_MAX) {
 		dev_err(&psy->dev, "Too many temperature values\n");
-		return -EINVAL;
+		err = -EINVAL;
+		goto out_put_node;
 	} else if (len > 0) {
 		of_property_read_u32_array(battery_np, "ocv-capacity-celsius",
 					   info->ocv_temp, len);
@@ -650,7 +654,8 @@ int power_supply_get_battery_info(struct power_supply *psy,
 			dev_err(&psy->dev, "failed to get %s\n", propname);
 			kfree(propname);
 			power_supply_put_battery_info(psy, info);
-			return -EINVAL;
+			err = -EINVAL;
+			goto out_put_node;
 		}
 
 		kfree(propname);
@@ -661,7 +666,8 @@ int power_supply_get_battery_info(struct power_supply *psy,
 			devm_kcalloc(&psy->dev, tab_len, sizeof(*table), GFP_KERNEL);
 		if (!info->ocv_table[index]) {
 			power_supply_put_battery_info(psy, info);
-			return -ENOMEM;
+			err = -ENOMEM;
+			goto out_put_node;
 		}
 
 		for (i = 0; i < tab_len; i++) {
@@ -670,7 +676,9 @@ int power_supply_get_battery_info(struct power_supply *psy,
 		}
 	}
 
-	return 0;
+out_put_node:
+	of_node_put(battery_np);
+	return err;
 }
 EXPORT_SYMBOL_GPL(power_supply_get_battery_info);
 
-- 
2.9.5
