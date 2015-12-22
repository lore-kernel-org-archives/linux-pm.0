From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 10/17] cpufreq: dt: Rename 'need_update' to 'opp_v1'
Date: Tue, 22 Dec 2015 15:46:11 +0530
Message-ID: <0107c166a02315b3e04dd3a9e1af5c59f469ce3c.1450777582.git.viresh.kumar@linaro.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33003 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932181AbbLVKQ6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Dec 2015 05:16:58 -0500
Received: by mail-pa0-f44.google.com with SMTP id cy9so33023929pac.0
        for <linux-pm@vger.kernel.org>; Tue, 22 Dec 2015 02:16:58 -0800 (PST)
In-Reply-To: <cover.1450777582.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1450777582.git.viresh.kumar@linaro.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>

That's the real purpose of this field, i.e. to take special care of old
OPP V1 bindings. Lets name it accordingly, so that it can be used
elsewhere.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 45ff7671a883..7af6e466205f 100644
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
2.7.0.rc1.186.g94414c4

