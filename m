From: Vaishali Thakkar <vthakkar1994@gmail.com>
Subject: [PATCH v2] thermal: cpu_cooling: Remove usage of devm functions
Date: Thu, 20 Aug 2015 21:44:02 +0530
Message-ID: <20150820161402.GA4951@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36504 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145AbbHTQOH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Aug 2015 12:14:07 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

In the function cpufreq_get_requested_power, the memory allocated
for load_cpu is live within the function only. And after the
allocation it is immediately freed with devm_kfree. There is no
need to allocate memory for load_cpu with devm function so replace
devm_kcalloc with kcalloc and devm_kfree with kfree.

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
---
Changes since v1:
	- Introduce new label based on Viresh Kumar's suggestion
---
 drivers/thermal/cpu_cooling.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 620dcd4..7027923 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -584,8 +584,7 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 	if (trace_thermal_power_cpu_get_power_enabled()) {
 		u32 ncpus = cpumask_weight(&cpufreq_device->allowed_cpus);
 
-		load_cpu = devm_kcalloc(&cdev->device, ncpus, sizeof(*load_cpu),
-					GFP_KERNEL);
+		load_cpu = kcalloc(ncpus, sizeof(*load_cpu), GFP_KERNEL);
 	}
 
 	for_each_cpu(cpu, &cpufreq_device->allowed_cpus) {
@@ -607,22 +606,21 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 
 	dynamic_power = get_dynamic_power(cpufreq_device, freq);
 	ret = get_static_power(cpufreq_device, tz, freq, &static_power);
-	if (ret) {
-		if (load_cpu)
-			devm_kfree(&cdev->device, load_cpu);
-		return ret;
-	}
+	if (ret)
+		goto free;
 
-	if (load_cpu) {
+	if (load_cpu)
 		trace_thermal_power_cpu_get_power(
 			&cpufreq_device->allowed_cpus,
 			freq, load_cpu, i, dynamic_power, static_power);
 
-		devm_kfree(&cdev->device, load_cpu);
-	}
-
 	*power = static_power + dynamic_power;
 	return 0;
+
+free:
+	kfree(load_cpu);
+
+	return ret;
 }
 
 /**
-- 
1.9.1

