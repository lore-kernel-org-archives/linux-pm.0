From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 5/5] cpufreq: ARM big LITTLE: Improve print message
Date: Mon, 29 Apr 2013 18:54:48 +0530
Message-ID: <61da22c0f40fb46dc31f0ad5183b4ea51dda518c.1367241503.git.viresh.kumar@linaro.org>
References: <cover.1367241503.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1367241503.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1367241503.git.viresh.kumar@linaro.org>
References: <cover.1367241503.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Print message at the end of driver->init() doesn't carry "cpufreq" string at all
and so is difficult to find in dmesg. Add function name in message to clearly
state where the message is coming from.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/arm_big_little.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index fd7beed..5d7f53f 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -187,7 +187,7 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
 
 	cpumask_copy(policy->cpus, topology_core_cpumask(policy->cpu));
 
-	dev_info(cpu_dev, "CPU %d initialized\n", policy->cpu);
+	dev_info(cpu_dev, "%s: CPU %d initialized\n", __func__, policy->cpu);
 	return 0;
 }
 
-- 
1.7.12.rc2.18.g61b472e
