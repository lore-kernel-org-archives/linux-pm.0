From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 3/4] Power_supply: allow power supply devices registered w/o wakeup source
Date: Wed, 28 May 2014 15:23:37 +0800
Message-ID: <1401261818-2978-4-git-send-email-rui.zhang@intel.com>
References: <1401261818-2978-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:40127 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006AbaE1HXs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 28 May 2014 03:23:48 -0400
In-Reply-To: <1401261818-2978-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rafael.j.wysocki@intel.com, anton@enomsg.org, Zhang Rui <rui.zhang@intel.com>

Currently, all the power supply devices are registered with wakeup source,
this results in that every power_supply_changed() invocation brings
the system out of suspend-to-freeze state.

This is overkill as some device drivers, e.g. ACPI battery driver,
have the ability to check the device status and wake up the system
from sleeping only when necessary.

Thus introduce a new API which allows device to be registered
w/o wakeup source.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/power/power_supply_core.c | 15 +++++++++++++--
 include/linux/power_supply.h      |  2 ++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
index 2660664..5a5a24e 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -537,7 +537,7 @@ static void psy_unregister_cooler(struct power_supply *psy)
 }
 #endif
 
-int power_supply_register(struct device *parent, struct power_supply *psy)
+int __power_supply_register(struct device *parent, struct power_supply *psy, bool ws)
 {
 	struct device *dev;
 	int rc;
@@ -568,7 +568,7 @@ int power_supply_register(struct device *parent, struct power_supply *psy)
 	}
 
 	spin_lock_init(&psy->changed_lock);
-	rc = device_init_wakeup(dev, true);
+	rc = device_init_wakeup(dev, ws);
 	if (rc)
 		goto wakeup_init_failed;
 
@@ -606,8 +606,19 @@ int power_supply_register(struct device *parent, struct power_supply *psy)
 success:
 	return rc;
 }
+
+int power_supply_register(struct device *parent, struct power_supply *psy)
+{
+	return __power_supply_register(parent, psy, true);
+}
 EXPORT_SYMBOL_GPL(power_supply_register);
 
+int power_supply_register_no_ws(struct device *parent, struct power_supply *psy)
+{
+	return __power_supply_register(parent, psy, false);
+}
+EXPORT_SYMBOL_GPL(power_supply_register_no_ws);
+
 void power_supply_unregister(struct power_supply *psy)
 {
 	cancel_work_sync(&psy->changed_work);
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index c9dc4e0..f2b76ae 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -264,6 +264,8 @@ static inline int power_supply_is_system_supplied(void) { return -ENOSYS; }
 
 extern int power_supply_register(struct device *parent,
 				 struct power_supply *psy);
+extern int power_supply_register_no_ws(struct device *parent,
+				 struct power_supply *psy);
 extern void power_supply_unregister(struct power_supply *psy);
 extern int power_supply_powers(struct power_supply *psy, struct device *dev);
 
-- 
1.8.3.2

