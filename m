From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/2] cpufreq: schedutil: Fix per-CPU structure initialization in sugov_start()
Date: Sun, 19 Mar 2017 14:30:02 +0100
Message-ID: <2230625.Zj7J7bOCCf@aspire.rjw.lan>
References: <4366682.tsferJN35u@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:56493 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751369AbdCSNlQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Mar 2017 09:41:16 -0400
In-Reply-To: <4366682.tsferJN35u@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Ingo Molnar <mingo@redhat.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

sugov_start() only initializes struct sugov_cpu per-CPU structures
for shared policies, but it should do that for single-CPU policies too.

That in particular makes the IO-wait boost mechanism work in the
cases when cpufreq policies correspond to individual CPUs.

Fixes: 21ca6d2c52f8 (cpufreq: schedutil: Add iowait boosting)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/sched/cpufreq_schedutil.c |   20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

Index: linux-pm/kernel/sched/cpufreq_schedutil.c
===================================================================
--- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
+++ linux-pm/kernel/sched/cpufreq_schedutil.c
@@ -577,20 +577,14 @@ static int sugov_start(struct cpufreq_po
 	for_each_cpu(cpu, policy->cpus) {
 		struct sugov_cpu *sg_cpu = &per_cpu(sugov_cpu, cpu);
 
+		memset(sg_cpu, 0, sizeof(*sg_cpu));
 		sg_cpu->sg_policy = sg_policy;
-		if (policy_is_shared(policy)) {
-			sg_cpu->util = 0;
-			sg_cpu->max = 0;
-			sg_cpu->flags = SCHED_CPUFREQ_RT;
-			sg_cpu->last_update = 0;
-			sg_cpu->iowait_boost = 0;
-			sg_cpu->iowait_boost_max = policy->cpuinfo.max_freq;
-			cpufreq_add_update_util_hook(cpu, &sg_cpu->update_util,
-						     sugov_update_shared);
-		} else {
-			cpufreq_add_update_util_hook(cpu, &sg_cpu->update_util,
-						     sugov_update_single);
-		}
+		sg_cpu->flags = SCHED_CPUFREQ_RT;
+		sg_cpu->iowait_boost_max = policy->cpuinfo.max_freq;
+		cpufreq_add_update_util_hook(cpu, &sg_cpu->update_util,
+					     policy_is_shared(policy) ?
+							sugov_update_shared :
+							sugov_update_single);
 	}
 	return 0;
 }
