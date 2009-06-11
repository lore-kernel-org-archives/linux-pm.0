From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 09/19] PM: Rename device_power_down/up()
Date: Thu, 11 Jun 2009 22:01:06 +0000 (UTC)
Message-ID: <S4AoGnG.A.D7H.mZXMKB__38318.2906349704$1244757666$gmane$org@chimera>
References: <0615007ad8090a890586d530b5d3bb98da566014.1244752872.git.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Date: Thu Jun 11 23:25:58 CEST 2009
In-Reply-To: <0615007ad8090a890586d530b5d3bb98da566014.1244752872.git.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM List <linux-pm@lists.linux-foundation.org>
Cc: Sergio Luis <sergio@larces.uece.br>, Lauro Salmito <laurosalmito@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Magnus Damm <damm@igel.co.jp>, Ingo Molnar <mingo@elte.hu>, Wu Fengguang <fengguang.wu@intel.com>, Jaswinder Singh Rajput <jaswinder@kernel.org>
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
Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
Acked-by: Len Brown <lenb@kernel.org>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/x86/kernel/apm_32.c  |    8 ++++----
 drivers/base/power/main.c |   26 +++++++++++++-------------
 drivers/xen/manage.c      |   10 +++++-----
 include/linux/pm.h        |    4 ++--
 kernel/kexec.c            |    8 ++++----
 kernel/power/disk.c       |   16 ++++++++--------
 kernel/power/main.c       |    4 ++--
 7 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
index 49e0939..31ae547 100644
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
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
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 3e4bc69..c5a35bc 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -315,13 +315,13 @@ static void pm_dev_err(struct device *dev, pm_message_t state, char *info,
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
 
@@ -363,7 +363,7 @@ static void dpm_power_up(pm_message_t state)
 			int error;
 
 			dev->power.status = DPM_OFF;
-			error = resume_device_noirq(dev, state);
+			error = __device_resume_noirq(dev, state);
 			if (error)
 				pm_dev_err(dev, state, " early", error);
 		}
@@ -371,18 +371,18 @@ static void dpm_power_up(pm_message_t state)
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
@@ -577,13 +577,13 @@ static pm_message_t resume_event(pm_message_t sleep_state)
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
 
@@ -602,7 +602,7 @@ static int suspend_device_noirq(struct device *dev, pm_message_t state)
 }
 
 /**
- *	device_power_down - Shut down special devices.
+ *	device_suspend_noirq - Shut down special devices.
  *	@state: PM transition of the system being carried out.
  *
  *	Prevent device drivers from receiving interrupts and call the "late"
@@ -610,7 +610,7 @@ static int suspend_device_noirq(struct device *dev, pm_message_t state)
  *
  *	Must be called under dpm_list_mtx.
  */
-int device_power_down(pm_message_t state)
+int device_suspend_noirq(pm_message_t state)
 {
 	struct device *dev;
 	int error = 0;
@@ -618,7 +618,7 @@ int device_power_down(pm_message_t state)
 	suspend_device_irqs();
 	mutex_lock(&dpm_list_mtx);
 	list_for_each_entry_reverse(dev, &dpm_list, power.entry) {
-		error = suspend_device_noirq(dev, state);
+		error = __device_suspend_noirq(dev, state);
 		if (error) {
 			pm_dev_err(dev, state, " late", error);
 			break;
@@ -627,10 +627,10 @@ int device_power_down(pm_message_t state)
 	}
 	mutex_unlock(&dpm_list_mtx);
 	if (error)
-		device_power_up(resume_event(state));
+		device_resume_noirq(resume_event(state));
 	return error;
 }
-EXPORT_SYMBOL_GPL(device_power_down);
+EXPORT_SYMBOL_GPL(device_suspend_noirq);
 
 /**
  *	suspend_device - Save state of one device.
diff --git a/drivers/xen/manage.c b/drivers/xen/manage.c
index fddc202..d5b327a 100644
--- a/drivers/xen/manage.c
+++ b/drivers/xen/manage.c
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
@@ -101,9 +101,9 @@ static void do_suspend(void)
 	printk(KERN_DEBUG "suspending xenstore...\n");
 	xs_suspend();
 
-	err = device_power_down(PMSG_SUSPEND);
+	err = device_suspend_noirq(PMSG_SUSPEND);
 	if (err) {
-		printk(KERN_ERR "device_power_down failed: %d\n", err);
+		printk(KERN_ERR "device_suspend_noirq failed: %d\n", err);
 		goto resume_devices;
 	}
 
@@ -119,7 +119,7 @@ static void do_suspend(void)
 	} else
 		xs_suspend_cancel();
 
-	device_power_up(PMSG_RESUME);
+	device_resume_noirq(PMSG_RESUME);
 
 resume_devices:
 	device_resume(PMSG_RESUME);
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 1d4e2d2..2170252 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
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
 
diff --git a/kernel/kexec.c b/kernel/kexec.c
index e498377..5a3da87 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1452,13 +1452,13 @@ int kernel_kexec(void)
 		if (error)
 			goto Resume_console;
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
@@ -1486,7 +1486,7 @@ int kernel_kexec(void)
 		local_irq_enable();
  Enable_cpus:
 		enable_nonboot_cpus();
-		device_power_up(PMSG_RESTORE);
+		device_resume_noirq(PMSG_RESTORE);
  Resume_devices:
 		device_resume(PMSG_RESTORE);
  Resume_console:
diff --git a/kernel/power/disk.c b/kernel/power/disk.c
index 5cb080e..1c18bc8 100644
--- a/kernel/power/disk.c
+++ b/kernel/power/disk.c
@@ -216,12 +216,12 @@ static int create_image(int platform_mode)
 		return error;
 
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
@@ -262,7 +262,7 @@ static int create_image(int platform_mode)
 
  Power_up:
 	sysdev_resume();
-	/* NOTE:  device_power_up() is just a resume() for devices
+	/* NOTE:  device_resume_noirq() is just a resume() for devices
 	 * that suspended with irqs off ... no overall powerup.
 	 */
 
@@ -275,7 +275,7 @@ static int create_image(int platform_mode)
  Platform_finish:
 	platform_finish(platform_mode);
 
-	device_power_up(in_suspend ?
+	device_resume_noirq(in_suspend ?
 		(error ? PMSG_RECOVER : PMSG_THAW) : PMSG_RESTORE);
 
 	return error;
@@ -339,7 +339,7 @@ static int resume_target_kernel(bool platform_mode)
 {
 	int error;
 
-	error = device_power_down(PMSG_QUIESCE);
+	error = device_suspend_noirq(PMSG_QUIESCE);
 	if (error) {
 		printk(KERN_ERR "PM: Some devices failed to power down, "
 			"aborting resume\n");
@@ -394,7 +394,7 @@ static int resume_target_kernel(bool platform_mode)
  Cleanup:
 	platform_restore_cleanup(platform_mode);
 
-	device_power_up(PMSG_RECOVER);
+	device_resume_noirq(PMSG_RECOVER);
 
 	return error;
 }
@@ -454,7 +454,7 @@ int hibernation_platform_enter(void)
 		goto Resume_devices;
 	}
 
-	error = device_power_down(PMSG_HIBERNATE);
+	error = device_suspend_noirq(PMSG_HIBERNATE);
 	if (error)
 		goto Resume_devices;
 
@@ -479,7 +479,7 @@ int hibernation_platform_enter(void)
  Platofrm_finish:
 	hibernation_ops->finish();
 
-	device_power_up(PMSG_RESTORE);
+	device_suspend_noirq(PMSG_RESTORE);
 
  Resume_devices:
 	entering_platform_hibernation = false;
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 8680282..2f6638e 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -295,7 +295,7 @@ static int suspend_enter(suspend_state_t state)
 			return error;
 	}
 
-	error = device_power_down(PMSG_SUSPEND);
+	error = device_suspend_noirq(PMSG_SUSPEND);
 	if (error) {
 		printk(KERN_ERR "PM: Some devices failed to power down\n");
 		goto Platfrom_finish;
@@ -335,7 +335,7 @@ static int suspend_enter(suspend_state_t state)
 		suspend_ops->wake();
 
  Power_up_devices:
-	device_power_up(PMSG_RESUME);
+	device_resume_noirq(PMSG_RESUME);
 
  Platfrom_finish:
 	if (suspend_ops->finish)
-- 
1.5.2.4
