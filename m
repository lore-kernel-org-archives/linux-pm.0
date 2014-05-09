From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCHv2 5/5] devfreq: exynos5: Use devm_devfreq_* function using
 device resource management
Date: Fri, 09 May 2014 16:43:11 +0900
Message-ID: <1399621391-27228-6-git-send-email-cw00.choi@samsung.com>
References: <1399621391-27228-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1399621391-27228-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rafael.j.wysocki@intel.com, nm@ti.com, jkosina@suse.cz, labbe.montjoie@gmail.com, a.kesavan@samsung.com, sreekumar.c@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Manish Badarkhe <badarkhe.manish@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch uses devm_devfreq_add_device()/devm_devfreq_register_opp_notifier()
to control automatically the resource of devfreq.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Manish Badarkhe <badarkhe.manish@gmail.com>
Cc: Abhilash Kesavan <a.kesavan@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
---
 drivers/devfreq/exynos/exynos5_bus.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/devfreq/exynos/exynos5_bus.c b/drivers/devfreq/exynos/exynos5_bus.c
index ab54a69..6cd0392 100644
--- a/drivers/devfreq/exynos/exynos5_bus.c
+++ b/drivers/devfreq/exynos/exynos5_bus.c
@@ -163,21 +163,12 @@ static int exynos5_int_get_dev_status(struct device *dev,
 
 	return 0;
 }
-static void exynos5_int_exit(struct device *dev)
-{
-	struct platform_device *pdev = container_of(dev, struct platform_device,
-						    dev);
-	struct busfreq_data_int *data = platform_get_drvdata(pdev);
-
-	devfreq_unregister_opp_notifier(dev, data->devfreq);
-}
 
 static struct devfreq_dev_profile exynos5_devfreq_int_profile = {
 	.initial_freq		= 160000,
 	.polling_ms		= 100,
 	.target			= exynos5_busfreq_int_target,
 	.get_dev_status		= exynos5_int_get_dev_status,
-	.exit			= exynos5_int_exit,
 };
 
 static int exynos5250_init_int_tables(struct busfreq_data_int *data)
@@ -343,30 +334,27 @@ static int exynos5_busfreq_int_probe(struct platform_device *pdev)
 
 	busfreq_mon_reset(ppmu_data);
 
-	data->devfreq = devfreq_add_device(dev, &exynos5_devfreq_int_profile,
+	data->devfreq = devm_devfreq_add_device(dev, &exynos5_devfreq_int_profile,
 					   "simple_ondemand", NULL);
+	if (IS_ERR(data->devfreq))
+		return PTR_ERR(data->devfreq);
 
-	if (IS_ERR(data->devfreq)) {
-		err = PTR_ERR(data->devfreq);
-		goto err_devfreq_add;
+	err = devm_devfreq_register_opp_notifier(dev, data->devfreq);
+	if (err < 0) {
+		dev_err(dev, "Failed to register opp notifier\n");
+		return err;
 	}
 
-	devfreq_register_opp_notifier(dev, data->devfreq);
-
 	err = register_pm_notifier(&data->pm_notifier);
 	if (err) {
 		dev_err(dev, "Failed to setup pm notifier\n");
-		goto err_devfreq_add;
+		return err;
 	}
 
 	/* TODO: Add a new QOS class for int/mif bus */
 	pm_qos_add_request(&data->int_req, PM_QOS_NETWORK_THROUGHPUT, -1);
 
 	return 0;
-
-err_devfreq_add:
-	devfreq_remove_device(data->devfreq);
-	return err;
 }
 
 static int exynos5_busfreq_int_remove(struct platform_device *pdev)
@@ -375,7 +363,6 @@ static int exynos5_busfreq_int_remove(struct platform_device *pdev)
 
 	pm_qos_remove_request(&data->int_req);
 	unregister_pm_notifier(&data->pm_notifier);
-	devfreq_remove_device(data->devfreq);
 
 	return 0;
 }
-- 
1.8.0
