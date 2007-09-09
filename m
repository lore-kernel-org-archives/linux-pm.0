From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH -mm] Hibernation: Enter platform hibernation
	state in a consistent way (rev. 4)
Date: Sun, 9 Sep 2007 15:04:20 +0200
Message-ID: <200709091504.21117.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
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
Cc: Stefan Becker <Stefan.Becker@nokia.com>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Make hibernation_platform_enter() execute the enter-a-sleep-state sequence
instead of the mixed shutdown-with-entering-S4 thing.

Replace the shutting down of devices done by kernel_shutdown_prepare(), before
entering the ACPI S4 sleep state, with suspending them and the shutting down of
sysdevs with calling device_power_down(PMSG_SUSPEND) (just like before entering
S1 or S3, but the target state is now S4).  Also, disable the nonboot CPUs
before entering the sleep state (S4), which generally always is a good idea.

This is known to fix the "double disk spin down during hibernation" on some
machines, eg. HPC nx6325 (ref. http://lkml.org/lkml/2007/8/7/316 and the
following thread).  Moreover, it has been reported to make
/sys/class/rtc/rtc0/wakealarm work correctly with hibernation for some users.
It also generally causes the hibernation state (ACPI S4) to be entered faster.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 kernel/power/disk.c |   61 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 17 deletions(-)

Index: linux-2.6.23-rc4-mm1/kernel/power/disk.c
===================================================================
--- linux-2.6.23-rc4-mm1.orig/kernel/power/disk.c
+++ linux-2.6.23-rc4-mm1/kernel/power/disk.c
@@ -222,21 +222,48 @@ int hibernation_platform_enter(void)
 {
 	int error;
 
-	if (hibernation_ops) {
-		kernel_shutdown_prepare(SYSTEM_SUSPEND_DISK);
-		/*
-		 * We have cancelled the power transition by running
-		 * hibernation_ops->finish() before saving the image, so we
-		 * should let the firmware know that we're going to enter the
-		 * sleep state after all
-		 */
-		error = hibernation_ops->prepare();
-		sysdev_shutdown();
-		if (!error)
-			error = hibernation_ops->enter();
-	} else {
-		error = -ENOSYS;
+	if (!hibernation_ops)
+		return -ENOSYS;
+
+	/*
+	 * We have cancelled the power transition by running
+	 * hibernation_ops->finish() before saving the image, so we should let
+	 * the firmware know that we're going to enter the sleep state after all
+	 */
+	error = hibernation_ops->start();
+	if (error)
+		return error;
+
+	suspend_console();
+	error = device_suspend(PMSG_SUSPEND);
+	if (error)
+		return error;
+
+	error = hibernation_ops->prepare();
+	if (error)
+		goto Resume_devices;
+
+	error = disable_nonboot_cpus();
+	if (error)
+		goto Finish;
+
+	local_irq_disable();
+	error = device_power_down(PMSG_SUSPEND);
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
