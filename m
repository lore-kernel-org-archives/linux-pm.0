From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PM / sleep: Add support for read-only sysfs attributes
Date: Sat, 02 Jan 2016 03:09:16 +0100
Message-ID: <4744819.Itnh720Sq0@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56055 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751354AbcABBim (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Jan 2016 20:38:42 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Some sysfs attributes in /sys/power/ should really be read-only,
so add support for that, convert those attributes to read-only
and drop the stub .show() routines from them.

Original-by: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/main.c  |   17 ++---------------
 kernel/power/power.h |    9 +++++++++
 2 files changed, 11 insertions(+), 15 deletions(-)

Index: linux-pm/kernel/power/power.h
===================================================================
--- linux-pm.orig/kernel/power/power.h
+++ linux-pm/kernel/power/power.h
@@ -77,6 +77,15 @@ static struct kobj_attribute _name##_att
 	.store	= _name##_store,		\
 }
 
+#define power_attr_ro(_name) \
+static struct kobj_attribute _name##_attr = {	\
+	.attr	= {				\
+		.name = __stringify(_name),	\
+		.mode = S_IRUGO,		\
+	},					\
+	.show	= _name##_show,			\
+}
+
 /* Preferred image size in bytes (default 500 MB) */
 extern unsigned long image_size;
 /* Size of memory reserved for drivers (default SPARE_PAGES x PAGE_SIZE) */
Index: linux-pm/kernel/power/main.c
===================================================================
--- linux-pm.orig/kernel/power/main.c
+++ linux-pm/kernel/power/main.c
@@ -280,13 +280,7 @@ static ssize_t pm_wakeup_irq_show(struct
 	return pm_wakeup_irq ? sprintf(buf, "%u\n", pm_wakeup_irq) : -ENODATA;
 }
 
-static ssize_t pm_wakeup_irq_store(struct kobject *kobj,
-					struct kobj_attribute *attr,
-					const char *buf, size_t n)
-{
-	return -EINVAL;
-}
-power_attr(pm_wakeup_irq);
+power_attr_ro(pm_wakeup_irq);
 
 #else /* !CONFIG_PM_SLEEP_DEBUG */
 static inline void pm_print_times_init(void) {}
@@ -564,14 +558,7 @@ static ssize_t pm_trace_dev_match_show(s
 	return show_trace_dev_match(buf, PAGE_SIZE);
 }
 
-static ssize_t
-pm_trace_dev_match_store(struct kobject *kobj, struct kobj_attribute *attr,
-			 const char *buf, size_t n)
-{
-	return -EINVAL;
-}
-
-power_attr(pm_trace_dev_match);
+power_attr_ro(pm_trace_dev_match);
 
 #endif /* CONFIG_PM_TRACE */
 

