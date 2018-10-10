From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpuidle: menu: Simplify checks related to the polling state
Date: Wed, 10 Oct 2018 14:16:38 +0200
Message-ID: <1902472.jET4SC7PGT@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Doug Smythies <dsmythies@telus.net>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After some recent menu governor changes, the promotion of the
"polling" state to a physical one is mostly controlled by the
latency limit (resulting from the "interactivity" factor) and
not by the time to the closest timer event, so it should be
sufficient to check the exit latency of that state for this
purpose (of course, its target residency still needs to be
within the next timer event range for energy-efficiency).

Also, the physical state the "polling" one is promoted to need not
be the next one in principle (in case the next state is disabled,
for example).

For these reasons, simplify the checks made to decide whether or
not to promote the "polling" state to a physical one and update
the target idle duration when it is promoted in case the residency
of the new state turns out to be above the tick boundary (in which
case there is no reason to stop the tick).

Tested-by: Doug Smythies <dsmythies@telus.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -371,12 +371,12 @@ static int menu_select(struct cpuidle_dr
 		if (s->target_residency > predicted_us) {
 			/*
 			 * Use a physical idle state, not busy polling, unless
-			 * a timer is going to trigger really really soon.
+			 * a timer is going to trigger soon enough.
 			 */
 			if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
-			    i == idx + 1 && latency_req > s->exit_latency &&
-			    data->next_timer_us > max_t(unsigned int, 20,
-							s->target_residency)) {
+			    s->exit_latency <= latency_req &&
+			    s->target_residency <= data->next_timer_us) {
+				predicted_us = s->target_residency;
 				idx = i;
 				break;
 			}
