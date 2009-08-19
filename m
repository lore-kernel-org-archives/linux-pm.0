From: Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH 2/5] introduce default operation for wakeup event
Date: Wed, 19 Aug 2009 15:24:14 +0800
Message-ID: <1250666654.23178.117.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, mjg59 <mjg59@srcf.ucam.org>
List-Id: linux-pm@vger.kernel.org


The default action to handle wakeup event. Currently just prints something.
Later we should add real operations like calling pm_runtime_resume().
The routine will be called in task context.

---
 drivers/base/power/main.c |    6 ++++++
 include/linux/pm.h        |    2 ++
 2 files changed, 8 insertions(+)

Index: linux/drivers/base/power/main.c
===================================================================
--- linux.orig/drivers/base/power/main.c	2009-08-19 13:44:03.000000000 +0800
+++ linux/drivers/base/power/main.c	2009-08-19 13:48:27.000000000 +0800
@@ -825,3 +825,9 @@ void __suspend_report_result(const char 
 		printk(KERN_ERR "%s(): %pF returns %d\n", function, fn, ret);
 }
 EXPORT_SYMBOL_GPL(__suspend_report_result);
+
+void device_receive_wakeup_event(struct device *dev)
+{
+	pr_debug("Device %s invokes wakeup event\n", dev_name(dev));
+}
+EXPORT_SYMBOL(device_receive_wakeup_event);
Index: linux/include/linux/pm.h
===================================================================
--- linux.orig/include/linux/pm.h	2009-08-19 13:44:03.000000000 +0800
+++ linux/include/linux/pm.h	2009-08-19 13:48:27.000000000 +0800
@@ -437,6 +437,8 @@ struct dev_pm_info {
 /* Necessary, because several drivers use PM_EVENT_PRETHAW */
 #define PM_EVENT_PRETHAW PM_EVENT_QUIESCE
 
+void device_receive_wakeup_event(struct device *dev);
+
 /*
  * One transition is triggered by resume(), after a suspend() call; the
  * message is implicit:


