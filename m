From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 02/26] thermal: db8500: pass cpu_present_mask to cpufreq_cooling_register()
Date: Thu,  4 Dec 2014 09:41:44 +0530
Message-ID: <fc802a046dd2ad250e934a05af1104789f5c12e7.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:65259 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872AbaLDEMy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Dec 2014 23:12:54 -0500
Received: by mail-pa0-f45.google.com with SMTP id lj1so17188037pab.4
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2014 20:12:53 -0800 (PST)
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, amit.daniel@samsung.com, javi.merino@arm.com, Viresh Kumar <viresh.kumar@linaro.org>, Hongbo Zhang <hongbo.zhang@linaro.com>, Linus Walleij <linus.walleij@linaro.org>

cpufreq_cooling_register() expects mask of all the CPUs where frequency
constraint is applicable.

This platform has more than one CPU to which these constraints will apply and so
passing mask of only CPU0 wouldn't be sufficient. Also, this platform has a
single cluster of CPUs and the constraint applies to all CPUs.

If CPU0 is hoplugged out then we may face strange BUGs as cpu_cooling framework
isn't aware of any siblings sharing clock line.

Fix it by passing cpu_present_mask to cpufreq_cooling_register().

Cc: Hongbo Zhang <hongbo.zhang@linaro.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/db8500_cpufreq_cooling.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/thermal/db8500_cpufreq_cooling.c b/drivers/thermal/db8500_cpufreq_cooling.c
index 1ac7ec6..3cc3dd9 100644
--- a/drivers/thermal/db8500_cpufreq_cooling.c
+++ b/drivers/thermal/db8500_cpufreq_cooling.c
@@ -27,11 +27,8 @@
 static int db8500_cpufreq_cooling_probe(struct platform_device *pdev)
 {
 	struct thermal_cooling_device *cdev;
-	struct cpumask mask_val;
-
-	cpumask_set_cpu(0, &mask_val);
-	cdev = cpufreq_cooling_register(&mask_val);
 
+	cdev = cpufreq_cooling_register(cpu_present_mask);
 	if (IS_ERR(cdev)) {
 		dev_err(&pdev->dev, "Failed to register cooling device\n");
 		return PTR_ERR(cdev);
-- 
2.0.3.693.g996b0fd

