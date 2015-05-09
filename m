From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [Resend][PATCH] PM / tick: Add tracepoints for suspend-to-idle diagnostics
Date: Sun, 10 May 2015 01:23:35 +0200
Message-ID: <1543314.9EN5CRZp0f@vostro.rjw.lan>
References: <17474563.tpu6u1dKOa@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61001 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751185AbbEIW63 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 9 May 2015 18:58:29 -0400
In-Reply-To: <17474563.tpu6u1dKOa@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add suspend/resume tracepoints to tick_freeze() and tick_unfreeze()
to catch when timekeeping is suspended and resumed during suspend-to-idle
so as to be able to check whether or not we enter the "frozen" state
and to measure the time spent in it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Sorry for the duplication, but I messed up the Thomas' address in the previous one.

---
 kernel/time/tick-common.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

Index: linux-pm/kernel/time/tick-common.c
===================================================================
--- linux-pm.orig/kernel/time/tick-common.c
+++ linux-pm/kernel/time/tick-common.c
@@ -19,6 +19,7 @@
 #include <linux/profile.h>
 #include <linux/sched.h>
 #include <linux/module.h>
+#include <trace/events/power.h>
 
 #include <asm/irq_regs.h>
 
@@ -457,10 +458,13 @@ void tick_freeze(void)
 	raw_spin_lock(&tick_freeze_lock);
 
 	tick_freeze_depth++;
-	if (tick_freeze_depth == num_online_cpus())
+	if (tick_freeze_depth == num_online_cpus()) {
+		trace_suspend_resume(TPS("timekeeping_freeze"),
+				     smp_processor_id(), true);
 		timekeeping_suspend();
-	else
+	} else {
 		tick_suspend_local();
+	}
 
 	raw_spin_unlock(&tick_freeze_lock);
 }
@@ -478,10 +482,13 @@ void tick_unfreeze(void)
 {
 	raw_spin_lock(&tick_freeze_lock);
 
-	if (tick_freeze_depth == num_online_cpus())
+	if (tick_freeze_depth == num_online_cpus()) {
 		timekeeping_resume();
-	else
+		trace_suspend_resume(TPS("timekeeping_freeze"),
+				     smp_processor_id(), false);
+	} else {
 		tick_resume_local();
+	}
 
 	tick_freeze_depth--;
 

