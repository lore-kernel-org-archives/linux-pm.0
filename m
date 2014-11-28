From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 01/26] thermal: db8500: pass cpu_present_mask to cpufreq_cooling_register()
Date: Fri, 28 Nov 2014 15:13:55 +0530
Message-ID: <592c06a7619df6b9fe74d3bb716287902df9a2c1.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:42474 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbaK1Jok (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Nov 2014 04:44:40 -0500
Received: by mail-pd0-f169.google.com with SMTP id fp1so6323905pdb.14
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2014 01:44:40 -0800 (PST)
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, Viresh Kumar <viresh.kumar@linaro.org>, Hongbo Zhang <hongbo.zhang@linaro.com>

cpufreq_cooling_register() expects mask of all the CPUs where frequency
constraint is applicable.

This platform has more than one CPU to which these constraints will apply and so
passing mask of only CPU0 wouldn't be sufficient. Also, this platform has a
single cluster of CPUs and the constraint applies to all CPUs.

If CPU0 is hoplugged out then we may face strange BUGs as cpu_cooling framework
isn't aware of any siblings sharing clock line.

Fix it by passing cpu_present_mask to cpufreq_cooling_register().

Cc: Hongbo Zhang <hongbo.zhang@linaro.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/db8500_cpufreq_cooling.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/thermal/db8500_cpufreq_cooling.c b/drivers/thermal/db8500_cpufreq_cooling.c
index 786d192..374ef1e 100644
--- a/drivers/thermal/db8500_cpufreq_cooling.c
+++ b/drivers/thermal/db8500_cpufreq_cooling.c
@@ -28,15 +28,12 @@
 static int db8500_cpufreq_cooling_probe(struct platform_device *pdev)
 {
 	struct thermal_cooling_device *cdev;
-	struct cpumask mask_val;
 
 	/* make sure cpufreq driver has been initialized */
 	if (!cpufreq_frequency_get_table(0))
 		return -EPROBE_DEFER;
 
-	cpumask_set_cpu(0, &mask_val);
-	cdev = cpufreq_cooling_register(&mask_val);
-
+	cdev = cpufreq_cooling_register(cpu_present_mask);
 	if (IS_ERR(cdev)) {
 		dev_err(&pdev->dev, "Failed to register cooling device\n");
 		return PTR_ERR(cdev);
-- 
2.0.3.693.g996b0fd

