From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.18-rc5] PM: add kconfig option for deprecated
	.../power/state files
Date: Wed, 30 Aug 2006 13:54:36 -0700
Message-ID: <200608301354.37478.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Greg KH <greg@kroah.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

[ resend ... Pavel, ISTR you did ack this but correct me if not ]

Add a new PM_SYSFS_DEPRECATED config option to control whether or
not the /sys/devices/.../power/state files are provided.  This will
make it easier to get rid of that mechanism when the time comes,
and to verify that userspace tools work right without it.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Acked-by: Pavel Machek <pavel@suse.cz>

Index: linux/kernel/power/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/kernel/power/Kconfig	2006-07-18 11:00:35.000000000 -0700
+++ linux/kernel/power/Kconfig	2006-07-18 11:14:57.000000000 -0700
@@ -53,6 +53,17 @@
 	CAUTION: this option will cause your machine's real-time clock to be
 	set to an invalid time after a resume.
 =

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
 =

 config SOFTWARE_SUSPEND
 	bool "Software Suspend"
Index: linux/drivers/base/power/sysfs.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/drivers/base/power/sysfs.c	2006-07-18 11:13:56.000000000 -07=
00
+++ linux/drivers/base/power/sysfs.c	2006-07-18 11:15:24.000000000 -0700
@@ -7,6 +7,8 @@
 #include "power.h"
 =

 =

+#ifdef	CONFIG_PM_SYSFS_DEPRECATED
+
 /**
  *	state - Control current power state of device
  *
@@ -67,6 +69,8 @@
 =

 static DEVICE_ATTR(state, 0644, state_show, state_store);
 =

+#endif	/* CONFIG_PM_SYSFS_DEPRECATED */
+
 /*
  *	wakeup - Report/change current wakeup option for device
  *
@@ -140,7 +144,9 @@
 =

 =

 static struct attribute * power_attrs[] =3D {
+#ifdef	CONFIG_PM_SYSFS_DEPRECATED
 	&dev_attr_state.attr,
+#endif
 	&dev_attr_wakeup.attr,
 	NULL,
 };
