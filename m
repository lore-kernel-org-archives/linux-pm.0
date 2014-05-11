From: Yuyang Du <yuyang.du@intel.com>
Subject: [RFC PATCH 08/12 v2] Intercept wakeup/fork/exec load balancing
Date: Mon, 12 May 2014 02:16:57 +0800
Message-ID: <1399832221-8314-9-git-send-email-yuyang.du@intel.com>
References: <1399832221-8314-1-git-send-email-yuyang.du@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399832221-8314-1-git-send-email-yuyang.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com, peterz@infradead.org, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: arjan.van.de.ven@intel.com, len.brown@intel.com, alan.cox@intel.com, mark.gross@intel.com, morten.rasmussen@arm.com, vincent.guittot@linaro.org, rajeev.d.muralidhar@intel.com, vishwesh.m.rudramuni@intel.com, nicole.chalhoub@intel.com, ajaya.durg@intel.com, harinarayanan.seshadri@intel.com, jacob.jun.pan@linux.intel.com, fengguang.wu@intel.com, yuyang.du@intel.com
List-Id: linux-pm@vger.kernel.org

We intercept load balancing to contain the load and load balancing in
the consolidated CPUs according to our consolidating mechanism.

In wakeup load balaning, we do not select idle, if the CC of the wakee
and waker (in this order if SD_WAKE_AFFINE) is capable of handling the
wakee task. And in fork/exec load balancing when finding the sched_group,
we find the consolidated group.

Signed-off-by: Yuyang Du <yuyang.du@intel.com>
---
 kernel/sched/fair.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e7153ff..c7a6347 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4365,9 +4365,16 @@ static int select_idle_sibling(struct task_struct *p, int target)
 	struct sched_domain *sd;
 	struct sched_group *sg;
 	int i = task_cpu(p);
+#ifdef CONFIG_WORKLOAD_CONSOLIDATION
+	int ret;
 
+	ret = workload_consolidation_wakeup(i, target);
+	if (ret < nr_cpu_ids)
+		return ret;
+#else
 	if (idle_cpu(target))
 		return target;
+#endif
 
 	/*
 	 * If the prevous cpu is cache affine and idle, don't be stupid.
@@ -4460,7 +4467,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 	}
 
 	while (sd) {
-		struct sched_group *group;
+		struct sched_group *group = NULL;
 		int weight;
 
 		if (!(sd->flags & sd_flag)) {
@@ -4468,6 +4475,12 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 			continue;
 		}
 
+#ifdef CONFIG_WORKLOAD_CONSOLIDATION
+		if (sd->flags & SD_WORKLOAD_CONSOLIDATION)
+			group = workload_consolidation_find_group(sd, p, cpu);
+
+		if (!group)
+#endif
 		group = find_idlest_group(sd, p, cpu, sd_flag);
 		if (!group) {
 			sd = sd->child;
-- 
1.7.9.5
