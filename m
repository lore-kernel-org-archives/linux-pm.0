From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 8/8] imx6q: free OPP table created during ->init()
Date: Tue, 25 Nov 2014 16:04:23 +0530
Message-ID: <7c9805644464c2aa84e75478ac2854b06317bd21.1416910766.git.viresh.kumar@linaro.org>
References: <cover.1416910766.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:39422 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414AbaKYKgG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Nov 2014 05:36:06 -0500
Received: by mail-pd0-f176.google.com with SMTP id y10so314620pdj.35
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2014 02:36:06 -0800 (PST)
In-Reply-To: <cover.1416910766.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1416910766.git.viresh.kumar@linaro.org>
References: <cover.1416910766.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, stefan.wahren@i2se.com, nm@ti.com, linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, Viresh Kumar <viresh.kumar@linaro.org>

OPP layer now supports freeing of OPPs and we should free them once they aren't
useful anymore.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/imx6q-cpufreq.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index c2d3076..5da1d13 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -31,6 +31,7 @@ static struct clk *step_clk;
 static struct clk *pll2_pfd2_396m_clk;
 
 static struct device *cpu_dev;
+static bool free_opp;
 static struct cpufreq_frequency_table *freq_table;
 static unsigned int transition_latency;
 
@@ -207,11 +208,14 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 			goto put_reg;
 		}
 
+		/* Because we have added the OPPs here, we must free them */
+		free_opp = true;
+
 		num = dev_pm_opp_get_opp_count(cpu_dev);
 		if (num < 0) {
 			ret = num;
 			dev_err(cpu_dev, "no OPP table is found: %d\n", ret);
-			goto put_reg;
+			goto out_free_opp;
 		}
 	}
 
@@ -306,6 +310,9 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 
 free_freq_table:
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
+out_free_opp:
+	if (free_opp)
+		of_free_opp_table(cpu_dev);
 put_reg:
 	if (!IS_ERR(arm_reg))
 		regulator_put(arm_reg);
@@ -332,6 +339,8 @@ static int imx6q_cpufreq_remove(struct platform_device *pdev)
 {
 	cpufreq_unregister_driver(&imx6q_cpufreq_driver);
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
+	if (free_opp)
+		of_free_opp_table(cpu_dev);
 	regulator_put(arm_reg);
 	if (!IS_ERR(pu_reg))
 		regulator_put(pu_reg);
-- 
2.0.3.693.g996b0fd

