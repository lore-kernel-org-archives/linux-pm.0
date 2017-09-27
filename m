From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PM / s2idle: Invoke the ->wake() platform callback earlier
Date: Thu, 28 Sep 2017 01:45:10 +0200
Message-ID: <2377821.5zBMHogt8n@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Mario Limonciello <mario.limonciello@dell.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The role of the ->wake() platform callback for suspend-to-idle is to
deal with possible spurious wakeups, among other things.  The ACPI
implementation of it, acpi_s2idle_wake(), additionally checks the
conditions for entering the Low Power S0 Idle state by the platform
and reports the ones that have not been met.

However, the ->wake() platform callback is invoked after calling
dpm_noirq_resume_devices(), which means that the power states of some
devices may have changed since s2idle_enter() returned, so some unmet
Low Power S0 Idle conditions may be reported incorrectly as a result
of that.

To avoid these false positives, reorder the invocations of the
dpm_noirq_resume_devices() routine and the ->wake() platform callback
in s2idle_loop().

Fixes: 726fb6b4f2a8 (ACPI / PM: Check low power idle constraints for debug only)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Tested on Dell XPS13 9360.

---
 kernel/power/suspend.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -120,22 +120,26 @@ static void s2idle_loop(void)
 		 * frozen processes + suspended devices + idle processors.
 		 * Thus s2idle_enter() should be called right after
 		 * all devices have been suspended.
+		 *
+		 * Wakeups during the noirq suspend of devices may be spurious,
+		 * so prevent them from terminating the loop right away.
 		 */
 		error = dpm_noirq_suspend_devices(PMSG_SUSPEND);
 		if (!error)
 			s2idle_enter();
+		else if (error == -EBUSY && pm_wakeup_pending())
+			error = 0;
 
-		dpm_noirq_resume_devices(PMSG_RESUME);
-		if (error && (error != -EBUSY || !pm_wakeup_pending())) {
-			dpm_noirq_end();
-			break;
-		}
-
-		if (s2idle_ops && s2idle_ops->wake)
+		if (!error && s2idle_ops && s2idle_ops->wake)
 			s2idle_ops->wake();
 
+		dpm_noirq_resume_devices(PMSG_RESUME);
+
 		dpm_noirq_end();
 
+		if (error)
+			break;
+
 		if (s2idle_ops && s2idle_ops->sync)
 			s2idle_ops->sync();
 

