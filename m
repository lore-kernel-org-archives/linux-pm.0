From: Chris Redpath <chris.redpath@arm.com>
Subject: [PATCH v3] cpufreq: schedutil: Examine the correct CPU when we update util
Date: Fri,  3 Nov 2017 13:36:42 +0000
Message-ID: <20171103133642.8636-1-chris.redpath@arm.com>
References: <20171103034022.GD4240@vireshk-i7>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42968 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750857AbdKCNgu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Nov 2017 09:36:50 -0400
In-Reply-To: <20171103034022.GD4240@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Chris Redpath <chris.redpath@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>

After
674e75411fc2 ("sched: cpufreq: Allow remote cpufreq callbacks")

We stopped always reading utilization for the cpu we are running
the governor on, and instead read it for the cpu which we've been
told has updated utilization. This is stored in sugov_cpu->cpu.

The value is set in sugov_register but we clear it in sugov_start
which leads to always looking at the utilization of CPU0 instead
of the correct one.

Let's fix this by consolidating the initialization code into
sugov_start().

Fixes: 674e75411fc2 ("sched: cpufreq: Allow remote cpufreq callbacks")
Signed-off-by: Chris Redpath <chris.redpath@arm.com>
Reviewed-by: Patrick Bellasi <patrick.bellasi@arm.com>
Reviewed-by: Brendan Jackman <brendan.jackman@arm.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/cpufreq_schedutil.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 6c1a7fcfa2a7..dc68a1ccdb33 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -728,6 +728,7 @@ static int sugov_start(struct cpufreq_policy *policy)
 		struct sugov_cpu *sg_cpu = &per_cpu(sugov_cpu, cpu);
 
 		memset(sg_cpu, 0, sizeof(*sg_cpu));
+		sg_cpu->cpu = cpu;
 		sg_cpu->sg_policy = sg_policy;
 		sg_cpu->flags = SCHED_CPUFREQ_RT;
 		sg_cpu->iowait_boost_max = policy->cpuinfo.max_freq;
@@ -793,11 +794,6 @@ struct cpufreq_governor *cpufreq_default_governor(void)
 
 static int __init sugov_register(void)
 {
-	int cpu;
-
-	for_each_possible_cpu(cpu)
-		per_cpu(sugov_cpu, cpu).cpu = cpu;
-
 	return cpufreq_register_governor(&schedutil_gov);
 }
 fs_initcall(sugov_register);
-- 
2.13.1.449.g02a2850
