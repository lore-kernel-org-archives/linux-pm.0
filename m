From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 1/2] PM: Remove deprecated sysfs files
Date: Thu, 12 Jul 2007 16:55:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707121653440.2567-100000__42248.4157643796$1184273868$gmane$org@iolanthe.rowland.org>
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

This patch (as932) removes the deprecated sysfs .../power/state
attribute files.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Index: usb-2.6/kernel/power/Kconfig
===================================================================
--- usb-2.6.orig/kernel/power/Kconfig
+++ usb-2.6/kernel/power/Kconfig
@@ -65,18 +65,6 @@ config PM_TRACE
 	CAUTION: this option will cause your machine's real-time clock to be
 	set to an invalid time after a resume.
 
-config PM_SYSFS_DEPRECATED
-	bool "Driver model /sys/devices/.../power/state files (DEPRECATED)"
-	depends on PM && SYSFS
-	default n
-	help
-	  The driver model started out with a sysfs file intended to provide
-	  a userspace hook for device power management.  This feature has never
-	  worked very well, except for limited testing purposes, and so it will
-	  be removed.   It's not clear that a generic mechanism could really
-	  handle the wide variability of device power states; any replacements
-	  are likely to be bus or driver specific.
-
 config SOFTWARE_SUSPEND
 	bool "Software Suspend (Hibernation)"
 	depends on PM && SWAP && (((X86 || PPC64_SWSUSP) && (!SMP || SUSPEND_SMP)) || ((FRV || PPC32) && !SMP))
Index: usb-2.6/drivers/base/power/sysfs.c
===================================================================
--- usb-2.6.orig/drivers/base/power/sysfs.c
+++ usb-2.6/drivers/base/power/sysfs.c
@@ -7,69 +7,6 @@
 #include "power.h"
 
 
-#ifdef	CONFIG_PM_SYSFS_DEPRECATED
-
-/**
- *	state - Control current power state of device
- *
- *	show() returns the current power state of the device. '0' indicates
- *	the device is on. Other values (2) indicate the device is in some low
- *	power state.
- *
- *	store() sets the current power state, which is an integer valued
- *	0, 2, or 3.  Devices with bus.suspend_late(), or bus.resume_early()
- *	methods fail this operation; those methods couldn't be called.
- *	Otherwise,
- *
- *	- If the recorded dev->power.power_state.event matches the
- *	  target value, nothing is done.
- *	- If the recorded event code is nonzero, the device is reactivated
- *	  by calling bus.resume() and/or class.resume().
- *	- If the target value is nonzero, the device is suspended by
- *	  calling class.suspend() and/or bus.suspend() with event code
- *	  PM_EVENT_SUSPEND.
- *
- *	This mechanism is DEPRECATED and should only be used for testing.
- */
-
-static ssize_t state_show(struct device * dev, struct device_attribute *attr, char * buf)
-{
-	if (dev->power.power_state.event)
-		return sprintf(buf, "2\n");
-	else
-		return sprintf(buf, "0\n");
-}
-
-static ssize_t state_store(struct device * dev, struct device_attribute *attr, const char * buf, size_t n)
-{
-	pm_message_t state;
-	int error = -EINVAL;
-
-	/* disallow incomplete suspend sequences */
-	if (dev->bus && (dev->bus->suspend_late || dev->bus->resume_early))
-		return error;
-
-	state.event = PM_EVENT_SUSPEND;
-	/* Older apps expected to write "3" here - confused with PCI D3 */
-	if ((n == 1) && !strcmp(buf, "3"))
-		error = dpm_runtime_suspend(dev, state);
-
-	if ((n == 1) && !strcmp(buf, "2"))
-		error = dpm_runtime_suspend(dev, state);
-
-	if ((n == 1) && !strcmp(buf, "0")) {
-		dpm_runtime_resume(dev);
-		error = 0;
-	}
-
-	return error ? error : n;
-}
-
-static DEVICE_ATTR(state, 0644, state_show, state_store);
-
-
-#endif	/* CONFIG_PM_SYSFS_DEPRECATED */
-
 /*
  *	wakeup - Report/change current wakeup option for device
  *
@@ -143,9 +80,6 @@ static DEVICE_ATTR(wakeup, 0644, wake_sh
 
 
 static struct attribute * power_attrs[] = {
-#ifdef	CONFIG_PM_SYSFS_DEPRECATED
-	&dev_attr_state.attr,
-#endif
 	&dev_attr_wakeup.attr,
 	NULL,
 };
Index: usb-2.6/Documentation/feature-removal-schedule.txt
===================================================================
--- usb-2.6.orig/Documentation/feature-removal-schedule.txt
+++ usb-2.6/Documentation/feature-removal-schedule.txt
@@ -26,8 +26,7 @@ Who:	Hans Verkuil <hverkuil@xs4all.nl> a
 
 ---------------------------
 
-What:	/sys/devices/.../power/state
-	dev->power.power_state
+What:	dev->power.power_state
 	dpm_runtime_{suspend,resume)()
 When:	July 2007
 Why:	Broken design for runtime control over driver power states, confusing
