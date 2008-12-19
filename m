From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH 1/3] PM: introduce device parallel resume
	mechanism
Date: Fri, 19 Dec 2008 14:34:10 +0800
Message-ID: <1229668452.562.90.camel__4845.7465404228$1229668862$gmane$org@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pci@vger.kernel.org
Cc: "Barnes, Jesse" <jesse.barnes@intel.com>
List-Id: linux-pm@vger.kernel.org


Introduce a new mechanism for device resume in parallel.

with this patch applied, some device can have its own workqueue.
the resume method of the devices that depend on this device are all
executed in this workqueue.

For some kinds of devices like PCI device,
it's necessary to do a sync before resuming userspace
because other applications may depends on this hardware,
while for other devices it's not necessary to do so, like the ACPI battery devices.

this mechanism will reduce the device resume time a lot.
e.g. about 0.5s on a eeepc901, and more than 1 second on another test box.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/base/power/main.c |  145 +++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/device.h    |    2 
 include/linux/pm.h        |   12 +++
 3 files changed, 155 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/base/power/main.c
===================================================================
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -23,6 +23,8 @@
 #include <linux/pm.h>
 #include <linux/resume-trace.h>
 #include <linux/rwsem.h>
+#include <linux/workqueue.h>
+#include <linux/list.h>
 
 #include "../base.h"
 #include "power.h"
@@ -391,6 +393,65 @@ static int resume_device(struct device *
 	return error;
 }
 
+static LIST_HEAD(device_parallel_resume_list);
+
+struct device_parallel_resume_struct {
+	struct device *dev;
+	struct workqueue_struct *wq;
+	bool sync;	/* sync before resuming userspace or not */
+	struct list_head node;
+};
+
+struct parallel_resume_struct {
+	struct work_struct work;
+	struct device *dev;
+	pm_message_t state;
+};
+
+static void resume_device_parallel_func(struct work_struct *work)
+{
+	int error;
+	struct parallel_resume_struct *aresume_work =
+		container_of(work, struct parallel_resume_struct, work);
+
+	if (!aresume_work) {
+		printk(KERN_ERR "Invalid (NULL) context\n");
+		return;
+	}
+
+	error = resume_device(aresume_work->dev, aresume_work->state);
+	if (error)
+		pm_dev_err(aresume_work->dev, aresume_work->state, "", error);
+
+	kfree(aresume_work);
+}
+
+/**
+ *	resume_device_parallel - parallel execution of resume_device.
+ *	@dev:	Device.
+ *	@state: PM transition of the system being carried out.
+ */
+static int resume_device_parallel(struct device *dev, pm_message_t state)
+{
+	struct parallel_resume_struct *aresume_work;
+
+	if (!dev->resumed)
+		return -EINVAL;
+
+	aresume_work = kzalloc(sizeof(struct parallel_resume_struct),
+				GFP_KERNEL);
+	if (!aresume_work)
+		return -ENOMEM;
+
+	aresume_work->dev = dev;
+	aresume_work->state = state;
+	INIT_WORK(&aresume_work->work, resume_device_parallel_func);
+
+	return !queue_work(dev->resumed, &aresume_work->work);
+}
+
+int is_device_resume_in_parallel(struct device *dev);
+
 /**
  *	dpm_resume - Resume every device.
  *	@state: PM transition of the system being carried out.
@@ -401,6 +462,7 @@ static int resume_device(struct device *
 static void dpm_resume(pm_message_t state)
 {
 	struct list_head list;
+	struct device_parallel_resume_struct *pos;
 
 	INIT_LIST_HEAD(&list);
 	mutex_lock(&dpm_list_mtx);
@@ -414,9 +476,10 @@ static void dpm_resume(pm_message_t stat
 
 			dev->power.status = DPM_RESUMING;
 			mutex_unlock(&dpm_list_mtx);
-
-			error = resume_device(dev, state);
-
+			if (is_device_resume_in_parallel(dev))
+				error = resume_device_parallel(dev, state);
+			else
+				error = resume_device(dev, state);
 			mutex_lock(&dpm_list_mtx);
 			if (error)
 				pm_dev_err(dev, state, "", error);
@@ -430,6 +493,11 @@ static void dpm_resume(pm_message_t stat
 	}
 	list_splice(&list, &dpm_list);
 	mutex_unlock(&dpm_list_mtx);
+
+	/* flush device parallel resume wq before resuming applications */
+	list_for_each_entry(pos, &device_parallel_resume_list, node)
+		if (pos->sync)
+			flush_workqueue(pos->wq);
 }
 
 /**
@@ -507,6 +575,77 @@ void device_resume(pm_message_t state)
 }
 EXPORT_SYMBOL_GPL(device_resume);
 
+int is_device_resume_in_parallel(struct device *dev)
+{
+	struct workqueue_struct *wq = NULL;
+
+	if (dev->parent)
+		wq = dev->parent->resumed;
+
+	if (dev->parallel_resume) {
+		if (wq) {
+			/* inherit parent's wq */
+			device_parallel_resume_unregister(dev);
+			dev->resumed = wq;
+		}
+	} else {
+		if (!wq) {
+			dev->resumed = NULL;
+			return 0;
+		}
+		dev->resumed = wq;
+	}
+	return 1;
+}
+
+int device_parallel_resume_register(struct device *dev, bool sync)
+{
+	struct device_parallel_resume_struct *pos;
+
+	if (!dev)
+		return -EINVAL;
+
+	if (dev->resumed || dev->parallel_resume) {
+		printk(KERN_ERR "resumed already created\n");
+		return -EEXIST;
+	}
+	pos = kzalloc(sizeof(struct device_parallel_resume_struct),
+			GFP_KERNEL);
+	if (!pos)
+		return -ENOMEM;
+
+	dev->resumed = create_singlethread_workqueue(dev->bus_id);
+	if (!dev->resumed) {
+		kfree(pos);
+		return -ESRCH;
+	}
+	dev->parallel_resume = 1;
+	pos->wq = dev->resumed;
+	pos->dev = dev;
+	pos->sync = sync;
+	list_add_tail(&pos->node, &device_parallel_resume_list);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(device_parallel_resume_register);
+
+void device_parallel_resume_unregister(struct device *dev)
+{
+	struct device_parallel_resume_struct *pos, *next;
+
+	if (!dev->parallel_resume)
+		return;
+
+	destroy_workqueue(dev->resumed);
+	list_for_each_entry_safe(pos, next, &device_parallel_resume_list, node)
+		if ((pos->dev == dev) && (dev->resumed == pos->wq)) {
+			list_del(&pos->node);
+			kfree(pos);
+			dev->resumed = NULL;
+			dev->parallel_resume = 0;
+			return;
+		}
+}
+EXPORT_SYMBOL_GPL(device_parallel_resume_unregister);
 
 /*------------------------- Suspend routines -------------------------*/
 
Index: linux-2.6/include/linux/device.h
===================================================================
--- linux-2.6.orig/include/linux/device.h
+++ linux-2.6/include/linux/device.h
@@ -376,6 +376,8 @@ struct device {
 	const char		*init_name; /* initial name of the device */
 	struct device_type	*type;
 	unsigned		uevent_suppress:1;
+	unsigned		parallel_resume:1;
+	struct workqueue_struct *resumed;/* device parallel resume wq */
 
 	struct semaphore	sem;	/* semaphore to synchronize calls to
 					 * its driver.
Index: linux-2.6/include/linux/pm.h
===================================================================
--- linux-2.6.orig/include/linux/pm.h
+++ linux-2.6/include/linux/pm.h
@@ -415,6 +415,9 @@ extern int device_power_down(pm_message_
 extern int device_suspend(pm_message_t state);
 extern int device_prepare_suspend(pm_message_t state);
 
+extern int device_parallel_resume_register(struct device *dev, bool sync);
+extern void device_parallel_resume_unregister(struct device *);
+
 extern void __suspend_report_result(const char *function, void *fn, int ret);
 
 #define suspend_report_result(fn, ret)					\
@@ -428,7 +431,14 @@ static inline int device_suspend(pm_mess
 {
 	return 0;
 }
-
+static inline int device_parallel_resume_register(struct device *, int)
+{
+	return 0;
+}
+static inline void device_parallel_resume_unregister(struct device *)
+{
+	return;
+}
 #define suspend_report_result(fn, ret)		do {} while (0)
 
 #endif /* !CONFIG_PM_SLEEP */
