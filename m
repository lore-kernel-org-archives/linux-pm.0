From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCHv3 1/8] devfreq: exynos4: Fix bug of resource leak and code
 clean on probe()
Date: Fri, 14 Mar 2014 18:30:01 +0900
Message-ID: <1394789408-14648-2-git-send-email-cw00.choi@samsung.com>
References: <1394789408-14648-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:59049 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755940AbaCNJaW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Mar 2014 05:30:22 -0400
In-reply-to: <1394789408-14648-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rafael.j.wysocki@intel.com, nm@ti.com, b.zolnierkie@samsaung.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>

This patch fix bug about resource leak when happening probe fail and code clean
to add debug message.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/exynos/exynos4_bus.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/devfreq/exynos/exynos4_bus.c b/drivers/devfreq/exynos/exynos4_bus.c
index e07b0c6..378e4bd 100644
--- a/drivers/devfreq/exynos/exynos4_bus.c
+++ b/drivers/devfreq/exynos/exynos4_bus.c
@@ -765,9 +765,6 @@ static int exynos4_bus_get_dev_status(struct device *dev,
 
 static void exynos4_bus_exit(struct device *dev)
 {
-	struct busfreq_data *data = dev_get_drvdata(dev);
-
-	devfreq_unregister_opp_notifier(dev, data->devfreq);
 }
 
 static struct devfreq_dev_profile exynos4_devfreq_profile = {
@@ -1048,8 +1045,11 @@ static int exynos4_busfreq_probe(struct platform_device *pdev)
 		dev_err(dev, "Cannot determine the device id %d\n", data->type);
 		err = -EINVAL;
 	}
-	if (err)
+	if (err) {
+		dev_err(dev, "Cannot initialize busfreq table %d\n",
+			     data->type);
 		return err;
+	}
 
 	data->vdd_int = devm_regulator_get(dev, "vdd_int");
 	if (IS_ERR(data->vdd_int)) {
@@ -1086,23 +1086,39 @@ static int exynos4_busfreq_probe(struct platform_device *pdev)
 	if (IS_ERR(data->devfreq))
 		return PTR_ERR(data->devfreq);
 
-	devfreq_register_opp_notifier(dev, data->devfreq);
+	/* Register opp_notifier for Exynos4 busfreq */
+	err = devfreq_register_opp_notifier(dev, data->devfreq);
+	if (err < 0) {
+		dev_err(dev, "Failed to register opp notifier\n");
+		goto err_notifier_opp;
+	}
 
+	/* Register pm_notifier for Exynos4 busfreq */
 	err = register_pm_notifier(&data->pm_notifier);
 	if (err) {
 		dev_err(dev, "Failed to setup pm notifier\n");
-		devfreq_remove_device(data->devfreq);
-		return err;
+		goto err_notifier_pm;
 	}
 
 	return 0;
+
+err_notifier_pm:
+	devfreq_unregister_opp_notifier(dev, data->devfreq);
+err_notifier_opp:
+	devfreq_remove_device(data->devfreq);
+
+	return err;
 }
 
 static int exynos4_busfreq_remove(struct platform_device *pdev)
 {
 	struct busfreq_data *data = platform_get_drvdata(pdev);
 
+	/* Unregister all of notifier chain */
 	unregister_pm_notifier(&data->pm_notifier);
+	devfreq_unregister_opp_notifier(data->dev, data->devfreq);
+
+	/* Remove devfreq instance */
 	devfreq_remove_device(data->devfreq);
 
 	return 0;
-- 
1.8.0

