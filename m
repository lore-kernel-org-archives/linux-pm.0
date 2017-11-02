From: Chris Redpath <chris.redpath@arm.com>
Subject: [PATCH] cpufreq: schedutil: Examine the correct CPU when we update util
Date: Thu,  2 Nov 2017 10:54:38 +0000
Message-ID: <20171102105438.14258-1-chris.redpath@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: morten.rasmussen@arm.com, dietmar.eggemann@arm.com, Chris Redpath <chris.redpath@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "4 . 9+" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Since:

4296f23ed cpufreq: schedutil: Fix per-CPU structure initialization in
 sugov_start()

We lost the value of sg_cpu->cpu which is assigned during
sugov_register. The memset in sugov_start overwrites it with zero.

This leads to always looking at the utilization of CPU0 instead of
the one we just updated when we do a utilization update callback.

Let's fix this by consolidating the initialization code into
sugov_start().

Fixes: 4296f23ed49a ("cpufreq: schedutil: Fix per-CPU structure initialization in sugov_start()")
Signed-off-by: Chris Redpath <chris.redpath@arm.com>
Reviewed-by: Patrick Bellasi <patrick.bellasi@arm.com>
Reviewed-by: Brendan Jackman <brendan.jackman@arm.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: 4.9+ <stable@vger.kernel.org>
---
 kernel/sched/cpufreq_schedutil.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 6c1a7fcfa2a7..eeb7e0a1d861 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -731,6 +731,7 @@ static int sugov_start(struct cpufreq_policy *policy)
 		sg_cpu->sg_policy = sg_policy;
 		sg_cpu->flags = SCHED_CPUFREQ_RT;
 		sg_cpu->iowait_boost_max = policy->cpuinfo.max_freq;
+		sg_cpu->cpu = cpu;
 	}
 
 	for_each_cpu(cpu, policy->cpus) {
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
