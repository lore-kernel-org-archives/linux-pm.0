From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v3] PM / sleep: prohibit devices probing during suspend/hibernation
Date: Tue, 10 Nov 2015 11:42:34 +0200
Message-ID: <1447148554-18401-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-pm@vger.kernel.org

It is unsafe [1] if probing of devices will happen during suspend or
hibernation and system behavior will be unpredictable in this case.
So, let's prohibit device's probing in dpm_prepare() and defer their
probing instead. The normal behavior will be restored in
dpm_complete().

This patch introduces new DD core APIs:
 device_block_probing()
   It will disable probing of devices and defer their probes instead.
 device_unblock_probing()
   It will restore normal behavior and trigger re-probing of deferred
   devices.

[1] https://lkml.org/lkml/2015/9/11/554
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
Changes in v3:
- rename device_defer_all_probes_enable/disable() to 
  device_block/unblock_probing()

Changes in v2:
- DD core API device_defer_all_probes(bool enable) split on two
  void device_defer_all_probes_enable(void);
  void device_defer_all_probes_disable(void);
- more comments added

Link on v2:
 https://lkml.org/lkml/2015/10/19/783
Link on v1:
 https://lkml.org/lkml/2015/10/8/681

 drivers/base/base.h       |  2 ++
 drivers/base/dd.c         | 48 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/base/power/main.c | 17 +++++++++++++++++
 3 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 1782f3a..e05db38 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -131,6 +131,8 @@ extern void device_remove_groups(struct device *dev,
 extern char *make_class_name(const char *name, struct kobject *kobj);
 
 extern int devres_release_all(struct device *dev);
+extern void device_block_probing(void);
+extern void device_unblock_probing(void);
 
 /* /sys/devices directory */
 extern struct kset *devices_kset;
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 318ec9d..b827a4a 100644
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
@@ -193,6 +200,30 @@ static void driver_deferred_probe_trigger(void)
 }
 
 /**
+ * device_block_probing() - Block/defere device's probes
+ *
+ *	It will disable probing of devices and defer their probes instead.
+ */
+void device_block_probing(void)
+{
+	defer_all_probes = true;
+	/* sync with probes to avoid races. */
+	wait_for_device_probe();
+}
+
+/**
+ * device_unblock_probing() - Unblock/enable device's probes
+ *
+ *	It will restore normal behavior and trigger re-probing of deferred
+ * devices.
+ */
+void device_unblock_probing(void)
+{
+	defer_all_probes = false;
+	driver_deferred_probe_trigger();
+}
+
+/**
  * deferred_probe_initcall() - Enable probing of deferred devices
  *
  * We don't want to get in the way when the bulk of drivers are getting probed.
@@ -307,9 +338,20 @@ static DECLARE_WAIT_QUEUE_HEAD(probe_waitqueue);
 
 static int really_probe(struct device *dev, struct device_driver *drv)
 {
-	int ret = 0;
+	int ret = -EPROBE_DEFER;
 	int local_trigger_count = atomic_read(&deferred_trigger_count);
 
+	if (defer_all_probes) {
+		/*
+		 * Value of defer_all_probes can be set only by
+		 * device_defer_all_probes_enable() which, in turn, will call
+		 * wait_for_device_probe() right after that to avoid any races.
+		 */
+		dev_dbg(dev, "Driver %s force probe deferral\n", drv->name);
+		driver_deferred_probe_add(dev);
+		return ret;
+	}
+
 	atomic_inc(&probe_count);
 	pr_debug("bus: '%s': %s: probing driver %s with device %s\n",
 		 drv->bus->name, __func__, drv->name, dev_name(dev));
@@ -424,6 +466,10 @@ int driver_probe_done(void)
  */
 void wait_for_device_probe(void)
 {
+	/* wait for the deferred probe workqueue to finish */
+	if (driver_deferred_probe_enable)
+		flush_workqueue(deferred_wq);
+
 	/* wait for the known devices to complete their probing */
 	wait_event(probe_waitqueue, atomic_read(&probe_count) == 0);
 	async_synchronize_full();
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 1710c26..9d626ac 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -963,6 +963,9 @@ void dpm_complete(pm_message_t state)
 	}
 	list_splice(&list, &dpm_list);
 	mutex_unlock(&dpm_list_mtx);
+
+	/* Allow device probing and trigger re-probing of deferred devices */
+	device_unblock_probing();
 	trace_suspend_resume(TPS("dpm_complete"), state.event, false);
 }
 
@@ -1624,6 +1627,20 @@ int dpm_prepare(pm_message_t state)
 	trace_suspend_resume(TPS("dpm_prepare"), state.event, true);
 	might_sleep();
 
+	/*
+	 * Give a chance for the known devices to complete their probes, before
+	 * disable probing of devices. This sync point is important at least
+	 * at boot time + hibernation restore.
+	 */
+	wait_for_device_probe();
+	/*
+	 * It is unsafe if probing of devices will happen during suspend or
+	 * hibernation and system behavior will be unpredictable in this case.
+	 * So, let's prohibit device's probing here and defer their probes
+	 * instead. The normal behavior will be restored in dpm_complete().
+	 */
+	device_block_probing();
+
 	mutex_lock(&dpm_list_mtx);
 	while (!list_empty(&dpm_list)) {
 		struct device *dev = to_device(dpm_list.next);
-- 
2.6.2
