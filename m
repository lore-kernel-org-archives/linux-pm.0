From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PM / sleep: Refine diagnostic messages in enter_state()
Date: Tue, 05 May 2015 23:42:25 +0200
Message-ID: <2242846.s2CNuMpWnm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Some of the system suspend diagnostic messages related to
suspend-to-idle refer to it as "freeze sleep" or "freeze state"
while the others say "suspend-to-idle".  To reduce the possible
confusion that may result from that, refine the former either to
say "suspend to idle" too or to make it clearer that what is printed
is a state string written to /sys/power/state ("mem", "standby",
or "freeze").

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/suspend.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -468,7 +468,7 @@ static int enter_state(suspend_state_t s
 	if (state == PM_SUSPEND_FREEZE) {
 #ifdef CONFIG_PM_DEBUG
 		if (pm_test_level != TEST_NONE && pm_test_level <= TEST_CPUS) {
-			pr_warning("PM: Unsupported test mode for freeze state,"
+			pr_warning("PM: Unsupported test mode for suspend to idle,"
 				   "please choose none/freezer/devices/platform.\n");
 			return -EAGAIN;
 		}
@@ -488,7 +488,7 @@ static int enter_state(suspend_state_t s
 	printk("done.\n");
 	trace_suspend_resume(TPS("sync_filesystems"), 0, false);
 
-	pr_debug("PM: Preparing system for %s sleep\n", pm_states[state]);
+	pr_debug("PM: Preparing system for sleep (%s)\n", pm_states[state]);
 	error = suspend_prepare(state);
 	if (error)
 		goto Unlock;
@@ -497,7 +497,7 @@ static int enter_state(suspend_state_t s
 		goto Finish;
 
 	trace_suspend_resume(TPS("suspend_enter"), state, false);
-	pr_debug("PM: Entering %s sleep\n", pm_states[state]);
+	pr_debug("PM: Suspending system (%s)\n", pm_states[state]);
 	pm_restrict_gfp_mask();
 	error = suspend_devices_and_enter(state);
 	pm_restore_gfp_mask();
