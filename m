From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 11/17] cpufreq: dt: OPP layers handles clock-latency for V1 bindings as well
Date: Tue, 22 Dec 2015 15:46:12 +0530
Message-ID: <617c40e84b653fa4253c8f3b2520f27127f87264.1450777582.git.viresh.kumar@linaro.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34694 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932181AbbLVKRC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Dec 2015 05:17:02 -0500
Received: by mail-pf0-f174.google.com with SMTP id u7so57927608pfb.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Dec 2015 02:17:01 -0800 (PST)
In-Reply-To: <cover.1450777582.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1450777582.git.viresh.kumar@linaro.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>

"clock-latency" is handled by OPP layer for all bindings and so there is
no need to make special calls for V1 bindings. Use
dev_pm_opp_get_max_clock_latency() for both the cases.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 7af6e466205f..a6f91da7283e 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -265,10 +265,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		if (ret)
 			dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
 				__func__, ret);
-
-		of_property_read_u32(np, "clock-latency", &transition_latency);
-	} else {
-		transition_latency = dev_pm_opp_get_max_clock_latency(cpu_dev);
 	}
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
@@ -279,6 +275,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 
 	of_property_read_u32(np, "voltage-tolerance", &priv->voltage_tolerance);
 
+	transition_latency = dev_pm_opp_get_max_clock_latency(cpu_dev);
 	if (!transition_latency)
 		transition_latency = CPUFREQ_ETERNAL;
 
-- 
2.7.0.rc1.186.g94414c4

