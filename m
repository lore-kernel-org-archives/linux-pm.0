From: Rhyland Klein <rklein@nvidia.com>
Subject: [PATCH v3] power_supply: power_supply_read_temp only if use_cnt > 0
Date: Tue, 7 Jun 2016 16:26:03 -0400
Message-ID: <1465331163-16884-1-git-send-email-rklein@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Rhyland Klein <rklein@nvidia.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Change power_supply_read_temp() to use power_supply_get_property()
so that it will check the use_cnt and ensure it is > 0. The use_cnt
will be incremented at the end of __power_supply_register, so this
will block to case where get_property can be called before the supply
is fully registered. This fixes the issue show in the stack below:

[    1.452598] power_supply_read_temp+0x78/0x80
[    1.458680] thermal_zone_get_temp+0x5c/0x11c
[    1.464765] thermal_zone_device_update+0x34/0xb4
[    1.471195] thermal_zone_device_register+0x87c/0x8cc
[    1.477974] __power_supply_register+0x364/0x424
[    1.484317] power_supply_register_no_ws+0x10/0x18
[    1.490833] bq27xxx_battery_setup+0x10c/0x164
[    1.497003] bq27xxx_battery_i2c_probe+0xd0/0x1b0
[    1.503435] i2c_device_probe+0x174/0x240
[    1.509172] driver_probe_device+0x1fc/0x29c
[    1.515167] __driver_attach+0xa4/0xa8
[    1.520643] bus_for_each_dev+0x58/0x98
[    1.526204] driver_attach+0x20/0x28
[    1.531505] bus_add_driver+0x1c8/0x22c
[    1.537067] driver_register+0x68/0x108
[    1.542630] i2c_register_driver+0x38/0x7c
[    1.548457] bq27xxx_battery_i2c_driver_init+0x18/0x20
[    1.555321] do_one_initcall+0x38/0x12c
[    1.560886] kernel_init_freeable+0x148/0x1ec
[    1.566972] kernel_init+0x10/0xfc
[    1.572101] ret_from_fork+0x10/0x40

Also make the same change to ps_get_max_charge_cntl_limit() and
ps_get_cur_chrage_cntl_limit() to be safe. Lastly, change the return
value of power_supply_get_property() to -EAGAIN from -ENODEV if
use_cnt <= 0.

Fixes: 297d716f6260 ("power_supply: Change ownership from driver to core")
Cc: stable@vger.kernel.org
Signed-off-by: Rhyland Klein <rklein@nvidia.com>
---
v3:
 - Changed calls to ->get_property() to use common
   power_supply_get_property()
 - reworded description, added "Fixes" line
 - Changed return value of power_supply_get_property() to -EAGAIN

v2:
 - Added cc stable
 - changed return to -EAGAIN in case of use_cnt < 1
 - Removed WARNING
 - return value check added in additional patch:
   https://lkml.org/lkml/2016/6/6/706

 drivers/power/power_supply_core.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
index 456987c88baa..cccc630bd68e 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -492,7 +492,7 @@ int power_supply_get_property(struct power_supply *psy,
 			    union power_supply_propval *val)
 {
 	if (atomic_read(&psy->use_cnt) <= 0)
-		return -ENODEV;
+		return -EAGAIN;
 
 	return psy->desc->get_property(psy, psp, val);
 }
@@ -564,12 +564,14 @@ static int power_supply_read_temp(struct thermal_zone_device *tzd,
 	int ret;
 
 	WARN_ON(tzd == NULL);
+
 	psy = tzd->devdata;
-	ret = psy->desc->get_property(psy, POWER_SUPPLY_PROP_TEMP, &val);
+	ret = power_supply_get_property(psy, POWER_SUPPLY_PROP_TEMP, &val);
+	if (!ret)
+		return ret;
 
 	/* Convert tenths of degree Celsius to milli degree Celsius. */
-	if (!ret)
-		*temp = val.intval * 100;
+	*temp = val.intval * 100;
 
 	return ret;
 }
@@ -612,10 +614,12 @@ static int ps_get_max_charge_cntl_limit(struct thermal_cooling_device *tcd,
 	int ret;
 
 	psy = tcd->devdata;
-	ret = psy->desc->get_property(psy,
-		POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX, &val);
+	ret = power_supply_get_property(psy,
+			POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX, &val);
 	if (!ret)
-		*state = val.intval;
+		return ret;
+
+	*state = val.intval;
 
 	return ret;
 }
@@ -628,10 +632,12 @@ static int ps_get_cur_chrage_cntl_limit(struct thermal_cooling_device *tcd,
 	int ret;
 
 	psy = tcd->devdata;
-	ret = psy->desc->get_property(psy,
-		POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT, &val);
+	ret = power_supply_get_property(psy,
+			POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT, &val);
 	if (!ret)
-		*state = val.intval;
+		return ret;
+
+	*state = val.intval;
 
 	return ret;
 }
-- 
1.9.1
