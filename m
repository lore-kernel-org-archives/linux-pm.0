From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH V2 1/2] sched/cpufreq: Reorganize the cpufreq files
Date: Thu, 18 Oct 2018 11:44:14 +0200
Message-ID: <1539855869-13524-1-git-send-email-daniel.lezcano@linaro.org>
References: <CAJZ5v0iALqLw+Y_tKw86dh2oxnmvALhoVJxEcWWA+x1jU3GjdA@mail.gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0iALqLw+Y_tKw86dh2oxnmvALhoVJxEcWWA+x1jU3GjdA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rafael@kernel.org, mingo@kernel.org
Cc: thara.gopinath@linaro.org, linux-kernel@vger.kernel.org, peterz@infradead.org, rui.zhang@intel.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, amit.kachhap@gmail.com, javi.merino@kernel.org, edubezval@gmail.com, linux-pm@vger.kernel.org, quentin.perret@arm.com, ionela.voinescu@arm.com, vincent.guittot@linaro.org, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Juri Lelli <juri.lelli@redhat.com>, Patrick Bellasi <patrick.bellasi@arm.com>
List-Id: linux-pm@vger.kernel.org

It was suggested to set the scene for the PM components in the
scheduler code organization in the recent discussion about making the
scheduler aware of the capacity capping from the thermal framework.

Move the cpufreq files into its own directory as suggested at:

https://lkml.org/lkml/2018/10/18/353
https://lkml.org/lkml/2018/10/18/408

Suggested-by: Ingo Molnar <mingo@kernel.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
Changelog:
 * git added the Makefile in cpufreq/Makefile (V2)

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 kernel/sched/Makefile                                   | 3 +--
 kernel/sched/cpufreq/Makefile                           | 3 +++
 kernel/sched/{cpufreq.c => cpufreq/core.c}              | 2 +-
 kernel/sched/{cpufreq_schedutil.c => cpufreq/metrics.c} | 2 +-
 4 files changed, 6 insertions(+), 4 deletions(-)
 create mode 100644 kernel/sched/cpufreq/Makefile
 rename kernel/sched/{cpufreq.c => cpufreq/core.c} (99%)
 rename kernel/sched/{cpufreq_schedutil.c => cpufreq/metrics.c} (99%)

diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 7fe1834..bc6bce0 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -19,13 +19,12 @@ endif
 obj-y += core.o loadavg.o clock.o cputime.o
 obj-y += idle.o fair.o rt.o deadline.o
 obj-y += wait.o wait_bit.o swait.o completion.o
+obj-y += cpufreq/
 
 obj-$(CONFIG_SMP) += cpupri.o cpudeadline.o topology.o stop_task.o pelt.o
 obj-$(CONFIG_SCHED_AUTOGROUP) += autogroup.o
 obj-$(CONFIG_SCHEDSTATS) += stats.o
 obj-$(CONFIG_SCHED_DEBUG) += debug.o
 obj-$(CONFIG_CGROUP_CPUACCT) += cpuacct.o
-obj-$(CONFIG_CPU_FREQ) += cpufreq.o
-obj-$(CONFIG_CPU_FREQ_GOV_SCHEDUTIL) += cpufreq_schedutil.o
 obj-$(CONFIG_MEMBARRIER) += membarrier.o
 obj-$(CONFIG_CPU_ISOLATION) += isolation.o
diff --git a/kernel/sched/cpufreq/Makefile b/kernel/sched/cpufreq/Makefile
new file mode 100644
index 0000000..4bf1087
--- /dev/null
+++ b/kernel/sched/cpufreq/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_CPU_FREQ) += core.o
+obj-$(CONFIG_CPU_FREQ_GOV_SCHEDUTIL) += metrics.o
diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq/core.c
similarity index 99%
rename from kernel/sched/cpufreq.c
rename to kernel/sched/cpufreq/core.c
index 5e54cbc..8c17a63 100644
--- a/kernel/sched/cpufreq.c
+++ b/kernel/sched/cpufreq/core.c
@@ -8,7 +8,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#include "sched.h"
+#include "../sched.h"
 
 DEFINE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
 
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq/metrics.c
similarity index 99%
rename from kernel/sched/cpufreq_schedutil.c
rename to kernel/sched/cpufreq/metrics.c
index 3fffad3..597df47 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq/metrics.c
@@ -11,7 +11,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include "sched.h"
+#include "../sched.h"
 
 #include <trace/events/power.h>
 
-- 
2.7.4
