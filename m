From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 09/17] thermal: cpu_cooling: store cpufreq policy
Date: Mon, 17 Apr 2017 11:31:54 +0530
Message-ID: <43bc32f0c5fc796fd90f3c2310bb04a8226ccf64.1492408342.git.viresh.kumar@linaro.org>
References: <cover.1492408342.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36747 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932941AbdDQGDS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Apr 2017 02:03:18 -0400
Received: by mail-pg0-f48.google.com with SMTP id g2so67321019pge.3
        for <linux-pm@vger.kernel.org>; Sun, 16 Apr 2017 23:03:13 -0700 (PDT)
In-Reply-To: <cover.1492408342.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1492408342.git.viresh.kumar@linaro.org>
References: <cover.1492408342.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

The cpufreq policy can be used by the cpu_cooling driver, lets store it
in the cpufreq_cooling_device structure.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 48fc5447bbf6..bc018c628c93 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -67,6 +67,7 @@ struct power_table {
  *	registered.
  * @cdev: thermal_cooling_device pointer to keep track of the
  *	registered cooling device.
+ * @policy: cpufreq policy.
  * @cpufreq_state: integer value representing the current state of cpufreq
  *	cooling	devices.
  * @clipped_freq: integer value representing the absolute value of the clipped
@@ -91,6 +92,7 @@ struct power_table {
 struct cpufreq_cooling_device {
 	int id;
 	struct thermal_cooling_device *cdev;
+	struct cpufreq_policy *policy;
 	unsigned int cpufreq_state;
 	unsigned int clipped_freq;
 	unsigned int max_level;
@@ -827,6 +829,7 @@ __cpufreq_cooling_register(struct device_node *np,
 
 	cpufreq_cdev->clipped_freq = cpufreq_cdev->freq_table[0];
 	cpufreq_cdev->cdev = cdev;
+	cpufreq_cdev->policy = policy;
 
 	mutex_lock(&cooling_list_lock);
 	/* Register the notifier for first cpufreq cooling device */
-- 
2.12.0.432.g71c3a4f4ba37
