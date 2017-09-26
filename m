From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [PATCH v5 05/10] drivers base/arch_topology: provide frequency-invariant accounting support
Date: Tue, 26 Sep 2017 17:41:10 +0100
Message-ID: <20170926164115.32367-6-dietmar.eggemann@arm.com>
References: <20170926164115.32367-1-dietmar.eggemann@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170926164115.32367-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

Implements the arch-specific (arm and arm64) frequency-invariance setter
function arch_set_freq_scale() which provides the following frequency
scaling factor:

  current_freq(cpu) << SCHED_CAPACITY_SHIFT / max_supported_freq(cpu)

One possible consumer of the frequency-invariance getter function
topology_get_freq_scale() is the Per-Entity Load Tracking (PELT)
mechanism of the task scheduler.

Allow inlining of topology_get_freq_scale() into the task scheduler
fast path (e.g. __update_load_avg_se()) by coding it as a static inline
function in the arch topology header file.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Juri Lelli <juri.lelli@arm.com>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/arch_topology.c  | 14 ++++++++++++++
 include/linux/arch_topology.h |  9 +++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index e9bb368f32b3..416ec2f5211d 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -22,6 +22,20 @@
 #include <linux/string.h>
 #include <linux/sched/topology.h>
 
+DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
+
+void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
+			 unsigned long max_freq)
+{
+	unsigned long scale;
+	int i;
+
+	scale = (cur_freq << SCHED_CAPACITY_SHIFT) / max_freq;
+
+	for_each_cpu(i, cpus)
+		per_cpu(freq_scale, i) = scale;
+}
+
 static DEFINE_MUTEX(cpu_scale_mutex);
 static DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
 
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 716ce587247e..f6e490312e4d 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -5,6 +5,7 @@
 #define _LINUX_ARCH_TOPOLOGY_H_
 
 #include <linux/types.h>
+#include <linux/percpu.h>
 
 void topology_normalize_cpu_scale(void);
 
@@ -16,4 +17,12 @@ unsigned long topology_get_cpu_scale(struct sched_domain *sd, int cpu);
 
 void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity);
 
+DECLARE_PER_CPU(unsigned long, freq_scale);
+
+static inline
+unsigned long topology_get_freq_scale(struct sched_domain *sd, int cpu)
+{
+	return per_cpu(freq_scale, cpu);
+}
+
 #endif /* _LINUX_ARCH_TOPOLOGY_H_ */
-- 
2.11.0
