From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 125/228] cpufreq: tegra: don't initialize part of policy that is set by core too
Date: Fri, 13 Sep 2013 18:31:11 +0530
Message-ID: <cc2261a50960673d13df14b49ebfd1ecad2d1ab3.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:62874 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932804Ab3IMNRt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Sep 2013 09:17:49 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf1so2539005pab.10
        for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2013 06:17:49 -0700 (PDT)
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, Stephen Warren <swarren@nvidia.com>

Many common initializations of struct policy are moved to core now and hence
this driver doesn't need to do it. This patch removes such code.

Most recent of those changes is to call ->get() in the core after calling
->init().

Cc: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/tegra-cpufreq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/tegra-cpufreq.c b/drivers/cpufreq/tegra-cpufreq.c
index c36a8e7..9c32b23 100644
--- a/drivers/cpufreq/tegra-cpufreq.c
+++ b/drivers/cpufreq/tegra-cpufreq.c
@@ -211,8 +211,7 @@ static int tegra_cpu_init(struct cpufreq_policy *policy)
 	clk_prepare_enable(cpu_clk);
 
 	cpufreq_table_validate_and_show(policy, freq_table);
-	policy->cur = tegra_getspeed(policy->cpu);
-	target_cpu_speed[policy->cpu] = policy->cur;
+	target_cpu_speed[policy->cpu] = tegra_getspeed(policy->cpu);
 
 	/* FIXME: what's the actual transition time? */
 	policy->cpuinfo.transition_latency = 300 * 1000;
-- 
1.7.12.rc2.18.g61b472e

