From: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC] cpuidle: menu: nearby timer use lightest state; allow state 0 to be disabled
Date: Wed, 31 May 2017 02:26:31 +1000
Message-ID: <20170530162631.9073-1-npiggin@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33406 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751063AbdE3Q0n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 May 2017 12:26:43 -0400
Received: by mail-pf0-f196.google.com with SMTP id f27so19019239pfe.0
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2017 09:26:42 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Nicholas Piggin <npiggin@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, linux-pm@vger.kernel.org

I've found the menu driver does not allow state0 to properly be disabled
because of all this poll logic selecting the first state and then trying
to iterate over subsequent states. Ripping most of that out and simplifying
it solved that issue but raised more questions about polling logic.

Firstly polling logic is there only on architectures which define
ARCH_HAS_CPU_RELAX, which is only x86. Seems like if we think a
timer is so close that no powersave should be done, then surely just
picking the lightest mode (whether that is polling or something else)
would be best.

But looking further into it, it seems maybe like some x86 hack (as
the comments and changelog in 7884084f3bcc and subsequent attempts to
work around Atom and broken firmware suggests). I would have thought
such broken hard/firmware should get workarounds applied to fix the
state values rather than add such logic?

On the other hand, if (CPUIDLE_DRIVER_STATE_START > 0) is shorthand for
if (x86 hacks), that's fine I'm happy to leave that alone and just work
with the else parts...

This is just a draft, but it does what I want at least with regard to
disabling state0 for testing.

Thanks,
Nick

---
 drivers/cpuidle/governors/menu.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index b2330fd69e34..05de5d345ac7 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -286,6 +286,8 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	struct device *device = get_cpu_device(dev->cpu);
 	int latency_req = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
 	int i;
+	int first_idx;
+	int idx;
 	unsigned int interactivity_req;
 	unsigned int expected_interval;
 	unsigned long nr_iowaiters, cpu_load;
@@ -318,7 +320,6 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	data->predicted_us = DIV_ROUND_CLOSEST_ULL((uint64_t)data->next_timer_us *
 					 data->correction_factor[data->bucket],
 					 RESOLUTION * DECAY);
-
 	expected_interval = get_typical_interval(data);
 	expected_interval = min(expected_interval, data->next_timer_us);
 
@@ -327,19 +328,19 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 		unsigned int polling_threshold;
 
 		/*
-		 * We want to default to C1 (hlt), not to busy polling
-		 * unless the timer is happening really really soon, or
-		 * C1's exit latency exceeds the user configured limit.
+		 * x86 wants to avoid busy polling unless the timer is
+		 * happening really really soon, or C1's exit latency exceeds
+		 * the uesr configured limit.
 		 */
 		polling_threshold = max_t(unsigned int, 20, s->target_residency);
 		if (data->next_timer_us > polling_threshold &&
 		    latency_req > s->exit_latency && !s->disabled &&
 		    !dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable)
-			data->last_state_idx = CPUIDLE_DRIVER_STATE_START;
+			first_idx = CPUIDLE_DRIVER_STATE_START;
 		else
-			data->last_state_idx = CPUIDLE_DRIVER_STATE_START - 1;
+			first_idx = CPUIDLE_DRIVER_STATE_START - 1;
 	} else {
-		data->last_state_idx = CPUIDLE_DRIVER_STATE_START;
+		first_idx = 0;
 	}
 
 	/*
@@ -359,7 +360,8 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	 * Find the idle state with the lowest power while satisfying
 	 * our constraints.
 	 */
-	for (i = data->last_state_idx + 1; i < drv->state_count; i++) {
+	idx = -1;
+	for (i = first_idx; i < drv->state_count; i++) {
 		struct cpuidle_state *s = &drv->states[i];
 		struct cpuidle_state_usage *su = &dev->states_usage[i];
 
@@ -370,9 +372,14 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 		if (s->exit_latency > latency_req)
 			break;
 
-		data->last_state_idx = i;
+		idx = i;
 	}
 
+	if (idx == -1) /* no states */
+		idx = 0;
+
+	data->last_state_idx = idx;
+
 	return data->last_state_idx;
 }
 
-- 
2.11.0
