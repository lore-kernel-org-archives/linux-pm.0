From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [PATCH v4 06/10] drivers base/arch_topology: allow inlining cpu-invariant accounting support
Date: Fri, 25 Aug 2017 15:32:02 +0100
Message-ID: <20170825143206.30467-7-dietmar.eggemann@arm.com>
References: <20170825143206.30467-1-dietmar.eggemann@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170825143206.30467-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

Allow inlining of topology_get_cpu_scale() into the task
scheduler fast path (e.g. __update_load_avg_se()) by coding it as a
static inline function in the arch topology header file.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Juri Lelli <juri.lelli@arm.com>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/arch_topology.c  | 7 +------
 include/linux/arch_topology.h | 8 +++++++-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index af9ab98a233e..c8cd92ba4cc0 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -37,12 +37,7 @@ void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
 }
 
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
index 3e3c2657c9a1..0c4e43d6a3bb 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -11,8 +11,14 @@ void topology_normalize_cpu_scale(void);
 struct device_node;
 int topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu);
 
+DECLARE_PER_CPU(unsigned long, cpu_scale);
+
 struct sched_domain;
-unsigned long topology_get_cpu_scale(struct sched_domain *sd, int cpu);
+static inline
+unsigned long topology_get_cpu_scale(struct sched_domain *sd, int cpu)
+{
+	return per_cpu(cpu_scale, cpu);
+}
 
 void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity);
 
-- 
2.11.0
