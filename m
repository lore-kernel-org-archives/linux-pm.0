From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 16/26] thermal: cpu_cooling: do error handling at the bottom in __cpufreq_cooling_register()
Date: Thu,  4 Dec 2014 09:41:58 +0530
Message-ID: <9597eda04a6c679cbf8cdcb18ee423bbb7ac833a.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:34673 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753002AbaLDENr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Dec 2014 23:13:47 -0500
Received: by mail-pd0-f180.google.com with SMTP id p10so16872358pdj.11
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2014 20:13:46 -0800 (PST)
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, amit.daniel@samsung.com, javi.merino@arm.com, Viresh Kumar <viresh.kumar@linaro.org>

This makes life easy and bug free. And is scalable for future resource
allocations.

Acked-by: Javi Merino <javi.merino@arm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 1dd4cc4..491d90a 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -448,8 +448,8 @@ __cpufreq_cooling_register(struct device_node *np,
 
 	ret = get_idr(&cpufreq_idr, &cpufreq_dev->id);
 	if (ret) {
-		kfree(cpufreq_dev);
-		return ERR_PTR(ret);
+		cool_dev = ERR_PTR(ret);
+		goto free_cdev;
 	}
 
 	snprintf(dev_name, sizeof(dev_name), "thermal-cpufreq-%d",
@@ -457,11 +457,9 @@ __cpufreq_cooling_register(struct device_node *np,
 
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
@@ -476,6 +474,13 @@ __cpufreq_cooling_register(struct device_node *np,
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

