From: Marcelo Tosatti <marcelo@kvack.org>
Subject: parallel suspend/resume
Date: Mon, 8 Oct 2007 15:46:39 -0400
Message-ID: <20071008194639.GA5301@dmt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

I spent some time working with the parallel suspend/resume idea, even
wrote a simple patch (attached), but that obviously does not scale to
large number of devices.

What would be a better approach? 

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 05dc876..45f5851 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -62,6 +62,8 @@ int device_pm_add(struct device * dev)
 	down(&dpm_list_sem);
 	list_add_tail(&dev->power.entry, &dpm_active);
 	device_pm_set_parent(dev, dev->parent);
+	init_waitqueue_head(&dev->power.powered_on);
+	INIT_LIST_HEAD(&dev->power.entry_sus);
 	if ((error = dpm_sysfs_add(dev)))
 		list_del(&dev->power.entry);
 	up(&dpm_list_sem);
diff --git a/drivers/base/power/resume.c b/drivers/base/power/resume.c
index a2c6418..a3de7d6 100644
--- a/drivers/base/power/resume.c
+++ b/drivers/base/power/resume.c
@@ -9,10 +9,13 @@
  */
 
 #include <linux/device.h>
+#include <linux/sched.h>
+#include <linux/kthread.h>
 #include <linux/resume-trace.h>
 #include "../base.h"
 #include "power.h"
 
+LIST_HEAD(suspend_threads);
 
 /**
  *	resume_device - Restore state for one device.
@@ -40,24 +43,61 @@ int resume_device(struct device * dev)
 	if (dev->bus && dev->bus->resume) {
 		dev_dbg(dev,"resuming\n");
 		error = dev->bus->resume(dev);
+		dev_dbg(dev,"finish\n");
 	}
 
 	if (!error && dev->type && dev->type->resume) {
 		dev_dbg(dev,"resuming\n");
 		error = dev->type->resume(dev);
+		dev_dbg(dev,"finish\n");
 	}
 
 	if (!error && dev->class && dev->class->resume) {
 		dev_dbg(dev,"class resume\n");
 		error = dev->class->resume(dev);
+		dev_dbg(dev,"finish\n");
 	}
 
+	dev->power.power_state = PMSG_ON;
+
 	up(&dev->sem);
 
 	TRACE_RESUME(error);
+
 	return error;
 }
 
+static int resume_device_work(void *data)
+{
+	int error;
+	struct device *dev = (struct device *)data;
+
+	if (dev->power.pm_parent
+			&& dev->power.pm_parent->power.power_state.event) {
+		dev_err(dev, "PM: resume from %d, parent %s still %d\n",
+			dev->power.power_state.event,
+			dev->power.pm_parent->bus_id,
+			dev->power.pm_parent->power.power_state.event);
+		wait_event_interruptible(dev->power.pm_parent->power.powered_on,
+					!dev->power.pm_parent->power.power_state.event);
+	}
+
+	error = resume_device(dev);
+	if (!error) 
+		wake_up_all(&dev->power.powered_on);
+
+	put_device(dev);
+	return error;
+}
+
+int span_resume_thread(struct device *dev)
+{
+	dev->power.resume_thread = kthread_run(resume_device_work, dev,
+				"resume-%s", dev_driver_string(dev));
+	list_add(&dev->power.entry_sus, &suspend_threads);
+	return 0;
+}
+
 
 static int resume_device_early(struct device * dev)
 {
@@ -80,6 +120,8 @@ static int resume_device_early(struct de
  */
 void dpm_resume(void)
 {
+	struct dev_pm_info *dev;
+
 	down(&dpm_list_sem);
 	while(!list_empty(&dpm_off)) {
 		struct list_head * entry = dpm_off.next;
@@ -90,11 +132,15 @@ void dpm_resume(void)
 
 		up(&dpm_list_sem);
 		if (!dev->power.prev_state.event)
-			resume_device(dev);
+			span_resume_thread(dev);
 		down(&dpm_list_sem);
-		put_device(dev);
 	}
 	up(&dpm_list_sem);
+
+	list_for_each_entry(dev, &suspend_threads, entry_sus)
+		wait_event_interruptible(dev->powered_on,
+					!dev->power_state.event);
+	INIT_LIST_HEAD(&suspend_threads);
 }
 
 
diff --git a/drivers/base/power/suspend.c b/drivers/base/power/suspend.c
index 42d2b86..3f6e9b0 100644
--- a/drivers/base/power/suspend.c
+++ b/drivers/base/power/suspend.c
@@ -169,8 +169,10 @@ int device_suspend(pm_message_t state)
 		/* Check if the device got removed */
 		if (!list_empty(&dev->power.entry)) {
 			/* Move it to the dpm_off list */
-			if (!error)
+			if (!error) {
+				dev->power.power_state = PMSG_SUSPEND;
 				list_move(&dev->power.entry, &dpm_off);
+			}
 		}
 		if (error)
 			printk(KERN_ERR "Could not suspend device %s: "
diff --git a/include/linux/pm.h b/include/linux/pm.h
index b2c4fde..4bfa8da 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -24,6 +24,7 @@ #define _LINUX_PM_H
 #ifdef __KERNEL__
 
 #include <linux/list.h>
+#include <linux/wait.h>
 #include <asm/atomic.h>
 
 /*
@@ -271,6 +272,9 @@ #ifdef	CONFIG_PM
 	void			* saved_state;
 	struct device		* pm_parent;
 	struct list_head	entry;
+	struct task_struct 	* resume_thread;
+	wait_queue_head_t 	powered_on;
+	struct list_head entry_sus;
 #endif
 };
 
