From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpuidle: menu: Fall back to polling if next timer event is near
Date: Sun, 20 Mar 2016 01:33:35 +0100
Message-ID: <11672478.oHFBPvKbda@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62310 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932626AbcCTAb3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 19 Mar 2016 20:31:29 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: Rik van Riel <riel@redhat.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit a9ceb78bc75c (cpuidle,menu: use interactivity_req to disable
polling) changed the behavior of the fallback state selection part
of menu_select() so it looks at interactivity_req instead of
data->next_timer_us when it makes its decision.  That effectively
caused polling to be used more often as fallback idle which led to
significant increases of energy consumption in some cases.

Commit e132b9b3bc7f (cpuidle: menu: use high confidence factors
only when considering polling) changed that logic again to be more
predictable, but that didn't help with the increased energy
consumption problem.

For this reason, go back to making decisions on which state to fall
back to based on data->next_timer_us which is the time we know for
sure something will happen rather than a prediction (which may be
inaccurate and turns out to be so often enough to be problematic).
However, take the target residency of the first proper idle state
(C1) into account, so that state is not used as the fallback one
if its target residency is greater than data->next_timer_us.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Doug, can you please see if this patch helps to address the problem
you're seeing?

Commit e132b9b3bc7f is in linux-next only ATM, but it is a rebased
version of https://patchwork.kernel.org/patch/8602101/.

---
 drivers/cpuidle/governors/menu.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -315,17 +315,21 @@ static int menu_select(struct cpuidle_dr
 	expected_interval = min(expected_interval, data->next_timer_us);
 
 	if (CPUIDLE_DRIVER_STATE_START > 0) {
-		data->last_state_idx = CPUIDLE_DRIVER_STATE_START - 1;
+		struct cpuidle_state *s = &drv->states[CPUIDLE_DRIVER_STATE_START];
+		unsigned int polling_threshold;
+
 		/*
 		 * We want to default to C1 (hlt), not to busy polling
 		 * unless the timer is happening really really soon, or
 		 * C1's exit latency exceeds the user configured limit.
 		 */
-		if (expected_interval > drv->states[CPUIDLE_DRIVER_STATE_START].target_residency &&
-		    latency_req > drv->states[CPUIDLE_DRIVER_STATE_START].exit_latency &&
-		    !drv->states[CPUIDLE_DRIVER_STATE_START].disabled &&
+		polling_threshold = max_t(unsigned int, 20, s->target_residency);
+		if (data->next_timer_us > polling_threshold &&
+		    latency_req > s->exit_latency && !s->disabled &&
 		    !dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable)
 			data->last_state_idx = CPUIDLE_DRIVER_STATE_START;
+		else
+			data->last_state_idx = CPUIDLE_DRIVER_STATE_START - 1;
 	} else {
 		data->last_state_idx = CPUIDLE_DRIVER_STATE_START;
 	}

