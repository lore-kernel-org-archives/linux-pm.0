From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 02/26] thermal: imx: pass cpu_present_mask to cpufreq_cooling_register()
Date: Fri, 28 Nov 2014 15:13:56 +0530
Message-ID: <1586ae144b782ab964debfd3936a4ae63d5109e1.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:54873 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbaK1Joo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Nov 2014 04:44:44 -0500
Received: by mail-pd0-f178.google.com with SMTP id g10so6458908pdj.9
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2014 01:44:44 -0800 (PST)
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawn.guo@linaro.org>

cpufreq_cooling_register() expects mask of all the CPUs where frequency
constraint is applicable.

This platform has more than one CPU to which these constraints will apply and so
passing mask of only CPU0 wouldn't be sufficient. Also, this platform has a
single cluster of CPUs and the constraint applies to all CPUs.

If CPU0 is hoplugged out then we may face strange BUGs as cpu_cooling framework
isn't aware of any siblings sharing clock line.

Fix it by passing cpu_present_mask to cpufreq_cooling_register().

Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/imx_thermal.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 5a1f107..1eefc6d 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -454,7 +454,6 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	const struct of_device_id *of_id =
 		of_match_device(of_imx_thermal_match, &pdev->dev);
 	struct imx_thermal_data *data;
-	struct cpumask clip_cpus;
 	struct regmap *map;
 	int measure_freq;
 	int ret;
@@ -516,8 +515,7 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	regmap_write(map, MISC0 + REG_SET, MISC0_REFTOP_SELBIASOFF);
 	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_POWER_DOWN);
 
-	cpumask_set_cpu(0, &clip_cpus);
-	data->cdev = cpufreq_cooling_register(&clip_cpus);
+	data->cdev = cpufreq_cooling_register(cpu_present_mask);
 	if (IS_ERR(data->cdev)) {
 		ret = PTR_ERR(data->cdev);
 		dev_err(&pdev->dev,
-- 
2.0.3.693.g996b0fd

