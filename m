From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpuidle: poll_state: Revise loop termination condition
Date: Tue, 02 Oct 2018 23:50:30 +0200
Message-ID: <3981163.1RDrRiq2Iz@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If need_resched() returns "false", breaking out of the loop in
poll_idle() will cause a new idle state to be selected, so in fact
usually it doesn't make sense to spin in it longer than the target
residency of the second state.  [Note that the "polling" state is
used only if there is at least one "real" state defined in addition
to it.]  On the other hand, breaking out of it early (say in case
the next state is disabled) shouldn't hurt as it is polling anyway.

For this reason, make the loop in poll_idle() break if the CPU has
been spinning longer than the target residency of the second state
(the "polling" state can only be state[0]).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/poll_state.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/cpuidle/poll_state.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/poll_state.c
+++ linux-pm/drivers/cpuidle/poll_state.c
@@ -9,7 +9,6 @@
 #include <linux/sched/clock.h>
 #include <linux/sched/idle.h>
 
-#define POLL_IDLE_TIME_LIMIT	(TICK_NSEC / 16)
 #define POLL_IDLE_RELAX_COUNT	200
 
 static int __cpuidle poll_idle(struct cpuidle_device *dev,
@@ -21,6 +20,7 @@ static int __cpuidle poll_idle(struct cp
 
 	local_irq_enable();
 	if (!current_set_polling_and_test()) {
+		u64 limit = (u64)drv->states[1].target_residency * NSEC_PER_USEC;
 		unsigned int loop_count = 0;
 
 		while (!need_resched()) {
@@ -29,7 +29,7 @@ static int __cpuidle poll_idle(struct cp
 				continue;
 
 			loop_count = 0;
-			if (local_clock() - time_start > POLL_IDLE_TIME_LIMIT) {
+			if (local_clock() - time_start > limit) {
 				dev->poll_time_limit = true;
 				break;
 			}
