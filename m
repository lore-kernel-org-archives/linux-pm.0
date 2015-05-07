From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RFC PATCH] cpuidle: Remove the default poll idle loop
Date: Thu,  7 May 2015 18:56:20 +0200
Message-ID: <1431017784-19599-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: daniel.lezcano@linaro.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mohammad Merajul Islam Molla <meraj.enigma@gmail.com>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, Mel Gorman <mgorman@suse.de>, Javi Merino <javi.merino@arm.com>, Jiri Kosina <jkosina@suse.cz>, Antonio Ospite <ao2@ao2.it>, "open list:ACPI" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:CPUIDLE DRIVERS" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

The poll idle loop is useful only for the *menu* governor: when there
is a timer about to shutdown very soon (less than 5us), then we default
to the poll idle if no other idle state is found, otherwise the 'hlt'
state is the default.

The poll idle state is x86 specific, hence leading to the DRIVER_START
index hell all around the code and prone to buggy code.

I have been looking on a x86 24 cpus system, how many times this state is
called. It appears to be very rarely used with a recent kernel. Furthermore
the poll code is more than 7 years old and now very fast idle instruction
exists (less than 1us).

Another pitfall with the poll idle state is when the governor makes a bad
prediction and selects this state while the idle state duration is much
more longer, that results in an excessive energy consumption.

Remove this state and the related code as it brings more complexity for
a very discutable benefit.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/processor_idle.c      |  8 ++++----
 drivers/cpuidle/cpuidle.c          |  6 +++---
 drivers/cpuidle/driver.c           | 32 --------------------------------
 drivers/cpuidle/governors/ladder.c | 12 ++++++------
 drivers/cpuidle/governors/menu.c   | 13 ++-----------
 include/linux/cpuidle.h            |  6 ------
 6 files changed, 15 insertions(+), 62 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 39e0c8e..4fbbe07 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -799,7 +799,7 @@ static int acpi_idle_enter(struct cpuidle_device *dev,
 
 	if (cx->type != ACPI_STATE_C1) {
 		if (acpi_idle_fallback_to_c1(pr) && num_online_cpus() > 1) {
-			index = CPUIDLE_DRIVER_STATE_START;
+			index = 0;
 			cx = per_cpu(acpi_cstate[index], dev->cpu);
 		} else if (cx->type == ACPI_STATE_C3 && pr->flags.bm_check) {
 			if (cx->bm_sts_skip || !acpi_idle_bm_check()) {
@@ -863,7 +863,7 @@ struct cpuidle_driver acpi_idle_driver = {
 static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
 					   struct cpuidle_device *dev)
 {
-	int i, count = CPUIDLE_DRIVER_STATE_START;
+	int i, count = 0;
 	struct acpi_processor_cx *cx;
 
 	if (!pr->flags.power_setup_done)
@@ -908,7 +908,7 @@ static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
  */
 static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
 {
-	int i, count = CPUIDLE_DRIVER_STATE_START;
+	int i, count = 0;
 	struct acpi_processor_cx *cx;
 	struct cpuidle_state *state;
 	struct cpuidle_driver *drv = &acpi_idle_driver;
@@ -920,7 +920,7 @@ static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
 		return -EINVAL;
 
 	drv->safe_state_index = -1;
-	for (i = CPUIDLE_DRIVER_STATE_START; i < CPUIDLE_STATE_MAX; i++) {
+	for (i = 0; i < CPUIDLE_STATE_MAX; i++) {
 		drv->states[i].name[0] = '\0';
 		drv->states[i].desc[0] = '\0';
 	}
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 61c417b..ffdbf1f 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -65,7 +65,7 @@ int cpuidle_play_dead(void)
 		return -ENODEV;
 
 	/* Find lowest-power state that supports long-term idle */
-	for (i = drv->state_count - 1; i >= CPUIDLE_DRIVER_STATE_START; i--)
+	for (i = drv->state_count - 1; i >= 0; i--)
 		if (drv->states[i].enter_dead)
 			return drv->states[i].enter_dead(dev, i);
 
@@ -76,9 +76,9 @@ static int find_deepest_state(struct cpuidle_driver *drv,
 			      struct cpuidle_device *dev, bool freeze)
 {
 	unsigned int latency_req = 0;
-	int i, ret = freeze ? -1 : CPUIDLE_DRIVER_STATE_START - 1;
+	int i, ret = freeze ? -1 : 0;
 
-	for (i = CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i++) {
+	for (i = 0; i < drv->state_count; i++) {
 		struct cpuidle_state *s = &drv->states[i];
 		struct cpuidle_state_usage *su = &dev->states_usage[i];
 
diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index 5db1478..8b51220 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -177,36 +177,6 @@ static void __cpuidle_driver_init(struct cpuidle_driver *drv)
 	}
 }
 
-#ifdef CONFIG_ARCH_HAS_CPU_RELAX
-static int poll_idle(struct cpuidle_device *dev,
-		struct cpuidle_driver *drv, int index)
-{
-	local_irq_enable();
-	if (!current_set_polling_and_test()) {
-		while (!need_resched())
-			cpu_relax();
-	}
-	current_clr_polling();
-
-	return index;
-}
-
-static void poll_idle_init(struct cpuidle_driver *drv)
-{
-	struct cpuidle_state *state = &drv->states[0];
-
-	snprintf(state->name, CPUIDLE_NAME_LEN, "POLL");
-	snprintf(state->desc, CPUIDLE_DESC_LEN, "CPUIDLE CORE POLL IDLE");
-	state->exit_latency = 0;
-	state->target_residency = 0;
-	state->power_usage = -1;
-	state->enter = poll_idle;
-	state->disabled = false;
-}
-#else
-static void poll_idle_init(struct cpuidle_driver *drv) {}
-#endif /* !CONFIG_ARCH_HAS_CPU_RELAX */
-
 /**
  * __cpuidle_register_driver: register the driver
  * @drv: a valid pointer to a struct cpuidle_driver
@@ -240,8 +210,6 @@ static int __cpuidle_register_driver(struct cpuidle_driver *drv)
 		on_each_cpu_mask(drv->cpumask, cpuidle_setup_broadcast_timer,
 				 (void *)1, 1);
 
-	poll_idle_init(drv);
-
 	return 0;
 }
 
diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
index 401c010..304e08c 100644
--- a/drivers/cpuidle/governors/ladder.c
+++ b/drivers/cpuidle/governors/ladder.c
@@ -96,13 +96,13 @@ static int ladder_select_state(struct cpuidle_driver *drv,
 	}
 
 	/* consider demotion */
-	if (last_idx > CPUIDLE_DRIVER_STATE_START &&
+	if (last_idx > 0 &&
 	    (drv->states[last_idx].disabled ||
 	    dev->states_usage[last_idx].disable ||
 	    drv->states[last_idx].exit_latency > latency_req)) {
 		int i;
 
-		for (i = last_idx - 1; i > CPUIDLE_DRIVER_STATE_START; i--) {
+		for (i = last_idx - 1; i > 0; i--) {
 			if (drv->states[i].exit_latency <= latency_req)
 				break;
 		}
@@ -110,7 +110,7 @@ static int ladder_select_state(struct cpuidle_driver *drv,
 		return i;
 	}
 
-	if (last_idx > CPUIDLE_DRIVER_STATE_START &&
+	if (last_idx > 0 &&
 	    last_residency < last_state->threshold.demotion_time) {
 		last_state->stats.demotion_count++;
 		last_state->stats.promotion_count = 0;
@@ -137,9 +137,9 @@ static int ladder_enable_device(struct cpuidle_driver *drv,
 	struct ladder_device_state *lstate;
 	struct cpuidle_state *state;
 
-	ldev->last_state_idx = CPUIDLE_DRIVER_STATE_START;
+	ldev->last_state_idx = 0;
 
-	for (i = CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i++) {
+	for (i = 0; i < drv->state_count; i++) {
 		state = &drv->states[i];
 		lstate = &ldev->states[i];
 
@@ -151,7 +151,7 @@ static int ladder_enable_device(struct cpuidle_driver *drv,
 
 		if (i < drv->state_count - 1)
 			lstate->threshold.promotion_time = state->exit_latency;
-		if (i > CPUIDLE_DRIVER_STATE_START)
+		if (i > 0)
 			lstate->threshold.demotion_time = state->exit_latency;
 	}
 
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index b8a5fa1..5c5e7db 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -294,7 +294,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 		data->needs_update = 0;
 	}
 
-	data->last_state_idx = CPUIDLE_DRIVER_STATE_START - 1;
+	data->last_state_idx = 0;
 
 	/* Special case when user has set very strict latency requirement */
 	if (unlikely(latency_req == 0))
@@ -327,19 +327,10 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 		latency_req = interactivity_req;
 
 	/*
-	 * We want to default to C1 (hlt), not to busy polling
-	 * unless the timer is happening really really soon.
-	 */
-	if (data->next_timer_us > 5 &&
-	    !drv->states[CPUIDLE_DRIVER_STATE_START].disabled &&
-		dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable == 0)
-		data->last_state_idx = CPUIDLE_DRIVER_STATE_START;
-
-	/*
 	 * Find the idle state with the lowest power while satisfying
 	 * our constraints.
 	 */
-	for (i = CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i++) {
+	for (i = 0; i < drv->state_count; i++) {
 		struct cpuidle_state *s = &drv->states[i];
 		struct cpuidle_state_usage *su = &dev->states_usage[i];
 
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 9c5e892..351b652 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -236,10 +236,4 @@ static inline int cpuidle_register_governor(struct cpuidle_governor *gov)
 {return 0;}
 #endif
 
-#ifdef CONFIG_ARCH_HAS_CPU_RELAX
-#define CPUIDLE_DRIVER_STATE_START	1
-#else
-#define CPUIDLE_DRIVER_STATE_START	0
-#endif
-
 #endif /* _LINUX_CPUIDLE_H */
-- 
1.9.1

