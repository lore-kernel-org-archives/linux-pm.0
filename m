From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] pm: rename device_power_down/up()
Date: Thu, 14 May 2009 21:23:56 +0900
Message-ID: <20090514122356.19418.31612.sendpatchset@rx1.opensource.se>
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
To: linux-pm@lists.linux-foundation.org
Cc: akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Rename the functions performing "_noirq" dev_pm_ops
operations from device_power_down() and device_power_up()
to device_suspend_noirq() and device_resume_noirq().

The new function names are chosen to show that the functions
are responsible for calling the _noirq() versions to finalize
the suspend/resume operation. The current function names do
not perform power down/up anymore so the names may be misleading.

Global function renames:
- device_power_down() -> device_suspend_noirq()
- device_power_up() -> device_resume_noirq()

Static function renames:
- suspend_device_noirq() -> __device_suspend_noirq()
- resume_device_noirq() -> __device_resume_noirq() 

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Please excuse the cosmetic nature of this patch.
 Feel free to pick up the patch if you find the new names better.
 If not please just ignore it, I have no interest in discussing names.

 Compile tested with -next on x86 using i386_defconfig and
 x86_64_defconfig and on SuperH with sh7724_generic_defconfig.

 Thanks for your help.

 arch/x86/kernel/apm_32.c  |    8 ++++----
 drivers/base/power/main.c |   26 +++++++++++++-------------
 drivers/xen/manage.c      |   10 +++++-----
 include/linux/pm.h        |    4 ++--
 kernel/kexec.c            |    8 ++++----
 kernel/power/disk.c       |   16 ++++++++--------
 kernel/power/main.c       |    4 ++--
 7 files changed, 38 insertions(+), 38 deletions(-)

--- 0001/arch/x86/kernel/apm_32.c
+++ work/arch/x86/kernel/apm_32.c	2009-05-13 18:27:32.000000000 +0900
@@ -1235,7 +1235,7 @@ static int suspend(int vetoable)
 
 	device_suspend(PMSG_SUSPEND);
 
-	device_power_down(PMSG_SUSPEND);
+	device_suspend_noirq(PMSG_SUSPEND);
 
 	local_irq_disable();
 	sysdev_suspend(PMSG_SUSPEND);
@@ -1259,7 +1259,7 @@ static int suspend(int vetoable)
 	sysdev_resume();
 	local_irq_enable();
 
-	device_power_up(PMSG_RESUME);
+	device_resume_noirq(PMSG_RESUME);
 
 	device_resume(PMSG_RESUME);
 	queue_event(APM_NORMAL_RESUME, NULL);
@@ -1277,7 +1277,7 @@ static void standby(void)
 {
 	int err;
 
-	device_power_down(PMSG_SUSPEND);
+	device_suspend_noirq(PMSG_SUSPEND);
 
 	local_irq_disable();
 	sysdev_suspend(PMSG_SUSPEND);
@@ -1291,7 +1291,7 @@ static void standby(void)
 	sysdev_resume();
 	local_irq_enable();
 
-	device_power_up(PMSG_RESUME);
+	device_resume_noirq(PMSG_RESUME);
 }
 
 static apm_event_t get_event(void)
--- 0001/drivers/base/power/main.c
+++ work/drivers/base/power/main.c	2009-05-13 18:32:44.000000000 +0900
@@ -315,13 +315,13 @@ static void pm_dev_err(struct device *de
 /*------------------------- Resume routines -------------------------*/
 
 /**
- *	resume_device_noirq - Power on one device (early resume).
+ *	__device_resume_noirq - Power on one device (early resume).
  *	@dev:	Device.
  *	@state: PM transition of the system being carried out.
  *
  *	Must be called with interrupts disabled.
  */
-static int resume_device_noirq(struct device *dev, pm_message_t state)
+static int __device_resume_noirq(struct device *dev, pm_message_t state)
 {
 	int error = 0;
 
@@ -362,25 +362,25 @@ static void dpm_power_up(pm_message_t st
 			int error;
 
 			dev->power.status = DPM_OFF;
-			error = resume_device_noirq(dev, state);
+			error = __device_resume_noirq(dev, state);
 			if (error)
 				pm_dev_err(dev, state, " early", error);
 		}
 }
 
 /**
- *	device_power_up - Turn on all devices that need special attention.
+ *	device_resume_noirq - Turn on all devices that need special attention.
  *	@state: PM transition of the system being carried out.
  *
  *	Call the "early" resume handlers and enable device drivers to receive
  *	interrupts.
  */
-void device_power_up(pm_message_t state)
+void device_resume_noirq(pm_message_t state)
 {
 	dpm_power_up(state);
 	resume_device_irqs();
 }
-EXPORT_SYMBOL_GPL(device_power_up);
+EXPORT_SYMBOL_GPL(device_resume_noirq);
 
 /**
  *	resume_device - Restore state for one device.
@@ -575,13 +575,13 @@ static pm_message_t resume_event(pm_mess
 }
 
 /**
- *	suspend_device_noirq - Shut down one device (late suspend).
+ *	__device_suspend_noirq - Shut down one device (late suspend).
  *	@dev:	Device.
  *	@state: PM transition of the system being carried out.
  *
  *	This is called with interrupts off and only a single CPU running.
  */
-static int suspend_device_noirq(struct device *dev, pm_message_t state)
+static int __device_suspend_noirq(struct device *dev, pm_message_t state)
 {
 	int error = 0;
 
@@ -600,7 +600,7 @@ static int suspend_device_noirq(struct d
 }
 
 /**
- *	device_power_down - Shut down special devices.
+ *	device_suspend_noirq - Shut down special devices.
  *	@state: PM transition of the system being carried out.
  *
  *	Prevent device drivers from receiving interrupts and call the "late"
@@ -608,14 +608,14 @@ static int suspend_device_noirq(struct d
  *
  *	Must be called under dpm_list_mtx.
  */
-int device_power_down(pm_message_t state)
+int device_suspend_noirq(pm_message_t state)
 {
 	struct device *dev;
 	int error = 0;
 
 	suspend_device_irqs();
 	list_for_each_entry_reverse(dev, &dpm_list, power.entry) {
-		error = suspend_device_noirq(dev, state);
+		error = __device_suspend_noirq(dev, state);
 		if (error) {
 			pm_dev_err(dev, state, " late", error);
 			break;
@@ -623,10 +623,10 @@ int device_power_down(pm_message_t state
 		dev->power.status = DPM_OFF_IRQ;
 	}
 	if (error)
-		device_power_up(resume_event(state));
+		device_resume_noirq(resume_event(state));
 	return error;
 }
-EXPORT_SYMBOL_GPL(device_power_down);
+EXPORT_SYMBOL_GPL(device_suspend_noirq);
 
 /**
  *	suspend_device - Save state of one device.
--- 0001/drivers/xen/manage.c
+++ work/drivers/xen/manage.c	2009-05-13 18:28:47.000000000 +0900
@@ -43,7 +43,7 @@ static int xen_suspend(void *data)
 	if (err) {
 		printk(KERN_ERR "xen_suspend: sysdev_suspend failed: %d\n",
 			err);
-		device_power_up(PMSG_RESUME);
+		device_resume_noirq(PMSG_RESUME);
 		return err;
 	}
 
@@ -69,7 +69,7 @@ static int xen_suspend(void *data)
 	}
 
 	sysdev_resume();
-	device_power_up(PMSG_RESUME);
+	device_resume_noirq(PMSG_RESUME);
 
 	return 0;
 }
@@ -102,9 +102,9 @@ static void do_suspend(void)
 	/* XXX use normal device tree? */
 	xenbus_suspend();
 
-	err = device_power_down(PMSG_SUSPEND);
+	err = device_suspend_noirq(PMSG_SUSPEND);
 	if (err) {
-		printk(KERN_ERR "device_power_down failed: %d\n", err);
+		printk(KERN_ERR "device_suspend_noirq failed: %d\n", err);
 		goto resume_devices;
 	}
 
@@ -120,7 +120,7 @@ static void do_suspend(void)
 	} else
 		xenbus_suspend_cancel();
 
-	device_power_up(PMSG_RESUME);
+	device_resume_noirq(PMSG_RESUME);
 
 resume_devices:
 	device_resume(PMSG_RESUME);
--- 0001/include/linux/pm.h
+++ work/include/linux/pm.h	2009-05-13 18:23:04.000000000 +0900
@@ -382,12 +382,12 @@ struct dev_pm_info {
 #ifdef CONFIG_PM_SLEEP
 extern void device_pm_lock(void);
 extern int sysdev_resume(void);
-extern void device_power_up(pm_message_t state);
+extern void device_resume_noirq(pm_message_t state);
 extern void device_resume(pm_message_t state);
 
 extern void device_pm_unlock(void);
 extern int sysdev_suspend(pm_message_t state);
-extern int device_power_down(pm_message_t state);
+extern int device_suspend_noirq(pm_message_t state);
 extern int device_suspend(pm_message_t state);
 extern int device_prepare_suspend(pm_message_t state);
 
--- 0001/kernel/kexec.c
+++ work/kernel/kexec.c	2009-05-13 18:22:14.000000000 +0900
@@ -1453,13 +1453,13 @@ int kernel_kexec(void)
 			goto Resume_console;
 		device_pm_lock();
 		/* At this point, device_suspend() has been called,
-		 * but *not* device_power_down(). We *must*
-		 * device_power_down() now.  Otherwise, drivers for
+		 * but *not* device_suspend_noirq(). We *must* call
+		 * device_suspend_noirq() now.  Otherwise, drivers for
 		 * some devices (e.g. interrupt controllers) become
 		 * desynchronized with the actual state of the
 		 * hardware at resume time, and evil weirdness ensues.
 		 */
-		error = device_power_down(PMSG_FREEZE);
+		error = device_suspend_noirq(PMSG_FREEZE);
 		if (error)
 			goto Resume_devices;
 		error = disable_nonboot_cpus();
@@ -1487,7 +1487,7 @@ int kernel_kexec(void)
 		local_irq_enable();
  Enable_cpus:
 		enable_nonboot_cpus();
-		device_power_up(PMSG_RESTORE);
+		device_resume_noirq(PMSG_RESTORE);
  Resume_devices:
 		device_pm_unlock();
 		device_resume(PMSG_RESTORE);
--- 0001/kernel/power/disk.c
+++ work/kernel/power/disk.c	2009-05-13 18:26:33.000000000 +0900
@@ -218,12 +218,12 @@ static int create_image(int platform_mod
 	device_pm_lock();
 
 	/* At this point, device_suspend() has been called, but *not*
-	 * device_power_down(). We *must* call device_power_down() now.
+	 * device_suspend_noirq(). We *must* call device_suspend_noirq() now.
 	 * Otherwise, drivers for some devices (e.g. interrupt controllers)
 	 * become desynchronized with the actual state of the hardware
 	 * at resume time, and evil weirdness ensues.
 	 */
-	error = device_power_down(PMSG_FREEZE);
+	error = device_suspend_noirq(PMSG_FREEZE);
 	if (error) {
 		printk(KERN_ERR "PM: Some devices failed to power down, "
 			"aborting hibernation\n");
@@ -264,7 +264,7 @@ static int create_image(int platform_mod
 
  Power_up:
 	sysdev_resume();
-	/* NOTE:  device_power_up() is just a resume() for devices
+	/* NOTE:  device_resume_noirq() is just a resume() for devices
 	 * that suspended with irqs off ... no overall powerup.
 	 */
 
@@ -277,7 +277,7 @@ static int create_image(int platform_mod
  Platform_finish:
 	platform_finish(platform_mode);
 
-	device_power_up(in_suspend ?
+	device_resume_noirq(in_suspend ?
 		(error ? PMSG_RECOVER : PMSG_THAW) : PMSG_RESTORE);
 
  Unlock:
@@ -346,7 +346,7 @@ static int resume_target_kernel(bool pla
 
 	device_pm_lock();
 
-	error = device_power_down(PMSG_QUIESCE);
+	error = device_suspend_noirq(PMSG_QUIESCE);
 	if (error) {
 		printk(KERN_ERR "PM: Some devices failed to power down, "
 			"aborting resume\n");
@@ -401,7 +401,7 @@ static int resume_target_kernel(bool pla
  Cleanup:
 	platform_restore_cleanup(platform_mode);
 
-	device_power_up(PMSG_RECOVER);
+	device_resume_noirq(PMSG_RECOVER);
 
  Unlock:
 	device_pm_unlock();
@@ -466,7 +466,7 @@ int hibernation_platform_enter(void)
 
 	device_pm_lock();
 
-	error = device_power_down(PMSG_HIBERNATE);
+	error = device_suspend_noirq(PMSG_HIBERNATE);
 	if (error)
 		goto Unlock;
 
@@ -491,7 +491,7 @@ int hibernation_platform_enter(void)
  Platofrm_finish:
 	hibernation_ops->finish();
 
-	device_power_up(PMSG_RESTORE);
+	device_suspend_noirq(PMSG_RESTORE);
 
  Unlock:
 	device_pm_unlock();
--- 0001/kernel/power/main.c
+++ work/kernel/power/main.c	2009-05-13 18:29:45.000000000 +0900
@@ -297,7 +297,7 @@ static int suspend_enter(suspend_state_t
 			goto Done;
 	}
 
-	error = device_power_down(PMSG_SUSPEND);
+	error = device_suspend_noirq(PMSG_SUSPEND);
 	if (error) {
 		printk(KERN_ERR "PM: Some devices failed to power down\n");
 		goto Platfrom_finish;
@@ -337,7 +337,7 @@ static int suspend_enter(suspend_state_t
 		suspend_ops->wake();
 
  Power_up_devices:
-	device_power_up(PMSG_RESUME);
+	device_resume_noirq(PMSG_RESUME);
 
  Platfrom_finish:
 	if (suspend_ops->finish)
