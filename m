From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 6/6] cpufreq: arm_big_little: Make ->get_transition_latency() mandatory
Date: Thu, 29 Jun 2017 16:29:09 +0530
Message-ID: <2397694de67a66309815b7e38d5888f140a0f336.1498733506.git.viresh.kumar@linaro.org>
References: <cover.1498733506.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35588 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752689AbdF2K7d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jun 2017 06:59:33 -0400
Received: by mail-pg0-f42.google.com with SMTP id j186so46255610pge.2
        for <linux-pm@vger.kernel.org>; Thu, 29 Jun 2017 03:59:32 -0700 (PDT)
In-Reply-To: <cover.1498733506.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1498733506.git.viresh.kumar@linaro.org>
References: <cover.1498733506.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org

All users of arm_big_little driver are defining it and there is no need
to keep it optional. Make it mandatory.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/arm_big_little.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index 418042201e6d..d1eb2a53b61f 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -483,11 +483,8 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
 		return ret;
 	}
 
-	if (arm_bL_ops->get_transition_latency)
-		policy->cpuinfo.transition_latency =
-			arm_bL_ops->get_transition_latency(cpu_dev);
-	else
-		policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
+	policy->cpuinfo.transition_latency =
+				arm_bL_ops->get_transition_latency(cpu_dev);
 
 	if (is_bL_switching_enabled())
 		per_cpu(cpu_last_req_freq, policy->cpu) = clk_get_cpu_rate(policy->cpu);
@@ -622,7 +619,8 @@ int bL_cpufreq_register(struct cpufreq_arm_bL_ops *ops)
 		return -EBUSY;
 	}
 
-	if (!ops || !strlen(ops->name) || !ops->init_opp_table) {
+	if (!ops || !strlen(ops->name) || !ops->init_opp_table ||
+	    !ops->get_transition_latency) {
 		pr_err("%s: Invalid arm_bL_ops, exiting\n", __func__);
 		return -ENODEV;
 	}
-- 
2.13.0.71.gd7076ec9c9cb
