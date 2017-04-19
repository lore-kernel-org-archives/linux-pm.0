From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 17/17] thermal: cpu_cooling: Rearrange struct cpufreq_cooling_device
Date: Wed, 19 Apr 2017 10:59:12 +0530
Message-ID: <56b3e4d4209787d3b2292f04c90f1fd969fdf90c.1492579345.git.viresh.kumar@linaro.org>
References: <cover.1492579345.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34644 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760021AbdDSFbm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Apr 2017 01:31:42 -0400
Received: by mail-pf0-f177.google.com with SMTP id c198so7003720pfc.1
        for <linux-pm@vger.kernel.org>; Tue, 18 Apr 2017 22:31:42 -0700 (PDT)
In-Reply-To: <cover.1492579345.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1492579345.git.viresh.kumar@linaro.org>
References: <cover.1492579345.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Lukasz Luba <lukasz.luba@arm.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Punit Agrawal <punit.agrawal@arm.com>

This shrinks the size of the structure on arm64 by 8 bytes by avoiding
padding of 4 bytes at two places.

Also add missing doc comment for freq_table

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index dc73405b04f2..05073c33ba20 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -75,17 +75,18 @@ struct time_in_idle {
  * struct cpufreq_cooling_device - data for cooling device with cpufreq
  * @id: unique integer value corresponding to each cpufreq_cooling_device
  *	registered.
- * @cdev: thermal_cooling_device pointer to keep track of the
- *	registered cooling device.
- * @policy: cpufreq policy.
+ * @last_load: load measured by the latest call to cpufreq_get_requested_power()
  * @cpufreq_state: integer value representing the current state of cpufreq
  *	cooling	devices.
  * @clipped_freq: integer value representing the absolute value of the clipped
  *	frequency.
  * @max_level: maximum cooling level. One less than total number of valid
  *	cpufreq frequencies.
+ * @freq_table: Freq table in descending order of frequencies
+ * @cdev: thermal_cooling_device pointer to keep track of the
+ *	registered cooling device.
+ * @policy: cpufreq policy.
  * @node: list_head to link all cpufreq_cooling_device together.
- * @last_load: load measured by the latest call to cpufreq_get_requested_power()
  * @idle_time: idle time stats
  * @plat_get_static_power: callback to calculate the static power
  *
@@ -94,14 +95,14 @@ struct time_in_idle {
  */
 struct cpufreq_cooling_device {
 	int id;
-	struct thermal_cooling_device *cdev;
-	struct cpufreq_policy *policy;
+	u32 last_load;
 	unsigned int cpufreq_state;
 	unsigned int clipped_freq;
 	unsigned int max_level;
 	struct freq_table *freq_table;	/* In descending order */
+	struct thermal_cooling_device *cdev;
+	struct cpufreq_policy *policy;
 	struct list_head node;
-	u32 last_load;
 	struct time_in_idle *idle_time;
 	get_static_t plat_get_static_power;
 };
-- 
2.12.0.432.g71c3a4f4ba37
