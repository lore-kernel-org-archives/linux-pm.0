From: Yuyang Du <yuyang.du@intel.com>
Subject: [RFC PATCH 08/12 v1] Intercept wakeup/fork/exec balance
Date: Mon,  5 May 2014 08:02:48 +0800
Message-ID: <1399248172-13871-9-git-send-email-yuyang.du@intel.com>
References: <1399248172-13871-1-git-send-email-yuyang.du@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399248172-13871-1-git-send-email-yuyang.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com, peterz@infradead.org, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: arjan.van.de.ven@intel.com, len.brown@intel.com, alan.cox@intel.com, mark.gross@intel.com, morten.rasmussen@arm.com, vincent.guittot@linaro.org, rajeev.d.muralidhar@intel.com, vishwesh.m.rudramuni@intel.com, nicole.chalhoub@intel.com, ajaya.durg@intel.com, harinarayanan.seshadri@intel.com, yuyang.du@intel.com
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Yuyang Du <yuyang.du@intel.com>
---
 kernel/sched/fair.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e7153ff..65f1651 100644
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
+		if (sd->flags & SD_ASYM_CONCURRENCY)
+			group = workload_consolidation_find_group(sd, p, cpu);
+
+		if (!group)
+#endif
 		group = find_idlest_group(sd, p, cpu, sd_flag);
 		if (!group) {
 			sd = sd->child;
-- 
1.7.9.5
