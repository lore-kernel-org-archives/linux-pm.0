From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH] PM: Separate suspend and hibernation
	callbacks (highest level) - updated
Date: Sun, 9 Mar 2008 02:20:16 +0100
Message-ID: <200803090220.17431.linux-acpi-owner@vger.kernel.org>
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

Below is a new version of the patch that introduces the separation of suspend
and hibernation callbacks on the highest level.

Relative to the previous version two additional callbacks have been added,
->prepare() and ->complete(), allowing to prepare the device for a "suspend"
transition and to finalize the "resume" respectively.

Also, all callbacks and PM_EVENT_ messages are now described in the
comments in include/linux/pm.h (the documentation in Documentation/power
will be updated separately).

As previously, it is assumed that the existing (legacy) ->suspend() and
->resume() callbacks will be used for bus types, device classes and device
types that don't implement the new callbacks.  As a result, the patch doesn't
introduce any visible functional changes.

The patch has been compilation tested on x86-64.

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

Not-yet-signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---

 arch/x86/kernel/apm_32.c  |    4 
 drivers/base/power/main.c |  375 +++++++++++++++++++++++++++++++++++-----------
 include/linux/device.h    |    8 
 include/linux/pm.h        |  193 ++++++++++++++++++++---
 kernel/power/disk.c       |   14 -
 kernel/power/main.c       |    4 
 6 files changed, 482 insertions(+), 116 deletions(-)

Index: linux-2.6/include/linux/pm.h
===================================================================
--- linux-2.6.orig/include/linux/pm.h
+++ linux-2.6/include/linux/pm.h
@@ -110,11 +110,9 @@ extern void (*pm_power_off_prepare)(void
 
 struct device;
 
-typedef struct pm_message {
-	int event;
-} pm_message_t;
-
-/*
+/**
+ * struct pm_ops - device PM callbacks
+ *
  * Several driver power state transitions are externally visible, affecting
  * the state of pending I/O queues and (for drivers that touch hardware)
  * interrupts, wakeups, DMA, and other hardware state.  There may also be
@@ -122,6 +120,169 @@ typedef struct pm_message {
  * to the rest of the driver stack (such as a driver that's ON gating off
  * clocks which are not in active use).
  *
+ * The externally visible transitions are handled with the help of the following
+ * callbacks included in this structure:
+ *
+ * @prepare: Prepare the device for the upcoming transition, but do NOT change
+ *	its hardware state.  Prevent new children of the device from being
+ *	registered after @prepare() returns.  Also, if a concurrent child
+ *	registration already in progress is detected by @prepare(), it should
+ *	wait for the registration to complete, block the subsequent
+ *	registrations of children and return -EAGAIN, so that the PM core can
+ *	execute it once again (after suspending the newly registered child) to
+ *	recover from the race condition.  This method is executed for all kinds
+ *	of suspend transitions and is immediately followed by one of the suspend
+ *	callbacks: @suspend(), @freeze(), @poweroff(), or @quiesce().
+ *
+ * @complete: Undo the changes made by @prepare().  This method is executed for
+ *	all kinds of resume transitions, immediately following one of the resume
+ *	callbacks: @resume(), @thaw(), @restore(), or @recover().  Also executed
+ *	if a suspend callback (@suspend(), @freeze(), @poweroff(), @quiesce())
+ *	immediately following a successful @prepare() fails.
+ *
+ * @suspend: Executed before putting the system into a sleep state in which the
+ *	contents of main memory are preserved.  Quiesce the device, put it into
+ *	a low power state appropriate for the upcoming system state (such as
+ *	PCI_D3hot), and enable wakeup events as appropriate.
+ *
+ * @resume: Executed after waking the system up from a sleep state in which the
+ *	contents of main memory were preserved.  Put the device into the
+ *	appropriate state, according to the information saved in memory by the
+ *	preceding @suspend().  The driver starts working again, responding to
+ *	hardware events and software requests.  The hardware may have gone
+ *	through a power-off reset, or it may have maintained state from the
+ *	previous suspend() which the driver may rely on while resuming.  On most
+ *	platforms, there are no restrictions on availability of resources like
+ *	clocks during @resume().
+ *
+ * @freeze: Hibernation-specific, executed before creating a hibernation image.
+ *	Quiesce operations so that a consistent image can be created, but do NOT
+ *	otherwise put the device into a low power device state and do NOT emit
+ *	system wakeup events.  Save in main memory the device settings to be
+ *	used by @restore() during the subsequent resume from hibernation.
+ *
+ * @thaw: Hibernation-specific, executed after creating a hibernation image.
+ *	Undo the changes made by the preceding @freeze(), so the device can be
+ *	operated in the same was as immediately before the call to @freeze().
+ *
+ * @poweroff: Hibernation-specific, executed after saving a hibernation image.
+ *	Quiesce the device, put it into a low power state appropriate for the
+ *	upcoming system state (such as PCI_D3hot), and enable wakeup events as
+ *	appropriate.
+ *
+ * @quiesce: Hibernation-specific, executed after loading a hibernation image
+ *	and before restoring the contents of main memory from it.  Quiesce
+ *	operations so that the contents of main memory can be restored from the
+ *	image in a consistent way, but do NOT otherwise put the device into a
+ *	low power state and do NOT emit system wakeup events.  Do NOT save any
+ *	device settings in main memory.
+ *
+ * @restore: Hibernation-specific, executed after restoring the contents of main
+ *	memory from a hibernation image.  Driver starts working again,
+ *	responding to hardware events and software requests.  Do NOT make ANY
+ *	assumptions about the hardware state right prior to @restore().  On most
+ *	platforms, there are no restrictions on availability of resources like
+ *	clocks during @restore().
+ *
+ * @recover: Hibernation-specific, executed after a failing creation of a
+ *	hibernation image OR after a failing attempt to restore the contents of
+ *	main memory from such an image.  Undo the changes made by the preceding
+ *	@freeze() or @quiesce, so the device can be operated in the same was as
+ *	immediately before the failing transition.
+ */
+
+struct pm_ops {
+#ifdef CONFIG_PM_SLEEP
+	int (*prepare)(struct device *dev);
+	void (*complete)(struct device *dev);
+#endif
+#ifdef CONFIG_SUSPEND
+	int (*suspend)(struct device *dev);
+	int (*resume)(struct device *dev);
+#endif
+#ifdef CONFIG_HIBERNATION
+	int (*freeze)(struct device *dev);
+	int (*thaw)(struct device *dev);
+	int (*poweroff)(struct device *dev);
+	int (*quiesce)(struct device *dev);
+	int (*restore)(struct device *dev);
+	int (*recover)(struct device *dev);
+#endif
+};
+
+/**
+ * PM_EVENT_ messages
+ *
+ * The following PM_EVENT_ messages are defined for the internal use of the PM
+ * core, in order to provide a mechanism allowing the high level suspend and
+ * hibernation code to convey the necessary information to the device PM core
+ * code:
+ *
+ * ON		No transition.
+ *
+ * FREEZE 	System is going to hibernate, call ->prepare() and ->freeze()
+ *		for all devices.
+ *
+ * SUSPEND	System is going to suspend, call ->prepare() and ->suspend()
+ *		for all devices.
+ *
+ * HIBERNATE	Hibernation image has been saved, call ->prepare() and
+ *		->poweroff() for all devices.
+ *
+ * QUIESCE	Contents of main memory are going to be restored from a (loaded)
+ *		hibernation image, call ->prepare() and ->quiesce() for all
+ *		devices.
+ *
+ * RESUME	System is resuming, call ->resume() and ->complete() for all
+ *		devices.
+ *
+ * THAW		Hibernation image has been created, call ->thaw() and
+ *		->complete() for all devices.
+ *
+ * RESTORE	Contents of main memory have been restored from a hibernation
+ *		image, call ->restore() and ->complete() for all devices.
+ *
+ * RECOVER	Creation of a hibernation image or restoration of the main
+ *		memory contents from a hibernation image has failed, call
+ *		->recover() and ->complete() for all devices.
+ */
+
+typedef struct pm_message {
+	int event;
+} pm_message_t;
+
+#define PM_EVENT_ON		0x0000
+#define PM_EVENT_FREEZE 	0x0001
+#define PM_EVENT_SUSPEND	0x0002
+#define PM_EVENT_HIBERNATE	0x0004
+#define PM_EVENT_QUIESCE	0x0008
+#define PM_EVENT_RESUME		0x0010
+#define PM_EVENT_THAW		0x0020
+#define PM_EVENT_RESTORE	0x0040
+#define PM_EVENT_RECOVER	0x0080
+
+#define PM_EVENT_SLEEP	(PM_EVENT_SUSPEND | PM_EVENT_HIBERNATE)
+
+#define PMSG_FREEZE	((struct pm_message){ .event = PM_EVENT_FREEZE, })
+#define PMSG_QUIESCE	((struct pm_message){ .event = PM_EVENT_QUIESCE, })
+#define PMSG_SUSPEND	((struct pm_message){ .event = PM_EVENT_SUSPEND, })
+#define PMSG_HIBERNATE	((struct pm_message){ .event = PM_EVENT_HIBERNATE, })
+#define PMSG_RESUME	((struct pm_message){ .event = PM_EVENT_RESUME, })
+#define PMSG_THAW	((struct pm_message){ .event = PM_EVENT_THAW, })
+#define PMSG_RESTORE	((struct pm_message){ .event = PM_EVENT_RESTORE, })
+#define PMSG_RECOVER	((struct pm_message){ .event = PM_EVENT_RECOVER, })
+#define PMSG_ON		((struct pm_message){ .event = PM_EVENT_ON, })
+
+/*
+ * The PM_EVENT_ messages are also used by drivers implementing the legacy
+ * suspend framework, based on the ->suspend() and ->resume() callbacks common
+ * for suspend and hibernation transitions, according to the rules below.
+ */
+
+/* Necessary, because several drivers use PM_EVENT_PRETHAW */
+#define PM_EVENT_PRETHAW PM_EVENT_QUIESCE
+
+/*
  * One transition is triggered by resume(), after a suspend() call; the
  * message is implicit:
  *
@@ -166,20 +327,6 @@ typedef struct pm_message {
  * or from system low-power states such as standby or suspend-to-RAM.
  */
 
-#define PM_EVENT_ON 0
-#define PM_EVENT_FREEZE 1
-#define PM_EVENT_SUSPEND 2
-#define PM_EVENT_HIBERNATE 4
-#define PM_EVENT_PRETHAW 8
-
-#define PM_EVENT_SLEEP	(PM_EVENT_SUSPEND | PM_EVENT_HIBERNATE)
-
-#define PMSG_FREEZE	((struct pm_message){ .event = PM_EVENT_FREEZE, })
-#define PMSG_PRETHAW	((struct pm_message){ .event = PM_EVENT_PRETHAW, })
-#define PMSG_SUSPEND	((struct pm_message){ .event = PM_EVENT_SUSPEND, })
-#define PMSG_HIBERNATE	((struct pm_message){ .event = PM_EVENT_HIBERNATE, })
-#define PMSG_ON		((struct pm_message){ .event = PM_EVENT_ON, })
-
 struct dev_pm_info {
 	pm_message_t		power_state;
 	unsigned		can_wakeup:1;
@@ -190,11 +337,11 @@ struct dev_pm_info {
 #endif
 };
 
-extern int device_power_down(pm_message_t state);
-extern void device_power_up(void);
-extern void device_resume(void);
-
 #ifdef CONFIG_PM_SLEEP
+extern void device_power_up(pm_message_t state);
+extern void device_resume(pm_message_t state);
+
+extern int device_power_down(pm_message_t state);
 extern int device_suspend(pm_message_t state);
 extern int device_prepare_suspend(pm_message_t state);
 
Index: linux-2.6/drivers/base/power/main.c
===================================================================
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -124,26 +124,129 @@ void device_pm_schedule_removal(struct d
 }
 EXPORT_SYMBOL_GPL(device_pm_schedule_removal);
 
+/**
+ *	pm_op - execute the PM operation appropiate for given PM event
+ *	@dev:	Device.
+ *	@ops:	PM operations to choose from.
+ *	@state:	PM event message.
+ */
+static int pm_op(struct device *dev, struct pm_ops *ops, pm_message_t state)
+{
+	int error = 0;
+
+	switch (state.event) {
+#ifdef CONFIG_SUSPEND
+	case PM_EVENT_SUSPEND:
+		if (ops->suspend) {
+			error = ops->suspend(dev);
+			suspend_report_result(ops->suspend, error);
+		}
+		break;
+	case PM_EVENT_RESUME:
+		if (ops->resume) {
+			error = ops->resume(dev);
+			suspend_report_result(ops->resume, error);
+		}
+		break;
+#endif /* CONFIG_SUSPEND */
+#ifdef CONFIG_HIBERNATION
+	case PM_EVENT_FREEZE:
+		if (ops->freeze) {
+			error = ops->freeze(dev);
+			suspend_report_result(ops->freeze, error);
+		}
+		break;
+	case PM_EVENT_QUIESCE:
+		if (ops->quiesce) {
+			error = ops->quiesce(dev);
+			suspend_report_result(ops->quiesce, error);
+		}
+		break;
+	case PM_EVENT_HIBERNATE:
+		if (ops->poweroff) {
+			error = ops->poweroff(dev);
+			suspend_report_result(ops->poweroff, error);
+		}
+		break;
+	case PM_EVENT_THAW:
+		if (ops->thaw) {
+			error = ops->thaw(dev);
+			suspend_report_result(ops->thaw, error);
+		}
+		break;
+	case PM_EVENT_RESTORE:
+		if (ops->restore) {
+			error = ops->restore(dev);
+			suspend_report_result(ops->restore, error);
+		}
+		break;
+	case PM_EVENT_RECOVER:
+		if (ops->recover) {
+			error = ops->recover(dev);
+			suspend_report_result(ops->recover, error);
+		}
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
+
 /*------------------------- Resume routines -------------------------*/
 
 /**
- *	resume_device_early - Power on one device (early resume).
+ *	resume_device_noirq - Power on one device (early resume).
  *	@dev:	Device.
+ *	@state: Operation to carry out.
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
@@ -158,7 +261,7 @@ static int resume_device_early(struct de
  *
  *	Must be called with interrupts disabled and only one CPU running.
  */
-static void dpm_power_up(void)
+static void dpm_power_up(pm_message_t state)
 {
 
 	while (!list_empty(&dpm_off_irq)) {
@@ -166,7 +269,7 @@ static void dpm_power_up(void)
 		struct device *dev = to_device(entry);
 
 		list_move_tail(entry, &dpm_off);
-		resume_device_early(dev);
+		resume_device_noirq(dev, state);
 	}
 }
 
@@ -178,19 +281,49 @@ static void dpm_power_up(void)
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
 
 /**
+ *	complete_device - Complete a PM transition for given device
+ *	@dev:	Device.
+ *	@state:	Power transition we are completing.
+ */
+static void complete_device(struct device *dev, pm_message_t state)
+{
+	down(&dev->sem);
+
+	if (dev->bus) {
+		pm_dev_dbg(dev, state, "completing ");
+		if (dev->bus->pm && dev->bus->pm->complete)
+			dev->bus->pm->complete(dev);
+	}
+
+	if (dev->type) {
+		pm_dev_dbg(dev, state, "completing type ");
+		if (dev->type->pm && dev->type->pm->complete)
+			dev->type->pm->complete(dev);
+	}
+
+	if (dev->class) {
+		pm_dev_dbg(dev, state, "completing class ");
+		if (dev->class->pm && dev->class->pm->complete)
+			dev->class->pm->complete(dev);
+	}
+
+	up(&dev->sem);
+}
+
+/**
  *	resume_device - Restore state for one device.
  *	@dev:	Device.
- *
+ *	@state:	Operation to carry out.
  */
-static int resume_device(struct device *dev)
+static int resume_device(struct device *dev, pm_message_t state)
 {
 	int error = 0;
 
@@ -199,21 +332,34 @@ static int resume_device(struct device *
 
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
@@ -228,9 +374,9 @@ static int resume_device(struct device *
  *	went through the early resume.
  *
  *	Take devices from the dpm_off_list, resume them,
- *	and put them on the dpm_locked list.
+ *	and put them on the dpm_active list.
  */
-static void dpm_resume(void)
+static void dpm_resume(pm_message_t state)
 {
 	mutex_lock(&dpm_list_mtx);
 	all_sleeping = false;
@@ -241,7 +387,8 @@ static void dpm_resume(void)
 		list_move_tail(entry, &dpm_active);
 		dev->power.sleeping = false;
 		mutex_unlock(&dpm_list_mtx);
-		resume_device(dev);
+		resume_device(dev, state);
+		complete_device(dev, state);
 		mutex_lock(&dpm_list_mtx);
 	}
 	mutex_unlock(&dpm_list_mtx);
@@ -269,14 +416,15 @@ static void unregister_dropped_devices(v
 
 /**
  *	device_resume - Restore state of each device in system.
+ *	@state: Operation to carry out.
  *
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
 }
 EXPORT_SYMBOL_GPL(device_resume);
@@ -284,37 +432,43 @@ EXPORT_SYMBOL_GPL(device_resume);
 
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
+		return PMSG_RECOVER;
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
@@ -339,7 +493,7 @@ int device_power_down(pm_message_t state
 		struct list_head *entry = dpm_off.prev;
 		struct device *dev = to_device(entry);
 
-		error = suspend_device_late(dev, state);
+		error = suspend_device_noirq(dev, state);
 		if (error) {
 			printk(KERN_ERR "Could not power down device %s: "
 					"error %d\n",
@@ -353,45 +507,100 @@ int device_power_down(pm_message_t state
 	if (!error)
 		error = sysdev_suspend(state);
 	if (error)
-		dpm_power_up();
+		dpm_power_up(resume_event(state));
 	return error;
 }
 EXPORT_SYMBOL_GPL(device_power_down);
 
 /**
- *	suspend_device - Save state of one device.
+ *	prepare_device - Execute the ->prepare() callback(s) for given device.
  *	@dev:	Device.
- *	@state:	Power state device is entering.
+ *	@state: Operation we are preparing for.
  */
-static int suspend_device(struct device *dev, pm_message_t state)
+static int prepare_device(struct device *dev, pm_message_t state)
 {
 	int error = 0;
 
 	down(&dev->sem);
 
-	if (dev->power.power_state.event) {
-		dev_dbg(dev, "PM: suspend %d-->%d\n",
-			dev->power.power_state.event, state.event);
+	if (dev->bus) {
+		pm_dev_dbg(dev, state, "preparing ");
+		if (dev->bus->pm && dev->bus->pm->prepare) {
+			error = dev->bus->pm->prepare(dev);
+			suspend_report_result(dev->bus->pm->prepare, error);
+		}
 	}
+	if (error)
+		goto End;
 
-	if (dev->class && dev->class->suspend) {
-		suspend_device_dbg(dev, state, "class ");
-		error = dev->class->suspend(dev, state);
-		suspend_report_result(dev->class->suspend, error);
+	if (dev->type) {
+		pm_dev_dbg(dev, state, "preparing type ");
+		if (dev->type->pm && dev->type->pm->prepare) {
+			error = dev->type->pm->prepare(dev);
+			suspend_report_result(dev->type->pm->prepare, error);
+		}
 	}
+	if (error)
+		goto End;
 
-	if (!error && dev->type && dev->type->suspend) {
-		suspend_device_dbg(dev, state, "type ");
-		error = dev->type->suspend(dev, state);
-		suspend_report_result(dev->type->suspend, error);
+	if (dev->class) {
+		pm_dev_dbg(dev, state, "preparing class ");
+		if (dev->class->pm && dev->class->pm->prepare) {
+			error = dev->class->pm->prepare(dev);
+			suspend_report_result(dev->class->pm->prepare, error);
+		}
 	}
+ End:
+	up(&dev->sem);
+
+	return error;
+}
 
-	if (!error && dev->bus && dev->bus->suspend) {
-		suspend_device_dbg(dev, state, "");
-		error = dev->bus->suspend(dev, state);
-		suspend_report_result(dev->bus->suspend, error);
+/**
+ *	suspend_device - Save state of one device.
+ *	@dev:	Device.
+ *	@state:	Power state device is entering.
+ */
+static int suspend_device(struct device *dev, pm_message_t state)
+{
+	int error = 0;
+
+	down(&dev->sem);
+
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
+
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
@@ -401,13 +610,8 @@ static int suspend_device(struct device 
  *	dpm_suspend - Suspend every device.
  *	@state:	Power state to put each device in.
  *
- *	Walk the dpm_locked list.  Suspend each device and move it
+ *	Walk the dpm_active list.  Suspend each device and move it
  *	to the dpm_off list.
- *
- *	(For historical reasons, if it returns -EAGAIN, that used to mean
- *	that the device would be called again with interrupts disabled.
- *	These days, we use the "suspend_late()" callback for that, so we
- *	print a warning and consider it an error).
  */
 static int dpm_suspend(pm_message_t state)
 {
@@ -419,21 +623,29 @@ static int dpm_suspend(pm_message_t stat
 		struct device *dev = to_device(entry);
 
 		WARN_ON(dev->parent && dev->parent->power.sleeping);
+		mutex_unlock(&dpm_list_mtx);
 
+		error = prepare_device(dev, state);
+
+		mutex_lock(&dpm_list_mtx);
+		if (error) {
+			if (error == -EAGAIN)
+				continue;
+			else
+				break;
+		}
 		dev->power.sleeping = true;
 		mutex_unlock(&dpm_list_mtx);
+
 		error = suspend_device(dev, state);
+
 		mutex_lock(&dpm_list_mtx);
 		if (error) {
-			printk(KERN_ERR "Could not suspend device %s: "
-					"error %d%s\n",
-					kobject_name(&dev->kobj),
-					error,
-					(error == -EAGAIN ?
-					" (please convert to suspend_late)" :
-					""));
 			dev->power.sleeping = false;
-			break;
+			mutex_unlock(&dpm_list_mtx);
+
+			complete_device(dev, resume_event(state));
+			return error;
 		}
 		if (!list_empty(&dev->power.entry))
 			list_move(&dev->power.entry, &dpm_off);
@@ -449,8 +661,7 @@ static int dpm_suspend(pm_message_t stat
  *	device_suspend - Save state and stop all devices in system.
  *	@state: new power management state
  *
- *	Prevent new devices from being registered, then lock all devices
- *	and suspend them.
+ *	Prepare and suspend all devices.
  */
 int device_suspend(pm_message_t state)
 {
@@ -459,7 +670,7 @@ int device_suspend(pm_message_t state)
 	might_sleep();
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
Index: linux-2.6/kernel/power/disk.c
===================================================================
--- linux-2.6.orig/kernel/power/disk.c
+++ linux-2.6/kernel/power/disk.c
@@ -224,7 +224,7 @@ static int create_image(int platform_mod
 	/* NOTE:  device_power_up() is just a resume() for devices
 	 * that suspended with irqs off ... no overall powerup.
 	 */
-	device_power_up();
+	device_power_up(in_suspend ? PMSG_RECOVER : PMSG_RESTORE);
  Enable_irqs:
 	local_irq_enable();
 	return error;
@@ -280,7 +280,7 @@ int hibernation_snapshot(int platform_mo
  Finish:
 	platform_finish(platform_mode);
  Resume_devices:
-	device_resume();
+	device_resume(in_suspend ? PMSG_RECOVER : PMSG_RESTORE);
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
+	device_resume(PMSG_RECOVER);
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
