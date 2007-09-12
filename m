From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Resend][PATCH -mm] Hibernation: Enter platform
	hibernation state in a consistent way (rev. 4)
Date: Wed, 12 Sep 2007 13:14:08 +0200
Message-ID: <200709121314.09676.rjw__13643.2287785739$1189594989$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Stefan Becker <Stefan.Becker@nokia.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Make hibernation_platform_enter() execute the enter-a-sleep-state sequenc=
e
instead of the mixed shutdown-with-entering-S4 thing.

Replace the shutting down of devices done by kernel_shutdown_prepare(), b=
efore
entering the ACPI S4 sleep state, with suspending them and the shutting d=
own of
sysdevs with calling device_power_down(PMSG_SUSPEND) (just like before en=
tering
S1 or S3, but the target state is now S4). =A0Also, disable the nonboot C=
PUs
before entering the sleep state (S4), which generally always is a good id=
ea.

This is known to fix the "double disk spin down during hibernation" on so=
me
machines, eg. HPC nx6325 (ref. http://lkml.org/lkml/2007/8/7/316 and the
following thread). =A0Moreover, it has been reported to make
/sys/class/rtc/rtc0/wakealarm work correctly with hibernation for some us=
ers.
It also generally causes the hibernation state (ACPI S4) to be entered fa=
ster.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 kernel/power/disk.c |   61 +++++++++++++++++++++++++++++++++++++--------=
-------
 1 file changed, 44 insertions(+), 17 deletions(-)

Index: linux-2.6.23-rc6/kernel/power/disk.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23-rc6.orig/kernel/power/disk.c
+++ linux-2.6.23-rc6/kernel/power/disk.c
@@ -222,21 +222,48 @@ int hibernation_platform_enter(void)
 {
 	int error;
=20
-	if (hibernation_ops) {
-		kernel_shutdown_prepare(SYSTEM_SUSPEND_DISK);
-		/*
-		 * We have cancelled the power transition by running
-		 * hibernation_ops->finish() before saving the image, so we
-		 * should let the firmware know that we're going to enter the
-		 * sleep state after all
-		 */
-		error =3D hibernation_ops->prepare();
-		sysdev_shutdown();
-		if (!error)
-			error =3D hibernation_ops->enter();
-	} else {
-		error =3D -ENOSYS;
+	if (!hibernation_ops)
+		return -ENOSYS;
+
+	/*
+	 * We have cancelled the power transition by running
+	 * hibernation_ops->finish() before saving the image, so we should let
+	 * the firmware know that we're going to enter the sleep state after al=
l
+	 */
+	error =3D hibernation_ops->start();
+	if (error)
+		return error;
+
+	suspend_console();
+	error =3D device_suspend(PMSG_SUSPEND);
+	if (error)
+		return error;
+
+	error =3D hibernation_ops->prepare();
+	if (error)
+		goto Resume_devices;
+
+	error =3D disable_nonboot_cpus();
+	if (error)
+		goto Finish;
+
+	local_irq_disable();
+	error =3D device_power_down(PMSG_SUSPEND);
+	if (!error) {
+		hibernation_ops->enter();
+		/* We should never get here */
+		while (1);
 	}
+	local_irq_enable();
+
+	/*
+	 * We don't need to reenable the nonboot CPUs or resume consoles, since
+	 * the system is going to be halted anyway.
+	 */
+ Finish:
+	hibernation_ops->finish();
+ Resume_devices:
+	device_resume();
 	return error;
 }
=20
@@ -253,14 +280,14 @@ static void power_down(void)
 	case HIBERNATION_TEST:
 	case HIBERNATION_TESTPROC:
 		break;
-	case HIBERNATION_SHUTDOWN:
-		kernel_power_off();
-		break;
 	case HIBERNATION_REBOOT:
 		kernel_restart(NULL);
 		break;
 	case HIBERNATION_PLATFORM:
 		hibernation_platform_enter();
+	case HIBERNATION_SHUTDOWN:
+		kernel_power_off();
+		break;
 	}
 	kernel_halt();
 	/*
