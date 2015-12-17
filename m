From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2] PM / runtime: Add new helper for conditional usage count incrementation
Date: Thu, 17 Dec 2015 02:54:26 +0100
Message-ID: <8499566.e3riUpjlOo@vostro.rjw.lan>
References: <1449675920-12986-1-git-send-email-joonas.lahtinen@linux.intel.com> <20151212194956.GA2407@nuc-i3427.alporthouse.com> <32970649.AWpGt5zezN@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:44923 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750754AbbLQBYQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Dec 2015 20:24:16 -0500
In-Reply-To: <32970649.AWpGt5zezN@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chris Wilson <chris@chris-wilson.co.uk>, Imre Deak <imre.deak@intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>, linux-pm@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Introduce a new runtime PM function, pm_runtime_get_if_in_use(),
that will increment the device's runtime PM usage counter and
return 'true' if its status is RPM_ACTIVE and its usage counter
is greater than 0 at the same time ('false' will be returned
otherwise).

This is useful for things that should only be done if the device
is active (from the runtime PM perspective) and used by somebody
(as indicated by the usage counter) already and they are not worth
bothering otherwise.

Requested-by: Imre Deak <imre.deak@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Changes from v1:
- kerneldoc and runtime PM doc changes as suggested by Alan.
- The new function returns an int now and -EINVAL is returned for devices
  with runtime PM disabled.

---
 Documentation/power/runtime_pm.txt |    6 ++++++
 drivers/base/power/runtime.c       |   24 ++++++++++++++++++++++++
 include/linux/pm_runtime.h         |    5 +++++
 3 files changed, 35 insertions(+)

Index: linux-pm/drivers/base/power/runtime.c
===================================================================
--- linux-pm.orig/drivers/base/power/runtime.c
+++ linux-pm/drivers/base/power/runtime.c
@@ -966,6 +966,30 @@ int __pm_runtime_resume(struct device *d
 EXPORT_SYMBOL_GPL(__pm_runtime_resume);
 
 /**
+ * pm_runtime_get_if_in_use - Conditionally bump up the device's usage counter.
+ * @dev: Device to handle.
+ *
+ * Return -EINVAL if runtime PM is disabled for the device.
+ *
+ * If that's not the case and if the device's runtime PM status is RPM_ACTIVE
+ * and the runtime PM usage counter is nonzero, increment the counter and
+ * return 1.  Otherwise return 0 without changing the counter.
+ */
+int pm_runtime_get_if_in_use(struct device *dev)
+{
+	unsigned long flags;
+	int retval;
+
+	spin_lock_irqsave(&dev->power.lock, flags);
+	retval = dev->power.disable_depth > 0 ? -EINVAL :
+		dev->power.runtime_status == RPM_ACTIVE
+			&& atomic_inc_not_zero(&dev->power.usage_count);
+	spin_unlock_irqrestore(&dev->power.lock, flags);
+	return retval;
+}
+EXPORT_SYMBOL_GPL(pm_runtime_get_if_in_use);
+
+/**
  * __pm_runtime_set_status - Set runtime PM status of a device.
  * @dev: Device to handle.
  * @status: New runtime PM status of the device.
Index: linux-pm/include/linux/pm_runtime.h
===================================================================
--- linux-pm.orig/include/linux/pm_runtime.h
+++ linux-pm/include/linux/pm_runtime.h
@@ -39,6 +39,7 @@ extern int pm_runtime_force_resume(struc
 extern int __pm_runtime_idle(struct device *dev, int rpmflags);
 extern int __pm_runtime_suspend(struct device *dev, int rpmflags);
 extern int __pm_runtime_resume(struct device *dev, int rpmflags);
+extern int pm_runtime_get_if_in_use(struct device *dev);
 extern int pm_schedule_suspend(struct device *dev, unsigned int delay);
 extern int __pm_runtime_set_status(struct device *dev, unsigned int status);
 extern int pm_runtime_barrier(struct device *dev);
@@ -143,6 +144,10 @@ static inline int pm_schedule_suspend(st
 {
 	return -ENOSYS;
 }
+static inline int pm_runtime_get_if_in_use(struct device *dev)
+{
+	return -EINVAL;
+}
 static inline int __pm_runtime_set_status(struct device *dev,
 					    unsigned int status) { return 0; }
 static inline int pm_runtime_barrier(struct device *dev) { return 0; }
Index: linux-pm/Documentation/power/runtime_pm.txt
===================================================================
--- linux-pm.orig/Documentation/power/runtime_pm.txt
+++ linux-pm/Documentation/power/runtime_pm.txt
@@ -371,6 +371,12 @@ drivers/base/power/runtime.c and include
     - increment the device's usage counter, run pm_runtime_resume(dev) and
       return its result
 
+  int pm_runtime_get_if_in_use(struct device *dev);
+    - return -EINVAL if 'power.disable_depth' is nonzero; otherwise, if the
+      runtime PM status is RPM_ACTIVE and the runtime PM usage counter is
+      nonzero, increment the counter and return 1; otherwise return 0 without
+      changing the counter
+
   void pm_runtime_put_noidle(struct device *dev);
     - decrement the device's usage counter
 

