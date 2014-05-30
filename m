From: Yuyang Du <yuyang.du@intel.com>
Subject: [RFC PATCH 09/16 v3] Define and allocate a per CPU local cpumask for Workload Consolidation
Date: Fri, 30 May 2014 14:36:05 +0800
Message-ID: <1401431772-14320-10-git-send-email-yuyang.du@intel.com>
References: <1401431772-14320-1-git-send-email-yuyang.du@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1401431772-14320-1-git-send-email-yuyang.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com, peterz@infradead.org, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: arjan.van.de.ven@intel.com, len.brown@intel.com, alan.cox@intel.com, mark.gross@intel.com, pjt@google.com, bsegall@google.com, morten.rasmussen@arm.com, vincent.guittot@linaro.org, rajeev.d.muralidhar@intel.com, vishwesh.m.rudramuni@intel.com, nicole.chalhoub@intel.com, ajaya.durg@intel.com, harinarayanan.seshadri@intel.com, jacob.jun.pan@linux.intel.com, fengguang.wu@intel.com, yuyang.du@intel.com
List-Id: linux-pm@vger.kernel.org

We need these cpumasks to aid in cosolidated load balancing

Signed-off-by: Yuyang Du <yuyang.du@intel.com>
---
 kernel/sched/fair.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 96d6f64..5755746 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6638,6 +6638,8 @@ out:
 	return ld_moved;
 }
 
+static DEFINE_PER_CPU(cpumask_var_t, local_cpu_mask);
+
 /*
  * idle_balance is called by schedule() if this_cpu is about to become
  * idle. Attempts to pull tasks from other CPUs.
@@ -7692,6 +7694,12 @@ void print_cfs_stats(struct seq_file *m, int cpu)
 __init void init_sched_fair_class(void)
 {
 #ifdef CONFIG_SMP
+	unsigned int i;
+	for_each_possible_cpu(i) {
+		zalloc_cpumask_var_node(&per_cpu(local_cpu_mask, i),
+					GFP_KERNEL, cpu_to_node(i));
+	}
+
 	open_softirq(SCHED_SOFTIRQ, run_rebalance_domains);
 
 #ifdef CONFIG_NO_HZ_COMMON
-- 
1.7.9.5
