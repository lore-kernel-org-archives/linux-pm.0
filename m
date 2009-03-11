From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 4/10] kexec: Change kexec jump code ordering
Date: Wed, 11 Mar 2009 10:39:01 +0100
Message-ID: <200903111039.02582.rjw@sisk.pl>
References: <200902221837.49396.rjw@sisk.pl> <200903111030.39371.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200903111030.39371.rjw@sisk.pl>
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
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Arve@smtp1.linux-foundation.org, Jeremy Fitzhardinge <jeremy@goop.org>, Frans Pop <elendil@planet.nl>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Change the ordering of the kexec jump code so that the nonboot CPUs
are disabled after calling device drivers' "late suspend" methods.

This change reflects the recent modifications of the power management
code that is also used by kexec jump.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/kexec.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

Index: linux-2.6/kernel/kexec.c
===================================================================
--- linux-2.6.orig/kernel/kexec.c
+++ linux-2.6/kernel/kexec.c
@@ -1450,9 +1450,6 @@ int kernel_kexec(void)
 		error = device_suspend(PMSG_FREEZE);
 		if (error)
 			goto Resume_console;
-		error = disable_nonboot_cpus();
-		if (error)
-			goto Resume_devices;
 		device_pm_lock();
 		/* At this point, device_suspend() has been called,
 		 * but *not* device_power_down(). We *must*
@@ -1463,13 +1460,15 @@ int kernel_kexec(void)
 		 */
 		error = device_power_down(PMSG_FREEZE);
 		if (error)
-			goto Unlock_pm;
-
+			goto Resume_devices;
+		error = disable_nonboot_cpus();
+		if (error)
+			goto Enable_cpus;
 		local_irq_disable();
 		/* Suspend system devices */
 		error = sysdev_suspend(PMSG_FREEZE);
 		if (error)
-			goto Power_up_devices;
+			goto Enable_irqs;
 	} else
 #endif
 	{
@@ -1483,13 +1482,13 @@ int kernel_kexec(void)
 #ifdef CONFIG_KEXEC_JUMP
 	if (kexec_image->preserve_context) {
 		sysdev_resume();
- Power_up_devices:
+ Enable_irqs:
 		local_irq_enable();
-		device_power_up(PMSG_RESTORE);
- Unlock_pm:
-		device_pm_unlock();
+ Enable_cpus:
 		enable_nonboot_cpus();
+		device_power_up(PMSG_RESTORE);
  Resume_devices:
+		device_pm_unlock();
 		device_resume(PMSG_RESTORE);
  Resume_console:
 		resume_console();
