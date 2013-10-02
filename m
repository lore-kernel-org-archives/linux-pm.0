From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH RESEND 04/11] cpufreq: Remove extra blank line
Date: Wed,  2 Oct 2013 14:13:12 +0530
Message-ID: <f70f2486e3107448d1d3b835b78ad20724fdd252.1380703248.git.viresh.kumar@linaro.org>
References: <cover.1380703248.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1380703248.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380703248.git.viresh.kumar@linaro.org>
References: <cover.1380703248.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

We don't need a blank line just at start of a block, lets remove it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d80cbe6..d149caa 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1155,7 +1155,6 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
 		if (!frozen)
 			sysfs_remove_link(&dev->kobj, "cpufreq");
 	} else if (cpus > 1) {
-
 		new_cpu = cpufreq_nominate_new_policy_cpu(policy, cpu, frozen);
 		if (new_cpu >= 0) {
 			update_policy_cpu(policy, new_cpu);
-- 
1.7.12.rc2.18.g61b472e

