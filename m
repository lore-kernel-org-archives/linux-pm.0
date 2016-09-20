From: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v2] power: bq27xxx_battery: allow kernel poll_interval parameter runtime update
Date: Mon, 19 Sep 2016 20:43:02 -0700
Message-ID: <1474342982-7242-1-git-send-email-matt@ranostay.consulting>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Andrew F . Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>, Matt Ranostay <matt@ranostay.consulting>, Tony Lindgren <tony@atomide.com>, Liam Breck <liam@networkimprov.net>
List-Id: linux-pm@vger.kernel.org

Fix issue with poll_interval being not updated till the previous
interval expired.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Liam Breck <liam@networkimprov.net>
Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
---

Changes from v1:
 * Change param_get_ushort to param_get_uint
 * Changed param_lock naming to more precise bq27xxx_list_lock

 drivers/power/supply/bq27xxx_battery.c | 38 +++++++++++++++++++++++++++++++++-
 include/linux/power/bq27xxx_battery.h  |  1 +
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 3f57dd54803a..3b0dbc689d72 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -39,6 +39,7 @@
 
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/param.h>
 #include <linux/jiffies.h>
 #include <linux/workqueue.h>
@@ -390,8 +391,35 @@ static struct {
 	BQ27XXX_PROP(BQ27421, bq27421_battery_props),
 };
 
+static DEFINE_MUTEX(bq27xxx_list_lock);
+static LIST_HEAD(bq27xxx_battery_devices);
+
+static int poll_interval_param_set(const char *val, const struct kernel_param *kp)
+{
+	struct bq27xxx_device_info *di;
+	int ret;
+
+	ret = param_set_uint(val, kp);
+	if (ret < 0)
+		return ret;
+
+	mutex_lock(&bq27xxx_list_lock);
+	list_for_each_entry(di, &bq27xxx_battery_devices, list) {
+		cancel_delayed_work_sync(&di->work);
+		schedule_delayed_work(&di->work, 0);
+	}
+	mutex_unlock(&bq27xxx_list_lock);
+
+	return ret;
+}
+
+static const struct kernel_param_ops param_ops_poll_interval = {
+	.get = param_get_uint,
+	.set = poll_interval_param_set,
+};
+
 static unsigned int poll_interval = 360;
-module_param(poll_interval, uint, 0644);
+module_param_cb(poll_interval, &param_ops_poll_interval, &poll_interval, 0644);
 MODULE_PARM_DESC(poll_interval,
 		 "battery poll interval in seconds - 0 disables polling");
 
@@ -972,6 +1000,10 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 
 	bq27xxx_battery_update(di);
 
+	mutex_lock(&bq27xxx_list_lock);
+	list_add(&di->list, &bq27xxx_battery_devices);
+	mutex_unlock(&bq27xxx_list_lock);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(bq27xxx_battery_setup);
@@ -990,6 +1022,10 @@ void bq27xxx_battery_teardown(struct bq27xxx_device_info *di)
 
 	power_supply_unregister(di->bat);
 
+	mutex_lock(&bq27xxx_list_lock);
+	list_del(&di->list);
+	mutex_unlock(&bq27xxx_list_lock);
+
 	mutex_destroy(&di->lock);
 }
 EXPORT_SYMBOL_GPL(bq27xxx_battery_teardown);
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index b50c0492629d..e30deb046156 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -58,6 +58,7 @@ struct bq27xxx_device_info {
 	unsigned long last_update;
 	struct delayed_work work;
 	struct power_supply *bat;
+	struct list_head list;
 	struct mutex lock;
 	u8 *regs;
 };
-- 
2.7.4
