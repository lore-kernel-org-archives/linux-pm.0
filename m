From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 15/26] cpu_cooling: do error handling at the bottom in __cpufreq_cooling_register()
Date: Fri, 28 Nov 2014 15:14:09 +0530
Message-ID: <01711a86da59f30b33e1c32aa29cc9b378d0c627.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:56127 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbaK1Jpd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Nov 2014 04:45:33 -0500
Received: by mail-pd0-f171.google.com with SMTP id y13so6405472pdi.16
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2014 01:45:33 -0800 (PST)
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, Viresh Kumar <viresh.kumar@linaro.org>

This makes life easy and bug free. And is scalable for future resource
allocations.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 41aa7d5..032cba3 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -440,8 +440,8 @@ __cpufreq_cooling_register(struct device_node *np,
 
 	ret = get_idr(&cpufreq_idr, &cpufreq_dev->id);
 	if (ret) {
-		kfree(cpufreq_dev);
-		return ERR_PTR(cpufreq_dev->id);
+		cool_dev = ERR_PTR(cpufreq_dev->id);
+		goto free_cdev;
 	}
 
 	snprintf(dev_name, sizeof(dev_name), "thermal-cpufreq-%d",
@@ -449,11 +449,9 @@ __cpufreq_cooling_register(struct device_node *np,
 
 	cool_dev = thermal_of_cooling_device_register(np, dev_name, cpufreq_dev,
 						      &cpufreq_cooling_ops);
-	if (IS_ERR(cool_dev)) {
-		release_idr(&cpufreq_idr, cpufreq_dev->id);
-		kfree(cpufreq_dev);
-		return cool_dev;
-	}
+	if (IS_ERR(cool_dev))
+		goto remove_idr;
+
 	cpufreq_dev->cool_dev = cool_dev;
 
 	mutex_lock(&cooling_cpufreq_lock);
@@ -467,6 +465,13 @@ __cpufreq_cooling_register(struct device_node *np,
 	mutex_unlock(&cooling_cpufreq_lock);
 
 	return cool_dev;
+
+remove_idr:
+	release_idr(&cpufreq_idr, cpufreq_dev->id);
+free_cdev:
+	kfree(cpufreq_dev);
+
+	return cool_dev;
 }
 
 /**
-- 
2.0.3.693.g996b0fd

