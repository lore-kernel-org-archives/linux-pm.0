From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] sched: idle: Avoid retaining the tick when it has been stopped
Date: Thu, 09 Aug 2018 19:08:34 +0200
Message-ID: <2161372.IsD4PDzmmY@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>, Leo Yan <leo.yan@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If the tick has been stopped already, but the governor has not asked to
stop it (which it can do sometimes), the idle loop should invoke
tick_nohz_idle_stop_tick(), to let tick_nohz_stop_tick() take care
of this case properly.

Fixes: 554c8aa8ecad (sched: idle: Select idle state before stopping the tick)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/sched/idle.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/kernel/sched/idle.c
===================================================================
--- linux-pm.orig/kernel/sched/idle.c
+++ linux-pm/kernel/sched/idle.c
@@ -190,7 +190,7 @@ static void cpuidle_idle_call(void)
 		 */
 		next_state = cpuidle_select(drv, dev, &stop_tick);
 
-		if (stop_tick)
+		if (stop_tick || tick_nohz_tick_stopped())
 			tick_nohz_idle_stop_tick();
 		else
 			tick_nohz_idle_retain_tick();
