From: Abhishek Goel <huntbag@linux.vnet.ibm.com>
Subject: [PATCH 1/1] cpuidle-powernv : forced wakeup for stop lite states
Date: Mon, 22 Apr 2019 01:32:31 -0500
Message-ID: <20190422063231.51043-2-huntbag@linux.vnet.ibm.com>
References: <20190422063231.51043-1-huntbag@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190422063231.51043-1-huntbag@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, daniel.lezcano@linaro.org, mpe@ellerman.id.au, ego@linux.vnet.ibm.com, dja@axtens.net, Abhishek Goel <huntbag@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

Currently, the cpuidle governors determine what idle state a idling CPU
should enter into based on heuristics that depend on the idle history on
that CPU. Given that no predictive heuristic is perfect, there are cases
where the governor predicts a shallow idle state, hoping that the CPU will
be busy soon. However, if no new workload is scheduled on that CPU in the
near future, the CPU will end up in the shallow state.

In case of POWER, this is problematic, when the predicted state in the
aforementioned scenario is a lite stop state, as such lite states will
inhibit SMT folding, thereby depriving the other threads in the core from
using the core resources.

So we do not want to get stucked in such states for longer duration. To
address this, the cpuidle-core can queue timer to correspond with the
residency value of the next available state. This timer will forcefully
wakeup the cpu. Few such iterations will essentially train the governor to
select a deeper state for that cpu, as the timer here corresponds to the
next available cpuidle state residency. Cpu will be kicked out of the lite
state and end up in a non-lite state.

Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal-api.h |  1 +
 drivers/cpuidle/cpuidle-powernv.c   | 71 ++++++++++++++++++++++++++++-
 2 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 870fb7b23..735dec731 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -226,6 +226,7 @@
  */
 
 #define OPAL_PM_TIMEBASE_STOP		0x00000002
+#define OPAL_PM_LOSE_USER_CONTEXT	0x00001000
 #define OPAL_PM_LOSE_HYP_CONTEXT	0x00002000
 #define OPAL_PM_LOSE_FULL_CONTEXT	0x00004000
 #define OPAL_PM_NAP_ENABLED		0x00010000
diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 84b1ebe21..30b877962 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -15,6 +15,7 @@
 #include <linux/clockchips.h>
 #include <linux/of.h>
 #include <linux/slab.h>
+#include <linux/hrtimer.h>
 
 #include <asm/machdep.h>
 #include <asm/firmware.h>
@@ -43,6 +44,40 @@ struct stop_psscr_table {
 
 static struct stop_psscr_table stop_psscr_table[CPUIDLE_STATE_MAX] __read_mostly;
 
+DEFINE_PER_CPU(struct hrtimer, forced_wakeup_timer);
+
+static int forced_wakeup_time_compute(struct cpuidle_device *dev,
+				      struct cpuidle_driver *drv,
+				      int index)
+{
+	int i, timeout_us = 0;
+
+	for (i = index + 1; i < drv->state_count; i++) {
+		if (drv->states[i].disabled || dev->states_usage[i].disable)
+			continue;
+		timeout_us = drv->states[i].target_residency +
+				2 * drv->states[i].exit_latency;
+		break;
+	}
+
+	return timeout_us;
+}
+
+enum hrtimer_restart forced_wakeup_hrtimer_callback(struct hrtimer *hrtimer)
+{
+	return HRTIMER_NORESTART;
+}
+
+static void forced_wakeup_timer_init(int cpu, struct cpuidle_driver *drv)
+{
+	struct hrtimer *cpu_forced_wakeup_timer = &per_cpu(forced_wakeup_timer,
+								cpu);
+
+	hrtimer_init(cpu_forced_wakeup_timer, CLOCK_MONOTONIC,
+			HRTIMER_MODE_REL);
+	cpu_forced_wakeup_timer->function = forced_wakeup_hrtimer_callback;
+}
+
 static u64 default_snooze_timeout __read_mostly;
 static bool snooze_timeout_en __read_mostly;
 
@@ -103,6 +138,28 @@ static int snooze_loop(struct cpuidle_device *dev,
 	return index;
 }
 
+static int stop_lite_loop(struct cpuidle_device *dev,
+			  struct cpuidle_driver *drv,
+			  int index)
+{
+	int timeout_us;
+	struct hrtimer *this_timer = &per_cpu(forced_wakeup_timer, dev->cpu);
+
+	timeout_us = forced_wakeup_time_compute(dev, drv, index);
+
+	if (timeout_us > 0)
+		hrtimer_start(this_timer, ns_to_ktime(timeout_us * 1000),
+						HRTIMER_MODE_REL_PINNED);
+
+	power9_idle_type(stop_psscr_table[index].val,
+			 stop_psscr_table[index].mask);
+
+	if (unlikely(hrtimer_is_queued(this_timer)))
+		hrtimer_cancel(this_timer);
+
+	return index;
+}
+
 static int nap_loop(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv,
 			int index)
@@ -190,7 +247,7 @@ static int powernv_cpuidle_cpu_dead(unsigned int cpu)
  */
 static int powernv_cpuidle_driver_init(void)
 {
-	int idle_state;
+	int idle_state, cpu;
 	struct cpuidle_driver *drv = &powernv_idle_driver;
 
 	drv->state_count = 0;
@@ -224,6 +281,9 @@ static int powernv_cpuidle_driver_init(void)
 
 	drv->cpumask = (struct cpumask *)cpu_present_mask;
 
+	for_each_cpu(cpu, drv->cpumask)
+		forced_wakeup_timer_init(cpu, drv);
+
 	return 0;
 }
 
@@ -299,6 +359,7 @@ static int powernv_add_idle_states(void)
 	for (i = 0; i < dt_idle_states; i++) {
 		unsigned int exit_latency, target_residency;
 		bool stops_timebase = false;
+		bool lose_user_context = false;
 		struct pnv_idle_states_t *state = &pnv_idle_states[i];
 
 		/*
@@ -324,6 +385,9 @@ static int powernv_add_idle_states(void)
 		if (has_stop_states && !(state->valid))
 				continue;
 
+		if (state->flags & OPAL_PM_LOSE_USER_CONTEXT)
+			lose_user_context = true;
+
 		if (state->flags & OPAL_PM_TIMEBASE_STOP)
 			stops_timebase = true;
 
@@ -332,6 +396,11 @@ static int powernv_add_idle_states(void)
 			add_powernv_state(nr_idle_states, "Nap",
 					  CPUIDLE_FLAG_NONE, nap_loop,
 					  target_residency, exit_latency, 0, 0);
+		} else if (has_stop_states && !lose_user_context) {
+			add_powernv_state(nr_idle_states, state->name,
+					  CPUIDLE_FLAG_NONE, stop_lite_loop,
+					  target_residency, exit_latency,
+					  state->psscr_val, state->psscr_mask);
 		} else if (has_stop_states && !stops_timebase) {
 			add_powernv_state(nr_idle_states, state->name,
 					  CPUIDLE_FLAG_NONE, stop_loop,
-- 
2.17.1
