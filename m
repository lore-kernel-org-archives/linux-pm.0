From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 3/3] PM / devfreq: Use devm_* APIs in exynos5_bus.c
Date: Wed,  5 Jun 2013 11:43:01 +0530
Message-ID: <1370412781-20683-3-git-send-email-sachin.kamat@linaro.org>
References: <1370412781-20683-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:35558 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268Ab3FEG1Z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2013 02:27:25 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so1359197pdj.15
        for <linux-pm@vger.kernel.org>; Tue, 04 Jun 2013 23:27:25 -0700 (PDT)
In-Reply-To: <1370412781-20683-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, a.kesavan@samsung.com, sachin.kamat@linaro.org, patches@linaro.org

devm_* APIs are device managed and make clean up and exit codes
simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/devfreq/exynos/exynos5_bus.c |   26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/devfreq/exynos/exynos5_bus.c b/drivers/devfreq/exynos/exynos5_bus.c
index 9a82419..102d1f0 100644
--- a/drivers/devfreq/exynos/exynos5_bus.c
+++ b/drivers/devfreq/exynos/exynos5_bus.c
@@ -351,20 +351,18 @@ static int exynos5_busfreq_int_probe(struct platform_device *pdev)
 
 	err = exynos5250_init_int_tables(data);
 	if (err)
-		goto err_regulator;
+		return err;
 
-	data->vdd_int = regulator_get(dev, "vdd_int");
+	data->vdd_int = devm_regulator_get(dev, "vdd_int");
 	if (IS_ERR(data->vdd_int)) {
 		dev_err(dev, "Cannot get the regulator \"vdd_int\"\n");
-		err = PTR_ERR(data->vdd_int);
-		goto err_regulator;
+		return PTR_ERR(data->vdd_int);
 	}
 
-	data->int_clk = clk_get(dev, "int_clk");
+	data->int_clk = devm_clk_get(dev, "int_clk");
 	if (IS_ERR(data->int_clk)) {
 		dev_err(dev, "Cannot get clock \"int_clk\"\n");
-		err = PTR_ERR(data->int_clk);
-		goto err_clock;
+		return PTR_ERR(data->int_clk);
 	}
 
 	rcu_read_lock();
@@ -374,8 +372,7 @@ static int exynos5_busfreq_int_probe(struct platform_device *pdev)
 		rcu_read_unlock();
 		dev_err(dev, "Invalid initial frequency %lu kHz.\n",
 		       exynos5_devfreq_int_profile.initial_freq);
-		err = PTR_ERR(opp);
-		goto err_opp_add;
+		return PTR_ERR(opp);
 	}
 	initial_freq = opp_get_freq(opp);
 	initial_volt = opp_get_voltage(opp);
@@ -385,12 +382,12 @@ static int exynos5_busfreq_int_probe(struct platform_device *pdev)
 	err = clk_set_rate(data->int_clk, initial_freq * 1000);
 	if (err) {
 		dev_err(dev, "Failed to set initial frequency\n");
-		goto err_opp_add;
+		return err;
 	}
 
 	err = exynos5_int_setvolt(data, initial_volt);
 	if (err)
-		goto err_opp_add;
+		return err;
 
 	platform_set_drvdata(pdev, data);
 
@@ -419,11 +416,6 @@ static int exynos5_busfreq_int_probe(struct platform_device *pdev)
 
 err_devfreq_add:
 	devfreq_remove_device(data->devfreq);
-err_opp_add:
-	clk_put(data->int_clk);
-err_clock:
-	regulator_put(data->vdd_int);
-err_regulator:
 	return err;
 }
 
@@ -434,8 +426,6 @@ static int exynos5_busfreq_int_remove(struct platform_device *pdev)
 	pm_qos_remove_request(&data->int_req);
 	unregister_pm_notifier(&data->pm_notifier);
 	devfreq_remove_device(data->devfreq);
-	regulator_put(data->vdd_int);
-	clk_put(data->int_clk);
 
 	return 0;
 }
-- 
1.7.9.5

