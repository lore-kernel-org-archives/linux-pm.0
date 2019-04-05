From: Abhishek Goel <huntbag@linux.vnet.ibm.com>
Subject: [PATCH v2 1/2] cpuidle : auto-promotion for cpuidle states
Date: Fri,  5 Apr 2019 04:16:46 -0500
Message-ID: <20190405091647.4169-2-huntbag@linux.vnet.ibm.com>
References: <20190405091647.4169-1-huntbag@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190405091647.4169-1-huntbag@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, daniel.lezcano@linaro.org, mpe@ellerman.id.au, ego@linux.vnet.ibm.com, Abhishek Goel <huntbag@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

Currently, the cpuidle governors (menu /ladder) determine what idle state
an idling CPU should enter into based on heuristics that depend on the
idle history on that CPU. Given that no predictive heuristic is perfect,
there are cases where the governor predicts a shallow idle state, hoping
that the CPU will be busy soon. However, if no new workload is scheduled
on that CPU in the near future, the CPU will end up in the shallow state.

In case of POWER, this is problematic, when the predicted state in the
aforementioned scenario is a lite stop state, as such lite states will
inhibit SMT folding, thereby depriving the other threads in the core from
using the core resources.

To address this, such lite states need to be autopromoted. The cpuidle-
core can queue timer to correspond with the residency value of the next
available state. Thus leading to auto-promotion to a deeper idle state as
soon as possible.

Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
---

v1->v2 : Removed timeout_needed and rebased to current upstream kernel

 drivers/cpuidle/cpuidle.c          | 68 +++++++++++++++++++++++++++++-
 drivers/cpuidle/governors/ladder.c |  3 +-
 drivers/cpuidle/governors/menu.c   | 22 +++++++++-
 include/linux/cpuidle.h            | 10 ++++-
 4 files changed, 99 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 7f108309e..11ce43f19 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -36,6 +36,11 @@ static int enabled_devices;
 static int off __read_mostly;
 static int initialized __read_mostly;
 
+struct auto_promotion {
+	struct hrtimer  hrtimer;
+	unsigned long	timeout_us;
+};
+
 int cpuidle_disabled(void)
 {
 	return off;
@@ -188,6 +193,54 @@ int cpuidle_enter_s2idle(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 }
 #endif /* CONFIG_SUSPEND */
 
+enum hrtimer_restart auto_promotion_hrtimer_callback(struct hrtimer *hrtimer)
+{
+	return HRTIMER_NORESTART;
+}
+
+#ifdef CONFIG_CPU_IDLE_AUTO_PROMOTION
+DEFINE_PER_CPU(struct auto_promotion, ap);
+
+static void cpuidle_auto_promotion_start(int cpu, struct cpuidle_state *state)
+{
+	struct auto_promotion *this_ap = &per_cpu(ap, cpu);
+
+	if (state->flags & CPUIDLE_FLAG_AUTO_PROMOTION)
+		hrtimer_start(&this_ap->hrtimer, ns_to_ktime(this_ap->timeout_us
+					* 1000), HRTIMER_MODE_REL_PINNED);
+}
+
+static void cpuidle_auto_promotion_cancel(int cpu)
+{
+	struct hrtimer *hrtimer;
+
+	hrtimer = &per_cpu(ap, cpu).hrtimer;
+	if (hrtimer_is_queued(hrtimer))
+		hrtimer_cancel(hrtimer);
+}
+
+static void cpuidle_auto_promotion_update(int cpu, unsigned long timeout)
+{
+	per_cpu(ap, cpu).timeout_us = timeout;
+}
+
+static void cpuidle_auto_promotion_init(int cpu, struct cpuidle_driver *drv)
+{
+	struct auto_promotion *this_ap = &per_cpu(ap, cpu);
+
+	hrtimer_init(&this_ap->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	this_ap->hrtimer.function = auto_promotion_hrtimer_callback;
+}
+#else
+static inline void cpuidle_auto_promotion_start(int cpu, struct cpuidle_state
+						*state) { }
+static inline void cpuidle_auto_promotion_cancel(int cpu) { }
+static inline void cpuidle_auto_promotion_update(int cpu, unsigned long
+						timeout) { }
+static inline void cpuidle_auto_promotion_init(int cpu, struct cpuidle_driver
+						*drv) { }
+#endif
+
 /**
  * cpuidle_enter_state - enter the state and update stats
  * @dev: cpuidle device for this cpu
@@ -225,12 +278,17 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 	trace_cpu_idle_rcuidle(index, dev->cpu);
 	time_start = ns_to_ktime(local_clock());
 
+	cpuidle_auto_promotion_start(dev->cpu, target_state);
+
 	stop_critical_timings();
 	entered_state = target_state->enter(dev, drv, index);
 	start_critical_timings();
 
 	sched_clock_idle_wakeup_event();
 	time_end = ns_to_ktime(local_clock());
+
+	cpuidle_auto_promotion_cancel(dev->cpu);
+
 	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
 
 	/* The cpu is no longer idle or about to enter idle. */
@@ -312,7 +370,13 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		   bool *stop_tick)
 {
-	return cpuidle_curr_governor->select(drv, dev, stop_tick);
+	unsigned long timeout_us, ret;
+
+	timeout_us = UINT_MAX;
+	ret = cpuidle_curr_governor->select(drv, dev, stop_tick, &timeout_us);
+	cpuidle_auto_promotion_update(dev->cpu, timeout_us);
+
+	return ret;
 }
 
 /**
@@ -658,6 +722,8 @@ int cpuidle_register(struct cpuidle_driver *drv,
 		device = &per_cpu(cpuidle_dev, cpu);
 		device->cpu = cpu;
 
+		cpuidle_auto_promotion_init(cpu, drv);
+
 #ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
 		/*
 		 * On multiplatform for ARM, the coupled idle states could be
diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
index f0dddc66a..65b518dd7 100644
--- a/drivers/cpuidle/governors/ladder.c
+++ b/drivers/cpuidle/governors/ladder.c
@@ -64,7 +64,8 @@ static inline void ladder_do_selection(struct ladder_device *ldev,
  * @dummy: not used
  */
 static int ladder_select_state(struct cpuidle_driver *drv,
-			       struct cpuidle_device *dev, bool *dummy)
+			       struct cpuidle_device *dev, bool *dummy,
+			       unsigned long *unused)
 {
 	struct ladder_device *ldev = this_cpu_ptr(&ladder_devices);
 	struct ladder_device_state *last_state;
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 5951604e7..835e337de 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -276,7 +276,7 @@ static unsigned int get_typical_interval(struct menu_device *data,
  * @stop_tick: indication on whether or not to stop the tick
  */
 static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
-		       bool *stop_tick)
+		       bool *stop_tick, unsigned long *timeout)
 {
 	struct menu_device *data = this_cpu_ptr(&menu_devices);
 	int latency_req = cpuidle_governor_latency_req(dev->cpu);
@@ -442,6 +442,26 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		}
 	}
 
+#ifdef CPUIDLE_FLAG_AUTO_PROMOTION
+	if (drv->states[idx].flags & CPUIDLE_FLAG_AUTO_PROMOTION) {
+		/*
+		 * Timeout is intended to be defined as sum of target residency
+		 * of next available state, entry latency and exit latency. If
+		 * time interval equal to timeout is spent in current state,
+		 * and if it is a shallow lite state, we may want to auto-
+		 * promote from such state.
+		 */
+		for (i = idx + 1; i < drv->state_count; i++) {
+			if (drv->states[i].disabled ||
+					dev->states_usage[i].disable)
+				continue;
+			*timeout = drv->states[i].target_residency +
+					2 * drv->states[i].exit_latency;
+			break;
+		}
+	}
+#endif
+
 	return idx;
 }
 
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 3b3947232..84d76d1ec 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -72,6 +72,13 @@ struct cpuidle_state {
 #define CPUIDLE_FLAG_POLLING	BIT(0) /* polling state */
 #define CPUIDLE_FLAG_COUPLED	BIT(1) /* state applies to multiple cpus */
 #define CPUIDLE_FLAG_TIMER_STOP BIT(2) /* timer is stopped on this state */
+/*
+ * State with only and only fast state bit set don't even lose user context.
+ * But such states prevent other sibling threads from thread folding benefits.
+ * And hence we don't want to stay for too long in such states and want to
+ * auto-promote from it.
+ */
+#define CPUIDLE_FLAG_AUTO_PROMOTION	BIT(3)
 
 struct cpuidle_device_kobj;
 struct cpuidle_state_kobj;
@@ -243,7 +250,8 @@ struct cpuidle_governor {
 
 	int  (*select)		(struct cpuidle_driver *drv,
 					struct cpuidle_device *dev,
-					bool *stop_tick);
+					bool *stop_tick, unsigned long
+					*timeout);
 	void (*reflect)		(struct cpuidle_device *dev, int index);
 };
 
-- 
2.17.1
