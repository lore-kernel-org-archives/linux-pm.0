From: Rhyland Klein <rklein@nvidia.com>
Subject: [PATCH v3] power_supply: fix return value of get_property
Date: Wed, 22 Jun 2016 11:45:52 -0400
Message-ID: <1466610352-28926-1-git-send-email-rklein@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17373 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932185AbcFVQIh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jun 2016 12:08:37 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Rhyland Klein <rklein@nvidia.com>

power_supply_get_property() should ideally return -EAGAIN if it is
called while the power_supply is being registered. There was no way
previously to determine if use_cnt == 0 meant that the power_supply
wasn't fully registered yet, or if it had already been unregistered.

Add a new boolean to the power_supply struct to simply show if
registration is completed. Lastly, modify the check in
power_supply_show_property() to also ignore -EAGAIN when so it
doesn't complain about not returning the property.

Signed-off-by: Rhyland Klein <rklein@nvidia.com>
---
v3:
 - Moved psy->initialized after atomic increment of use_cnt

v2:
 - Modify power_supply_show_property() to not complain if it
   sees a return value of -EAGAIN after calling
   power_supply_get_property().

 drivers/power/power_supply_core.c  | 6 +++++-
 drivers/power/power_supply_sysfs.c | 2 +-
 include/linux/power_supply.h       | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
index b13cd074c52a..a74d8ca383a1 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -491,8 +491,11 @@ int power_supply_get_property(struct power_supply *psy,
 			    enum power_supply_property psp,
 			    union power_supply_propval *val)
 {
-	if (atomic_read(&psy->use_cnt) <= 0)
+	if (atomic_read(&psy->use_cnt) <= 0) {
+		if (!psy->initialized)
+			return -EAGAIN;
 		return -ENODEV;
+	}
 
 	return psy->desc->get_property(psy, psp, val);
 }
@@ -785,6 +788,7 @@ __power_supply_register(struct device *parent,
 	 *    after calling power_supply_register()).
 	 */
 	atomic_inc(&psy->use_cnt);
+	psy->initialized = true;
 
 	queue_delayed_work(system_power_efficient_wq,
 			   &psy->deferred_register_work,
diff --git a/drivers/power/power_supply_sysfs.c b/drivers/power/power_supply_sysfs.c
index 80fed98832f9..bcde8d13476a 100644
--- a/drivers/power/power_supply_sysfs.c
+++ b/drivers/power/power_supply_sysfs.c
@@ -83,7 +83,7 @@ static ssize_t power_supply_show_property(struct device *dev,
 			if (ret == -ENODATA)
 				dev_dbg(dev, "driver has no data for `%s' property\n",
 					attr->attr.name);
-			else if (ret != -ENODEV)
+			else if (ret != -ENODEV && ret != -EAGAIN)
 				dev_err(dev, "driver failed to report `%s' property: %zd\n",
 					attr->attr.name, ret);
 			return ret;
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 751061790626..3965503315ef 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -248,6 +248,7 @@ struct power_supply {
 	struct delayed_work deferred_register_work;
 	spinlock_t changed_lock;
 	bool changed;
+	bool initialized;
 	atomic_t use_cnt;
 #ifdef CONFIG_THERMAL
 	struct thermal_zone_device *tzd;
-- 
1.9.1

