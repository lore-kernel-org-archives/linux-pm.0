From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 2/2] PM / sleep: prohibit devices probing during suspend/hibernation
Date: Thu, 8 Oct 2015 11:57:07 -0500
Message-ID: <1444323427-6822-3-git-send-email-grygorii.strashko@ti.com>
References: <1444323427-6822-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57641 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964922AbbJHQ5T (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 8 Oct 2015 12:57:19 -0400
In-Reply-To: <1444323427-6822-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Thierry Reding <thierry.reding@gmail.com>

It is unsafe [1] if probing of devices will happen during suspend or
hibernation and system behavior will be unpredictable in this case.
So, lets prohibit device's probing in dpm_prepare() and defer their
probing instead. The normal behavior will be restored in
dpm_complete().

This patch introduces new DD core API device_defer_all_probes(bool enable)
to enable/disable probing of devices:
 if @enable = true
   It will disable probing of devices and defer their probes.
 otherwise
   It will restore normal behavior and trigger re-probing of deferred devices.

[1] https://lkml.org/lkml/2015/9/11/554
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/base/base.h       |  1 +
 drivers/base/dd.c         | 35 ++++++++++++++++++++++++++++++++++-
 drivers/base/power/main.c | 13 +++++++++++++
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 1782f3a..6c9684b 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -131,6 +131,7 @@ extern void device_remove_groups(struct device *dev,
 extern char *make_class_name(const char *name, struct kobject *kobj);
 
 extern int devres_release_all(struct device *dev);
+extern void device_defer_all_probes(bool enable);
 
 /* /sys/devices directory */
 extern struct kset *devices_kset;
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 98de1a5..d600c14 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -55,6 +55,13 @@ static struct workqueue_struct *deferred_wq;
 static atomic_t deferred_trigger_count = ATOMIC_INIT(0);
 
 /*
+ * In some cases, like suspend to RAM or hibernation, It might be reasonable
+ * to prohibit probing of devices as it could be unsafe.
+ * Once defer_all_probes is true all drivers probes will be forcibly deferred.
+ */
+static bool defer_all_probes;
+
+/*
  * deferred_probe_work_func() - Retry probing devices in the active list.
  */
 static void deferred_probe_work_func(struct work_struct *work)
@@ -172,6 +179,26 @@ static void driver_deferred_probe_trigger(void)
 }
 
 /**
+ * device_defer_all_probes() - Enable/disable probing of devices
+ * @enable:  Enable/disable probing of devices
+ *
+ * if @enable = true
+ *	It will disable probing of devices and defer their probes.
+ * otherwise
+ *	It will restore normal behavior and trigger re-probing of deferred
+ *	devices.
+ */
+void device_defer_all_probes(bool enable)
+{
+	defer_all_probes = enable;
+	if (enable)
+		/* sync with probes to avoid any races. */
+		wait_for_device_probe();
+	else
+		driver_deferred_probe_trigger();
+}
+
+/**
  * deferred_probe_initcall() - Enable probing of deferred devices
  *
  * We don't want to get in the way when the bulk of drivers are getting probed.
@@ -277,9 +304,15 @@ static DECLARE_WAIT_QUEUE_HEAD(probe_waitqueue);
 
 static int really_probe(struct device *dev, struct device_driver *drv)
 {
-	int ret = 0;
+	int ret = -EPROBE_DEFER;
 	int local_trigger_count = atomic_read(&deferred_trigger_count);
 
+	if (defer_all_probes) {
+		dev_dbg(dev, "Driver %s force probe deferral\n", drv->name);
+		driver_deferred_probe_add(dev);
+		return ret;
+	}
+
 	atomic_inc(&probe_count);
 	pr_debug("bus: '%s': %s: probing driver %s with device %s\n",
 		 drv->bus->name, __func__, drv->name, dev_name(dev));
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 1710c26..98c1da36 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -963,6 +963,9 @@ void dpm_complete(pm_message_t state)
 	}
 	list_splice(&list, &dpm_list);
 	mutex_unlock(&dpm_list_mtx);
+
+	/* Allow device probing and trigger re-probing of deferred devices */
+	device_defer_all_probes(false);
 	trace_suspend_resume(TPS("dpm_complete"), state.event, false);
 }
 
@@ -1624,6 +1627,16 @@ int dpm_prepare(pm_message_t state)
 	trace_suspend_resume(TPS("dpm_prepare"), state.event, true);
 	might_sleep();
 
+	/* Give a chance for the known devices to complete their probing. */
+	wait_for_device_probe();
+	/*
+	 * It is unsafe if probing of devices will happen during suspend or
+	 * hibernation and system behavior will be unpredictable in this case.
+	 * So, lets prohibit device's probing here and defer their probes
+	 * instead. The normal behavior will be restored in dpm_complete().
+	 */
+	device_defer_all_probes(true);
+
 	mutex_lock(&dpm_list_mtx);
 	while (!list_empty(&dpm_list)) {
 		struct device *dev = to_device(dpm_list.next);
-- 
2.5.1

