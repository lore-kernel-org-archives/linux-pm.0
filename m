From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V11 5/7] soc: qcom: rpmpd: Add support for set performance state
Date: Wed, 11 Oct 2017 12:54:17 +0530
Message-ID: <5122d00c2f3c0ba076fd7879a4cc397183ccfab2.1507703370.git.viresh.kumar@linaro.org>
References: <cover.1507703370.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:44147 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757076AbdJKHZB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Oct 2017 03:25:01 -0400
Received: by mail-pg0-f52.google.com with SMTP id j3so553747pga.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Oct 2017 00:25:00 -0700 (PDT)
In-Reply-To: <cover.1507703370.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1507703370.git.viresh.kumar@linaro.org>
References: <cover.1507703370.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Nishanth Menon <nm@ti.com>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, sudeep.holla@arm.com, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>

From: Rajendra Nayak <rnayak@codeaurora.org>

NOT FOR MERGE.

With genpd now expecting power domain drivers supporting performance
state to support set performance state callbacks, add support for it in
the rpmpd driver.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/soc/qcom/rpmpd.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 0958d7693c4f..34d2eb4e75bf 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -230,6 +230,28 @@ static int rpmpd_power_off(struct generic_pm_domain *domain)
 	return ret;
 }
 
+static int rpmpd_set_performance(struct generic_pm_domain *domain,
+				 unsigned int state)
+{
+	int ret = 0;
+	struct rpmpd *pd = domain_to_rpmpd(domain);
+
+	mutex_lock(&rpmpd_lock);
+
+	pd->corner = state;
+
+	if (!pd->enabled && (pd->key != KEY_FLOOR_CORNER))
+		goto out;
+
+	ret = rpmpd_aggregate_corner(pd);
+
+out:
+	mutex_unlock(&rpmpd_lock);
+
+	return ret;
+}
+
+
 static int rpmpd_probe(struct platform_device *pdev)
 {
 	int i;
@@ -267,6 +289,7 @@ static int rpmpd_probe(struct platform_device *pdev)
 		rpmpds[i]->rpm = rpm;
 		rpmpds[i]->pd.power_off = rpmpd_power_off;
 		rpmpds[i]->pd.power_on = rpmpd_power_on;
+		rpmpds[i]->pd.genpd_set_performance_state = rpmpd_set_performance;
 		pm_genpd_init(&rpmpds[i]->pd, NULL, true);
 
 		data->domains[i] = &rpmpds[i]->pd;
-- 
2.7.4
