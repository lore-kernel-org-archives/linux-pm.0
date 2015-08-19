From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [RFC PATCH 11/14] sched/fair: add boosted CPU usage
Date: Wed, 19 Aug 2015 19:47:21 +0100
Message-ID: <1440010044-3402-12-git-send-email-patrick.bellasi@arm.com>
References: <1440010044-3402-1-git-send-email-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440010044-3402-1-git-send-email-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The CPU usage signal is used by the scheduler as an estimation of the
overall bandwidth currently allocated on a CPU. When SchedDVFS is in
use, this signal affects the selection of the operating points (OPP)
required to accommodate all the workload allocated in a CPU.
A convenient way to boost the performance of tasks running on a CPU,
which is also little intrusive, is to boost the CPU usage signal each
time it is used to select an OPP.

This patch introduces a new function:
  get_boosted_cpu_usage(cpu)
to return a boosted value for the usage of a specified CPU.
The margin added to the original usage is:
  1. computed based on the "boosting strategy" in use
  2. proportional to the system-wide boost value defined by provided
     user-space interface

The boosted signal is used by SchedDVFS (transparently) each time it
requires to get an estimation of the capacity required for a CPU.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
---
 kernel/sched/fair.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 15fde75..633fcab4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4083,6 +4083,7 @@ static inline void hrtick_update(struct rq *rq)
 static unsigned int capacity_margin = 1280;
 static unsigned long capacity_orig_of(int cpu);
 static int cpu_util(int cpu);
+static inline unsigned long boosted_cpu_util(int cpu);
 
 static void update_capacity_of(int cpu)
 {
@@ -4091,7 +4092,8 @@ static void update_capacity_of(int cpu)
 	if (!sched_energy_freq())
 		return;
 
-	req_cap = cpu_util(cpu) * capacity_margin / capacity_orig_of(cpu);
+	req_cap = boosted_cpu_util(cpu);
+	req_cap = req_cap * capacity_margin / capacity_orig_of(cpu);
 	cpufreq_sched_set_cap(cpu, req_cap);
 }
 
@@ -4766,8 +4768,36 @@ schedtune_margin(unsigned long signal, unsigned long boost)
 	return margin;
 }
 
+static inline unsigned int
+schedtune_cpu_margin(unsigned long util)
+{
+	unsigned int boost = get_sysctl_sched_cfs_boost();
+
+	if (boost == 0)
+		return 0;
+
+	return schedtune_margin(util, boost);
+}
+
+#else /* CONFIG_SCHED_TUNE */
+
+static inline unsigned int
+schedtune_cpu_margin(unsigned long util)
+{
+	return 0;
+}
+
 #endif /* CONFIG_SCHED_TUNE */
 
+static inline unsigned long
+boosted_cpu_util(int cpu)
+{
+	unsigned long util = cpu_util(cpu);
+	unsigned long margin = schedtune_cpu_margin(util);
+
+	return util + margin;
+}
+
 /*
  * find_idlest_group finds and returns the least busy CPU group within the
  * domain.
-- 
2.5.0
