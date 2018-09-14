From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2] PM / suspend: Count suspend-to-idle loop as sleep time
Date: Fri, 14 Sep 2018 10:13:53 +0200
Message-ID: <2512990.M6WkFzBlpI@aspire.rjw.lan>
References: <9611469.2z7W9akjOQ@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9611469.2z7W9akjOQ@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is a difference in behavior between suspend-to-idle and
suspend-to-RAM in the timekeeping handling that leads to functional
issues.  Namely, every iteration of the loop in s2idle_loop()
increases the monotinic clock somewhat, even if timekeeping_suspend()
and timekeeping_resume() are invoked from s2idle_enter(), and if
many of them are carried out in a row, the monotonic clock can grow
significantly while the system is regarded as suspended, which
doesn't happen during suspend-to-RAM and so it is unexpected and
leads to confusion and misbehavior in user space (similar to what
ensued when we tried to combine the boottime and monotonic clocks).

To avoid that, count all iterations of the loop in s2idle_loop()
as "sleep time" and adjust the clock for that on exit from
suspend-to-idle.

[That also covers systems on which timekeeping is not suspended
 by s2idle_enter().]

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---

-> v2:
 - Switched over to ktime_get_ns() as suggested by Peter.
 - Tentatively added "Acked-by" from Peter.

---
 kernel/power/suspend.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -109,8 +109,12 @@ static void s2idle_enter(void)
 
 static void s2idle_loop(void)
 {
+	u64 delta_ns;
+
 	pm_pr_dbg("suspend-to-idle\n");
 
+	delta_ns = ktime_get_ns();
+
 	for (;;) {
 		int error;
 
@@ -150,6 +154,20 @@ static void s2idle_loop(void)
 		pm_wakeup_clear(false);
 	}
 
+	/*
+	 * If the monotonic clock difference between the start of the loop and
+	 * this point is too large, user space may get confused about whether or
+	 * not the system has been suspended and tasks may get killed by
+	 * watchdogs etc., so count the loop as "sleep time" to compensate for
+	 * that.
+	 */
+	delta_ns = ktime_get_ns() - delta_ns;
+	if (delta_ns) {
+		struct timespec64 timespec64_delta = ns_to_timespec64(delta_ns);
+
+		timekeeping_inject_sleeptime64(&timespec64_delta);
+	}
+
 	pm_pr_dbg("resume from suspend-to-idle\n");
 }
 
