From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 22/26] cpu_cooling: use cpufreq_dev_list instead of cpufreq_dev_count
Date: Fri, 28 Nov 2014 15:14:16 +0530
Message-ID: <a42cdb1213ec253a25ad0ed62657828e70f85600.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:44489 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbaK1JqB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Nov 2014 04:46:01 -0500
Received: by mail-pd0-f178.google.com with SMTP id g10so6460860pdj.9
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2014 01:46:00 -0800 (PST)
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, Viresh Kumar <viresh.kumar@linaro.org>

As we already have a list of cpufreq_cooling_devices now, lets use it instead of
a local counter.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index f76a665..4965a55 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -73,8 +73,6 @@ static DEFINE_IDR(cpufreq_idr);
 static LIST_HEAD(cpufreq_dev_list);
 static DEFINE_MUTEX(cooling_cpufreq_lock);
 
-static unsigned int cpufreq_dev_count;
-
 /* notify_table passes value to the CPUFREQ_ADJUST callback function. */
 #define NOTIFY_INVALID NULL
 static struct cpufreq_cooling_device *notify_device;
@@ -380,10 +378,9 @@ __cpufreq_cooling_register(struct device_node *np,
 	mutex_lock(&cooling_cpufreq_lock);
 
 	/* Register the notifier for first cpufreq cooling device */
-	if (cpufreq_dev_count == 0)
+	if (list_empty(&cpufreq_dev_list))
 		cpufreq_register_notifier(&thermal_cpufreq_notifier_block,
 					  CPUFREQ_POLICY_NOTIFIER);
-	cpufreq_dev_count++;
 
 	list_add(&cpufreq_dev->head, &cpufreq_dev_list);
 	mutex_unlock(&cooling_cpufreq_lock);
@@ -455,11 +452,10 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 
 	cpufreq_dev = cdev->devdata;
 	mutex_lock(&cooling_cpufreq_lock);
-	cpufreq_dev_count--;
 	list_del(&cpufreq_dev->head);
 
 	/* Unregister the notifier for the last cpufreq cooling device */
-	if (cpufreq_dev_count == 0)
+	if (list_empty(&cpufreq_dev_list))
 		cpufreq_unregister_notifier(&thermal_cpufreq_notifier_block,
 					    CPUFREQ_POLICY_NOTIFIER);
 	mutex_unlock(&cooling_cpufreq_lock);
-- 
2.0.3.693.g996b0fd

