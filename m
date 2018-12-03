From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpuidle: poll_state: Disregard disable idle states
Date: Mon, 03 Dec 2018 13:32:53 +0100
Message-ID: <4697959.rYJ3NsDDJG@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Documentation <linux-doc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Giovanni Gherdovich <ggherdovich@suse.cz>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

When computing the limit of time to spend in the loop in poll_idle(),
use the target residency of the first enabled idle state deeper than
state 0 instead of always using the target residency of state 1.

This helps when state 1 is disabled for diagnostics, for instance.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/poll_state.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/cpuidle/poll_state.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/poll_state.c
+++ linux-pm/drivers/cpuidle/poll_state.c
@@ -20,8 +20,17 @@ static int __cpuidle poll_idle(struct cp
 
 	local_irq_enable();
 	if (!current_set_polling_and_test()) {
-		u64 limit = (u64)drv->states[1].target_residency * NSEC_PER_USEC;
 		unsigned int loop_count = 0;
+		u64 limit = TICK_USEC;
+		int i;
+
+		for (i = 1; i < drv->state_count; i++) {
+			if (drv->states[i].disabled || dev->states_usage[i].disable)
+				continue;
+
+			limit = (u64)drv->states[i].target_residency * NSEC_PER_USEC;
+			break;
+		}
 
 		while (!need_resched()) {
 			cpu_relax();
