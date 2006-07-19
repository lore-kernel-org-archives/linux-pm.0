From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.18-rc2-mm 1/2] PM: make
	/sys/devices/.../power/state optional
Date: Wed, 19 Jul 2006 13:37:01 -0700
Message-ID: <200607191337.02365.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ufpvE5ACnZ4yIyU"
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linux-pm mailing list <linux-pm@lists.osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>
List-Id: linux-pm@vger.kernel.org

--Boundary-00=_ufpvE5ACnZ4yIyU
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

There seems to be a consensus on linux-pm that the sysfs power/state files
are the wrong approach to userspace having control over runtime PM.  Not
that there's agreement on what such controls _should_ look like, or even
that there should be such controls for purposes other than testing...

So here's a patch that just makes it easy to get rid of this misfeature.
It'll help flush out any userspace software that really thinks it needs that
mechanism; PCMCIA seems to no longer be in that camp, it has it's own
sysfs attribute.

- Dave


--Boundary-00=_ufpvE5ACnZ4yIyU
Content-Type: text/x-diff;
  charset="us-ascii";
  name="pm-sysfs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pm-sysfs.patch"

Add a new PM_SYSFS_DEPRECATED config option to control whether or
not the /sys/devices/.../power/state files are provided.  This will
make it easier to get rid of that mechanism when the time comes,
and to verify that userspace tools work right without it.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: linux/kernel/power/Kconfig
===================================================================
--- linux.orig/kernel/power/Kconfig	2006-07-18 11:00:35.000000000 -0700
+++ linux/kernel/power/Kconfig	2006-07-18 11:14:57.000000000 -0700
@@ -53,6 +53,17 @@
 	CAUTION: this option will cause your machine's real-time clock to be
 	set to an invalid time after a resume.
 
+config PM_SYSFS_DEPRECATED
+	bool "Driver model /sys/devices/.../power/state files (DEPRECATED)"
+	depends on PM && SYSFS
+	default n
+	help
+	  The driver model started out with a sysfs file intended to provide
+	  a userspace hook for device power management.  This feature has never
+	  worked very well, except for limited testing purposes, and so it will
+	  be removed.   It's not clear that a generic mechanism could really
+	  handle the wide variability of device power states; any replacements
+	  are likely to be bus or driver specific.
 
 config SOFTWARE_SUSPEND
 	bool "Software Suspend"
Index: linux/drivers/base/power/sysfs.c
===================================================================
--- linux.orig/drivers/base/power/sysfs.c	2006-07-18 11:13:56.000000000 -0700
+++ linux/drivers/base/power/sysfs.c	2006-07-18 11:15:24.000000000 -0700
@@ -7,6 +7,8 @@
 #include "power.h"
 
 
+#ifdef	CONFIG_PM_SYSFS_DEPRECATED
+
 /**
  *	state - Control current power state of device
  *
@@ -67,6 +69,8 @@
 
 static DEVICE_ATTR(state, 0644, state_show, state_store);
 
+#endif	/* CONFIG_PM_SYSFS_DEPRECATED */
+
 /*
  *	wakeup - Report/change current wakeup option for device
  *
@@ -140,7 +144,9 @@
 
 
 static struct attribute * power_attrs[] = {
+#ifdef	CONFIG_PM_SYSFS_DEPRECATED
 	&dev_attr_state.attr,
+#endif
 	&dev_attr_wakeup.attr,
 	NULL,
 };

--Boundary-00=_ufpvE5ACnZ4yIyU
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--Boundary-00=_ufpvE5ACnZ4yIyU--
