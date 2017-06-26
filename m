From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] cpuidle: menu: allow state 0 to be disabled
Date: Mon, 26 Jun 2017 15:38:15 +1000
Message-ID: <20170626053815.11845-1-npiggin@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-pm@vger.kernel.org, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The menu driver does not allow state0 to be disabled completely.
If it is disabled but other enabled states don't meet latency
requirements, it is still used.

Fix this by starting with the first enabled idle state. Fall back
to state 0 if no idle states are enabled (arguably this should be
-EINVAL if it is attempted, but this is the minimal fix).

Acked-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

Hi Rafael,

This patch is helpful when measuring power draw of polling,
latency cost of idle states, etc. Please consider merging if
you agree.

Thanks,
Nick


 drivers/cpuidle/governors/menu.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index b2330fd69e34..61b64c2b2cb8 100644
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
@@ -335,11 +337,11 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
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
@@ -359,20 +361,28 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	 * Find the idle state with the lowest power while satisfying
 	 * our constraints.
 	 */
-	for (i = data->last_state_idx + 1; i < drv->state_count; i++) {
+	idx = -1;
+	for (i = first_idx; i < drv->state_count; i++) {
 		struct cpuidle_state *s = &drv->states[i];
 		struct cpuidle_state_usage *su = &dev->states_usage[i];
 
 		if (s->disabled || su->disable)
 			continue;
+		if (idx == -1)
+			idx = i; /* first enabled state */
 		if (s->target_residency > data->predicted_us)
 			break;
 		if (s->exit_latency > latency_req)
 			break;
 
-		data->last_state_idx = i;
+		idx = i;
 	}
 
+	if (idx == -1)
+		idx = 0; /* No states enabled. Must use 0. */
+
+	data->last_state_idx = idx;
+
 	return data->last_state_idx;
 }
 
-- 
2.11.0
