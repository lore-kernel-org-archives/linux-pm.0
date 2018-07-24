From: Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH v5 13/14] OPTIONAL: arch_topology: Start Energy Aware Scheduling
Date: Tue, 24 Jul 2018 13:25:20 +0100
Message-ID: <20180724122521.22109-14-quentin.perret@arm.com>
References: <20180724122521.22109-1-quentin.perret@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180724122521.22109-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org, quentin.perret@arm.com
List-Id: linux-pm@vger.kernel.org

Energy Aware Scheduling (EAS) starts when the scheduling domains are
built if the Energy Model (EM) is present. However, in the typical case
of Arm/Arm64 systems, the EM is provided after the scheduling domains
are first built at boot time, which results in EAS staying disabled.

Fix this issue by re-building the scheduling domain from the arch
topology driver, once CPUfreq is up and running and the asymmetry in CPU
capacities has been detected.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 drivers/base/arch_topology.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index e7cb0c6ade81..5b9f107f2e4a 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -10,6 +10,7 @@
 #include <linux/arch_topology.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
+#include <linux/cpuset.h>
 #include <linux/device.h>
 #include <linux/of.h>
 #include <linux/slab.h>
@@ -247,6 +248,7 @@ static void parsing_done_workfn(struct work_struct *work)
 	cpufreq_unregister_notifier(&init_cpu_capacity_notifier,
 					 CPUFREQ_POLICY_NOTIFIER);
 	free_cpumask_var(cpus_to_visit);
+	rebuild_sched_domains();
 }
 
 #else
-- 
2.18.0
