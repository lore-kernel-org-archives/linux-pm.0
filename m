From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [PATCH v2 10/10] drivers base/arch_topology: inline cpu- and frequency-invariant accounting
Date: Thu,  6 Jul 2017 10:49:48 +0100
Message-ID: <20170706094948.8779-11-dietmar.eggemann@arm.com>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170706094948.8779-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

To speed up the cpu- and frequency-invariant accounting of the task
scheduler make sure that the CIE (topology_get_cpu_scale()) and FIE
(topology_get_freq_scale() get completely inlined into the task
scheduler consumer functions (e.g. __update_load_avg_se()).

This patch-set changes the interface for CIE and FIE from:

drivers/base/arch_topology.c:

 static DEFINE_PER_CPU(unsigned long, item);

 unsigned long topology_get_item_scale(...)
 {
 	return per_cpu(item, cpu)
 }

include/linux/arch_topology.h:

 unsigned long topology_get_item_scale(...);

to:

drivers/base/arch_topology.c:

 DEFINE_PER_CPU(unsigned long, item);

include/linux/arch_topology.h:

 DECLARE_PER_CPU(unsigned long, item);

 static inline
 unsigned long topology_get_item_scale(...)
 {
 	return per_cpu(item, cpu)
 }

An uplift in performance could be detected running the kernel with the
following test patch on top (on JUNO R0 (arm64)):

@@ -2812,10 +2812,18 @@ accumulate_sum(u64 delta, int cpu, struct sched_avg *sa,
	unsigned long scale_freq, scale_cpu;
	u32 contrib = (u32)delta; /* p == 0 -> delta < 1024 */
	u64 periods;
+       u64 t1, t2;
+
+       t1 = sched_clock_cpu(cpu);

	scale_freq = arch_scale_freq_capacity(NULL, cpu);
	scale_cpu = arch_scale_cpu_capacity(NULL, cpu);

+       t2 = sched_clock_cpu(cpu);
+
+       trace_printk("cpu=%d t1=%llu t2=%llu diff=%llu\n",
+                    cpu, t1, t2, t2 - t1);
+
	delta += sa->period_contrib;
	periods = delta / 1024; /* A period is * 1024us * (~1ms) */

The following test results (3 test runs each) have been obtained by
tracing this trace printk (diff=x) for Cortex A-53 (LITTLE) and Cortex
A-57 (big) cpus w/ (inline) and w/o (non-inline) this patch.

         mean  max  min

A-57 inline:

	119.6  300   60
	 96.8  280   60
	110.2  660   60

A-57 non-inline:

	142.8  460   80
	157.6  680   80
	153.4  720   80

A-53 inline:

	141.6  360  100
	118.8  500  100
	148.6  380  100

A-53 non-inline:

	293    840  120
	253.2  840  120
	299.6 1060  140

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Juri Lelli <juri.lelli@arm.com>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 drivers/base/arch_topology.c  | 14 ++------------
 include/linux/arch_topology.h | 15 +++++++++++++--
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 63fb3f945d21..b4481cff14bf 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -22,12 +22,7 @@
 #include <linux/string.h>
 #include <linux/sched/topology.h>
 
-static DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
-
-unsigned long topology_get_freq_scale(struct sched_domain *sd, int cpu)
-{
-	return per_cpu(freq_scale, cpu);
-}
+DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
 
 void topology_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
 			     unsigned long max_freq)
@@ -43,12 +38,7 @@ void topology_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
 
 
 static DEFINE_MUTEX(cpu_scale_mutex);
-static DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
-
-unsigned long topology_get_cpu_scale(struct sched_domain *sd, int cpu)
-{
-	return per_cpu(cpu_scale, cpu);
-}
+DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
 
 void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
 {
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 168104d2d2cf..361e85a30151 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -11,12 +11,23 @@ void topology_normalize_cpu_scale(void);
 struct device_node;
 int topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu);
 
+DECLARE_PER_CPU(unsigned long, cpu_scale);
+DECLARE_PER_CPU(unsigned long, freq_scale);
+
 struct sched_domain;
-unsigned long topology_get_cpu_scale(struct sched_domain *sd, int cpu);
+static inline
+unsigned long topology_get_cpu_scale(struct sched_domain *sd, int cpu)
+{
+	return per_cpu(cpu_scale, cpu);
+}
 
 void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity);
 
-unsigned long topology_get_freq_scale(struct sched_domain *sd, int cpu);
+static inline
+unsigned long topology_get_freq_scale(struct sched_domain *sd, int cpu)
+{
+	return per_cpu(freq_scale, cpu);
+}
 
 void topology_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
 			     unsigned long max_freq);
-- 
2.11.0
