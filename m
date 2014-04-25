From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 4/5] devfreq: exynos4: Use devm_devfreq_* function using device
 resource management
Date: Fri, 25 Apr 2014 18:08:13 +0900
Message-ID: <1398416894-6782-5-git-send-email-cw00.choi@samsung.com>
References: <1398416894-6782-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1398416894-6782-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rafael.j.wysocki@intel.com, nm@ti.com, cw00.choi@samsung.com, jkosina@suse.cz, labbe.montjoie@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch uses devm_devfreq_add_device()/devm_devfreq_register_opp_notifier()
to control automatically the resource of devfreq.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
---
 drivers/devfreq/exynos/exynos4_bus.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/devfreq/exynos/exynos4_bus.c b/drivers/devfreq/exynos/exynos4_bus.c
index d257f1f..bebb0a4 100644
--- a/drivers/devfreq/exynos/exynos4_bus.c
+++ b/drivers/devfreq/exynos/exynos4_bus.c
@@ -979,7 +979,7 @@ static int exynos4_busfreq_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, data);
 
-	data->devfreq = devfreq_add_device(dev, &exynos4_devfreq_profile,
+	data->devfreq = devm_devfreq_add_device(dev, &exynos4_devfreq_profile,
 					   "simple_ondemand", NULL);
 	if (IS_ERR(data->devfreq))
 		return PTR_ERR(data->devfreq);
@@ -991,27 +991,20 @@ static int exynos4_busfreq_probe(struct platform_device *pdev)
 	busfreq_mon_reset(ppmu_data);
 
 	/* Register opp_notifier for Exynos4 busfreq */
-	err = devfreq_register_opp_notifier(dev, data->devfreq);
+	err = devm_devfreq_register_opp_notifier(dev, data->devfreq);
 	if (err < 0) {
 		dev_err(dev, "Failed to register opp notifier\n");
-		goto err_notifier_opp;
+		return err;
 	}
 
 	/* Register pm_notifier for Exynos4 busfreq */
 	err = register_pm_notifier(&data->pm_notifier);
 	if (err) {
 		dev_err(dev, "Failed to setup pm notifier\n");
-		goto err_notifier_pm;
+		return err;
 	}
 
 	return 0;
-
-err_notifier_pm:
-	devfreq_unregister_opp_notifier(dev, data->devfreq);
-err_notifier_opp:
-	devfreq_remove_device(data->devfreq);
-
-	return err;
 }
 
 static int exynos4_busfreq_remove(struct platform_device *pdev)
@@ -1020,10 +1013,6 @@ static int exynos4_busfreq_remove(struct platform_device *pdev)
 
 	/* Unregister all of notifier chain */
 	unregister_pm_notifier(&data->pm_notifier);
-	devfreq_unregister_opp_notifier(data->dev, data->devfreq);
-
-	/* Remove devfreq instance */
-	devfreq_remove_device(data->devfreq);
 
 	return 0;
 }
-- 
1.8.0
