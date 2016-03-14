From: Michael Turquette <mturquette@baylibre.com>
Subject: [PATCH 6/8] cpufreq/schedutil: sum per-sched class utilization
Date: Sun, 13 Mar 2016 22:22:10 -0700
Message-ID: <1457932932-28444-7-git-send-email-mturquette+renesas@baylibre.com>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36355 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933463AbcCNF00 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Mar 2016 01:26:26 -0400
Received: by mail-pa0-f43.google.com with SMTP id tt10so149509370pab.3
        for <linux-pm@vger.kernel.org>; Sun, 13 Mar 2016 22:26:26 -0700 (PDT)
In-Reply-To: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, steve.muckle@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>

Patch, "sched/cpufreq: pass sched class into cpufreq_update_util" made
it possible for calls of cpufreq_update_util() to specify scheduler
class, particularly cfs, rt & dl.

Update the schedutil governor to store these individual utilizations per
cpu and sum them to create a total utilization contribution.

Signed-off-by: Michael Turquette <mturquette+renesas@baylibre.com>
---
 drivers/cpufreq/cpufreq_schedutil.c | 39 +++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_schedutil.c b/drivers/cpufreq/cpufreq_schedutil.c
index 18d9ca3..b9234e1 100644
--- a/drivers/cpufreq/cpufreq_schedutil.c
+++ b/drivers/cpufreq/cpufreq_schedutil.c
@@ -46,8 +46,10 @@ struct sugov_cpu {
 	struct freq_update_hook update_hook;
 	struct sugov_policy *sg_policy;
 
+	unsigned long util[nr_util_types];
+	unsigned long total_util;
+
 	/* The fields below are only needed when sharing a policy. */
-	unsigned long util;
 	unsigned long max;
 	u64 last_update;
 };
@@ -106,6 +108,18 @@ static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
 	trace_cpu_frequency(freq, smp_processor_id());
 }
 
+static unsigned long sugov_sum_total_util(struct sugov_cpu *sg_cpu)
+{
+	enum sched_class_util sc;
+
+	/* sum the utilization of all sched classes */
+	sg_cpu->total_util = 0;
+	for (sc = 0; sc < nr_util_types; sc++)
+		sg_cpu->total_util += sg_cpu->util[sc];
+
+	return sg_cpu->total_util;
+}
+
 static void sugov_update_single(struct freq_update_hook *hook,
 				enum sched_class_util sc, u64 time,
 				unsigned long util, unsigned long max)
@@ -113,12 +127,17 @@ static void sugov_update_single(struct freq_update_hook *hook,
 	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_hook);
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	unsigned int max_f, next_f;
+	unsigned long total_util;
 
 	if (!sugov_should_update_freq(sg_policy, time))
 		return;
 
+	/* update per-sched_class utilization for this cpu */
+	sg_cpu->util[sc] = util;
+	total_util = sugov_sum_total_util(sg_cpu);
+
 	max_f = sg_policy->max_freq;
-	next_f = util > max ? max_f : util * max_f / max;
+	next_f = total_util > max ? max_f : total_util * max_f / max;
 	sugov_update_commit(sg_policy, time, next_f);
 }
 
@@ -153,7 +172,7 @@ static unsigned int sugov_next_freq(struct sugov_policy *sg_policy,
 		if ((s64)delta_ns > NSEC_PER_SEC / HZ)
 			continue;
 
-		j_util = j_sg_cpu->util;
+		j_util = j_sg_cpu->total_util;
 		j_max = j_sg_cpu->max;
 		if (j_util > j_max)
 			return max_f;
@@ -174,15 +193,19 @@ static void sugov_update_shared(struct freq_update_hook *hook,
 	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_hook);
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	unsigned int next_f;
+	unsigned long total_util;
 
 	raw_spin_lock(&sg_policy->update_lock);
 
-	sg_cpu->util = util;
+	sg_cpu->util[sc] = util;
 	sg_cpu->max = max;
 	sg_cpu->last_update = time;
 
+	/* update per-sched_class utilization for this cpu */
+	total_util = sugov_sum_total_util(sg_cpu);
+
 	if (sugov_should_update_freq(sg_policy, time)) {
-		next_f = sugov_next_freq(sg_policy, util, max);
+		next_f = sugov_next_freq(sg_policy, total_util, max);
 		sugov_update_commit(sg_policy, time, next_f);
 	}
 
@@ -423,6 +446,7 @@ static int sugov_start(struct cpufreq_policy *policy)
 {
 	struct sugov_policy *sg_policy = policy->governor_data;
 	unsigned int cpu;
+	enum sched_class_util sc;
 
 	sg_policy->freq_update_delay_ns = sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;
 	sg_policy->last_freq_update_time = 0;
@@ -434,8 +458,11 @@ static int sugov_start(struct cpufreq_policy *policy)
 		struct sugov_cpu *sg_cpu = &per_cpu(sugov_cpu, cpu);
 
 		sg_cpu->sg_policy = sg_policy;
+		for (sc = 0; sc < nr_util_types; sc++) {
+			sg_cpu->util[sc] = ULONG_MAX;
+			sg_cpu->total_util = ULONG_MAX;
+		}
 		if (policy_is_shared(policy)) {
-			sg_cpu->util = ULONG_MAX;
 			sg_cpu->max = 0;
 			sg_cpu->last_update = 0;
 			cpufreq_set_freq_update_hook(cpu, &sg_cpu->update_hook,
-- 
2.1.4

