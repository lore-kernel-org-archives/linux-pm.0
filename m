From: Thara Gopinath <thara.gopinath@linaro.org>
Subject: [RFC PATCH 3/7] sched: Add infrastructure to store and update instantaneous thermal pressure
Date: Tue,  9 Oct 2018 12:24:58 -0400
Message-ID: <1539102302-9057-4-git-send-email-thara.gopinath@linaro.org>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, amit.kachhap@gmail.com, viresh.kumar@linaro.org, javi.merino@kernel.org, edubezval@gmail.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, quentin.perret@arm.com, ionela.voinescu@arm.com, vincent.guittot@linaro.org
List-Id: linux-pm@vger.kernel.org

Add thermal.c and thermal.h files that provides interface
APIs to initialize, update/average, track, accumulate and decay
thermal pressure per cpu basis. A per cpu structure max_capacity_info is
introduced to keep track of instantaneous per cpu thermal pressure.
Thermal pressure the delta between max_capacity and cap_capacity.
API update_periodic_maxcap is called for periodic accumulate and decay
of the thermal pressure. It is to to be called from a periodic tick
function. The API calculates the delta between max_capacity and
cap_capacity and passes on the delta to update_thermal_avg to do the
necessary accumulate, decay and average. update_maxcap_capacity is for
the system to update the thermal pressure by updating cap_capacity.
Considering, update_periodic_maxcap reads cap_capacity and
update_maxcap_capacity writes into cap_capacity, one can argue for
some sort of locking mechanism to avoid a stale value.
But considering update_periodic_maxcap can be called from a system
critical path like scheduler tick function, a locking mechanism is not
ideal. This means that possibly for 1 tick period the value used to
calculate average thermal pressure for a cpu can be stale.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 include/linux/sched.h  | 14 +++++++++++
 kernel/sched/Makefile  |  2 +-
 kernel/sched/thermal.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/thermal.h | 13 ++++++++++
 4 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 kernel/sched/thermal.c
 create mode 100644 kernel/sched/thermal.h

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 977cb57..931b76d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1891,3 +1891,17 @@ static inline void rseq_syscall(struct pt_regs *regs)
 #endif
 
 #endif
+
+#ifdef CONFIG_SMP
+void update_maxcap_capacity(int cpu, u64 capacity);
+
+void populate_max_capacity_info(void);
+#else
+static inline void update_maxcap_capacity(int cpu, u64 capacity)
+{
+}
+
+static inline void populate_max_capacity_info(void)
+{
+}
+#endif
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 7fe1834..232a0cf 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -20,7 +20,7 @@ obj-y += core.o loadavg.o clock.o cputime.o
 obj-y += idle.o fair.o rt.o deadline.o
 obj-y += wait.o wait_bit.o swait.o completion.o
 
-obj-$(CONFIG_SMP) += cpupri.o cpudeadline.o topology.o stop_task.o pelt.o
+obj-$(CONFIG_SMP) += cpupri.o cpudeadline.o topology.o stop_task.o pelt.o thermal.o
 obj-$(CONFIG_SCHED_AUTOGROUP) += autogroup.o
 obj-$(CONFIG_SCHEDSTATS) += stats.o
 obj-$(CONFIG_SCHED_DEBUG) += debug.o
diff --git a/kernel/sched/thermal.c b/kernel/sched/thermal.c
new file mode 100644
index 0000000..dd8300d
--- /dev/null
+++ b/kernel/sched/thermal.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Sceduler Thermal Interactions
+ *
+ *  Copyright (C) 2018 Linaro, Inc., Thara Gopinath <thara.gopinath@linaro.org>
+ */
+
+#include <linux/sched.h>
+#include "sched.h"
+#include "pelt.h"
+#include "thermal.h"
+
+struct max_capacity_info {
+	unsigned long max_capacity;
+	unsigned long cap_capacity;
+};
+
+static DEFINE_PER_CPU(struct max_capacity_info, max_cap);
+
+void update_maxcap_capacity(int cpu, u64 capacity)
+{
+	struct max_capacity_info *__max_cap;
+	u64 __capacity;
+
+	__max_cap = (&per_cpu(max_cap, cpu));
+	if (!__max_cap) {
+		pr_err("no max_capacity_info structure for cpu %d\n", cpu);
+		return;
+	}
+
+	/* Normalize the capacity */
+	__capacity = (capacity * arch_scale_cpu_capacity(NULL, cpu)) >>
+							SCHED_CAPACITY_SHIFT;
+	pr_debug("updating cpu%d capped capacity from %ld to %ld\n", cpu, __max_cap->cap_capacity, __capacity);
+
+	__max_cap->cap_capacity = __capacity;
+}
+
+void populate_max_capacity_info(void)
+{
+	struct max_capacity_info *__max_cap;
+	u64 capacity;
+	int cpu;
+
+
+	for_each_possible_cpu(cpu) {
+		__max_cap = (&per_cpu(max_cap, cpu));
+		if (!__max_cap)
+			continue;
+		capacity = arch_scale_cpu_capacity(NULL, cpu);
+		__max_cap->max_capacity = __max_cap->cap_capacity = capacity;
+		pr_debug("cpu %d max capacity set to %ld\n", cpu, __max_cap->max_capacity);
+	}
+}
+
+void update_periodic_maxcap(struct rq *rq)
+{
+	struct max_capacity_info *__max_cap = (&per_cpu(max_cap, cpu_of(rq)));
+	unsigned long delta;
+
+	if (!__max_cap)
+		return;
+
+	delta = __max_cap->max_capacity - __max_cap->cap_capacity;
+	update_thermal_avg(rq_clock_task(rq), rq, delta);
+}
diff --git a/kernel/sched/thermal.h b/kernel/sched/thermal.h
new file mode 100644
index 0000000..20a0270
--- /dev/null
+++ b/kernel/sched/thermal.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Scheduler thermal interaction internal methods.
+ */
+
+#ifdef CONFIG_SMP
+void update_periodic_maxcap(struct rq *rq);
+
+#else
+static inline void update_periodic_maxcap(struct rq *rq)
+{
+}
+#endif
-- 
2.1.4
