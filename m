From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 04/26] thermal: exynos: Handle -EPROBE_DEFER properly
Date: Fri, 28 Nov 2014 15:13:58 +0530
Message-ID: <79bbedd743bdd82f37a578ece26359432ddccc72.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:58990 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbaK1Jow (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Nov 2014 04:44:52 -0500
Received: by mail-pd0-f173.google.com with SMTP id ft15so6411677pdb.4
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2014 01:44:52 -0800 (PST)
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, Viresh Kumar <viresh.kumar@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>

cpufreq_cooling_register() can return -EPROBE_DEFER if cpufreq driver isn't
ready yet and so the callers must defer their initialization.

Exynos thermal drivers weren't handling this well and were raising false error
message when -EPROBE_DEFER is returned to them.

Fix them to handle -EPROBE_DEFER.

Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/samsung/exynos_thermal_common.c | 7 ++++---
 drivers/thermal/samsung/exynos_tmu.c            | 4 +++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_thermal_common.c b/drivers/thermal/samsung/exynos_thermal_common.c
index bf39212..0be1d54 100644
--- a/drivers/thermal/samsung/exynos_thermal_common.c
+++ b/drivers/thermal/samsung/exynos_thermal_common.c
@@ -369,9 +369,10 @@ int exynos_register_thermal(struct thermal_sensor_conf *sensor_conf)
 		th_zone->cool_dev[th_zone->cool_dev_size] =
 				cpufreq_cooling_register(cpu_present_mask);
 		if (IS_ERR(th_zone->cool_dev[th_zone->cool_dev_size])) {
-			dev_err(sensor_conf->dev,
-				"Failed to register cpufreq cooling device\n");
-			ret = -EINVAL;
+			ret = PTR_ERR(th_zone->cool_dev[th_zone->cool_dev_size]);
+			if (ret != -EPROBE_DEFER)
+				dev_err(sensor_conf->dev,
+					"Failed to register cpufreq cooling device\n");
 			goto err_unregister;
 		}
 		th_zone->cool_dev_size++;
diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 49c0924..cc3677f 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -683,7 +683,9 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	/* Register the sensor with thermal management interface */
 	ret = exynos_register_thermal(sensor_conf);
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to register thermal interface\n");
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev,
+				"Failed to register thermal interface\n");
 		goto err_clk;
 	}
 	data->reg_conf = sensor_conf;
-- 
2.0.3.693.g996b0fd

