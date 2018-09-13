From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PM / suspend: Count extra iterations of s2idle loop as sleep time
Date: Thu, 13 Sep 2018 12:02:08 +0200
Message-ID: <2599994.ffBKF6PfAe@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Vitaly Kuznetsov <vkuznets@redhat.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is a difference in behavior between suspend-to-idle and
suspend-to-RAM in the timekeeping handling that leads to functional
issues.  Namely, every iteration of the loop in s2idle_loop()
increases the monotinic clock somewhat, even if timekeeping_suspend()
and timekeeping_resume() are invoked from s2idle_enter(), and if
many of them are carried out in a row, the monotonic clock can grow
significantly while the system is regarded as suspended, which
doesn't happend during suspend-to-RAM and so it is unexpected and
leads to confusion and misbehavior in user space (similar to what
ensued when we tried to combine the boottime and monotonic clocks).

To avoid that, count all iterations of the loop in s2idle_loop()
except for the last one as "sleep time" and adjust the clock for
that on exit from suspend-to-idle.

Fixes: 33e4f80ee69b (ACPI / PM: Ignore spurious SCI wakeups from suspend-to-idle)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/suspend.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -109,11 +109,16 @@ static void s2idle_enter(void)
 
 static void s2idle_loop(void)
 {
+	ktime_t delta = 0;
+
 	pm_pr_dbg("suspend-to-idle\n");
 
 	for (;;) {
+		ktime_t before;
 		int error;
 
+		before = ktime_get();
+
 		dpm_noirq_begin();
 
 		/*
@@ -148,6 +153,23 @@ static void s2idle_loop(void)
 			break;
 
 		pm_wakeup_clear(false);
+
+		/*
+		 * Count all iterations except for the last one as "sleep time".
+		 */
+		delta = ktime_add(delta, ktime_sub(ktime_get(), before));
+	}
+
+	/*
+	 * If the monotonic clock difference between the start of the loop and
+	 * this point is too large, user space may get confused about whether or
+	 * not the system has been suspended and tasks may get killed by
+	 * watchdogs etc., so compensate for that.
+	 */
+	if (ktime_to_ns(delta) > 0) {
+		struct timespec64 timespec64_delta = ktime_to_timespec64(delta);
+
+		timekeeping_inject_sleeptime64(&timespec64_delta);
 	}
 
 	pm_pr_dbg("resume from suspend-to-idle\n");
