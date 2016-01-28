From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 09/16] cpufreq: dt: Rename 'need_update' to 'opp_v1'
Date: Thu, 28 Jan 2016 13:50:38 +0530
Message-ID: <edfae8fef311a7b27bd3abecdc8220a39826857f.1453965717.git.viresh.kumar@linaro.org>
References: <cover.1453965717.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33590 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934435AbcA1IVW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jan 2016 03:21:22 -0500
Received: by mail-pf0-f176.google.com with SMTP id x125so20095671pfb.0
        for <linux-pm@vger.kernel.org>; Thu, 28 Jan 2016 00:21:21 -0800 (PST)
In-Reply-To: <cover.1453965717.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1453965717.git.viresh.kumar@linaro.org>
References: <cover.1453965717.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>

That's the real purpose of this field, i.e. to take special care of old
OPP V1 bindings. Lets name it accordingly, so that it can be used
elsewhere.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/cpufreq/cpufreq-dt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index ace0168274d4..0047d20803db 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -199,7 +199,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	struct dev_pm_opp *suspend_opp;
 	unsigned long min_uV = ~0, max_uV = 0;
 	unsigned int transition_latency;
-	bool need_update = false;
+	bool opp_v1 = false;
 	int ret;
 
 	ret = allocate_resources(policy->cpu, &cpu_dev, &cpu_reg, &cpu_clk);
@@ -223,7 +223,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		 * finding shared-OPPs for backward compatibility.
 		 */
 		if (ret == -ENOENT)
-			need_update = true;
+			opp_v1 = true;
 		else
 			goto out_node_put;
 	}
@@ -251,7 +251,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		goto out_free_opp;
 	}
 
-	if (need_update) {
+	if (opp_v1) {
 		struct cpufreq_dt_platform_data *pd = cpufreq_get_driver_data();
 
 		if (!pd || !pd->independent_clocks)
-- 
2.7.0.79.gdc08a19

