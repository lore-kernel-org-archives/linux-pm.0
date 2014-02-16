From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/3][Resend] PM / runtime: Routine for checking device status during system suspend
Date: Mon, 17 Feb 2014 00:51:32 +0100
Message-ID: <2606690.DpdlurHHNW@vostro.rjw.lan>
References: <5420830.W4laSGaAU9@vostro.rjw.lan> <1829141.MEZji1aIKp@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49658 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752620AbaBPXii (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 16 Feb 2014 18:38:38 -0500
In-Reply-To: <1829141.MEZji1aIKp@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Mika Westerberg <mika.westerberg@linux.intel.com>, Aaron Lu <aaron.lu@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a new helper routine, pm_runtime_enabled_and_suspended(), to
allow subsystems (or PM domains) to check the runtime PM status of
devices during system suspend (possibly to avoid resuming those
devices upfront at that time).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/runtime.c |   28 ++++++++++++++++++++++++++++
 include/linux/pm_runtime.h   |    2 ++
 2 files changed, 30 insertions(+)

Index: linux-pm/include/linux/pm_runtime.h
===================================================================
--- linux-pm.orig/include/linux/pm_runtime.h
+++ linux-pm/include/linux/pm_runtime.h
@@ -53,6 +53,7 @@ extern unsigned long pm_runtime_autosusp
 extern void pm_runtime_update_max_time_suspended(struct device *dev,
 						 s64 delta_ns);
 extern void pm_runtime_set_memalloc_noio(struct device *dev, bool enable);
+extern bool pm_runtime_enabled_and_suspended(struct device *dev);
 
 static inline bool pm_children_suspended(struct device *dev)
 {
@@ -161,6 +162,7 @@ static inline unsigned long pm_runtime_a
 				struct device *dev) { return 0; }
 static inline void pm_runtime_set_memalloc_noio(struct device *dev,
 						bool enable){}
+static inline bool pm_runtime_enabled_and_suspended(struct device *dev) { return false; }
 
 #endif /* !CONFIG_PM_RUNTIME */
 
Index: linux-pm/drivers/base/power/runtime.c
===================================================================
--- linux-pm.orig/drivers/base/power/runtime.c
+++ linux-pm/drivers/base/power/runtime.c
@@ -1194,6 +1194,34 @@ void pm_runtime_enable(struct device *de
 EXPORT_SYMBOL_GPL(pm_runtime_enable);
 
 /**
+ * pm_runtime_enabled_and_suspended - Check runtime PM status of a device.
+ * @dev: Device to handle.
+ *
+ * This routine is to be executed during system suspend only, after
+ * device_prepare() has been executed for @dev.
+ *
+ * Return false if runtime PM is disabled for the device.  Otherwise, wait
+ * for pending transitions to complete and check the runtime PM status of the
+ * device after that.  Return true if it is RPM_SUSPENDED.
+ */
+bool pm_runtime_enabled_and_suspended(struct device *dev)
+{
+	unsigned long flags;
+	bool ret;
+
+	spin_lock_irqsave(&dev->power.lock, flags);
+	if (dev->power.disable_depth) {
+		ret = false;
+	} else {
+		__pm_runtime_barrier(dev);
+		ret = pm_runtime_status_suspended(dev);
+	}
+	spin_unlock_irqrestore(&dev->power.lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pm_runtime_enabled_and_suspended);
+
+/**
  * pm_runtime_forbid - Block runtime PM of a device.
  * @dev: Device to handle.
  *

