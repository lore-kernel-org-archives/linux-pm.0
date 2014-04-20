From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] sched / idle: Make cpuidle_idle_call() void
Date: Mon, 21 Apr 2014 01:26:58 +0200
Message-ID: <4717784.WmVEpDoliM@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The only value ever returned by cpuidle_idle_call() is 0 and its
only caller ignores that value anyway, so make it void.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/sched/idle.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

Index: linux-pm/kernel/sched/idle.c
===================================================================
--- linux-pm.orig/kernel/sched/idle.c
+++ linux-pm/kernel/sched/idle.c
@@ -67,9 +67,8 @@ void __weak arch_cpu_idle(void)
  * cpuidle_idle_call - the main idle function
  *
  * NOTE: no locks or semaphores should be used here
- * return non-zero on failure
  */
-static int cpuidle_idle_call(void)
+static void cpuidle_idle_call(void)
 {
 	struct cpuidle_device *dev = __this_cpu_read(cpuidle_devices);
 	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
@@ -84,7 +83,7 @@ static int cpuidle_idle_call(void)
 	if (current_clr_polling_and_test()) {
 		local_irq_enable();
 		__current_set_polling();
-		return 0;
+		return;
 	}
 
 	/*
@@ -189,8 +188,6 @@ static int cpuidle_idle_call(void)
 
 	rcu_idle_exit();
 	start_critical_timings();
-
-	return 0;
 }
 
 /*
