From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 2/2] PM: remove deprecated dpm_runtime_* routines
Date: Thu, 12 Jul 2007 16:57:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707121655070.2567-100000__38692.8443833769$1184273978$gmane$org@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
To: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-pcmcia@lists.infradead.org, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-pm@vger.kernel.org

This patch (as933) removes the deprecated dpm_runtime_suspend() and
dpm_runtime_resume() routines from the PM core.  The only user of
those routines is the PCMCIA ds driver; local replacements are added.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
CC: Dominik Brodowski <linux@dominikbrodowski.net>

---

Dominik, I haven't been able to test the changes to
drivers/pcmcia/ds.c.  Please verify that I haven't messed anything up.


Index: usb-2.6/drivers/base/power/Makefile
===================================================================
--- usb-2.6.orig/drivers/base/power/Makefile
+++ usb-2.6/drivers/base/power/Makefile
@@ -1,5 +1,5 @@
 obj-y			:= shutdown.o
-obj-$(CONFIG_PM)	+= main.o suspend.o resume.o runtime.o sysfs.o
+obj-$(CONFIG_PM)	+= main.o suspend.o resume.o sysfs.o
 obj-$(CONFIG_PM_TRACE)	+= trace.o
 
 ifeq ($(CONFIG_DEBUG_DRIVER),y)
Index: usb-2.6/drivers/base/power/power.h
===================================================================
--- usb-2.6.orig/drivers/base/power/power.h
+++ usb-2.6/drivers/base/power/power.h
@@ -62,11 +62,6 @@ extern int resume_device(struct device *
  */
 extern int suspend_device(struct device *, pm_message_t);
 
-
-/*
- * runtime.c
- */
-
 #else /* CONFIG_PM */
 
 
Index: usb-2.6/drivers/base/power/runtime.c
===================================================================
--- usb-2.6.orig/drivers/base/power/runtime.c
+++ /dev/null
@@ -1,85 +0,0 @@
-/*
- * drivers/base/power/runtime.c - Handling dynamic device power management.
- *
- * Copyright (c) 2003 Patrick Mochel
- * Copyright (c) 2003 Open Source Development Lab
- *
- */
-
-#include <linux/device.h>
-#include "power.h"
-
-
-static void runtime_resume(struct device * dev)
-{
-	dev_dbg(dev, "resuming\n");
-	if (!dev->power.power_state.event)
-		return;
-	if (!resume_device(dev))
-		dev->power.power_state = PMSG_ON;
-}
-
-
-/**
- *	dpm_runtime_resume - Power one device back on.
- *	@dev:	Device.
- *
- *	Bring one device back to the on state by first powering it
- *	on, then restoring state. We only operate on devices that aren't
- *	already on.
- *	FIXME: We need to handle devices that are in an unknown state.
- */
-
-void dpm_runtime_resume(struct device * dev)
-{
-	mutex_lock(&dpm_mtx);
-	runtime_resume(dev);
-	mutex_unlock(&dpm_mtx);
-}
-EXPORT_SYMBOL(dpm_runtime_resume);
-
-
-/**
- *	dpm_runtime_suspend - Put one device in low-power state.
- *	@dev:	Device.
- *	@state:	State to enter.
- */
-
-int dpm_runtime_suspend(struct device * dev, pm_message_t state)
-{
-	int error = 0;
-
-	mutex_lock(&dpm_mtx);
-	if (dev->power.power_state.event == state.event)
-		goto Done;
-
-	if (dev->power.power_state.event)
-		runtime_resume(dev);
-
-	if (!(error = suspend_device(dev, state)))
-		dev->power.power_state = state;
- Done:
-	mutex_unlock(&dpm_mtx);
-	return error;
-}
-EXPORT_SYMBOL(dpm_runtime_suspend);
-
-
-#if 0
-/**
- *	dpm_set_power_state - Update power_state field.
- *	@dev:	Device.
- *	@state:	Power state device is in.
- *
- *	This is an update mechanism for drivers to notify the core
- *	what power state a device is in. Device probing code may not
- *	always be able to tell, but we need accurate information to
- *	work reliably.
- */
-void dpm_set_power_state(struct device * dev, pm_message_t state)
-{
-	mutex_lock(&dpm_mtx);
-	dev->power.power_state = state;
-	mutex_unlock(&dpm_mtx);
-}
-#endif  /*  0  */
Index: usb-2.6/include/linux/pm.h
===================================================================
--- usb-2.6.orig/include/linux/pm.h
+++ usb-2.6/include/linux/pm.h
@@ -284,8 +284,6 @@ extern int device_prepare_suspend(pm_mes
 #define device_may_wakeup(dev) \
 	(device_can_wakeup(dev) && (dev)->power.should_wakeup)
 
-extern int dpm_runtime_suspend(struct device *, pm_message_t);
-extern void dpm_runtime_resume(struct device *);
 extern void __suspend_report_result(const char *function, void *fn, int ret);
 
 #define suspend_report_result(fn, ret)					\
@@ -317,15 +315,6 @@ static inline int device_suspend(pm_mess
 #define device_set_wakeup_enable(dev,val)	do{}while(0)
 #define device_may_wakeup(dev)			(0)
 
-static inline int dpm_runtime_suspend(struct device * dev, pm_message_t state)
-{
-	return 0;
-}
-
-static inline void dpm_runtime_resume(struct device * dev)
-{
-}
-
 #define suspend_report_result(fn, ret) do { } while (0)
 
 static inline int call_platform_enable_wakeup(struct device *dev, int is_on)
Index: usb-2.6/Documentation/feature-removal-schedule.txt
===================================================================
--- usb-2.6.orig/Documentation/feature-removal-schedule.txt
+++ usb-2.6/Documentation/feature-removal-schedule.txt
@@ -27,7 +27,6 @@ Who:	Hans Verkuil <hverkuil@xs4all.nl> a
 ---------------------------
 
 What:	dev->power.power_state
-	dpm_runtime_{suspend,resume)()
 When:	July 2007
 Why:	Broken design for runtime control over driver power states, confusing
 	driver-internal runtime power management with:  mechanisms to support
Index: usb-2.6/drivers/pcmcia/ds.c
===================================================================
--- usb-2.6.orig/drivers/pcmcia/ds.c
+++ usb-2.6/drivers/pcmcia/ds.c
@@ -1127,6 +1127,34 @@ static int pcmcia_bus_uevent(struct devi
 
 #endif
 
+/************************ runtime PM support ***************************/
+
+static int pcmcia_dev_suspend(struct device *dev, pm_message_t state);
+static int pcmcia_dev_resume(struct device *dev);
+
+static int runtime_suspend(struct device *dev)
+{
+	int rc;
+
+	down(&dev->sem);
+	rc = pcmcia_dev_suspend(dev, PMSG_SUSPEND);
+	up(&dev->sem);
+	if (!rc)
+		dev->power.power_state.event = PM_EVENT_SUSPEND;
+	return rc;
+}
+
+static void runtime_resume(struct device *dev)
+{
+	int rc;
+
+	down(&dev->sem);
+	rc = pcmcia_dev_resume(dev);
+	up(&dev->sem);
+	if (!rc)
+		dev->power.power_state.event = PM_EVENT_ON;
+}
+
 /************************ per-device sysfs output ***************************/
 
 #define pcmcia_device_attr(field, test, format)				\
@@ -1173,9 +1201,9 @@ static ssize_t pcmcia_store_pm_state(str
                 return -EINVAL;
 
 	if ((!p_dev->suspended) && !strncmp(buf, "off", 3))
-		ret = dpm_runtime_suspend(dev, PMSG_SUSPEND);
+		ret = runtime_suspend(dev);
 	else if (p_dev->suspended && !strncmp(buf, "on", 2))
-		dpm_runtime_resume(dev);
+		runtime_resume(dev);
 
 	return ret ? ret : count;
 }
@@ -1312,10 +1340,10 @@ static int pcmcia_bus_suspend_callback(s
 	struct pcmcia_socket *skt = _data;
 	struct pcmcia_device *p_dev = to_pcmcia_dev(dev);
 
-	if (p_dev->socket != skt)
+	if (p_dev->socket != skt || p_dev->suspended)
 		return 0;
 
-	return dpm_runtime_suspend(dev, PMSG_SUSPEND);
+	return runtime_suspend(dev);
 }
 
 static int pcmcia_bus_resume_callback(struct device *dev, void * _data)
@@ -1323,10 +1351,10 @@ static int pcmcia_bus_resume_callback(st
 	struct pcmcia_socket *skt = _data;
 	struct pcmcia_device *p_dev = to_pcmcia_dev(dev);
 
-	if (p_dev->socket != skt)
+	if (p_dev->socket != skt || !p_dev->suspended)
 		return 0;
 
-	dpm_runtime_resume(dev);
+	runtime_resume(dev);
 
 	return 0;
 }
