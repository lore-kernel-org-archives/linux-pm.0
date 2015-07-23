From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 3/3] cpufreq: use cpumask_test_and_clear_cpu() instead of separate routines
Date: Thu, 23 Jul 2015 13:43:20 +0530
Message-ID: <e7bab41addcbe453186ab3c528d5bc23671d4fb5.1437639021.git.viresh.kumar@linaro.org>
References: <20150723060938.GD5322@linux>
 <e6d358cd9a19b6da6326deb05f9be2594904fad2.1437639021.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e6d358cd9a19b6da6326deb05f9be2594904fad2.1437639021.git.viresh.kumar@linaro.org>
In-Reply-To: <e6d358cd9a19b6da6326deb05f9be2594904fad2.1437639021.git.viresh.kumar@linaro.org>
References: <e6d358cd9a19b6da6326deb05f9be2594904fad2.1437639021.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

We need to clear cpumask only if the relevant cpu is set and we could
have used cpumask_test_and_clear_cpu() and set instead.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d01cad993fa7..b223c9c5296b 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1498,10 +1498,9 @@ static int cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 	}
 
 	/* sysfs links are removed only on subsys callback */
-	if (cpumask_test_cpu(cpu, policy->linked_cpus)) {
+	if (cpumask_test_and_clear_cpu(cpu, policy->linked_cpus)) {
 		dev_dbg(dev, "%s: Removing symlink for CPU: %u\n", __func__,
 			cpu);
-		cpumask_clear_cpu(cpu, policy->linked_cpus);
 		sysfs_remove_link(&dev->kobj, "cpufreq");
 		return 0;
 	}
-- 
2.4.0
