From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/11] PM: Change suspend code ordering
Date: Sat, 14 Mar 2009 12:28:08 +0100
Message-ID: <200903141228.09631.rjw__49771.1576907479$1237030768$gmane$org@sisk.pl>
References: <200902221837.49396.rjw@sisk.pl> <200903141224.29591.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200903141224.29591.rjw@sisk.pl>
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
Cc: Arve@smtp1.linux-foundation.org, Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Linux PCI <linux-pci@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Change the ordering of the suspend core code so that the platform
"prepare" callback is executed and the nonboot CPUs are disabled
after calling device drivers' "late suspend" methods.

This change will allow us to rework the PCI PM core so that the power
state of devices is changed in the "late" phase of suspend (and
analogously in the "early" phase of resume), which in turn will allow
us to avoid the race condition where a device using shared interrupts
is put into a low power state with interrupts enabled and then an
interrupt (for another device) comes in and confuses its driver.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/main.c |   38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

Index: linux-2.6/kernel/power/main.c
===================================================================
--- linux-2.6.orig/kernel/power/main.c
+++ linux-2.6/kernel/power/main.c
@@ -297,6 +297,19 @@ static int suspend_enter(suspend_state_t
 		goto Done;
 	}
 
+	if (suspend_ops->prepare) {
+		error = suspend_ops->prepare();
+		if (error)
+			goto Power_up_devices;
+	}
+
+	if (suspend_test(TEST_PLATFORM))
+		goto Platfrom_finish;
+
+	error = disable_nonboot_cpus();
+	if (error || suspend_test(TEST_CPUS))
+		goto Enable_cpus;
+
 	arch_suspend_disable_irqs();
 	BUG_ON(!irqs_disabled());
 
@@ -310,6 +323,14 @@ static int suspend_enter(suspend_state_t
 	arch_suspend_enable_irqs();
 	BUG_ON(irqs_disabled());
 
+ Enable_cpus:
+	enable_nonboot_cpus();
+
+ Platfrom_finish:
+	if (suspend_ops->finish)
+		suspend_ops->finish();
+
+ Power_up_devices:
 	device_power_up(PMSG_RESUME);
 
  Done:
@@ -346,23 +367,8 @@ int suspend_devices_and_enter(suspend_st
 	if (suspend_test(TEST_DEVICES))
 		goto Recover_platform;
 
-	if (suspend_ops->prepare) {
-		error = suspend_ops->prepare();
-		if (error)
-			goto Resume_devices;
-	}
-
-	if (suspend_test(TEST_PLATFORM))
-		goto Finish;
+	suspend_enter(state);
 
-	error = disable_nonboot_cpus();
-	if (!error && !suspend_test(TEST_CPUS))
-		suspend_enter(state);
-
-	enable_nonboot_cpus();
- Finish:
-	if (suspend_ops->finish)
-		suspend_ops->finish();
  Resume_devices:
 	suspend_test_start();
 	device_resume(PMSG_RESUME);
