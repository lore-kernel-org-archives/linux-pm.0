From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH] PM: Separate suspend and hibernation
	callbacks (highest level)
Date: Sun, 2 Mar 2008 14:49:26 +0100
Message-ID: <200803021449.27834.rjw__1652.74198302559$1204465942$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

Hi,

Below is a patch that introduces the separation of suspend and hibernation
callbacks on the highest level, which is the PM core.  This patch is a result
of a very recent work by Alex and me.

For now, we only take into account the callbacks necessary to replace the
existing code, so we haven't introduced any substantially new callbacks.  The
question is whether or not we'll need such callbacks and what purpose they
may serve.

Moreover, we assume that the existing (legacy) ->suspend() and ->resume()
callbacks will be used for bus types, device classes and device types that
don't implement the new callbacks.  As a result, the patch doesn't introduce
any visible functional changes.

It has been compilation tested on x86-64.

Comments welcome.

Thanks,
Rafael

---
Introduce 'struct pm_ops' representing a set of suspend and
hibernation operations for bus types, device classes and device
types.

Modify the PM core to use 'struct pm_ops' objects, if defined, instead
of the ->suspend(), ->resume(), ->suspend_late(), ->resume_early()
callbacks that will be considered as legacy and gradually phased out.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---

 arch/x86/kernel/apm_32.c  |    4 
 drivers/base/power/main.c |  241 ++++++++++++++++++++++++++++++++++------------
 include/linux/device.h    |    8 +
 include/linux/pm.h        |   33 +++++-
 kernel/power/disk.c       |   14 +-
 kernel/power/main.c       |    4 
 6 files changed, 226 insertions(+), 78 deletions(-)

Index: linux-2.6/drivers/base/power/main.c
===================================================================
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -132,27 +132,109 @@ void pm_sleep_unlock(void)
 	up_read(&pm_sleep_rwsem);
 }
 
+/**
+ *	pm_op - execute the PM operation appropiate for given PM event
+ *	@dev:	Device
+ *	@hops:	PM operations to choose from
+ *	@state:	PM event message
+ */
+static int pm_op(struct device *dev, struct pm_ops *ops, pm_message_t state)
+{
+	int error = 0;
+
+	switch (state.event) {
+#ifdef CONFIG_SUSPEND
+	case PM_EVENT_SUSPEND:
+		error = (ops->suspend && ops->resume) ?
+			ops->suspend(dev) : -ENOSYS;
+		suspend_report_result(ops->suspend, error);
+		break;
+	case PM_EVENT_RESUME:
+		ops->resume(dev);
+		break;
+#endif /* CONFIG_SUSPEND */
+#ifdef CONFIG_HIBERNATION
+	case PM_EVENT_FREEZE:
+		error = (ops->freeze && ops->thaw && ops->restore) ?
+			ops->freeze(dev) : -ENOSYS;
+		suspend_report_result(ops->freeze, error);
+		break;
+	case PM_EVENT_QUIESCE:
+		error = (ops->quiesce && ops->restore) ?
+			ops->quiesce(dev) : -ENOSYS;
+		suspend_report_result(ops->quiesce, error);
+		break;
+	case PM_EVENT_HIBERNATE:
+		/* This one is not mandatory */
+		if (ops->poweroff)
+			ops->poweroff(dev);
+		break;
+	case PM_EVENT_THAW:
+		ops->thaw(dev);
+		break;
+	case PM_EVENT_RESTORE:
+		ops->restore(dev);
+		break;
+#endif /* CONFIG_HIBERNATION */
+	default:
+		error = -EINVAL;
+	}
+	return error;
+}
+
+static char *pm_verb(int event)
+{
+	switch (event) {
+	case PM_EVENT_SUSPEND:
+		return "suspend";
+	case PM_EVENT_RESUME:
+		return "resume";
+	case PM_EVENT_FREEZE:
+		return "freeze";
+	case PM_EVENT_QUIESCE:
+		return "quiesce";
+	case PM_EVENT_HIBERNATE:
+		return "hibernate";
+	case PM_EVENT_THAW:
+		return "thaw";
+	case PM_EVENT_RESTORE:
+		return "restore";
+	default:
+		return "(unknown PM event)";
+	}
+}
+
+static void pm_dev_dbg(struct device *dev, pm_message_t state, char *info)
+{
+	dev_dbg(dev, "%s%s%s\n", info, pm_verb(state.event),
+		((state.event & PM_EVENT_SLEEP) && device_may_wakeup(dev)) ?
+		", may wakeup" : "");
+}
 
 /*------------------------- Resume routines -------------------------*/
 
 /**
- *	resume_device_early - Power on one device (early resume).
+ *	resume_device_noirq - Power on one device (early resume).
  *	@dev:	Device.
  *
  *	Must be called with interrupts disabled.
  */
-static int resume_device_early(struct device *dev)
+static int resume_device_noirq(struct device *dev, pm_message_t state)
 {
 	int error = 0;
 
 	TRACE_DEVICE(dev);
 	TRACE_RESUME(0);
 
-	if (dev->bus && dev->bus->resume_early) {
-		dev_dbg(dev, "EARLY resume\n");
-		error = dev->bus->resume_early(dev);
-	}
+	if (!dev->bus)
+		goto End;
 
+	pm_dev_dbg(dev, state, "EARLY ");
+	if (dev->bus->pm_noirq)
+		error = pm_op(dev, dev->bus->pm_noirq, state);
+	else if (dev->bus->resume_early)
+		error = dev->bus->resume_early(dev);
+ End:
 	TRACE_RESUME(error);
 	return error;
 }
@@ -167,7 +249,7 @@ static int resume_device_early(struct de
  *
  *	Must be called with interrupts disabled and only one CPU running.
  */
-static void dpm_power_up(void)
+static void dpm_power_up(pm_message_t state)
 {
 
 	while (!list_empty(&dpm_off_irq)) {
@@ -175,7 +257,7 @@ static void dpm_power_up(void)
 		struct device *dev = to_device(entry);
 
 		list_move_tail(entry, &dpm_off);
-		resume_device_early(dev);
+		resume_device_noirq(dev, state);
 	}
 }
 
@@ -187,10 +269,10 @@ static void dpm_power_up(void)
  *
  *	Must be called with interrupts disabled.
  */
-void device_power_up(void)
+void device_power_up(pm_message_t state)
 {
 	sysdev_resume();
-	dpm_power_up();
+	dpm_power_up(state);
 }
 EXPORT_SYMBOL_GPL(device_power_up);
 
@@ -199,7 +281,7 @@ EXPORT_SYMBOL_GPL(device_power_up);
  *	@dev:	Device.
  *
  */
-static int resume_device(struct device *dev)
+static int resume_device(struct device *dev, pm_message_t state)
 {
 	int error = 0;
 
@@ -208,21 +290,34 @@ static int resume_device(struct device *
 
 	down(&dev->sem);
 
-	if (dev->bus && dev->bus->resume) {
-		dev_dbg(dev,"resuming\n");
-		error = dev->bus->resume(dev);
+	if (dev->bus) {
+		pm_dev_dbg(dev, state, "");
+		if (dev->bus->pm)
+			error = pm_op(dev, dev->bus->pm, state);
+		else if (dev->bus->resume)
+			error = dev->bus->resume(dev);
 	}
+	if (error)
+		goto End;
 
-	if (!error && dev->type && dev->type->resume) {
-		dev_dbg(dev,"resuming\n");
-		error = dev->type->resume(dev);
+	if (dev->type) {
+		pm_dev_dbg(dev, state, "type ");
+		if (dev->type->pm)
+			error = pm_op(dev, dev->type->pm, state);
+		else if (dev->type->resume)
+			error = dev->type->resume(dev);
 	}
+	if (error)
+		goto End;
 
-	if (!error && dev->class && dev->class->resume) {
-		dev_dbg(dev,"class resume\n");
-		error = dev->class->resume(dev);
+	if (dev->class) {
+		pm_dev_dbg(dev, state, "class ");
+		if (dev->class->pm)
+			error = pm_op(dev, dev->class->pm, state);
+		else if (dev->class->resume)
+			error = dev->class->resume(dev);
 	}
-
+ End:
 	up(&dev->sem);
 
 	TRACE_RESUME(error);
@@ -239,7 +334,7 @@ static int resume_device(struct device *
  *	Take devices from the dpm_off_list, resume them,
  *	and put them on the dpm_locked list.
  */
-static void dpm_resume(void)
+static void dpm_resume(pm_message_t state)
 {
 	mutex_lock(&dpm_list_mtx);
 	while(!list_empty(&dpm_off)) {
@@ -248,7 +343,7 @@ static void dpm_resume(void)
 
 		list_move_tail(entry, &dpm_active);
 		mutex_unlock(&dpm_list_mtx);
-		resume_device(dev);
+		resume_device(dev, state);
 		mutex_lock(&dpm_list_mtx);
 	}
 	mutex_unlock(&dpm_list_mtx);
@@ -280,10 +375,10 @@ static void unregister_dropped_devices(v
  *	Resume all the devices, unlock them all, and allow new
  *	devices to be registered once again.
  */
-void device_resume(void)
+void device_resume(pm_message_t state)
 {
 	might_sleep();
-	dpm_resume();
+	dpm_resume(state);
 	unregister_dropped_devices();
 	up_write(&pm_sleep_rwsem);
 }
@@ -292,37 +387,43 @@ EXPORT_SYMBOL_GPL(device_resume);
 
 /*------------------------- Suspend routines -------------------------*/
 
-static inline char *suspend_verb(u32 event)
+/**
+ *	resume_event - return a PM message representing the resume event
+ *	               corresponding to given sleep state.
+ *	@sleep_state - PM message representing a sleep state
+ */
+static pm_message_t resume_event(pm_message_t sleep_state)
 {
-	switch (event) {
-	case PM_EVENT_SUSPEND:	return "suspend";
-	case PM_EVENT_FREEZE:	return "freeze";
-	case PM_EVENT_PRETHAW:	return "prethaw";
-	default:		return "(unknown suspend event)";
+	switch (sleep_state.event) {
+	case PM_EVENT_SUSPEND:
+		return PMSG_RESUME;
+	case PM_EVENT_FREEZE:
+	case PM_EVENT_QUIESCE:
+		return PMSG_THAW;
+	case PM_EVENT_HIBERNATE:
+		return PMSG_RESTORE;
 	}
-}
-
-static void
-suspend_device_dbg(struct device *dev, pm_message_t state, char *info)
-{
-	dev_dbg(dev, "%s%s%s\n", info, suspend_verb(state.event),
-		((state.event == PM_EVENT_SUSPEND) && device_may_wakeup(dev)) ?
-		", may wakeup" : "");
+	return PMSG_ON;
 }
 
 /**
- *	suspend_device_late - Shut down one device (late suspend).
+ *	suspend_device_noirq - Shut down one device (late suspend).
  *	@dev:	Device.
  *	@state:	Power state device is entering.
  *
  *	This is called with interrupts off and only a single CPU running.
  */
-static int suspend_device_late(struct device *dev, pm_message_t state)
+static int suspend_device_noirq(struct device *dev, pm_message_t state)
 {
 	int error = 0;
 
-	if (dev->bus && dev->bus->suspend_late) {
-		suspend_device_dbg(dev, state, "LATE ");
+	if (!dev->bus)
+		return 0;
+
+	pm_dev_dbg(dev, state, "LATE ");
+	if (dev->bus->pm_noirq) {
+		error = pm_op(dev, dev->bus->pm_noirq, state);
+	} else if (dev->bus->suspend_late) {
 		error = dev->bus->suspend_late(dev, state);
 		suspend_report_result(dev->bus->suspend_late, error);
 	}
@@ -347,7 +448,7 @@ int device_power_down(pm_message_t state
 		struct list_head *entry = dpm_off.prev;
 		struct device *dev = to_device(entry);
 
-		error = suspend_device_late(dev, state);
+		error = suspend_device_noirq(dev, state);
 		if (error) {
 			printk(KERN_ERR "Could not power down device %s: "
 					"error %d\n",
@@ -361,7 +462,7 @@ int device_power_down(pm_message_t state
 	if (!error)
 		error = sysdev_suspend(state);
 	if (error)
-		dpm_power_up();
+		dpm_power_up(resume_event(state));
 	return error;
 }
 EXPORT_SYMBOL_GPL(device_power_down);
@@ -382,24 +483,40 @@ static int suspend_device(struct device 
 			dev->power.power_state.event, state.event);
 	}
 
-	if (dev->class && dev->class->suspend) {
-		suspend_device_dbg(dev, state, "class ");
-		error = dev->class->suspend(dev, state);
-		suspend_report_result(dev->class->suspend, error);
-	}
-
-	if (!error && dev->type && dev->type->suspend) {
-		suspend_device_dbg(dev, state, "type ");
-		error = dev->type->suspend(dev, state);
-		suspend_report_result(dev->type->suspend, error);
-	}
-
-	if (!error && dev->bus && dev->bus->suspend) {
-		suspend_device_dbg(dev, state, "");
-		error = dev->bus->suspend(dev, state);
-		suspend_report_result(dev->bus->suspend, error);
+	if (dev->class) {
+		pm_dev_dbg(dev, state, "class ");
+		if (dev->class->pm) {
+			error = pm_op(dev, dev->class->pm, state);
+		} else if (dev->class->suspend) {
+			error = dev->class->suspend(dev, state);
+			suspend_report_result(dev->class->suspend, error);
+		}
 	}
+	if (error)
+		goto End;
 
+	if (dev->type) {
+		pm_dev_dbg(dev, state, "type ");
+		if (dev->type->pm) {
+			error = pm_op(dev, dev->type->pm, state);
+		} else if (dev->type->suspend) {
+			error = dev->type->suspend(dev, state);
+			suspend_report_result(dev->type->suspend, error);
+		}
+	}
+	if (error)
+		goto End;
+
+	if (dev->bus) {
+		pm_dev_dbg(dev, state, "");
+		if (dev->bus->pm) {
+			error = pm_op(dev, dev->bus->pm, state);
+		} else if (dev->bus->suspend) {
+			error = dev->bus->suspend(dev, state);
+			suspend_report_result(dev->bus->suspend, error);
+		}
+	}
+ End:
 	up(&dev->sem);
 
 	return error;
@@ -462,7 +579,7 @@ int device_suspend(pm_message_t state)
 	down_write(&pm_sleep_rwsem);
 	error = dpm_suspend(state);
 	if (error)
-		device_resume();
+		device_resume(resume_event(state));
 	return error;
 }
 EXPORT_SYMBOL_GPL(device_suspend);
Index: linux-2.6/include/linux/device.h
===================================================================
--- linux-2.6.orig/include/linux/device.h
+++ linux-2.6/include/linux/device.h
@@ -69,6 +69,9 @@ struct bus_type {
 	int (*resume_early)(struct device *dev);
 	int (*resume)(struct device *dev);
 
+	struct pm_ops *pm;
+	struct pm_ops *pm_noirq;
+
 	struct bus_type_private *p;
 };
 
@@ -202,6 +205,8 @@ struct class {
 
 	int (*suspend)(struct device *dev, pm_message_t state);
 	int (*resume)(struct device *dev);
+
+	struct pm_ops *pm;
 };
 
 extern int __must_check class_register(struct class *class);
@@ -345,8 +350,11 @@ struct device_type {
 	struct attribute_group **groups;
 	int (*uevent)(struct device *dev, struct kobj_uevent_env *env);
 	void (*release)(struct device *dev);
+
 	int (*suspend)(struct device *dev, pm_message_t state);
 	int (*resume)(struct device *dev);
+
+	struct pm_ops *pm;
 };
 
 /* interface for exporting device attributes */
Index: linux-2.6/include/linux/pm.h
===================================================================
--- linux-2.6.orig/include/linux/pm.h
+++ linux-2.6/include/linux/pm.h
@@ -170,14 +170,23 @@ typedef struct pm_message {
 #define PM_EVENT_FREEZE 1
 #define PM_EVENT_SUSPEND 2
 #define PM_EVENT_HIBERNATE 4
-#define PM_EVENT_PRETHAW 8
+#define PM_EVENT_QUIESCE 8
+#define PM_EVENT_RESUME 16
+#define PM_EVENT_THAW 32
+#define PM_EVENT_RESTORE 64
+
+/* Necessary, because many drivers use the old definition */
+#define PM_EVENT_PRETHAW PM_EVENT_QUIESCE
 
 #define PM_EVENT_SLEEP	(PM_EVENT_SUSPEND | PM_EVENT_HIBERNATE)
 
 #define PMSG_FREEZE	((struct pm_message){ .event = PM_EVENT_FREEZE, })
-#define PMSG_PRETHAW	((struct pm_message){ .event = PM_EVENT_PRETHAW, })
+#define PMSG_QUIESCE	((struct pm_message){ .event = PM_EVENT_QUIESCE, })
 #define PMSG_SUSPEND	((struct pm_message){ .event = PM_EVENT_SUSPEND, })
 #define PMSG_HIBERNATE	((struct pm_message){ .event = PM_EVENT_HIBERNATE, })
+#define PMSG_RESUME	((struct pm_message){ .event = PM_EVENT_RESUME, })
+#define PMSG_THAW	((struct pm_message){ .event = PM_EVENT_THAW, })
+#define PMSG_RESTORE	((struct pm_message){ .event = PM_EVENT_RESTORE, })
 #define PMSG_ON		((struct pm_message){ .event = PM_EVENT_ON, })
 
 struct dev_pm_info {
@@ -189,11 +198,25 @@ struct dev_pm_info {
 #endif
 };
 
-extern int device_power_down(pm_message_t state);
-extern void device_power_up(void);
-extern void device_resume(void);
+struct pm_ops {
+#ifdef CONFIG_SUSPEND
+	int (*suspend)(struct device *dev);
+	void (*resume)(struct device *dev);
+#endif
+#ifdef CONFIG_HIBERNATION
+	int (*freeze)(struct device *dev);
+	void (*thaw)(struct device *dev);
+	void (*poweroff)(struct device *dev);
+	int (*quiesce)(struct device *dev);
+	void (*restore)(struct device *dev);
+#endif
+};
 
 #ifdef CONFIG_PM_SLEEP
+extern void device_power_up(pm_message_t state);
+extern void device_resume(pm_message_t state);
+
+extern int device_power_down(pm_message_t state);
 extern int device_suspend(pm_message_t state);
 extern int device_prepare_suspend(pm_message_t state);
 
Index: linux-2.6/kernel/power/disk.c
===================================================================
--- linux-2.6.orig/kernel/power/disk.c
+++ linux-2.6/kernel/power/disk.c
@@ -224,7 +224,7 @@ static int create_image(int platform_mod
 	/* NOTE:  device_power_up() is just a resume() for devices
 	 * that suspended with irqs off ... no overall powerup.
 	 */
-	device_power_up();
+	device_power_up(in_suspend ? PMSG_THAW : PMSG_RESTORE);
  Enable_irqs:
 	local_irq_enable();
 	return error;
@@ -280,7 +280,7 @@ int hibernation_snapshot(int platform_mo
  Finish:
 	platform_finish(platform_mode);
  Resume_devices:
-	device_resume();
+	device_resume(in_suspend ? PMSG_THAW : PMSG_RESTORE);
  Resume_console:
 	resume_console();
  Close:
@@ -301,7 +301,7 @@ static int resume_target_kernel(void)
 	int error;
 
 	local_irq_disable();
-	error = device_power_down(PMSG_PRETHAW);
+	error = device_power_down(PMSG_QUIESCE);
 	if (error) {
 		printk(KERN_ERR "PM: Some devices failed to power down, "
 			"aborting resume\n");
@@ -329,7 +329,7 @@ static int resume_target_kernel(void)
 	swsusp_free();
 	restore_processor_state();
 	touch_softlockup_watchdog();
-	device_power_up();
+	device_power_up(PMSG_THAW);
  Enable_irqs:
 	local_irq_enable();
 	return error;
@@ -350,7 +350,7 @@ int hibernation_restore(int platform_mod
 
 	pm_prepare_console();
 	suspend_console();
-	error = device_suspend(PMSG_PRETHAW);
+	error = device_suspend(PMSG_QUIESCE);
 	if (error)
 		goto Finish;
 
@@ -362,7 +362,7 @@ int hibernation_restore(int platform_mod
 		enable_nonboot_cpus();
 	}
 	platform_restore_cleanup(platform_mode);
-	device_resume();
+	device_resume(PMSG_THAW);
  Finish:
 	resume_console();
 	pm_restore_console();
@@ -419,7 +419,7 @@ int hibernation_platform_enter(void)
  Finish:
 	hibernation_ops->finish();
  Resume_devices:
-	device_resume();
+	device_resume(PMSG_RESTORE);
  Resume_console:
 	resume_console();
  Close:
Index: linux-2.6/kernel/power/main.c
===================================================================
--- linux-2.6.orig/kernel/power/main.c
+++ linux-2.6/kernel/power/main.c
@@ -239,7 +239,7 @@ static int suspend_enter(suspend_state_t
 	if (!suspend_test(TEST_CORE))
 		error = suspend_ops->enter(state);
 
-	device_power_up();
+	device_power_up(PMSG_RESUME);
  Done:
 	arch_suspend_enable_irqs();
 	BUG_ON(irqs_disabled());
@@ -291,7 +291,7 @@ int suspend_devices_and_enter(suspend_st
 	if (suspend_ops->finish)
 		suspend_ops->finish();
  Resume_devices:
-	device_resume();
+	device_resume(PMSG_RESUME);
  Resume_console:
 	resume_console();
  Close:
Index: linux-2.6/arch/x86/kernel/apm_32.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/apm_32.c
+++ linux-2.6/arch/x86/kernel/apm_32.c
@@ -1221,9 +1221,9 @@ static int suspend(int vetoable)
 	if (err != APM_SUCCESS)
 		apm_error("suspend", err);
 	err = (err == APM_SUCCESS) ? 0 : -EIO;
-	device_power_up();
+	device_power_up(PMSG_RESUME);
 	local_irq_enable();
-	device_resume();
+	device_resume(PMSG_RESUME);
 	pm_send_all(PM_RESUME, (void *)0);
 	queue_event(APM_NORMAL_RESUME, NULL);
  out:
