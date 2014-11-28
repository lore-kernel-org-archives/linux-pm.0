From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 21/26] cpu_cooling: create list of cpufreq_cooling_devices
Date: Fri, 28 Nov 2014 15:14:15 +0530
Message-ID: <451cea6e5f417b0e76747ea8d8f3aa852f8bbf54.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:38089 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbaK1Jp5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Nov 2014 04:45:57 -0500
Received: by mail-pa0-f44.google.com with SMTP id et14so6599325pad.3
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2014 01:45:57 -0800 (PST)
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, Viresh Kumar <viresh.kumar@linaro.org>

That will be used by later patches to iterate over all cpufreq cooling devices.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index ddb97aa..f76a665 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -66,8 +66,11 @@ struct cpufreq_cooling_device {
 	unsigned int cpufreq_val;
 	unsigned int max_level;
 	struct cpumask allowed_cpus;
+	struct list_head head;
 };
+
 static DEFINE_IDR(cpufreq_idr);
+static LIST_HEAD(cpufreq_dev_list);
 static DEFINE_MUTEX(cooling_cpufreq_lock);
 
 static unsigned int cpufreq_dev_count;
@@ -372,6 +375,7 @@ __cpufreq_cooling_register(struct device_node *np,
 		goto remove_idr;
 
 	cpufreq_dev->cool_dev = cool_dev;
+	INIT_LIST_HEAD(&cpufreq_dev->head);
 
 	mutex_lock(&cooling_cpufreq_lock);
 
@@ -381,6 +385,7 @@ __cpufreq_cooling_register(struct device_node *np,
 					  CPUFREQ_POLICY_NOTIFIER);
 	cpufreq_dev_count++;
 
+	list_add(&cpufreq_dev->head, &cpufreq_dev_list);
 	mutex_unlock(&cooling_cpufreq_lock);
 
 	return cool_dev;
@@ -451,6 +456,7 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 	cpufreq_dev = cdev->devdata;
 	mutex_lock(&cooling_cpufreq_lock);
 	cpufreq_dev_count--;
+	list_del(&cpufreq_dev->head);
 
 	/* Unregister the notifier for the last cpufreq cooling device */
 	if (cpufreq_dev_count == 0)
-- 
2.0.3.693.g996b0fd

