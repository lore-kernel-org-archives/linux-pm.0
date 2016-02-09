From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 10/16] cpufreq: dt: OPP layers handles clock-latency for V1 bindings as well
Date: Tue,  9 Feb 2016 10:30:42 +0530
Message-ID: <27a4bd439b1355945dd2f965eeea58230d01ba6a.1454992187.git.viresh.kumar@linaro.org>
References: <cover.1454992186.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35312 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874AbcBIFCF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2016 00:02:05 -0500
Received: by mail-pa0-f41.google.com with SMTP id ho8so85229703pac.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Feb 2016 21:02:04 -0800 (PST)
In-Reply-To: <cover.1454992186.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1454992186.git.viresh.kumar@linaro.org>
References: <cover.1454992186.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>

"clock-latency" is handled by OPP layer for all bindings and so there is
no need to make special calls for V1 bindings. Use
dev_pm_opp_get_max_clock_latency() for both the cases.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/cpufreq/cpufreq-dt.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 0047d20803db..4c9f8a828f6f 100644
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
2.7.1.370.gb2aa7f8

