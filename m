From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 24/37] cpufreq: pcc: don't initialize part of policy that is set by core too
Date: Wed, 14 Aug 2013 19:02:13 +0530
Message-ID: <2201d8d70aca12a790f000333825353521fee1a7.1376486713.git.viresh.kumar@linaro.org>
References: <cover.1376486713.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1376486713.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376486713.git.viresh.kumar@linaro.org>
References: <cover.1376486713.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Many common initializations of struct policy are moved to core now and hence
this driver doesn't need to do it. This patch removes such code.

Most recent of those changes is to call ->get() in the core after calling
->init().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/pcc-cpufreq.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
index d81c4e5..0624bee 100644
--- a/drivers/cpufreq/pcc-cpufreq.c
+++ b/drivers/cpufreq/pcc-cpufreq.c
@@ -560,13 +560,6 @@ static int pcc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		ioread32(&pcch_hdr->nominal) * 1000;
 	policy->min = policy->cpuinfo.min_freq =
 		ioread32(&pcch_hdr->minimum_frequency) * 1000;
-	policy->cur = pcc_get_freq(cpu);
-
-	if (!policy->cur) {
-		pr_debug("init: Unable to get current CPU frequency\n");
-		result = -EINVAL;
-		goto out;
-	}
 
 	pr_debug("init: policy->max is %d, policy->min is %d\n",
 		policy->max, policy->min);
-- 
1.7.12.rc2.18.g61b472e
