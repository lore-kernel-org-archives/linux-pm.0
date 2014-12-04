From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 04/26] thermal: exynos: pass cpu_present_mask to cpufreq_cooling_register()
Date: Thu,  4 Dec 2014 09:41:46 +0530
Message-ID: <3cdb64044ce698b11beb0bb2f9a2c9f1ad100053.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:42476 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938AbaLDENB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Dec 2014 23:13:01 -0500
Received: by mail-pa0-f44.google.com with SMTP id et14so17152089pad.31
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2014 20:13:01 -0800 (PST)
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, amit.daniel@samsung.com, javi.merino@arm.com, Viresh Kumar <viresh.kumar@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>

cpufreq_cooling_register() expects mask of all the CPUs where frequency
constraint is applicable.

This platform has more than one CPU to which these constraints will apply and so
passing mask of only CPU0 wouldn't be sufficient. Also, this platform has a
single cluster of CPUs and the constraint applies to all CPUs.

If CPU0 is hoplugged out then we may face strange BUGs as cpu_cooling framework
isn't aware of any siblings sharing clock line.

Fix it by passing cpu_present_mask to cpufreq_cooling_register().

Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/samsung/exynos_thermal_common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_thermal_common.c b/drivers/thermal/samsung/exynos_thermal_common.c
index 50a1f17..6dc3815 100644
--- a/drivers/thermal/samsung/exynos_thermal_common.c
+++ b/drivers/thermal/samsung/exynos_thermal_common.c
@@ -347,7 +347,6 @@ void exynos_report_trigger(struct thermal_sensor_conf *conf)
 int exynos_register_thermal(struct thermal_sensor_conf *sensor_conf)
 {
 	int ret;
-	struct cpumask mask_val;
 	struct exynos_thermal_zone *th_zone;
 
 	if (!sensor_conf || !sensor_conf->read_temperature) {
@@ -367,9 +366,8 @@ int exynos_register_thermal(struct thermal_sensor_conf *sensor_conf)
 	 *	 sensor
 	 */
 	if (sensor_conf->cooling_data.freq_clip_count > 0) {
-		cpumask_set_cpu(0, &mask_val);
 		th_zone->cool_dev[th_zone->cool_dev_size] =
-					cpufreq_cooling_register(&mask_val);
+				cpufreq_cooling_register(cpu_present_mask);
 		if (IS_ERR(th_zone->cool_dev[th_zone->cool_dev_size])) {
 			ret = PTR_ERR(th_zone->cool_dev[th_zone->cool_dev_size]);
 			if (ret != -EPROBE_DEFER)
-- 
2.0.3.693.g996b0fd

