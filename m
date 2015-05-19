From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFC/RFT 2/2] power_supply: Fix possible NULL pointer dereference on
 early uevent
Date: Tue, 19 May 2015 14:26:03 +0900
Message-ID: <1432013163-20713-3-git-send-email-k.kozlowski@samsung.com>
References: <1432013163-20713-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:8437 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201AbbESF0Q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 May 2015 01:26:16 -0400
In-reply-to: <1432013163-20713-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>

Don't call the power_supply_changed() from power_supply_register() when
parent is still probing because it may lead to accessing parent too
early.

In bq27x00_battery this caused NULL pointer exception because uevent of
power_supply_changed called back the the get_property() method provided
by the driver. The get_property() method accessed pointer which should
be returned by power_supply_register().

Starting from bq27x00_battery_probe():
  di->bat = power_supply_register()
    power_supply_changed()
      kobject_uevent()
        power_supply_uevent()
          power_supply_show_property()
            power_supply_get_property()
              bq27x00_battery_get_property()
                dereference of di->bat which is NULL here

The dereference of di->bat (value returned by power_supply_register())
is the currently visible problem. However calling back the methods
provided by driver before ending the probe may lead to accessing other
driver-related data which is not yet initialized.

The call to power_supply_changed() is postponed till probing ends -
mutex of parent device is released.

Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Fixes: 297d716f6260 ("power_supply: Change ownership from driver to core")
---
 drivers/power/power_supply_core.c | 48 +++++++++++++++++++++++++++++++++++----
 include/linux/power_supply.h      |  1 +
 2 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
index 15da277e0e8d..3a36d2940803 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -30,6 +30,8 @@ EXPORT_SYMBOL_GPL(power_supply_notifier);
 
 static struct device_type power_supply_dev_type;
 
+#define POWER_SUPPLY_DEFERRED_REGISTER_TIME	msecs_to_jiffies(10)
+
 static bool __power_supply_is_supplied_by(struct power_supply *supplier,
 					 struct power_supply *supply)
 {
@@ -121,6 +123,30 @@ void power_supply_changed(struct power_supply *psy)
 }
 EXPORT_SYMBOL_GPL(power_supply_changed);
 
+/*
+ * Notify that power supply was registered after parent finished the probing.
+ *
+ * Often power supply is registered from driver's probe function. However
+ * calling power_supply_changed() directly from power_supply_register()
+ * would lead to execution of get_property() function provided by the driver
+ * too early - before the probe ends.
+ *
+ * Avoid that by waiting on parent's mutex.
+ */
+static void power_supply_deferred_register_work(struct work_struct *work)
+{
+	struct power_supply *psy = container_of(work, struct power_supply,
+						deferred_register_work);
+
+	if (psy->dev.parent)
+		mutex_lock(&psy->dev.parent->mutex);
+
+	power_supply_changed(psy);
+
+	if (psy->dev.parent)
+		mutex_unlock(&psy->dev.parent->mutex);
+}
+
 #ifdef CONFIG_OF
 #include <linux/of.h>
 
@@ -645,6 +671,8 @@ __power_supply_register(struct device *parent,
 	struct power_supply *psy;
 	int rc;
 
+	WARN(!parent, "Expected proper parent device\n");
+
 	psy = kzalloc(sizeof(*psy), GFP_KERNEL);
 	if (!psy)
 		return ERR_PTR(-ENOMEM);
@@ -671,6 +699,8 @@ __power_supply_register(struct device *parent,
 		goto dev_set_name_failed;
 
 	INIT_WORK(&psy->changed_work, power_supply_changed_work);
+	INIT_DELAYED_WORK(&psy->deferred_register_work,
+			  power_supply_deferred_register_work);
 
 	rc = power_supply_check_supplies(psy);
 	if (rc) {
@@ -709,7 +739,10 @@ __power_supply_register(struct device *parent,
 	 *    after calling power_supply_register()).
 	 */
 	atomic_inc(&psy->use_cnt);
-	power_supply_changed(psy);
+
+	queue_delayed_work(system_power_efficient_wq,
+			   &psy->deferred_register_work,
+			   POWER_SUPPLY_DEFERRED_REGISTER_TIME);
 
 	return psy;
 
@@ -729,7 +762,8 @@ dev_set_name_failed:
 
 /**
  * power_supply_register() - Register new power supply
- * @parent:	Device to be a parent of power supply's device
+ * @parent:	Device to be a parent of power supply's device, usually
+ *		the device which probe function calls this
  * @desc:	Description of power supply, must be valid through whole
  *		lifetime of this power supply
  * @cfg:	Run-time specific configuration accessed during registering,
@@ -750,7 +784,8 @@ EXPORT_SYMBOL_GPL(power_supply_register);
 
 /**
  * power_supply_register() - Register new non-waking-source power supply
- * @parent:	Device to be a parent of power supply's device
+ * @parent:	Device to be a parent of power supply's device, usually
+ *		the device which probe function calls this
  * @desc:	Description of power supply, must be valid through whole
  *		lifetime of this power supply
  * @cfg:	Run-time specific configuration accessed during registering,
@@ -779,7 +814,8 @@ static void devm_power_supply_release(struct device *dev, void *res)
 
 /**
  * power_supply_register() - Register managed power supply
- * @parent:	Device to be a parent of power supply's device
+ * @parent:	Device to be a parent of power supply's device, usually
+ *		the device which probe function calls this
  * @desc:	Description of power supply, must be valid through whole
  *		lifetime of this power supply
  * @cfg:	Run-time specific configuration accessed during registering,
@@ -814,7 +850,8 @@ EXPORT_SYMBOL_GPL(devm_power_supply_register);
 
 /**
  * power_supply_register() - Register managed non-waking-source power supply
- * @parent:	Device to be a parent of power supply's device
+ * @parent:	Device to be a parent of power supply's device, usually
+ *		the device which probe function calls this
  * @desc:	Description of power supply, must be valid through whole
  *		lifetime of this power supply
  * @cfg:	Run-time specific configuration accessed during registering,
@@ -858,6 +895,7 @@ void power_supply_unregister(struct power_supply *psy)
 {
 	WARN_ON(atomic_dec_return(&psy->use_cnt));
 	cancel_work_sync(&psy->changed_work);
+	cancel_delayed_work_sync(&psy->deferred_register_work);
 	sysfs_remove_link(&psy->dev.kobj, "powers");
 	power_supply_remove_triggers(psy);
 	psy_unregister_cooler(psy);
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 75a1dd8dc56e..a80f1fd01ddb 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -237,6 +237,7 @@ struct power_supply {
 	/* private */
 	struct device dev;
 	struct work_struct changed_work;
+	struct delayed_work deferred_register_work;
 	spinlock_t changed_lock;
 	bool changed;
 	atomic_t use_cnt;
-- 
1.9.1

