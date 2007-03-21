From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] introduce /sys/power/disk_powerdown_mode
Date: Wed, 21 Mar 2007 10:23:01 +0100
Message-ID: <1174468981.3769.8.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
To: linux-pm <linux-pm@lists.osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

This patch introduces /sys/power/disk_powerdown_mode and
deprecates /sys/power/disk. The former has the advantages
 * a much more expressive name
 * contains all valid modes as well as the selected one
   in a fashion known from the LED subsystem.

The disk attribute is scheduled for removal, but since there
are no disadvantages in keeping we give it plenty of time.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

---
 Documentation/feature-removal-schedule.txt |   12 +++
 kernel/power/Kconfig                       |   13 ++++
 kernel/power/disk.c                        |   92 ++++++++++++++++++++++++=
++++-
 3 files changed, 114 insertions(+), 3 deletions(-)

--- linux-2.6.orig/kernel/power/disk.c	2007-03-21 08:21:18.726639252 +0100
+++ linux-2.6/kernel/power/disk.c	2007-03-21 10:16:21.802243895 +0100
@@ -307,7 +307,7 @@ static const char * const pm_disk_modes[
 };
 =

 /**
- *	disk - Control suspend-to-disk mode
+ *	disk/disk_powerdown_mode - Control suspend-to-disk mode
  *
  *	Suspend-to-disk can be handled in several ways. We have a few options
  *	for putting the system to sleep - using the platform driver (e.g. ACPI
@@ -331,6 +331,7 @@ static const char * const pm_disk_modes[
  *	supports it (as determined from pm_ops->pm_disk_mode).
  */
 =

+#ifdef CONFIG_PM_DISKATTR
 static ssize_t disk_show(struct subsystem * subsys, char * buf)
 {
 	return sprintf(buf, "%s\n", pm_disk_modes[pm_disk_mode]);
@@ -374,13 +375,95 @@ static ssize_t disk_store(struct subsyst
 		error =3D -EINVAL;
 	}
 =

-	pr_debug("PM: suspend-to-disk mode set to '%s'\n",
-		 pm_disk_modes[mode]);
+	if (!error)
+		pr_debug("PM: suspend-to-disk mode set to '%s'\n",
+			 pm_disk_modes[mode]);
 	mutex_unlock(&pm_mutex);
 	return error ? error : n;
 }
 =

 power_attr(disk);
+#endif
+
+static ssize_t disk_powerdown_mode_show(struct subsystem *subsys, char *bu=
f)
+{
+	int i;
+	char *start =3D buf;
+
+	for (i =3D PM_DISK_PLATFORM; i < PM_DISK_MAX; i++) {
+		if (!pm_disk_modes[i])
+			continue;
+		switch (i) {
+		case PM_DISK_SHUTDOWN:
+		case PM_DISK_REBOOT:
+		case PM_DISK_TEST:
+		case PM_DISK_TESTPROC:
+			break;
+		default:
+			if (pm_ops && pm_ops->enter &&
+			    (i =3D=3D pm_ops->pm_disk_mode))
+				break;
+			/* not a valid mode, continue with loop */
+			continue;
+		}
+		if (i =3D=3D pm_disk_mode)
+			buf +=3D sprintf(buf, "[%s]", pm_disk_modes[i]);
+		else
+			buf +=3D sprintf(buf, "%s", pm_disk_modes[i]);
+		if (i+1 !=3D PM_DISK_MAX)
+			buf +=3D sprintf(buf, " ");
+	}
+	buf +=3D sprintf(buf, "\n");
+	return buf-start;
+}
+
+
+static ssize_t disk_powerdown_mode_store(struct subsystem *s,
+					 const char *buf, size_t n)
+{
+	int error =3D 0;
+	int i;
+	int len;
+	char *p;
+	suspend_disk_method_t mode =3D 0;
+
+	p =3D memchr(buf, '\n', n);
+	len =3D p ? p - buf : n;
+
+	mutex_lock(&pm_mutex);
+	for (i =3D PM_DISK_PLATFORM; i < PM_DISK_MAX; i++) {
+		if (!strncmp(buf, pm_disk_modes[i], len)) {
+			mode =3D i;
+			break;
+		}
+	}
+	if (mode) {
+		switch (mode) {
+		case PM_DISK_SHUTDOWN:
+		case PM_DISK_REBOOT:
+		case PM_DISK_TEST:
+		case PM_DISK_TESTPROC:
+			pm_disk_mode =3D mode;
+			break;
+		default:
+			if (pm_ops && pm_ops->enter &&
+			    (mode =3D=3D pm_ops->pm_disk_mode))
+				pm_disk_mode =3D mode;
+			else
+				error =3D -EINVAL;
+		}
+	} else {
+		error =3D -EINVAL;
+	}
+
+	if (!error)
+		pr_debug("PM: suspend-to-disk mode set to '%s'\n",
+			 pm_disk_modes[mode]);
+	mutex_unlock(&pm_mutex);
+	return error ? error : n;
+}
+
+power_attr(disk_powerdown_mode);
 =

 static ssize_t resume_show(struct subsystem * subsys, char *buf)
 {
@@ -434,7 +517,10 @@ static ssize_t image_size_store(struct s
 power_attr(image_size);
 =

 static struct attribute * g[] =3D {
+#ifdef CONFIG_PM_DISKATTR
 	&disk_attr.attr,
+#endif
+	&disk_powerdown_mode_attr.attr,
 	&resume_attr.attr,
 	&image_size_attr.attr,
 	NULL,
--- linux-2.6.orig/kernel/power/Kconfig	2007-03-21 08:27:18.496639252 +0100
+++ linux-2.6/kernel/power/Kconfig	2007-03-21 10:17:42.562243895 +0100
@@ -19,6 +19,19 @@ config PM
 	  will issue the hlt instruction if nothing is to be done, thereby
 	  sending the processor to sleep and saving power.
 =

+config PM_DISKATTR
+	bool "disk attribute in /sys/power/"
+	depends on PM
+	default y
+	---help---
+	  The "disk" attribute in /sys/power/ is being deprecated in favour
+	  of the "disk_powerdown_mode" attribute because the former does not
+	  let userspace see which modes are possible and the name is not
+	  very expressive.
+
+	  Deselect this option to turn off the deprecated disk attribute.
+	  If unsure, leave this option enabled.
+
 config PM_LEGACY
 	bool "Legacy Power Management API (DEPRECATED)"
 	depends on PM
--- linux-2.6.orig/Documentation/feature-removal-schedule.txt	2007-03-21 10=
:11:52.452243895 +0100
+++ linux-2.6/Documentation/feature-removal-schedule.txt	2007-03-21 10:18:3=
7.832243895 +0100
@@ -334,3 +334,15 @@ Why:	powermac supports proper generic pm
 Who:	Johannes Berg <johannes@sipsolutions.net>
 =

 ---------------------------
+
+What:	/sys/power/disk
+When:	Set PM_DISKATTR default n in 2.6.24, remove in 2.6.26
+Files:	kernel/power/disk.c kernel/power/Kconfig
+Why:	/sys/power/disk is not a very expressive name for what it
+	really is: /sys/power/disk_powerdown_mode. Having introduced
+	the latter which also has the advantage that it contains all
+	valid modes as well as the currently selected mode,
+	/sys/power/disk becomes useless.
+Who:	Johannes Berg <johannes@sipsolutions.net>
+
+---------------------------
