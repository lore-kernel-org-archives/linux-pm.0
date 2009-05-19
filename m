From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] PM core: rename suspend and resume functions
Date: Tue, 19 May 2009 10:53:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0905191051240.2646-100000@iolanthe.rowland.org>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

This patch (as1241) renames a bunch of functions in the PM core.
Rather than go through a boring list of name changes, suffice it to
say that in the end we have a bunch of pairs of functions:

	device_resume_noirq	dpm_resume_noirq
	device_resume		dpm_resume
	device_complete		dpm_complete
	device_suspend_noirq	dpm_suspend_noirq
	device_suspend		dpm_suspend
	device_prepare		dpm_prepare

in which device_X does the X operation on a single device and dpm_X
invokes device_X for all devices in the dpm_list.

In addition, the old dpm_power_up and device_resume_noirq have been
combined into a single function (dpm_resume_noirq).

Lastly, dpm_suspend_start and dpm_resume_end are the renamed versions
of the former top-level device_suspend and device_resume routines.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

I haven't got the very latest versions of the files under kernel/power, 
so some slight additional modifications may be needed.


Index: usb-2.6/include/linux/pm.h
===================================================================
--- usb-2.6.orig/include/linux/pm.h
+++ usb-2.6/include/linux/pm.h
@@ -382,14 +382,13 @@ struct dev_pm_info {
 #ifdef CONFIG_PM_SLEEP
 extern void device_pm_lock(void);
 extern int sysdev_resume(void);
-extern void device_resume_noirq(pm_message_t state);
-extern void device_resume(pm_message_t state);
+extern void dpm_resume_noirq(pm_message_t state);
+extern void dpm_resume_end(pm_message_t state);
 
 extern void device_pm_unlock(void);
 extern int sysdev_suspend(pm_message_t state);
-extern int device_suspend_noirq(pm_message_t state);
-extern int device_suspend(pm_message_t state);
-extern int device_prepare_suspend(pm_message_t state);
+extern int dpm_suspend_noirq(pm_message_t state);
+extern int dpm_suspend_start(pm_message_t state);
 
 extern void __suspend_report_result(const char *function, void *fn, int ret);
 
@@ -403,7 +402,7 @@ extern void __suspend_report_result(cons
 #define device_pm_lock() do {} while (0)
 #define device_pm_unlock() do {} while (0)
 
-static inline int device_suspend(pm_message_t state)
+static inline int dpm_suspend_start(pm_message_t state)
 {
 	return 0;
 }
Index: usb-2.6/drivers/base/power/main.c
===================================================================
--- usb-2.6.orig/drivers/base/power/main.c
+++ usb-2.6/drivers/base/power/main.c
@@ -315,13 +315,13 @@ static void pm_dev_err(struct device *de
 /*------------------------- Resume routines -------------------------*/
 
 /**
- *	__device_resume_noirq - Power on one device (early resume).
+ *	device_resume_noirq - Power on one device (early resume).
  *	@dev:	Device.
  *	@state: PM transition of the system being carried out.
  *
  *	Must be called with interrupts disabled.
  */
-static int __device_resume_noirq(struct device *dev, pm_message_t state)
+static int device_resume_noirq(struct device *dev, pm_message_t state)
 {
 	int error = 0;
 
@@ -344,16 +344,16 @@ static int __device_resume_noirq(struct 
 }
 
 /**
- *	dpm_power_up - Power on all regular (non-sysdev) devices.
+ *	dpm_resume_noirq - Power on all regular (non-sysdev) devices.
  *	@state: PM transition of the system being carried out.
  *
- *	Execute the appropriate "noirq resume" callback for all devices marked
- *	as DPM_OFF_IRQ.
+ *	Call the "noirq" resume handlers for all devices marked as
+ *	DPM_OFF_IRQ and enable device drivers to receive interrupts.
  *
  *	Must be called under dpm_list_mtx.  Device drivers should not receive
  *	interrupts while it's being executed.
  */
-static void dpm_power_up(pm_message_t state)
+void dpm_resume_noirq(pm_message_t state)
 {
 	struct device *dev;
 
@@ -362,32 +362,20 @@ static void dpm_power_up(pm_message_t st
 			int error;
 
 			dev->power.status = DPM_OFF;
-			error = __device_resume_noirq(dev, state);
+			error = device_resume_noirq(dev, state);
 			if (error)
 				pm_dev_err(dev, state, " early", error);
 		}
-}
-
-/**
- *	device_resume_noirq - Turn on all devices that need special attention.
- *	@state: PM transition of the system being carried out.
- *
- *	Call the "early" resume handlers and enable device drivers to receive
- *	interrupts.
- */
-void device_resume_noirq(pm_message_t state)
-{
-	dpm_power_up(state);
 	resume_device_irqs();
 }
-EXPORT_SYMBOL_GPL(device_resume_noirq);
+EXPORT_SYMBOL_GPL(dpm_resume_noirq);
 
 /**
- *	resume_device - Restore state for one device.
+ *	device_resume - Restore state for one device.
  *	@dev:	Device.
  *	@state: PM transition of the system being carried out.
  */
-static int resume_device(struct device *dev, pm_message_t state)
+static int device_resume(struct device *dev, pm_message_t state)
 {
 	int error = 0;
 
@@ -460,7 +448,7 @@ static void dpm_resume(pm_message_t stat
 			dev->power.status = DPM_RESUMING;
 			mutex_unlock(&dpm_list_mtx);
 
-			error = resume_device(dev, state);
+			error = device_resume(dev, state);
 
 			mutex_lock(&dpm_list_mtx);
 			if (error)
@@ -478,11 +466,11 @@ static void dpm_resume(pm_message_t stat
 }
 
 /**
- *	complete_device - Complete a PM transition for given device
+ *	device_complete - Complete a PM transition for given device
  *	@dev:	Device.
  *	@state: PM transition of the system being carried out.
  */
-static void complete_device(struct device *dev, pm_message_t state)
+static void device_complete(struct device *dev, pm_message_t state)
 {
 	down(&dev->sem);
 
@@ -525,7 +513,7 @@ static void dpm_complete(pm_message_t st
 			dev->power.status = DPM_ON;
 			mutex_unlock(&dpm_list_mtx);
 
-			complete_device(dev, state);
+			device_complete(dev, state);
 
 			mutex_lock(&dpm_list_mtx);
 		}
@@ -538,19 +526,19 @@ static void dpm_complete(pm_message_t st
 }
 
 /**
- *	device_resume - Restore state of each device in system.
+ *	dpm_resume_end - Restore state of each device in system.
  *	@state: PM transition of the system being carried out.
  *
  *	Resume all the devices, unlock them all, and allow new
  *	devices to be registered once again.
  */
-void device_resume(pm_message_t state)
+void dpm_resume_end(pm_message_t state)
 {
 	might_sleep();
 	dpm_resume(state);
 	dpm_complete(state);
 }
-EXPORT_SYMBOL_GPL(device_resume);
+EXPORT_SYMBOL_GPL(dpm_resume_end);
 
 
 /*------------------------- Suspend routines -------------------------*/
@@ -575,13 +563,13 @@ static pm_message_t resume_event(pm_mess
 }
 
 /**
- *	__device_suspend_noirq - Shut down one device (late suspend).
+ *	device_suspend_noirq - Shut down one device (late suspend).
  *	@dev:	Device.
  *	@state: PM transition of the system being carried out.
  *
  *	This is called with interrupts off and only a single CPU running.
  */
-static int __device_suspend_noirq(struct device *dev, pm_message_t state)
+static int device_suspend_noirq(struct device *dev, pm_message_t state)
 {
 	int error = 0;
 
@@ -600,22 +588,22 @@ static int __device_suspend_noirq(struct
 }
 
 /**
- *	device_suspend_noirq - Shut down special devices.
+ *	dpm_suspend_noirq - Power down all regular (non-sysdev) devices.
  *	@state: PM transition of the system being carried out.
  *
- *	Prevent device drivers from receiving interrupts and call the "late"
+ *	Prevent device drivers from receiving interrupts and call the "noirq"
  *	suspend handlers.
  *
  *	Must be called under dpm_list_mtx.
  */
-int device_suspend_noirq(pm_message_t state)
+int dpm_suspend_noirq(pm_message_t state)
 {
 	struct device *dev;
 	int error = 0;
 
 	suspend_device_irqs();
 	list_for_each_entry_reverse(dev, &dpm_list, power.entry) {
-		error = __device_suspend_noirq(dev, state);
+		error = device_suspend_noirq(dev, state);
 		if (error) {
 			pm_dev_err(dev, state, " late", error);
 			break;
@@ -623,17 +611,17 @@ int device_suspend_noirq(pm_message_t st
 		dev->power.status = DPM_OFF_IRQ;
 	}
 	if (error)
-		device_resume_noirq(resume_event(state));
+		dpm_resume_noirq(resume_event(state));
 	return error;
 }
-EXPORT_SYMBOL_GPL(device_suspend_noirq);
+EXPORT_SYMBOL_GPL(dpm_suspend_noirq);
 
 /**
- *	suspend_device - Save state of one device.
+ *	device_suspend - Save state of one device.
  *	@dev:	Device.
  *	@state: PM transition of the system being carried out.
  */
-static int suspend_device(struct device *dev, pm_message_t state)
+static int device_suspend(struct device *dev, pm_message_t state)
 {
 	int error = 0;
 
@@ -700,7 +688,7 @@ static int dpm_suspend(pm_message_t stat
 		get_device(dev);
 		mutex_unlock(&dpm_list_mtx);
 
-		error = suspend_device(dev, state);
+		error = device_suspend(dev, state);
 
 		mutex_lock(&dpm_list_mtx);
 		if (error) {
@@ -719,11 +707,11 @@ static int dpm_suspend(pm_message_t stat
 }
 
 /**
- *	prepare_device - Execute the ->prepare() callback(s) for given device.
+ *	device_prepare - Execute the ->prepare() callback(s) for given device.
  *	@dev:	Device.
  *	@state: PM transition of the system being carried out.
  */
-static int prepare_device(struct device *dev, pm_message_t state)
+static int device_prepare(struct device *dev, pm_message_t state)
 {
 	int error = 0;
 
@@ -777,7 +765,7 @@ static int dpm_prepare(pm_message_t stat
 		dev->power.status = DPM_PREPARING;
 		mutex_unlock(&dpm_list_mtx);
 
-		error = prepare_device(dev, state);
+		error = device_prepare(dev, state);
 
 		mutex_lock(&dpm_list_mtx);
 		if (error) {
@@ -803,12 +791,12 @@ static int dpm_prepare(pm_message_t stat
 }
 
 /**
- *	device_suspend - Save state and stop all devices in system.
+ *	dpm_suspend_start - Save state and stop all devices in system.
  *	@state: PM transition of the system being carried out.
  *
  *	Prepare and suspend all devices.
  */
-int device_suspend(pm_message_t state)
+int dpm_suspend_start(pm_message_t state)
 {
 	int error;
 
@@ -818,7 +806,7 @@ int device_suspend(pm_message_t state)
 		error = dpm_suspend(state);
 	return error;
 }
-EXPORT_SYMBOL_GPL(device_suspend);
+EXPORT_SYMBOL_GPL(dpm_suspend_start);
 
 void __suspend_report_result(const char *function, void *fn, int ret)
 {
Index: usb-2.6/kernel/power/disk.c
===================================================================
--- usb-2.6.orig/kernel/power/disk.c
+++ usb-2.6/kernel/power/disk.c
@@ -217,13 +217,13 @@ static int create_image(int platform_mod
 
 	device_pm_lock();
 
-	/* At this point, device_suspend() has been called, but *not*
-	 * device_suspend_noirq(). We *must* call device_suspend_noirq() now.
+	/* At this point, dpm_suspend_start() has been called, but *not*
+	 * dpm_suspend_noirq(). We *must* call dpm_suspend_noirq() now.
 	 * Otherwise, drivers for some devices (e.g. interrupt controllers)
 	 * become desynchronized with the actual state of the hardware
 	 * at resume time, and evil weirdness ensues.
 	 */
-	error = device_suspend_noirq(PMSG_FREEZE);
+	error = dpm_suspend_noirq(PMSG_FREEZE);
 	if (error) {
 		printk(KERN_ERR "PM: Some devices failed to power down, "
 			"aborting hibernation\n");
@@ -264,7 +264,7 @@ static int create_image(int platform_mod
 
  Power_up:
 	sysdev_resume();
-	/* NOTE:  device_resume_noirq() is just a resume() for devices
+	/* NOTE:  dpm_resume_noirq() is just a resume() for devices
 	 * that suspended with irqs off ... no overall powerup.
 	 */
 
@@ -277,7 +277,7 @@ static int create_image(int platform_mod
  Platform_finish:
 	platform_finish(platform_mode);
 
-	device_resume_noirq(in_suspend ?
+	dpm_resume_noirq(in_suspend ?
 		(error ? PMSG_RECOVER : PMSG_THAW) : PMSG_RESTORE);
 
  Unlock:
@@ -309,7 +309,7 @@ int hibernation_snapshot(int platform_mo
 		goto Close;
 
 	suspend_console();
-	error = device_suspend(PMSG_FREEZE);
+	error = dpm_suspend_start(PMSG_FREEZE);
 	if (error)
 		goto Recover_platform;
 
@@ -320,7 +320,7 @@ int hibernation_snapshot(int platform_mo
 	/* Control returns here after successful restore */
 
  Resume_devices:
-	device_resume(in_suspend ?
+	dpm_resume_end(in_suspend ?
 		(error ? PMSG_RECOVER : PMSG_THAW) : PMSG_RESTORE);
 	resume_console();
  Close:
@@ -346,7 +346,7 @@ static int resume_target_kernel(bool pla
 
 	device_pm_lock();
 
-	error = device_suspend_noirq(PMSG_QUIESCE);
+	error = dpm_suspend_noirq(PMSG_QUIESCE);
 	if (error) {
 		printk(KERN_ERR "PM: Some devices failed to power down, "
 			"aborting resume\n");
@@ -401,7 +401,7 @@ static int resume_target_kernel(bool pla
  Cleanup:
 	platform_restore_cleanup(platform_mode);
 
-	device_resume_noirq(PMSG_RECOVER);
+	dpm_resume_noirq(PMSG_RECOVER);
 
  Unlock:
 	device_pm_unlock();
@@ -424,10 +424,10 @@ int hibernation_restore(int platform_mod
 
 	pm_prepare_console();
 	suspend_console();
-	error = device_suspend(PMSG_QUIESCE);
+	error = dpm_suspend_start(PMSG_QUIESCE);
 	if (!error) {
 		error = resume_target_kernel(platform_mode);
-		device_resume(PMSG_RECOVER);
+		dpm_resume_end(PMSG_RECOVER);
 	}
 	resume_console();
 	pm_restore_console();
@@ -457,7 +457,7 @@ int hibernation_platform_enter(void)
 
 	entering_platform_hibernation = true;
 	suspend_console();
-	error = device_suspend(PMSG_HIBERNATE);
+	error = dpm_suspend_start(PMSG_HIBERNATE);
 	if (error) {
 		if (hibernation_ops->recover)
 			hibernation_ops->recover();
@@ -466,7 +466,7 @@ int hibernation_platform_enter(void)
 
 	device_pm_lock();
 
-	error = device_suspend_noirq(PMSG_HIBERNATE);
+	error = dpm_suspend_noirq(PMSG_HIBERNATE);
 	if (error)
 		goto Unlock;
 
@@ -491,14 +491,14 @@ int hibernation_platform_enter(void)
  Platofrm_finish:
 	hibernation_ops->finish();
 
-	device_suspend_noirq(PMSG_RESTORE);
+	dpm_suspend_noirq(PMSG_RESTORE);
 
  Unlock:
 	device_pm_unlock();
 
  Resume_devices:
 	entering_platform_hibernation = false;
-	device_resume(PMSG_RESTORE);
+	dpm_resume_end(PMSG_RESTORE);
 	resume_console();
 
  Close:
Index: usb-2.6/kernel/power/main.c
===================================================================
--- usb-2.6.orig/kernel/power/main.c
+++ usb-2.6/kernel/power/main.c
@@ -297,7 +297,7 @@ static int suspend_enter(suspend_state_t
 			goto Done;
 	}
 
-	error = device_suspend_noirq(PMSG_SUSPEND);
+	error = dpm_suspend_noirq(PMSG_SUSPEND);
 	if (error) {
 		printk(KERN_ERR "PM: Some devices failed to power down\n");
 		goto Platfrom_finish;
@@ -337,7 +337,7 @@ static int suspend_enter(suspend_state_t
 		suspend_ops->wake();
 
  Power_up_devices:
-	device_resume_noirq(PMSG_RESUME);
+	dpm_resume_noirq(PMSG_RESUME);
 
  Platfrom_finish:
 	if (suspend_ops->finish)
@@ -368,7 +368,7 @@ int suspend_devices_and_enter(suspend_st
 	}
 	suspend_console();
 	suspend_test_start();
-	error = device_suspend(PMSG_SUSPEND);
+	error = dpm_suspend_start(PMSG_SUSPEND);
 	if (error) {
 		printk(KERN_ERR "PM: Some devices failed to suspend\n");
 		goto Recover_platform;
@@ -381,7 +381,7 @@ int suspend_devices_and_enter(suspend_st
 
  Resume_devices:
 	suspend_test_start();
-	device_resume(PMSG_RESUME);
+	dpm_resume_end(PMSG_RESUME);
 	suspend_test_finish("resume devices");
 	resume_console();
  Close:
Index: usb-2.6/kernel/kexec.c
===================================================================
--- usb-2.6.orig/kernel/kexec.c
+++ usb-2.6/kernel/kexec.c
@@ -1448,18 +1448,18 @@ int kernel_kexec(void)
 			goto Restore_console;
 		}
 		suspend_console();
-		error = device_suspend(PMSG_FREEZE);
+		error = dpm_suspend_start(PMSG_FREEZE);
 		if (error)
 			goto Resume_console;
 		device_pm_lock();
-		/* At this point, device_suspend() has been called,
-		 * but *not* device_suspend_noirq(). We *must* call
-		 * device_suspend_noirq() now.  Otherwise, drivers for
+		/* At this point, dpm_suspend_start() has been called,
+		 * but *not* dpm_suspend_noirq(). We *must* call
+		 * dpm_suspend_noirq() now.  Otherwise, drivers for
 		 * some devices (e.g. interrupt controllers) become
 		 * desynchronized with the actual state of the
 		 * hardware at resume time, and evil weirdness ensues.
 		 */
-		error = device_suspend_noirq(PMSG_FREEZE);
+		error = dpm_suspend_noirq(PMSG_FREEZE);
 		if (error)
 			goto Resume_devices;
 		error = disable_nonboot_cpus();
@@ -1487,10 +1487,10 @@ int kernel_kexec(void)
 		local_irq_enable();
  Enable_cpus:
 		enable_nonboot_cpus();
-		device_resume_noirq(PMSG_RESTORE);
+		dpm_resume_noirq(PMSG_RESTORE);
  Resume_devices:
 		device_pm_unlock();
-		device_resume(PMSG_RESTORE);
+		dpm_resume_end(PMSG_RESTORE);
  Resume_console:
 		resume_console();
 		thaw_processes();
Index: usb-2.6/arch/x86/kernel/apm_32.c
===================================================================
--- usb-2.6.orig/arch/x86/kernel/apm_32.c
+++ usb-2.6/arch/x86/kernel/apm_32.c
@@ -1233,9 +1233,9 @@ static int suspend(int vetoable)
 	int err;
 	struct apm_user	*as;
 
-	device_suspend(PMSG_SUSPEND);
+	dpm_suspend_start(PMSG_SUSPEND);
 
-	device_suspend_noirq(PMSG_SUSPEND);
+	dpm_suspend_noirq(PMSG_SUSPEND);
 
 	local_irq_disable();
 	sysdev_suspend(PMSG_SUSPEND);
@@ -1259,9 +1259,9 @@ static int suspend(int vetoable)
 	sysdev_resume();
 	local_irq_enable();
 
-	device_resume_noirq(PMSG_RESUME);
+	dpm_resume_noirq(PMSG_RESUME);
 
-	device_resume(PMSG_RESUME);
+	dpm_resume_end(PMSG_RESUME);
 	queue_event(APM_NORMAL_RESUME, NULL);
 	spin_lock(&user_list_lock);
 	for (as = user_list; as != NULL; as = as->next) {
@@ -1277,7 +1277,7 @@ static void standby(void)
 {
 	int err;
 
-	device_suspend_noirq(PMSG_SUSPEND);
+	dpm_suspend_noirq(PMSG_SUSPEND);
 
 	local_irq_disable();
 	sysdev_suspend(PMSG_SUSPEND);
@@ -1291,7 +1291,7 @@ static void standby(void)
 	sysdev_resume();
 	local_irq_enable();
 
-	device_resume_noirq(PMSG_RESUME);
+	dpm_resume_noirq(PMSG_RESUME);
 }
 
 static apm_event_t get_event(void)
@@ -1376,7 +1376,7 @@ static void check_events(void)
 			ignore_bounce = 1;
 			if ((event != APM_NORMAL_RESUME)
 			    || (ignore_normal_resume == 0)) {
-				device_resume(PMSG_RESUME);
+				dpm_resume_end(PMSG_RESUME);
 				queue_event(event, NULL);
 			}
 			ignore_normal_resume = 0;
Index: usb-2.6/drivers/xen/manage.c
===================================================================
--- usb-2.6.orig/drivers/xen/manage.c
+++ usb-2.6/drivers/xen/manage.c
@@ -43,7 +43,7 @@ static int xen_suspend(void *data)
 	if (err) {
 		printk(KERN_ERR "xen_suspend: sysdev_suspend failed: %d\n",
 			err);
-		device_resume_noirq(PMSG_RESUME);
+		dpm_resume_noirq(PMSG_RESUME);
 		return err;
 	}
 
@@ -69,7 +69,7 @@ static int xen_suspend(void *data)
 	}
 
 	sysdev_resume();
-	device_resume_noirq(PMSG_RESUME);
+	dpm_resume_noirq(PMSG_RESUME);
 
 	return 0;
 }
@@ -92,9 +92,9 @@ static void do_suspend(void)
 	}
 #endif
 
-	err = device_suspend(PMSG_SUSPEND);
+	err = dpm_suspend_start(PMSG_SUSPEND);
 	if (err) {
-		printk(KERN_ERR "xen suspend: device_suspend %d\n", err);
+		printk(KERN_ERR "xen suspend: dpm_suspend_start %d\n", err);
 		goto out;
 	}
 
@@ -102,9 +102,9 @@ static void do_suspend(void)
 	/* XXX use normal device tree? */
 	xenbus_suspend();
 
-	err = device_suspend_noirq(PMSG_SUSPEND);
+	err = dpm_suspend_noirq(PMSG_SUSPEND);
 	if (err) {
-		printk(KERN_ERR "device_suspend_noirq failed: %d\n", err);
+		printk(KERN_ERR "dpm_suspend_noirq failed: %d\n", err);
 		goto resume_devices;
 	}
 
@@ -120,10 +120,10 @@ static void do_suspend(void)
 	} else
 		xenbus_suspend_cancel();
 
-	device_resume_noirq(PMSG_RESUME);
+	dpm_resume_noirq(PMSG_RESUME);
 
 resume_devices:
-	device_resume(PMSG_RESUME);
+	dpm_resume_end(PMSG_RESUME);
 
 	/* Make sure timer events get retriggered on all CPUs */
 	clock_was_set();
