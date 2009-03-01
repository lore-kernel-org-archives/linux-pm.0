From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 4/4] kexec: Change kexec jump code ordering
Date: Sun, 1 Mar 2009 23:27:27 +0100
Message-ID: <200903012327.29301.rjw__16309.6975688406$1235946935$gmane$org@sisk.pl>
References: <200902221837.49396.rjw@sisk.pl> <200903012321.40328.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200903012321.40328.rjw@sisk.pl>
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
To: LKML <linux-kernel@vger.kernel.org>
Cc: Arve@smtp1.linux-foundation.org, Jeremy Fitzhardinge <jeremy@goop.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
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
