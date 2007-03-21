From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 2/3] power management: remove firmware disk mode
Date: Wed, 21 Mar 2007 15:53:30 +0100
Message-ID: <20070321145421.528048000@sipsolutions.net>
References: <20070321145328.496614000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=012-remove-firmware-disk-mode.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-pm@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

This patch removes the firmware disk suspend mode which is the wrong
approach, it is supposed to be used for implementing firmware-based disk
suspend but cannot actually be used for that.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org

---
 Documentation/power/interface.txt |   21 +++++----------------
 Documentation/power/states.txt    |   13 +++++++------
 Documentation/power/swsusp.txt    |   14 +++++---------
 include/linux/pm.h                |   13 ++++++-------
 kernel/power/disk.c               |   27 +++++++++++----------------
 5 files changed, 34 insertions(+), 54 deletions(-)

--- linux-2.6.orig/include/linux/pm.h	2007-03-21 15:44:54.663148946 +0100
+++ linux-2.6/include/linux/pm.h	2007-03-21 15:45:04.403148946 +0100
@@ -114,13 +114,12 @@ typedef int __bitwise suspend_disk_metho
 =

 /* invalid must be 0 so struct pm_ops initialisers can leave it out */
 #define PM_DISK_INVALID		((__force suspend_disk_method_t) 0)
-#define	PM_DISK_FIRMWARE	((__force suspend_disk_method_t) 1)
-#define	PM_DISK_PLATFORM	((__force suspend_disk_method_t) 2)
-#define	PM_DISK_SHUTDOWN	((__force suspend_disk_method_t) 3)
-#define	PM_DISK_REBOOT		((__force suspend_disk_method_t) 4)
-#define	PM_DISK_TEST		((__force suspend_disk_method_t) 5)
-#define	PM_DISK_TESTPROC	((__force suspend_disk_method_t) 6)
-#define	PM_DISK_MAX		((__force suspend_disk_method_t) 7)
+#define	PM_DISK_PLATFORM	((__force suspend_disk_method_t) 1)
+#define	PM_DISK_SHUTDOWN	((__force suspend_disk_method_t) 2)
+#define	PM_DISK_REBOOT		((__force suspend_disk_method_t) 3)
+#define	PM_DISK_TEST		((__force suspend_disk_method_t) 4)
+#define	PM_DISK_TESTPROC	((__force suspend_disk_method_t) 5)
+#define	PM_DISK_MAX		((__force suspend_disk_method_t) 6)
 =

 /**
  * struct pm_ops - Callbacks for managing platform dependent suspend state=
s.
--- linux-2.6.orig/kernel/power/disk.c	2007-03-21 15:44:54.693148946 +0100
+++ linux-2.6/kernel/power/disk.c	2007-03-21 15:48:06.073148946 +0100
@@ -123,8 +123,6 @@ static int prepare_processes(void)
 /**
  *	pm_suspend_disk - The granpappy of hibernation power management.
  *
- *	If we're going through the firmware, then get it over with quickly.
- *
  *	If not, then call swsusp to do its thing, then figure out how
  *	to power down the system.
  */
@@ -301,7 +299,6 @@ late_initcall(software_resume);
 =

 =

 static const char * const pm_disk_modes[] =3D {
-	[PM_DISK_FIRMWARE]	=3D "firmware",
 	[PM_DISK_PLATFORM]	=3D "platform",
 	[PM_DISK_SHUTDOWN]	=3D "shutdown",
 	[PM_DISK_REBOOT]	=3D "reboot",
@@ -312,27 +309,25 @@ static const char * const pm_disk_modes[
 /**
  *	disk - Control suspend-to-disk mode
  *
- *	Suspend-to-disk can be handled in several ways. The greatest
- *	distinction is who writes memory to disk - the firmware or the OS.
- *	If the firmware does it, we assume that it also handles suspending
- *	the system.
- *	If the OS does it, then we have three options for putting the system
- *	to sleep - using the platform driver (e.g. ACPI or other PM registers),
- *	powering off the system or rebooting the system (for testing).
+ *	Suspend-to-disk can be handled in several ways. We have a few options
+ *	for putting the system to sleep - using the platform driver (e.g. ACPI
+ *	or other pm_ops), powering off the system or rebooting the system
+ *	(for testing) as well as the two test modes.
  *
- *	The system will support either 'firmware' or 'platform', and that is
- *	known a priori (and encoded in pm_ops). But, the user may choose
- *	'shutdown' or 'reboot' as alternatives.
+ *	The system can support 'platform', and that is known a priori (and
+ *	encoded in pm_ops). However, the user may choose 'shutdown' or 'reboot'
+ *	as alternatives, as well as the test modes 'test' and 'testproc'.
  *
  *	show() will display what the mode is currently set to.
  *	store() will accept one of
  *
- *	'firmware'
  *	'platform'
  *	'shutdown'
  *	'reboot'
+ *	'test'
+ *	'testproc'
  *
- *	It will only change to 'firmware' or 'platform' if the system
+ *	It will only change to 'platform' if the system
  *	supports it (as determined from pm_ops->pm_disk_mode).
  */
 =

@@ -354,7 +349,7 @@ static ssize_t disk_store(struct subsyst
 	len =3D p ? p - buf : n;
 =

 	mutex_lock(&pm_mutex);
-	for (i =3D PM_DISK_FIRMWARE; i < PM_DISK_MAX; i++) {
+	for (i =3D PM_DISK_PLATFORM; i < PM_DISK_MAX; i++) {
 		if (!strncmp(buf, pm_disk_modes[i], len)) {
 			mode =3D i;
 			break;
--- linux-2.6.orig/Documentation/power/interface.txt	2007-03-21 15:45:17.87=
3148946 +0100
+++ linux-2.6/Documentation/power/interface.txt	2007-03-21 15:49:26.6731489=
46 +0100
@@ -18,17 +18,10 @@ states.
 =

 =

 /sys/power/disk controls the operating mode of the suspend-to-disk
-mechanism. Suspend-to-disk can be handled in several ways. The
-greatest distinction is who writes memory to disk - the firmware or
-the kernel. If the firmware does it, we assume that it also handles
-suspending the system. =

-
-If the kernel does it, then we have three options for putting the system
-to sleep - using the platform driver (e.g. ACPI or other PM
-registers), powering off the system or rebooting the system (for
-testing). The system will support either 'firmware' or 'platform', and
-that is known a priori. But, the user may choose 'shutdown' or
-'reboot' as alternatives. =

+mechanism. Suspend-to-disk can be handled in several ways. We have a
+few options for putting the system to sleep - using the platform driver
+(e.g. ACPI or other pm_ops), powering off the system or rebooting the
+system (for testing).
 =

 Additionally, /sys/power/disk can be used to turn on one of the two testing
 modes of the suspend-to-disk mechanism: 'testproc' or 'test'.  If the
@@ -44,16 +37,12 @@ is being slow and which device drivers a
 Reading from this file will display what the mode is currently set
 to. Writing to this file will accept one of
 =

-       'firmware'
-       'platform'
+       'platform' (only if the platform supports it)
        'shutdown'
        'reboot'
        'testproc'
        'test'
 =

-It will only change to 'firmware' or 'platform' if the system supports
-it. =

-
 /sys/power/image_size controls the size of the image created by
 the suspend-to-disk mechanism.  It can be written a string
 representing a non-negative integer that will be used as an upper
--- linux-2.6.orig/Documentation/power/states.txt	2007-03-21 15:45:17.99314=
8946 +0100
+++ linux-2.6/Documentation/power/states.txt	2007-03-21 15:51:18.763148946 =
+0100
@@ -62,17 +62,18 @@ setup via another operating system for i
 inconvenience, this method requires minimal work by the kernel, since
 the firmware will also handle restoring memory contents on resume. =

 =

-If the kernel is responsible for persistently saving state, a mechanism
-called 'swsusp' (Swap Suspend) is used to write memory contents to
-free swap space. swsusp has some restrictive requirements, but should
-work in most cases. Some, albeit outdated, documentation can be found
-in Documentation/power/swsusp.txt. =

+For suspend-to-disk, a mechanism called swsusp called 'swsusp' (Swap
+Suspend) is used to write memory contents to free swap space.
+swsusp has some restrictive requirements, but should work in most
+cases. Some, albeit outdated, documentation can be found in
+Documentation/power/swsusp.txt. Alternatively, userspace can do most
+of the actual suspend to disk work, see userland-swsusp.txt.
 =

 Once memory state is written to disk, the system may either enter a
 low-power state (like ACPI S4), or it may simply power down. Powering
 down offers greater savings, and allows this mechanism to work on any
 system. However, entering a real low-power state allows the user to
-trigger wake up events (e.g. pressing a key or opening a laptop lid). =

+trigger wake up events (e.g. pressing a key or opening a laptop lid).
 =

 A transition from Suspend-to-Disk to the On state should take about 30
 seconds, though it's typically a bit more with the current
--- linux-2.6.orig/Documentation/power/swsusp.txt	2007-03-21 15:45:18.13314=
8946 +0100
+++ linux-2.6/Documentation/power/swsusp.txt	2007-03-21 15:52:20.423148946 =
+0100
@@ -156,8 +156,7 @@ instead set the PF_NOFREEZE process flag
 be very careful).
 =

 =

-Q: What is the difference between "platform", "shutdown" and
-"firmware" in /sys/power/disk?
+Q: What is the difference between "platform" and "shutdown"?
 =

 A:
 =

@@ -166,11 +165,8 @@ shutdown: save state in linux, then tell
 platform: save state in linux, then tell bios to powerdown and blink
           "suspended led"
 =

-firmware: tell bios to save state itself [needs BIOS-specific suspend
-	  partition, and has very little to do with swsusp]
-
-"platform" is actually right thing to do, but "shutdown" is most
-reliable.
+"platform" is actually right thing to do where supported, but
+"shutdown" is most reliable (except on ACPI systems).
 =

 Q: I do not understand why you have such strong objections to idea of
 selective suspend.
@@ -388,8 +384,8 @@ while the system is asleep, maintaining =

 modes like "suspend-to-RAM" or "standby".  (Don't write "disk" to the
 /sys/power/state file; write "standby" or "mem".)  We've not seen any
 hardware that can use these modes through software suspend, although in
-theory some systems might support "platform" or "firmware" modes that
-won't break the USB connections.
+theory some systems might support "platform" modes that won't break the
+USB connections.
 =

 Remember that it's always a bad idea to unplug a disk drive containing a
 mounted filesystem.  That's true even when your system is asleep!  The

--
