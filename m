From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC][PATCH 6/7] cpufreq: schedutil: Add iowait boosting
Date: Mon, 01 Aug 2016 01:37:59 +0200
Message-ID: <1572483.euTsoFDNE9@vostro.rjw.lan>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:53966 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750997AbcGaXkd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 31 Jul 2016 19:40:33 -0400
In-Reply-To: <3752826.3sXAQIvcIA@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Modify the schedutil cpufreq governor to boost the CPU frequency
if the UUF_IO flag is passed to it via cpufreq_update_util().

If that happens, the frequency is set to the maximum during
the first update after receiving the UUF_IO flag and then the
boost is reduced by half during each following update.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/sched/cpufreq_schedutil.c |   61 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 7 deletions(-)

Index: linux-pm/kernel/sched/cpufreq_schedutil.c
===================================================================
--- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
+++ linux-pm/kernel/sched/cpufreq_schedutil.c
@@ -48,11 +48,13 @@ struct sugov_cpu {
 	struct sugov_policy *sg_policy;
 
 	unsigned int cached_raw_freq;
+	unsigned long iowait_boost;
+	unsigned long iowait_boost_max;
+	u64 last_update;
 
 	/* The fields below are only needed when sharing a policy. */
 	unsigned long util;
 	unsigned long max;
-	u64 last_update;
 	unsigned int flags;
 };
 
@@ -172,22 +174,58 @@ static void sugov_get_util(unsigned long
 	}
 }
 
+static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
+				   unsigned int flags)
+{
+	if (flags & UUF_IO) {
+		sg_cpu->iowait_boost = sg_cpu->iowait_boost_max;
+	} else if (sg_cpu->iowait_boost) {
+		s64 delta_ns = time - sg_cpu->last_update;
+
+		/* Clear iowait_boost if the CPU apprears to have been idle. */
+		if (delta_ns > TICK_NSEC)
+			sg_cpu->iowait_boost = 0;
+	}
+}
+
+static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, unsigned long *util,
+			       unsigned long *max)
+{
+	unsigned long boost_util = sg_cpu->iowait_boost;
+	unsigned long boost_max = sg_cpu->iowait_boost_max;
+
+	if (!boost_util)
+		return;
+
+	if (*util * boost_max < *max * boost_util) {
+		*util = boost_util;
+		*max = boost_max;
+	}
+	sg_cpu->iowait_boost >>= 1;
+}
+
 static void sugov_update_single(struct update_util_data *hook, u64 time,
 				unsigned int flags)
 {
 	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
-	struct cpufreq_policy *policy = sg_policy->policy;
 	unsigned long util, max;
 	unsigned int next_f;
 
+	sugov_set_iowait_boost(sg_cpu, time, flags);
+	sg_cpu->last_update = time;
+
 	if (!sugov_should_update_freq(sg_policy, time))
 		return;
 
 	sugov_get_util(&util, &max, flags);
 
-	next_f = flags & UUF_RT ? policy->cpuinfo.max_freq :
-				  get_next_freq(sg_cpu, util, max);
+	if (flags & UUF_RT) {
+		next_f = sg_policy->policy->cpuinfo.max_freq;
+	} else {
+		sugov_iowait_boost(sg_cpu, &util, &max);
+		next_f = get_next_freq(sg_cpu, util, max);
+	}
 	sugov_update_commit(sg_policy, time, next_f);
 }
 
@@ -204,6 +242,8 @@ static unsigned int sugov_next_freq_shar
 	if (flags & UUF_RT)
 		return max_f;
 
+	sugov_iowait_boost(sg_cpu, &util, &max);
+
 	for_each_cpu(j, policy->cpus) {
 		struct sugov_cpu *j_sg_cpu;
 		unsigned long j_util, j_max;
@@ -218,12 +258,13 @@ static unsigned int sugov_next_freq_shar
 		 * frequency update and the time elapsed between the last update
 		 * of the CPU utilization and the last frequency update is long
 		 * enough, don't take the CPU into account as it probably is
-		 * idle now.
+		 * idle now (and clear iowait_boost for it).
 		 */
 		delta_ns = last_freq_update_time - j_sg_cpu->last_update;
-		if (delta_ns > TICK_NSEC)
+		if (delta_ns > TICK_NSEC) {
+			j_sg_cpu->iowait_boost = 0;
 			continue;
-
+		}
 		if (j_sg_cpu->flags & UUF_RT)
 			return max_f;
 
@@ -233,6 +274,8 @@ static unsigned int sugov_next_freq_shar
 			util = j_util;
 			max = j_max;
 		}
+
+		sugov_iowait_boost(j_sg_cpu, &util, &max);
 	}
 
 	return get_next_freq(sg_cpu, util, max);
@@ -253,6 +296,8 @@ static void sugov_update_shared(struct u
 	sg_cpu->util = util;
 	sg_cpu->max = max;
 	sg_cpu->flags = flags;
+
+	sugov_set_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
 
 	if (sugov_should_update_freq(sg_policy, time)) {
@@ -485,6 +530,8 @@ static int sugov_start(struct cpufreq_po
 			sg_cpu->flags = UUF_RT;
 			sg_cpu->last_update = 0;
 			sg_cpu->cached_raw_freq = 0;
+			sg_cpu->iowait_boost = 0;
+			sg_cpu->iowait_boost_max = policy->cpuinfo.max_freq;
 			cpufreq_add_update_util_hook(cpu, &sg_cpu->update_util,
 						     sugov_update_shared);
 		} else {

