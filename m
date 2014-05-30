From: Yuyang Du <yuyang.du@intel.com>
Subject: [RFC PATCH 08/16 v3] Write CPU topology info for Workload Consolidation fields in sched_domain
Date: Fri, 30 May 2014 14:36:04 +0800
Message-ID: <1401431772-14320-9-git-send-email-yuyang.du@intel.com>
References: <1401431772-14320-1-git-send-email-yuyang.du@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1401431772-14320-1-git-send-email-yuyang.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com, peterz@infradead.org, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: arjan.van.de.ven@intel.com, len.brown@intel.com, alan.cox@intel.com, mark.gross@intel.com, pjt@google.com, bsegall@google.com, morten.rasmussen@arm.com, vincent.guittot@linaro.org, rajeev.d.muralidhar@intel.com, vishwesh.m.rudramuni@intel.com, nicole.chalhoub@intel.com, ajaya.durg@intel.com, harinarayanan.seshadri@intel.com, jacob.jun.pan@linux.intel.com, fengguang.wu@intel.com, yuyang.du@intel.com
List-Id: linux-pm@vger.kernel.org

Write additional CPU topology info in sched_domain for our use in cpu_attach_domain()

Signed-off-by: Yuyang Du <yuyang.du@intel.com>
---
 kernel/sched/core.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1cb7402..9df01d5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5496,6 +5496,31 @@ static void update_top_cache_domain(int cpu)
 	rcu_assign_pointer(per_cpu(sd_asym, cpu), sd);
 }
 
+static void update_cpu_position_info(struct sched_domain *sd)
+{
+	while (sd) {
+		int i = 0, j = 0, first, min = INT_MAX;
+		struct sched_group *group;
+
+		group = sd->groups;
+		first = group_first_cpu(group);
+		do {
+			int k = group_first_cpu(group);
+			i += 1;
+			if (k < first)
+				j += 1;
+			if (k < min) {
+				sd->first_group = group;
+				min = k;
+			}
+		} while (group = group->next, group != sd->groups);
+
+		sd->total_groups = i;
+		sd->group_number = j;
+		sd = sd->parent;
+	}
+}
+
 /*
  * Attach the domain 'sd' to 'cpu' as its base domain. Callers must
  * hold the hotplug lock.
@@ -5544,6 +5569,8 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 	destroy_sched_domains(tmp, cpu);
 
 	update_top_cache_domain(cpu);
+
+	update_cpu_position_info(sd);
 }
 
 /* cpus with isolated domains */
-- 
1.7.9.5
