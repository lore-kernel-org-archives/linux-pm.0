From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/3] cpuidle: Eliminate the CPUIDLE_DRIVER_STATE_START symbol
Date: Wed, 23 Aug 2017 23:19:57 +0200
Message-ID: <2660674.9kuByRF0WC@aspire.rjw.lan>
References: <21794463.WNaOdcSnfv@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <21794463.WNaOdcSnfv@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

On some architectures the first (index 0) idle state is a polling
one and it doesn't really save energy, so there is the
CPUIDLE_DRIVER_STATE_START symbol allowing some pieces of
cpuidle code to avoid using that state.

However, this makes the code rather hard to follow.  It is better
to explicitly avoid the polling state, so add a new cpuidle state
flag CPUIDLE_FLAG_POLLING to mark it and make the relevant code
check that flag for the first state instead of using the
CPUIDLE_DRIVER_STATE_START symbol.

In the ACPI processor driver that cannot always rely on the state
flags (like before the states table has been set up) define
a new internal symbol ACPI_IDLE_STATE_START equivalent to the
CPUIDLE_DRIVER_STATE_START one and drop the latter.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_idle.c      |   10 ++++++----
 drivers/cpuidle/driver.c           |    1 +
 drivers/cpuidle/governors/ladder.c |   14 ++++++++------
 drivers/cpuidle/governors/menu.c   |   13 +++++--------
 include/linux/cpuidle.h            |    7 +------
 5 files changed, 21 insertions(+), 24 deletions(-)

Index: linux-pm/include/linux/cpuidle.h
===================================================================
--- linux-pm.orig/include/linux/cpuidle.h
+++ linux-pm/include/linux/cpuidle.h
@@ -63,6 +63,7 @@ struct cpuidle_state {
 
 /* Idle State Flags */
 #define CPUIDLE_FLAG_NONE       (0x00)
+#define CPUIDLE_FLAG_POLLING	(0x01) /* polling state */
 #define CPUIDLE_FLAG_COUPLED	(0x02) /* state applies to multiple cpus */
 #define CPUIDLE_FLAG_TIMER_STOP (0x04)  /* timer is stopped on this state */
 
@@ -250,12 +251,6 @@ static inline int cpuidle_register_gover
 {return 0;}
 #endif
 
-#ifdef CONFIG_ARCH_HAS_CPU_RELAX
-#define CPUIDLE_DRIVER_STATE_START	1
-#else
-#define CPUIDLE_DRIVER_STATE_START	0
-#endif
-
 #define CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx)	\
 ({								\
 	int __ret;						\
Index: linux-pm/drivers/cpuidle/driver.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/driver.c
+++ linux-pm/drivers/cpuidle/driver.c
@@ -204,6 +204,7 @@ static void poll_idle_init(struct cpuidl
 	state->power_usage = -1;
 	state->enter = poll_idle;
 	state->disabled = false;
+	state->flags = CPUIDLE_FLAG_POLLING;
 }
 #else
 static void poll_idle_init(struct cpuidle_driver *drv) {}
Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -324,8 +324,9 @@ static int menu_select(struct cpuidle_dr
 	expected_interval = get_typical_interval(data);
 	expected_interval = min(expected_interval, data->next_timer_us);
 
-	if (CPUIDLE_DRIVER_STATE_START > 0) {
-		struct cpuidle_state *s = &drv->states[CPUIDLE_DRIVER_STATE_START];
+	first_idx = 0;
+	if (drv->states[0].flags & CPUIDLE_FLAG_POLLING) {
+		struct cpuidle_state *s = &drv->states[1];
 		unsigned int polling_threshold;
 
 		/*
@@ -336,12 +337,8 @@ static int menu_select(struct cpuidle_dr
 		polling_threshold = max_t(unsigned int, 20, s->target_residency);
 		if (data->next_timer_us > polling_threshold &&
 		    latency_req > s->exit_latency && !s->disabled &&
-		    !dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable)
-			first_idx = CPUIDLE_DRIVER_STATE_START;
-		else
-			first_idx = CPUIDLE_DRIVER_STATE_START - 1;
-	} else {
-		first_idx = 0;
+		    !dev->states_usage[1].disable)
+			first_idx = 1;
 	}
 
 	/*
Index: linux-pm/drivers/cpuidle/governors/ladder.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/ladder.c
+++ linux-pm/drivers/cpuidle/governors/ladder.c
@@ -69,6 +69,7 @@ static int ladder_select_state(struct cp
 	struct ladder_device *ldev = this_cpu_ptr(&ladder_devices);
 	struct ladder_device_state *last_state;
 	int last_residency, last_idx = ldev->last_state_idx;
+	int first_idx = drv->states[0].flags & CPUIDLE_FLAG_POLLING ? 1 : 0;
 	int latency_req = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
 
 	/* Special case when user has set very strict latency requirement */
@@ -96,13 +97,13 @@ static int ladder_select_state(struct cp
 	}
 
 	/* consider demotion */
-	if (last_idx > CPUIDLE_DRIVER_STATE_START &&
+	if (last_idx > first_idx &&
 	    (drv->states[last_idx].disabled ||
 	    dev->states_usage[last_idx].disable ||
 	    drv->states[last_idx].exit_latency > latency_req)) {
 		int i;
 
-		for (i = last_idx - 1; i > CPUIDLE_DRIVER_STATE_START; i--) {
+		for (i = last_idx - 1; i > first_idx; i--) {
 			if (drv->states[i].exit_latency <= latency_req)
 				break;
 		}
@@ -110,7 +111,7 @@ static int ladder_select_state(struct cp
 		return i;
 	}
 
-	if (last_idx > CPUIDLE_DRIVER_STATE_START &&
+	if (last_idx > first_idx &&
 	    last_residency < last_state->threshold.demotion_time) {
 		last_state->stats.demotion_count++;
 		last_state->stats.promotion_count = 0;
@@ -133,13 +134,14 @@ static int ladder_enable_device(struct c
 				struct cpuidle_device *dev)
 {
 	int i;
+	int first_idx = drv->states[0].flags & CPUIDLE_FLAG_POLLING ? 1 : 0;
 	struct ladder_device *ldev = &per_cpu(ladder_devices, dev->cpu);
 	struct ladder_device_state *lstate;
 	struct cpuidle_state *state;
 
-	ldev->last_state_idx = CPUIDLE_DRIVER_STATE_START;
+	ldev->last_state_idx = first_idx;
 
-	for (i = CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i++) {
+	for (i = first_idx; i < drv->state_count; i++) {
 		state = &drv->states[i];
 		lstate = &ldev->states[i];
 
@@ -151,7 +153,7 @@ static int ladder_enable_device(struct c
 
 		if (i < drv->state_count - 1)
 			lstate->threshold.promotion_time = state->exit_latency;
-		if (i > CPUIDLE_DRIVER_STATE_START)
+		if (i > first_idx)
 			lstate->threshold.demotion_time = state->exit_latency;
 	}
 
Index: linux-pm/drivers/acpi/processor_idle.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_idle.c
+++ linux-pm/drivers/acpi/processor_idle.c
@@ -48,6 +48,8 @@
 #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("processor_idle");
 
+#define ACPI_IDLE_STATE_START	(IS_ENABLED(CONFIG_ARCH_HAS_CPU_RELAX) ? 1 : 0)
+
 static unsigned int max_cstate __read_mostly = ACPI_PROCESSOR_MAX_POWER;
 module_param(max_cstate, uint, 0000);
 static unsigned int nocst __read_mostly;
@@ -761,7 +763,7 @@ static int acpi_idle_enter(struct cpuidl
 
 	if (cx->type != ACPI_STATE_C1) {
 		if (acpi_idle_fallback_to_c1(pr) && num_online_cpus() > 1) {
-			index = CPUIDLE_DRIVER_STATE_START;
+			index = ACPI_IDLE_STATE_START;
 			cx = per_cpu(acpi_cstate[index], dev->cpu);
 		} else if (cx->type == ACPI_STATE_C3 && pr->flags.bm_check) {
 			if (cx->bm_sts_skip || !acpi_idle_bm_check()) {
@@ -813,7 +815,7 @@ static void acpi_idle_enter_s2idle(struc
 static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
 					   struct cpuidle_device *dev)
 {
-	int i, count = CPUIDLE_DRIVER_STATE_START;
+	int i, count = ACPI_IDLE_STATE_START;
 	struct acpi_processor_cx *cx;
 
 	if (max_cstate == 0)
@@ -840,7 +842,7 @@ static int acpi_processor_setup_cpuidle_
 
 static int acpi_processor_setup_cstates(struct acpi_processor *pr)
 {
-	int i, count = CPUIDLE_DRIVER_STATE_START;
+	int i, count = ACPI_IDLE_STATE_START;
 	struct acpi_processor_cx *cx;
 	struct cpuidle_state *state;
 	struct cpuidle_driver *drv = &acpi_idle_driver;
@@ -1291,7 +1293,7 @@ static int acpi_processor_setup_cpuidle_
 		return -EINVAL;
 
 	drv->safe_state_index = -1;
-	for (i = CPUIDLE_DRIVER_STATE_START; i < CPUIDLE_STATE_MAX; i++) {
+	for (i = ACPI_IDLE_STATE_START; i < CPUIDLE_STATE_MAX; i++) {
 		drv->states[i].name[0] = '\0';
 		drv->states[i].desc[0] = '\0';
 	}
