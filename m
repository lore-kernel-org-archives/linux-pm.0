From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3] cpufreq: Restore policy min/max limits on CPU online
Date: Tue, 21 Mar 2017 11:36:06 +0530
Message-ID: <96b7044b50a37b3c4c302e6e22d3cbc6e8864cd4.1490076285.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

On CPU online the cpufreq core restores the previous governor (or
the previous "policy" setting for ->setpolicy drivers), but it does
not restore the min/max limits at the same time, which is confusing,
inconsistent and real pain for users who set the limits and then
suspend/resume the system (using full suspend), in which case the
limits are reset on all CPUs except for the boot one.

Fix this by making cpufreq_online() restore the limits when an inactive
policy is brought online.

The commit log and patch are inspired from Rafael's earlier work.

Reported-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V1 and V2 were sent by Rafael and were trying to fix this differently.

 drivers/cpufreq/cpufreq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 38b9fdf854a4..87e7b9d0db1b 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1182,6 +1182,9 @@ static int cpufreq_online(unsigned int cpu)
 		for_each_cpu(j, policy->related_cpus)
 			per_cpu(cpufreq_cpu_data, j) = policy;
 		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
+	} else {
+		policy->min = policy->user_policy.min;
+		policy->max = policy->user_policy.max;
 	}
 
 	if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
-- 
2.12.0.432.g71c3a4f4ba37
