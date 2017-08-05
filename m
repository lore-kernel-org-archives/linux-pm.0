From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 3/4] PM / s2idle: Rename ->enter_freeze to ->enter_s2idle
Date: Sat, 05 Aug 2017 14:59:33 +0200
Message-ID: <3551395.ZQB7L0IZud@aspire.rjw.lan>
References: <1912685.WjJGzNPQ5e@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1912685.WjJGzNPQ5e@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Rename the ->enter_freeze cpuidle driver callback to ->enter_s2idle
to make it clear that it is used for entering suspend-to-idle and
rename the related functions, variables and so on accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/arm/mach-tegra/cpuidle-tegra114.c |    4 
 drivers/acpi/processor_idle.c          |    6 -
 drivers/cpuidle/cpuidle.c              |   18 +--
 drivers/cpuidle/dt_idle_states.c       |    4 
 drivers/idle/intel_idle.c              |  180 ++++++++++++++++-----------------
 include/linux/cpuidle.h                |    8 -
 kernel/sched/idle.c                    |    2 
 7 files changed, 111 insertions(+), 111 deletions(-)

Index: linux-pm/include/linux/cpuidle.h
===================================================================
--- linux-pm.orig/include/linux/cpuidle.h
+++ linux-pm/include/linux/cpuidle.h
@@ -52,11 +52,11 @@ struct cpuidle_state {
 	int (*enter_dead) (struct cpuidle_device *dev, int index);
 
 	/*
-	 * CPUs execute ->enter_freeze with the local tick or entire timekeeping
+	 * CPUs execute ->enter_s2idle with the local tick or entire timekeeping
 	 * suspended, so it must not re-enable interrupts at any point (even
 	 * temporarily) or attempt to change states of clock event devices.
 	 */
-	void (*enter_freeze) (struct cpuidle_device *dev,
+	void (*enter_s2idle) (struct cpuidle_device *dev,
 			      struct cpuidle_driver *drv,
 			      int index);
 };
@@ -197,14 +197,14 @@ static inline struct cpuidle_device *cpu
 #ifdef CONFIG_CPU_IDLE
 extern int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 				      struct cpuidle_device *dev);
-extern int cpuidle_enter_freeze(struct cpuidle_driver *drv,
+extern int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
 				struct cpuidle_device *dev);
 extern void cpuidle_use_deepest_state(bool enable);
 #else
 static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 					     struct cpuidle_device *dev)
 {return -ENODEV; }
-static inline int cpuidle_enter_freeze(struct cpuidle_driver *drv,
+static inline int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
 				       struct cpuidle_device *dev)
 {return -ENODEV; }
 static inline void cpuidle_use_deepest_state(bool enable)
Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -77,7 +77,7 @@ static int find_deepest_state(struct cpu
 			      struct cpuidle_device *dev,
 			      unsigned int max_latency,
 			      unsigned int forbidden_flags,
-			      bool freeze)
+			      bool s2idle)
 {
 	unsigned int latency_req = 0;
 	int i, ret = 0;
@@ -89,7 +89,7 @@ static int find_deepest_state(struct cpu
 		if (s->disabled || su->disable || s->exit_latency <= latency_req
 		    || s->exit_latency > max_latency
 		    || (s->flags & forbidden_flags)
-		    || (freeze && !s->enter_freeze))
+		    || (s2idle && !s->enter_s2idle))
 			continue;
 
 		latency_req = s->exit_latency;
@@ -128,7 +128,7 @@ int cpuidle_find_deepest_state(struct cp
 }
 
 #ifdef CONFIG_SUSPEND
-static void enter_freeze_proper(struct cpuidle_driver *drv,
+static void enter_s2idle_proper(struct cpuidle_driver *drv,
 				struct cpuidle_device *dev, int index)
 {
 	/*
@@ -143,7 +143,7 @@ static void enter_freeze_proper(struct c
 	 * suspended is generally unsafe.
 	 */
 	stop_critical_timings();
-	drv->states[index].enter_freeze(dev, drv, index);
+	drv->states[index].enter_s2idle(dev, drv, index);
 	WARN_ON(!irqs_disabled());
 	/*
 	 * timekeeping_resume() that will be called by tick_unfreeze() for the
@@ -155,25 +155,25 @@ static void enter_freeze_proper(struct c
 }
 
 /**
- * cpuidle_enter_freeze - Enter an idle state suitable for suspend-to-idle.
+ * cpuidle_enter_s2idle - Enter an idle state suitable for suspend-to-idle.
  * @drv: cpuidle driver for the given CPU.
  * @dev: cpuidle device for the given CPU.
  *
- * If there are states with the ->enter_freeze callback, find the deepest of
+ * If there are states with the ->enter_s2idle callback, find the deepest of
  * them and enter it with frozen tick.
  */
-int cpuidle_enter_freeze(struct cpuidle_driver *drv, struct cpuidle_device *dev)
+int cpuidle_enter_s2idle(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 {
 	int index;
 
 	/*
-	 * Find the deepest state with ->enter_freeze present, which guarantees
+	 * Find the deepest state with ->enter_s2idle present, which guarantees
 	 * that interrupts won't be enabled when it exits and allows the tick to
 	 * be frozen safely.
 	 */
 	index = find_deepest_state(drv, dev, UINT_MAX, 0, true);
 	if (index > 0)
-		enter_freeze_proper(drv, dev, index);
+		enter_s2idle_proper(drv, dev, index);
 
 	return index;
 }
Index: linux-pm/kernel/sched/idle.c
===================================================================
--- linux-pm.orig/kernel/sched/idle.c
+++ linux-pm/kernel/sched/idle.c
@@ -169,7 +169,7 @@ static void cpuidle_idle_call(void)
 
 	if (idle_should_enter_s2idle() || dev->use_deepest_state) {
 		if (idle_should_enter_s2idle()) {
-			entered_state = cpuidle_enter_freeze(drv, dev);
+			entered_state = cpuidle_enter_s2idle(drv, dev);
 			if (entered_state > 0) {
 				local_irq_enable();
 				goto exit_idle;
Index: linux-pm/drivers/idle/intel_idle.c
===================================================================
--- linux-pm.orig/drivers/idle/intel_idle.c
+++ linux-pm/drivers/idle/intel_idle.c
@@ -97,7 +97,7 @@ static const struct idle_cpu *icpu;
 static struct cpuidle_device __percpu *intel_idle_cpuidle_devices;
 static int intel_idle(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv, int index);
-static void intel_idle_freeze(struct cpuidle_device *dev,
+static void intel_idle_s2idle(struct cpuidle_device *dev,
 			      struct cpuidle_driver *drv, int index);
 static struct cpuidle_state *cpuidle_state_table;
 
@@ -132,7 +132,7 @@ static struct cpuidle_state nehalem_csta
 		.exit_latency = 3,
 		.target_residency = 6,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
@@ -140,7 +140,7 @@ static struct cpuidle_state nehalem_csta
 		.exit_latency = 10,
 		.target_residency = 20,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C3",
 		.desc = "MWAIT 0x10",
@@ -148,7 +148,7 @@ static struct cpuidle_state nehalem_csta
 		.exit_latency = 20,
 		.target_residency = 80,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x20",
@@ -156,7 +156,7 @@ static struct cpuidle_state nehalem_csta
 		.exit_latency = 200,
 		.target_residency = 800,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
 };
@@ -169,7 +169,7 @@ static struct cpuidle_state snb_cstates[
 		.exit_latency = 2,
 		.target_residency = 2,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
@@ -177,7 +177,7 @@ static struct cpuidle_state snb_cstates[
 		.exit_latency = 10,
 		.target_residency = 20,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C3",
 		.desc = "MWAIT 0x10",
@@ -185,7 +185,7 @@ static struct cpuidle_state snb_cstates[
 		.exit_latency = 80,
 		.target_residency = 211,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x20",
@@ -193,7 +193,7 @@ static struct cpuidle_state snb_cstates[
 		.exit_latency = 104,
 		.target_residency = 345,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C7",
 		.desc = "MWAIT 0x30",
@@ -201,7 +201,7 @@ static struct cpuidle_state snb_cstates[
 		.exit_latency = 109,
 		.target_residency = 345,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
 };
@@ -214,7 +214,7 @@ static struct cpuidle_state byt_cstates[
 		.exit_latency = 1,
 		.target_residency = 1,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6N",
 		.desc = "MWAIT 0x58",
@@ -222,7 +222,7 @@ static struct cpuidle_state byt_cstates[
 		.exit_latency = 300,
 		.target_residency = 275,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6S",
 		.desc = "MWAIT 0x52",
@@ -230,7 +230,7 @@ static struct cpuidle_state byt_cstates[
 		.exit_latency = 500,
 		.target_residency = 560,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C7",
 		.desc = "MWAIT 0x60",
@@ -238,7 +238,7 @@ static struct cpuidle_state byt_cstates[
 		.exit_latency = 1200,
 		.target_residency = 4000,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C7S",
 		.desc = "MWAIT 0x64",
@@ -246,7 +246,7 @@ static struct cpuidle_state byt_cstates[
 		.exit_latency = 10000,
 		.target_residency = 20000,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
 };
@@ -259,7 +259,7 @@ static struct cpuidle_state cht_cstates[
 		.exit_latency = 1,
 		.target_residency = 1,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6N",
 		.desc = "MWAIT 0x58",
@@ -267,7 +267,7 @@ static struct cpuidle_state cht_cstates[
 		.exit_latency = 80,
 		.target_residency = 275,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6S",
 		.desc = "MWAIT 0x52",
@@ -275,7 +275,7 @@ static struct cpuidle_state cht_cstates[
 		.exit_latency = 200,
 		.target_residency = 560,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C7",
 		.desc = "MWAIT 0x60",
@@ -283,7 +283,7 @@ static struct cpuidle_state cht_cstates[
 		.exit_latency = 1200,
 		.target_residency = 4000,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C7S",
 		.desc = "MWAIT 0x64",
@@ -291,7 +291,7 @@ static struct cpuidle_state cht_cstates[
 		.exit_latency = 10000,
 		.target_residency = 20000,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
 };
@@ -304,7 +304,7 @@ static struct cpuidle_state ivb_cstates[
 		.exit_latency = 1,
 		.target_residency = 1,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
@@ -312,7 +312,7 @@ static struct cpuidle_state ivb_cstates[
 		.exit_latency = 10,
 		.target_residency = 20,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C3",
 		.desc = "MWAIT 0x10",
@@ -320,7 +320,7 @@ static struct cpuidle_state ivb_cstates[
 		.exit_latency = 59,
 		.target_residency = 156,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x20",
@@ -328,7 +328,7 @@ static struct cpuidle_state ivb_cstates[
 		.exit_latency = 80,
 		.target_residency = 300,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C7",
 		.desc = "MWAIT 0x30",
@@ -336,7 +336,7 @@ static struct cpuidle_state ivb_cstates[
 		.exit_latency = 87,
 		.target_residency = 300,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
 };
@@ -349,7 +349,7 @@ static struct cpuidle_state ivt_cstates[
 		.exit_latency = 1,
 		.target_residency = 1,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
@@ -357,7 +357,7 @@ static struct cpuidle_state ivt_cstates[
 		.exit_latency = 10,
 		.target_residency = 80,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C3",
 		.desc = "MWAIT 0x10",
@@ -365,7 +365,7 @@ static struct cpuidle_state ivt_cstates[
 		.exit_latency = 59,
 		.target_residency = 156,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x20",
@@ -373,7 +373,7 @@ static struct cpuidle_state ivt_cstates[
 		.exit_latency = 82,
 		.target_residency = 300,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
 };
@@ -386,7 +386,7 @@ static struct cpuidle_state ivt_cstates_
 		.exit_latency = 1,
 		.target_residency = 1,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
@@ -394,7 +394,7 @@ static struct cpuidle_state ivt_cstates_
 		.exit_latency = 10,
 		.target_residency = 250,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C3",
 		.desc = "MWAIT 0x10",
@@ -402,7 +402,7 @@ static struct cpuidle_state ivt_cstates_
 		.exit_latency = 59,
 		.target_residency = 300,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x20",
@@ -410,7 +410,7 @@ static struct cpuidle_state ivt_cstates_
 		.exit_latency = 84,
 		.target_residency = 400,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
 };
@@ -423,7 +423,7 @@ static struct cpuidle_state ivt_cstates_
 		.exit_latency = 1,
 		.target_residency = 1,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
@@ -431,7 +431,7 @@ static struct cpuidle_state ivt_cstates_
 		.exit_latency = 10,
 		.target_residency = 500,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C3",
 		.desc = "MWAIT 0x10",
@@ -439,7 +439,7 @@ static struct cpuidle_state ivt_cstates_
 		.exit_latency = 59,
 		.target_residency = 600,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x20",
@@ -447,7 +447,7 @@ static struct cpuidle_state ivt_cstates_
 		.exit_latency = 88,
 		.target_residency = 700,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
 };
@@ -460,7 +460,7 @@ static struct cpuidle_state hsw_cstates[
 		.exit_latency = 2,
 		.target_residency = 2,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
@@ -468,7 +468,7 @@ static struct cpuidle_state hsw_cstates[
 		.exit_latency = 10,
 		.target_residency = 20,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C3",
 		.desc = "MWAIT 0x10",
@@ -476,7 +476,7 @@ static struct cpuidle_state hsw_cstates[
 		.exit_latency = 33,
 		.target_residency = 100,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x20",
@@ -484,7 +484,7 @@ static struct cpuidle_state hsw_cstates[
 		.exit_latency = 133,
 		.target_residency = 400,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C7s",
 		.desc = "MWAIT 0x32",
@@ -492,7 +492,7 @@ static struct cpuidle_state hsw_cstates[
 		.exit_latency = 166,
 		.target_residency = 500,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C8",
 		.desc = "MWAIT 0x40",
@@ -500,7 +500,7 @@ static struct cpuidle_state hsw_cstates[
 		.exit_latency = 300,
 		.target_residency = 900,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C9",
 		.desc = "MWAIT 0x50",
@@ -508,7 +508,7 @@ static struct cpuidle_state hsw_cstates[
 		.exit_latency = 600,
 		.target_residency = 1800,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C10",
 		.desc = "MWAIT 0x60",
@@ -516,7 +516,7 @@ static struct cpuidle_state hsw_cstates[
 		.exit_latency = 2600,
 		.target_residency = 7700,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
 };
@@ -528,7 +528,7 @@ static struct cpuidle_state bdw_cstates[
 		.exit_latency = 2,
 		.target_residency = 2,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
@@ -536,7 +536,7 @@ static struct cpuidle_state bdw_cstates[
 		.exit_latency = 10,
 		.target_residency = 20,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C3",
 		.desc = "MWAIT 0x10",
@@ -544,7 +544,7 @@ static struct cpuidle_state bdw_cstates[
 		.exit_latency = 40,
 		.target_residency = 100,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x20",
@@ -552,7 +552,7 @@ static struct cpuidle_state bdw_cstates[
 		.exit_latency = 133,
 		.target_residency = 400,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C7s",
 		.desc = "MWAIT 0x32",
@@ -560,7 +560,7 @@ static struct cpuidle_state bdw_cstates[
 		.exit_latency = 166,
 		.target_residency = 500,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C8",
 		.desc = "MWAIT 0x40",
@@ -568,7 +568,7 @@ static struct cpuidle_state bdw_cstates[
 		.exit_latency = 300,
 		.target_residency = 900,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C9",
 		.desc = "MWAIT 0x50",
@@ -576,7 +576,7 @@ static struct cpuidle_state bdw_cstates[
 		.exit_latency = 600,
 		.target_residency = 1800,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C10",
 		.desc = "MWAIT 0x60",
@@ -584,7 +584,7 @@ static struct cpuidle_state bdw_cstates[
 		.exit_latency = 2600,
 		.target_residency = 7700,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
 };
@@ -597,7 +597,7 @@ static struct cpuidle_state skl_cstates[
 		.exit_latency = 2,
 		.target_residency = 2,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
@@ -605,7 +605,7 @@ static struct cpuidle_state skl_cstates[
 		.exit_latency = 10,
 		.target_residency = 20,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C3",
 		.desc = "MWAIT 0x10",
@@ -613,7 +613,7 @@ static struct cpuidle_state skl_cstates[
 		.exit_latency = 70,
 		.target_residency = 100,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x20",
@@ -621,7 +621,7 @@ static struct cpuidle_state skl_cstates[
 		.exit_latency = 85,
 		.target_residency = 200,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C7s",
 		.desc = "MWAIT 0x33",
@@ -629,7 +629,7 @@ static struct cpuidle_state skl_cstates[
 		.exit_latency = 124,
 		.target_residency = 800,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C8",
 		.desc = "MWAIT 0x40",
@@ -637,7 +637,7 @@ static struct cpuidle_state skl_cstates[
 		.exit_latency = 200,
 		.target_residency = 800,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C9",
 		.desc = "MWAIT 0x50",
@@ -645,7 +645,7 @@ static struct cpuidle_state skl_cstates[
 		.exit_latency = 480,
 		.target_residency = 5000,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C10",
 		.desc = "MWAIT 0x60",
@@ -653,7 +653,7 @@ static struct cpuidle_state skl_cstates[
 		.exit_latency = 890,
 		.target_residency = 5000,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
 };
@@ -666,7 +666,7 @@ static struct cpuidle_state skx_cstates[
 		.exit_latency = 2,
 		.target_residency = 2,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
@@ -674,7 +674,7 @@ static struct cpuidle_state skx_cstates[
 		.exit_latency = 10,
 		.target_residency = 20,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x20",
@@ -682,7 +682,7 @@ static struct cpuidle_state skx_cstates[
 		.exit_latency = 133,
 		.target_residency = 600,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
 };
@@ -695,7 +695,7 @@ static struct cpuidle_state atom_cstates
 		.exit_latency = 10,
 		.target_residency = 20,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C2",
 		.desc = "MWAIT 0x10",
@@ -703,7 +703,7 @@ static struct cpuidle_state atom_cstates
 		.exit_latency = 20,
 		.target_residency = 80,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C4",
 		.desc = "MWAIT 0x30",
@@ -711,7 +711,7 @@ static struct cpuidle_state atom_cstates
 		.exit_latency = 100,
 		.target_residency = 400,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x52",
@@ -719,7 +719,7 @@ static struct cpuidle_state atom_cstates
 		.exit_latency = 140,
 		.target_residency = 560,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
 };
@@ -731,7 +731,7 @@ static struct cpuidle_state tangier_csta
 		.exit_latency = 1,
 		.target_residency = 4,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C4",
 		.desc = "MWAIT 0x30",
@@ -739,7 +739,7 @@ static struct cpuidle_state tangier_csta
 		.exit_latency = 100,
 		.target_residency = 400,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x52",
@@ -747,7 +747,7 @@ static struct cpuidle_state tangier_csta
 		.exit_latency = 140,
 		.target_residency = 560,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C7",
 		.desc = "MWAIT 0x60",
@@ -755,7 +755,7 @@ static struct cpuidle_state tangier_csta
 		.exit_latency = 1200,
 		.target_residency = 4000,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C9",
 		.desc = "MWAIT 0x64",
@@ -763,7 +763,7 @@ static struct cpuidle_state tangier_csta
 		.exit_latency = 10000,
 		.target_residency = 20000,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
 };
@@ -775,7 +775,7 @@ static struct cpuidle_state avn_cstates[
 		.exit_latency = 2,
 		.target_residency = 2,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x51",
@@ -783,7 +783,7 @@ static struct cpuidle_state avn_cstates[
 		.exit_latency = 15,
 		.target_residency = 45,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
 };
@@ -795,7 +795,7 @@ static struct cpuidle_state knl_cstates[
 		.exit_latency = 1,
 		.target_residency = 2,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze },
+		.enter_s2idle = intel_idle_s2idle },
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x10",
@@ -803,7 +803,7 @@ static struct cpuidle_state knl_cstates[
 		.exit_latency = 120,
 		.target_residency = 500,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze },
+		.enter_s2idle = intel_idle_s2idle },
 	{
 		.enter = NULL }
 };
@@ -816,7 +816,7 @@ static struct cpuidle_state bxt_cstates[
 		.exit_latency = 2,
 		.target_residency = 2,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
@@ -824,7 +824,7 @@ static struct cpuidle_state bxt_cstates[
 		.exit_latency = 10,
 		.target_residency = 20,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x20",
@@ -832,7 +832,7 @@ static struct cpuidle_state bxt_cstates[
 		.exit_latency = 133,
 		.target_residency = 133,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C7s",
 		.desc = "MWAIT 0x31",
@@ -840,7 +840,7 @@ static struct cpuidle_state bxt_cstates[
 		.exit_latency = 155,
 		.target_residency = 155,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C8",
 		.desc = "MWAIT 0x40",
@@ -848,7 +848,7 @@ static struct cpuidle_state bxt_cstates[
 		.exit_latency = 1000,
 		.target_residency = 1000,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C9",
 		.desc = "MWAIT 0x50",
@@ -856,7 +856,7 @@ static struct cpuidle_state bxt_cstates[
 		.exit_latency = 2000,
 		.target_residency = 2000,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C10",
 		.desc = "MWAIT 0x60",
@@ -864,7 +864,7 @@ static struct cpuidle_state bxt_cstates[
 		.exit_latency = 10000,
 		.target_residency = 10000,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
 };
@@ -877,7 +877,7 @@ static struct cpuidle_state dnv_cstates[
 		.exit_latency = 2,
 		.target_residency = 2,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
@@ -885,7 +885,7 @@ static struct cpuidle_state dnv_cstates[
 		.exit_latency = 10,
 		.target_residency = 20,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
 		.desc = "MWAIT 0x20",
@@ -893,7 +893,7 @@ static struct cpuidle_state dnv_cstates[
 		.exit_latency = 50,
 		.target_residency = 500,
 		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
 };
@@ -936,12 +936,12 @@ static __cpuidle int intel_idle(struct c
 }
 
 /**
- * intel_idle_freeze - simplified "enter" callback routine for suspend-to-idle
+ * intel_idle_s2idle - simplified "enter" callback routine for suspend-to-idle
  * @dev: cpuidle_device
  * @drv: cpuidle driver
  * @index: state index
  */
-static void intel_idle_freeze(struct cpuidle_device *dev,
+static void intel_idle_s2idle(struct cpuidle_device *dev,
 			     struct cpuidle_driver *drv, int index)
 {
 	unsigned long ecx = 1; /* break on interrupt flag */
@@ -1337,7 +1337,7 @@ static void __init intel_idle_cpuidle_dr
 		int num_substates, mwait_hint, mwait_cstate;
 
 		if ((cpuidle_state_table[cstate].enter == NULL) &&
-		    (cpuidle_state_table[cstate].enter_freeze == NULL))
+		    (cpuidle_state_table[cstate].enter_s2idle == NULL))
 			break;
 
 		if (cstate + 1 > max_cstate) {
Index: linux-pm/drivers/acpi/processor_idle.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_idle.c
+++ linux-pm/drivers/acpi/processor_idle.c
@@ -789,7 +789,7 @@ static int acpi_idle_enter(struct cpuidl
 	return index;
 }
 
-static void acpi_idle_enter_freeze(struct cpuidle_device *dev,
+static void acpi_idle_enter_s2idle(struct cpuidle_device *dev,
 				   struct cpuidle_driver *drv, int index)
 {
 	struct acpi_processor_cx *cx = per_cpu(acpi_cstate[index], dev->cpu);
@@ -867,14 +867,14 @@ static int acpi_processor_setup_cstates(
 			drv->safe_state_index = count;
 		}
 		/*
-		 * Halt-induced C1 is not good for ->enter_freeze, because it
+		 * Halt-induced C1 is not good for ->enter_s2idle, because it
 		 * re-enables interrupts on exit.  Moreover, C1 is generally not
 		 * particularly interesting from the suspend-to-idle angle, so
 		 * avoid C1 and the situations in which we may need to fall back
 		 * to it altogether.
 		 */
 		if (cx->type != ACPI_STATE_C1 && !acpi_idle_fallback_to_c1(pr))
-			state->enter_freeze = acpi_idle_enter_freeze;
+			state->enter_s2idle = acpi_idle_enter_s2idle;
 
 		count++;
 		if (count == CPUIDLE_STATE_MAX)
Index: linux-pm/drivers/cpuidle/dt_idle_states.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/dt_idle_states.c
+++ linux-pm/drivers/cpuidle/dt_idle_states.c
@@ -41,9 +41,9 @@ static int init_state_node(struct cpuidl
 	/*
 	 * Since this is not a "coupled" state, it's safe to assume interrupts
 	 * won't be enabled when it exits allowing the tick to be frozen
-	 * safely. So enter() can be also enter_freeze() callback.
+	 * safely. So enter() can be also enter_s2idle() callback.
 	 */
-	idle_state->enter_freeze = match_id->data;
+	idle_state->enter_s2idle = match_id->data;
 
 	err = of_property_read_u32(state_node, "wakeup-latency-us",
 				   &idle_state->exit_latency);
Index: linux-pm/arch/arm/mach-tegra/cpuidle-tegra114.c
===================================================================
--- linux-pm.orig/arch/arm/mach-tegra/cpuidle-tegra114.c
+++ linux-pm/arch/arm/mach-tegra/cpuidle-tegra114.c
@@ -60,7 +60,7 @@ static int tegra114_idle_power_down(stru
 	return index;
 }
 
-static void tegra114_idle_enter_freeze(struct cpuidle_device *dev,
+static void tegra114_idle_enter_s2idle(struct cpuidle_device *dev,
 				       struct cpuidle_driver *drv,
 				       int index)
 {
@@ -77,7 +77,7 @@ static struct cpuidle_driver tegra_idle_
 #ifdef CONFIG_PM_SLEEP
 		[1] = {
 			.enter			= tegra114_idle_power_down,
-			.enter_freeze		= tegra114_idle_enter_freeze,
+			.enter_s2idle		= tegra114_idle_enter_s2idle,
 			.exit_latency		= 500,
 			.target_residency	= 1000,
 			.flags			= CPUIDLE_FLAG_TIMER_STOP,
