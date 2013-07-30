From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/2] cpufreq: Remove extra variables
Date: Tue, 30 Jul 2013 19:06:33 +0530
Message-ID: <2095cb9de80d87867dbfa42f8433f766891c93ab.1375191318.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:49097 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754593Ab3G3NiR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2013 09:38:17 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so7190791pab.29
        for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2013 06:38:16 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

We call cpufreq_cpu_get() in cpufreq_add_dev_symlink() to increase usage
refcount of policy and not to get policy for a cpu. So, we don't really need to
capture the return value of this routine and call put for it later for failure
cases. We can simply use policy passed as an argument to this routine.

Moreover debug print is rewritten to make it more clear.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 170d344..35e1a03 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -813,19 +813,18 @@ static int cpufreq_add_dev_symlink(unsigned int cpu,
 	int ret = 0;
 
 	for_each_cpu(j, policy->cpus) {
-		struct cpufreq_policy *managed_policy;
 		struct device *cpu_dev;
 
 		if (j == cpu)
 			continue;
 
-		pr_debug("CPU %u already managed, adding link\n", j);
-		managed_policy = cpufreq_cpu_get(cpu);
+		pr_debug("Adding link for CPU: %u\n", j);
+		cpufreq_cpu_get(cpu);
 		cpu_dev = get_cpu_device(j);
 		ret = sysfs_create_link(&cpu_dev->kobj, &policy->kobj,
 					"cpufreq");
 		if (ret) {
-			cpufreq_cpu_put(managed_policy);
+			cpufreq_cpu_put(policy);
 			return ret;
 		}
 	}
-- 
1.7.12.rc2.18.g61b472e

