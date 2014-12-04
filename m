From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 22/26] thermal: cpu_cooling: use cpufreq_dev_list instead of cpufreq_dev_count
Date: Thu,  4 Dec 2014 09:42:04 +0530
Message-ID: <564b1bad6f91e237eee3eed823f45f3f32be1b48.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:40548 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582AbaLDEOL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Dec 2014 23:14:11 -0500
Received: by mail-pa0-f53.google.com with SMTP id kq14so17147023pab.12
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2014 20:14:10 -0800 (PST)
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, amit.daniel@samsung.com, javi.merino@arm.com, Viresh Kumar <viresh.kumar@linaro.org>

As we already have a list of cpufreq_cooling_devices now, lets use it instead of
a local counter.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index d2e6f84..32ff6dc 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -71,8 +71,6 @@ struct cpufreq_cooling_device {
 static DEFINE_IDR(cpufreq_idr);
 static DEFINE_MUTEX(cooling_cpufreq_lock);
 
-static unsigned int cpufreq_dev_count;
-
 static LIST_HEAD(cpufreq_dev_list);
 
 /**
@@ -419,10 +417,9 @@ __cpufreq_cooling_register(struct device_node *np,
 	mutex_lock(&cooling_cpufreq_lock);
 
 	/* Register the notifier for first cpufreq cooling device */
-	if (cpufreq_dev_count == 0)
+	if (list_empty(&cpufreq_dev_list))
 		cpufreq_register_notifier(&thermal_cpufreq_notifier_block,
 					  CPUFREQ_POLICY_NOTIFIER);
-	cpufreq_dev_count++;
 	list_add(&cpufreq_dev->node, &cpufreq_dev_list);
 
 	mutex_unlock(&cooling_cpufreq_lock);
@@ -495,10 +492,9 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 	cpufreq_dev = cdev->devdata;
 	mutex_lock(&cooling_cpufreq_lock);
 	list_del(&cpufreq_dev->node);
-	cpufreq_dev_count--;
 
 	/* Unregister the notifier for the last cpufreq cooling device */
-	if (cpufreq_dev_count == 0)
+	if (list_empty(&cpufreq_dev_list))
 		cpufreq_unregister_notifier(&thermal_cpufreq_notifier_block,
 					    CPUFREQ_POLICY_NOTIFIER);
 	mutex_unlock(&cooling_cpufreq_lock);
-- 
2.0.3.693.g996b0fd

