From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [PATCH v3 05/10] drivers base/arch_topology: provide frequency-invariant accounting support
Date: Thu, 27 Jul 2017 20:33:07 +0100
Message-ID: <20170727193312.9849-6-dietmar.eggemann@arm.com>
References: <20170727193312.9849-1-dietmar.eggemann@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170727193312.9849-1-dietmar.eggemann@arm.com>
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
---
 drivers/base/arch_topology.c  | 14 ++++++++++++++
 include/linux/arch_topology.h | 10 ++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 562e0c93ae52..af9ab98a233e 100644
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
index 9af3c174c03a..3e3c2657c9a1 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -4,6 +4,8 @@
 #ifndef _LINUX_ARCH_TOPOLOGY_H_
 #define _LINUX_ARCH_TOPOLOGY_H_
 
+#include <linux/percpu.h>
+
 void topology_normalize_cpu_scale(void);
 
 struct device_node;
@@ -14,4 +16,12 @@ unsigned long topology_get_cpu_scale(struct sched_domain *sd, int cpu);
 
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
