From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 5/8] Hibernation: New testing facility (rev. 2)
Date: Mon, 19 Nov 2007 23:42:31 +0100
Message-ID: <200711192342.32183.rjw__43660.4233728305$1195512266$gmane$org@sisk.pl>
References: <200711192332.15078.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200711192332.15078.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Adrian Bunk <bunk@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Make it possible to test the hibernation core code with the help of the
/sys/power/pm_test attribute introduced for suspend testing in the previo=
us
patch.

Writing an appropriate string to this file causes the hibernation code to=
 work
in one of the test modes defined as follows:

freezer
- test the freezing of processes

devices
- test the freezing of processes and suspending of devices

platform
- test the freezing of processes, suspending of devices and platform glob=
al
=A0 control methods(*)

processors
- test the freezing of processes, suspending of devices, platform global
=A0 control methods(*) and the disabling of nonboot CPUs

core
- test the freezing of processes, suspending of devices, platform global
=A0 control methods(*), the disabling of nonboot CPUs and suspending of
=A0 platform/system devices

(*) - the platform global control methods are only available on ACPI syst=
ems
=A0 =A0 =A0 and are only tested if the hibernation mode is set to "platfo=
rm"

Then, if a hibernation is started by normal means, the hibernation core w=
ill
perform its normal operations up to the point indicated by given test lev=
el.
Next, it will wait for 5 seconds and carry out the resume operations need=
ed to
transition the system back to the fully functional state.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 kernel/power/disk.c  |   70 ++++++++++++++++++++++++++++++++++++++++----=
-------
 kernel/power/power.h |    2 +
 2 files changed, 57 insertions(+), 15 deletions(-)

Index: linux-2.6/kernel/power/disk.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/kernel/power/disk.c
+++ linux-2.6/kernel/power/disk.c
@@ -70,6 +70,35 @@ void hibernation_set_ops(struct platform
 	mutex_unlock(&pm_mutex);
 }
=20
+#ifdef CONFIG_PM_DEBUG
+static void hibernation_debug_sleep(void)
+{
+	printk(KERN_INFO "hibernation debug: Waiting for 5 seconds.\n");
+	mdelay(5000);
+}
+
+static int hibernation_testmode(int mode)
+{
+	if (hibernation_mode =3D=3D mode) {
+		hibernation_debug_sleep();
+		return 1;
+	}
+	return 0;
+}
+
+static int hibernation_test(int level)
+{
+	if (pm_test_level =3D=3D level) {
+		hibernation_debug_sleep();
+		return 1;
+	}
+	return 0;
+}
+#else /* !CONFIG_PM_DEBUG */
+static int hibernation_testmode(int mode) { return 0; }
+static int hibernation_test(int level) { return 0; }
+#endif /* !CONFIG_PM_DEBUG */
+
 /**
  *	platform_start - tell the platform driver that we're starting
  *	hibernation
@@ -167,6 +196,10 @@ int create_image(int platform_mode)
 		goto Enable_irqs;
 	}
=20
+	if (hibernation_test(TEST_CORE))
+		goto Power_up;
+
+	in_suspend =3D 1;
 	save_processor_state();
 	error =3D swsusp_arch_suspend();
 	if (error)
@@ -175,6 +208,7 @@ int create_image(int platform_mode)
 	restore_processor_state();
 	if (!in_suspend)
 		platform_leave(platform_mode);
+ Power_up:
 	/* NOTE:  device_power_up() is just a resume() for devices
 	 * that suspended with irqs off ... no overall powerup.
 	 */
@@ -211,24 +245,29 @@ int hibernation_snapshot(int platform_mo
 	if (error)
 		goto Resume_console;
=20
-	error =3D platform_pre_snapshot(platform_mode);
-	if (error)
+	if (hibernation_test(TEST_DEVICES))
 		goto Resume_devices;
=20
+	error =3D platform_pre_snapshot(platform_mode);
+	if (error || hibernation_test(TEST_PLATFORM))
+		goto Finish;
+
 	error =3D disable_nonboot_cpus();
 	if (!error) {
-		if (hibernation_mode !=3D HIBERNATION_TEST) {
-			in_suspend =3D 1;
-			error =3D create_image(platform_mode);
-			/* Control returns here after successful restore */
-		} else {
-			printk("swsusp debug: Waiting for 5 seconds.\n");
-			mdelay(5000);
-		}
+		if (hibernation_test(TEST_CPUS))
+			goto Enable_cpus;
+
+		if (hibernation_testmode(HIBERNATION_TEST))
+			goto Enable_cpus;
+
+		error =3D create_image(platform_mode);
+		/* Control returns here after successful restore */
 	}
+ Enable_cpus:
 	enable_nonboot_cpus();
- Resume_devices:
+ Finish:
 	platform_finish(platform_mode);
+ Resume_devices:
 	device_resume();
  Resume_console:
 	resume_console();
@@ -406,11 +445,12 @@ int hibernate(void)
 	if (error)
 		goto Finish;
=20
-	if (hibernation_mode =3D=3D HIBERNATION_TESTPROC) {
-		printk("swsusp debug: Waiting for 5 seconds.\n");
-		mdelay(5000);
+	if (hibernation_test(TEST_FREEZER))
 		goto Thaw;
-	}
+
+	if (hibernation_testmode(HIBERNATION_TESTPROC))
+		goto Thaw;
+
 	error =3D hibernation_snapshot(hibernation_mode =3D=3D HIBERNATION_PLAT=
FORM);
 	if (in_suspend && !error) {
 		unsigned int flags =3D 0;
Index: linux-2.6/kernel/power/power.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/kernel/power/power.h
+++ linux-2.6/kernel/power/power.h
@@ -208,3 +208,5 @@ enum {
=20
 #define TEST_FIRST	TEST_NONE
 #define TEST_MAX	(__TEST_AFTER_LAST - 1)
+
+extern int pm_test_level;
