From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 71/92] cpufreq: tegra: don't initialize part of policy that is set by core too
Date: Thu,  3 Oct 2013 20:29:05 +0530
Message-ID: <1e5ed605e56b1c7f57203c69ff2b0554e9e0584e.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:45487 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754326Ab3JCPG6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2013 11:06:58 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so2597349pde.37
        for <linux-pm@vger.kernel.org>; Thu, 03 Oct 2013 08:06:58 -0700 (PDT)
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Stephen Warren <swarren@nvidia.com>

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

