From: Shaohua Li <shaohua.li@intel.com>
Subject: [RFC] make /sys/bus/pci/devices/foo/power/state work
Date: Fri, 01 Jun 2007 10:42:45 +0800
Message-ID: <1180665765.27219.11.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
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
To: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

the interface /sys/bus/pci/devices/foo/power/state is marked as just for
test, but actually I need below fix to do test. If the interface will be
removed soon, please ignore the mail.

Index: 2.6.22-rc2/drivers/base/power/sysfs.c
===================================================================
--- 2.6.22-rc2.orig/drivers/base/power/sysfs.c	2007-05-23 09:15:14.000000000 +0800
+++ 2.6.22-rc2/drivers/base/power/sysfs.c	2007-05-24 11:48:24.000000000 +0800
@@ -45,19 +45,15 @@ static ssize_t state_store(struct device
 	pm_message_t state;
 	int error = -EINVAL;
 
-	/* disallow incomplete suspend sequences */
-	if (dev->bus && (dev->bus->suspend_late || dev->bus->resume_early))
-		return error;
-
 	state.event = PM_EVENT_SUSPEND;
 	/* Older apps expected to write "3" here - confused with PCI D3 */
-	if ((n == 1) && !strcmp(buf, "3"))
+	if (!strncmp(buf, "3", 1))
 		error = dpm_runtime_suspend(dev, state);
 
-	if ((n == 1) && !strcmp(buf, "2"))
+	if (!strncmp(buf, "2", 1))
 		error = dpm_runtime_suspend(dev, state);
 
-	if ((n == 1) && !strcmp(buf, "0")) {
+	if (!strncmp(buf, "0", 1)) {
 		dpm_runtime_resume(dev);
 		error = 0;
 	}
Index: 2.6.22-rc2/drivers/base/power/power.h
===================================================================
--- 2.6.22-rc2.orig/drivers/base/power/power.h	2007-05-23 09:15:14.000000000 +0800
+++ 2.6.22-rc2/drivers/base/power/power.h	2007-05-24 11:41:51.000000000 +0800
@@ -56,12 +56,13 @@ extern void dpm_sysfs_remove(struct devi
 extern void dpm_resume(void);
 extern void dpm_power_up(void);
 extern int resume_device(struct device *);
+extern int resume_device_early(struct device *);
 
 /*
  * suspend.c
  */
 extern int suspend_device(struct device *, pm_message_t);
-
+extern int suspend_device_late(struct device *, pm_message_t);
 
 /*
  * runtime.c
Index: 2.6.22-rc2/drivers/base/power/runtime.c
===================================================================
--- 2.6.22-rc2.orig/drivers/base/power/runtime.c	2007-05-24 10:56:47.000000000 +0800
+++ 2.6.22-rc2/drivers/base/power/runtime.c	2007-05-24 11:43:15.000000000 +0800
@@ -33,6 +33,9 @@ static void runtime_resume(struct device
 void dpm_runtime_resume(struct device * dev)
 {
 	down(&dpm_sem);
+	local_irq_disable();
+	resume_device_early(dev);
+	local_irq_enable();
 	runtime_resume(dev);
 	up(&dpm_sem);
 }
@@ -56,8 +59,15 @@ int dpm_runtime_suspend(struct device * 
 	if (dev->power.power_state.event)
 		runtime_resume(dev);
 
-	if (!(error = suspend_device(dev, state)))
-		dev->power.power_state = state;
+	if (!(error = suspend_device(dev, state))) {
+		local_irq_disable();
+		error = suspend_device_late(dev, state);
+		local_irq_enable();
+		if (!error)
+			dev->power.power_state = state;
+		else
+			resume_device(dev);
+	}
  Done:
 	up(&dpm_sem);
 	return error;
Index: 2.6.22-rc2/drivers/base/power/resume.c
===================================================================
--- 2.6.22-rc2.orig/drivers/base/power/resume.c	2007-05-24 11:33:23.000000000 +0800
+++ 2.6.22-rc2/drivers/base/power/resume.c	2007-05-24 11:44:39.000000000 +0800
@@ -59,7 +59,7 @@ int resume_device(struct device * dev)
 }
 
 
-static int resume_device_early(struct device * dev)
+int resume_device_early(struct device * dev)
 {
 	int error = 0;
 
Index: 2.6.22-rc2/drivers/base/power/suspend.c
===================================================================
--- 2.6.22-rc2.orig/drivers/base/power/suspend.c	2007-05-24 11:33:19.000000000 +0800
+++ 2.6.22-rc2/drivers/base/power/suspend.c	2007-05-24 11:44:20.000000000 +0800
@@ -111,7 +111,7 @@ int suspend_device(struct device * dev, 
  * running. We can't do down() on a semaphore (and we don't
  * need the protection)
  */
-static int suspend_device_late(struct device *dev, pm_message_t state)
+int suspend_device_late(struct device *dev, pm_message_t state)
 {
 	int error = 0;
 
