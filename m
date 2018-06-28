From: Quentin Perret <quentin.perret@arm.com>
Subject: [RFC PATCH v4 11/12] OPTIONAL: arch_topology: Start Energy Aware Scheduling
Date: Thu, 28 Jun 2018 12:40:42 +0100
Message-ID: <20180628114043.24724-12-quentin.perret@arm.com>
References: <20180628114043.24724-1-quentin.perret@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180628114043.24724-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org, quentin.perret@arm.com
List-Id: linux-pm@vger.kernel.org

Energy Aware Scheduling (EAS) starts when the scheduling domains are
built if the Energy Model (EM) is present. However, in the typical case
of Arm/Arm64 systems, the EM is provided after the scheduling domains
are first built at boot time, which results in EAS staying disabled.

Fix this issue by re-building the scheduling domain from the arch
topology driver, once CPUfreq is up and running and when the CPU
capacities have been updated to their final value.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 drivers/base/arch_topology.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index e7cb0c6ade81..2022174f5ac5 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -10,7 +10,9 @@
 #include <linux/arch_topology.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
+#include <linux/cpuset.h>
 #include <linux/device.h>
+#include <linux/energy_model.h>
 #include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -173,6 +175,9 @@ static cpumask_var_t cpus_to_visit;
 static void parsing_done_workfn(struct work_struct *work);
 static DECLARE_WORK(parsing_done_work, parsing_done_workfn);
 
+static void start_eas_workfn(struct work_struct *work);
+static DECLARE_WORK(start_eas_work, start_eas_workfn);
+
 static int
 init_cpu_capacity_callback(struct notifier_block *nb,
 			   unsigned long val,
@@ -204,6 +209,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 		free_raw_capacity();
 		pr_debug("cpu_capacity: parsing done\n");
 		schedule_work(&parsing_done_work);
+		schedule_work(&start_eas_work);
 	}
 
 	return 0;
@@ -249,6 +255,15 @@ static void parsing_done_workfn(struct work_struct *work)
 	free_cpumask_var(cpus_to_visit);
 }
 
+static void start_eas_workfn(struct work_struct *work)
+{
+	/* Make sure the EM knows about the updated CPU capacities. */
+	em_rescale_cpu_capacity();
+
+	/* Inform the scheduler about the EM availability. */
+	rebuild_sched_domains();
+}
+
 #else
 core_initcall(free_raw_capacity);
 #endif
-- 
2.17.1
