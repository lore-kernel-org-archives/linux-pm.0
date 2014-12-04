From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 03/26] thermal: imx: pass cpu_present_mask to cpufreq_cooling_register()
Date: Thu,  4 Dec 2014 09:41:45 +0530
Message-ID: <86506c35f168670c63da247c584182a9da80db63.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:38250 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755AbaLDEM5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Dec 2014 23:12:57 -0500
Received: by mail-pa0-f44.google.com with SMTP id et14so17151962pad.31
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2014 20:12:57 -0800 (PST)
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, amit.daniel@samsung.com, javi.merino@arm.com, Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawn.guo@linaro.org>

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
index 16405b4..d80e36eb 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -453,7 +453,6 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	const struct of_device_id *of_id =
 		of_match_device(of_imx_thermal_match, &pdev->dev);
 	struct imx_thermal_data *data;
-	struct cpumask clip_cpus;
 	struct regmap *map;
 	int measure_freq;
 	int ret;
@@ -511,8 +510,7 @@ static int imx_thermal_probe(struct platform_device *pdev)
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

