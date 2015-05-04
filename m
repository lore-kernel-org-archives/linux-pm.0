From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/4] sched / idle: Move the default idle call code to a separate function
Date: Mon, 04 May 2015 15:56:24 +0200
Message-ID: <1607938.mB5HZupMYV@vostro.rjw.lan>
References: <3084951.QaIkFrZ3VU@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60462 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752844AbbEDNeK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2015 09:34:10 -0400
In-Reply-To: <3084951.QaIkFrZ3VU@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Move the code under the "use_default" label in cpuidle_idle_call()
into a separate (new) function.

This just allows the subsequent changes to be more stratightforward.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/sched/idle.c |   42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

Index: linux-pm/kernel/sched/idle.c
===================================================================
--- linux-pm.orig/kernel/sched/idle.c
+++ linux-pm/kernel/sched/idle.c
@@ -67,6 +67,17 @@ void __weak arch_cpu_idle(void)
 	local_irq_enable();
 }
 
+static void default_idle_call(void) {
+	/*
+	 * We can't use the cpuidle framework, let's use the default idle
+	 * routine.
+	 */
+	if (current_clr_polling_and_test())
+		local_irq_enable();
+	else
+		arch_cpu_idle();
+}
+
 /**
  * cpuidle_idle_call - the main idle function
  *
@@ -105,8 +116,10 @@ static void cpuidle_idle_call(void)
 	 */
 	rcu_idle_enter();
 
-	if (cpuidle_not_available(drv, dev))
-		goto use_default;
+	if (cpuidle_not_available(drv, dev)) {
+		default_idle_call();
+		goto exit_idle;
+	}
 
 	/*
 	 * Suspend-to-idle ("freeze") is a system state in which all user space
@@ -134,8 +147,10 @@ static void cpuidle_idle_call(void)
 		next_state = cpuidle_select(drv, dev);
 	}
 	/* Fall back to the default arch idle method on errors. */
-	if (next_state < 0)
-		goto use_default;
+	if (next_state < 0) {
+		default_idle_call();
+		goto exit_idle;
+	}
 
 	/*
 	 * The idle task must be scheduled, it is pointless to
@@ -162,8 +177,10 @@ static void cpuidle_idle_call(void)
 	/* The cpu is no longer idle or about to enter idle. */
 	idle_set_state(this_rq(), NULL);
 
-	if (entered_state == -EBUSY)
-		goto use_default;
+	if (entered_state == -EBUSY) {
+		default_idle_call();
+		goto exit_idle;
+	}
 
 	/*
 	 * Give the governor an opportunity to reflect on the outcome
@@ -182,19 +199,6 @@ exit_idle:
 
 	rcu_idle_exit();
 	start_critical_timings();
-	return;
-
-use_default:
-	/*
-	 * We can't use the cpuidle framework, let's use the default
-	 * idle routine.
-	 */
-	if (current_clr_polling_and_test())
-		local_irq_enable();
-	else
-		arch_cpu_idle();
-
-	goto exit_idle;
 }
 
 DEFINE_PER_CPU(bool, cpu_dead_idle);

