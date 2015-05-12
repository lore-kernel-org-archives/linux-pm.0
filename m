From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv4 PATCH 21/34] sched: Highest energy aware balancing sched_domain level pointer
Date: Tue, 12 May 2015 20:38:56 +0100
Message-ID: <1431459549-18343-22-git-send-email-morten.rasmussen@arm.com>
References: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33937 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933894AbbELTik (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 12 May 2015 15:38:40 -0400
In-Reply-To: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com
Cc: vincent.guittot@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, preeti@linux.vnet.ibm.com, mturquette@linaro.org, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, morten.rasmussen@arm.com

Add another member to the family of per-cpu sched_domain shortcut
pointers. This one, sd_ea, points to the highest level at which energy
model is provided. At this level and all levels below all sched_groups
have energy model data attached.

Partial energy model information is possible but restricted to providing
energy model data for lower level sched_domains (sd_ea and below) and
leaving load-balancing on levels above to non-energy-aware
load-balancing. For example, it is possible to apply energy-aware
scheduling within each socket on a multi-socket system and let normal
scheduling handle load-balancing between sockets.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/core.c  | 11 ++++++++++-
 kernel/sched/sched.h |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5499b2c..8818bf0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5777,11 +5777,12 @@ DEFINE_PER_CPU(int, sd_llc_id);
 DEFINE_PER_CPU(struct sched_domain *, sd_numa);
 DEFINE_PER_CPU(struct sched_domain *, sd_busy);
 DEFINE_PER_CPU(struct sched_domain *, sd_asym);
+DEFINE_PER_CPU(struct sched_domain *, sd_ea);
 
 static void update_top_cache_domain(int cpu)
 {
 	struct sched_domain *sd;
-	struct sched_domain *busy_sd = NULL;
+	struct sched_domain *busy_sd = NULL, *ea_sd = NULL;
 	int id = cpu;
 	int size = 1;
 
@@ -5802,6 +5803,14 @@ static void update_top_cache_domain(int cpu)
 
 	sd = highest_flag_domain(cpu, SD_ASYM_PACKING);
 	rcu_assign_pointer(per_cpu(sd_asym, cpu), sd);
+
+	for_each_domain(cpu, sd) {
+		if (sd->groups->sge)
+			ea_sd = sd;
+		else
+			break;
+	}
+	rcu_assign_pointer(per_cpu(sd_ea, cpu), ea_sd);
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ea32e9e..b627dfa 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -829,6 +829,7 @@ DECLARE_PER_CPU(int, sd_llc_id);
 DECLARE_PER_CPU(struct sched_domain *, sd_numa);
 DECLARE_PER_CPU(struct sched_domain *, sd_busy);
 DECLARE_PER_CPU(struct sched_domain *, sd_asym);
+DECLARE_PER_CPU(struct sched_domain *, sd_ea);
 
 struct sched_group_capacity {
 	atomic_t ref;
-- 
1.9.1

