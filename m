From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCHv2 4/8] devfreq: exynos4: Fix bug of resource leak and code
 clean on probe()
Date: Thu, 13 Mar 2014 17:17:25 +0900
Message-ID: <1394698649-20996-5-git-send-email-cw00.choi@samsung.com>
References: <1394698649-20996-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-reply-to: <1394698649-20996-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-doc-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rafael.j.wysocki@intel.com, nm@ti.com, b.zolnierkie@samsaung.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch fix bug about resource leak when happening probe fail and code clean
to add debug message.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/exynos/exynos4_bus.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/devfreq/exynos/exynos4_bus.c b/drivers/devfreq/exynos/exynos4_bus.c
index a2a3a47..152a3e9 100644
--- a/drivers/devfreq/exynos/exynos4_bus.c
+++ b/drivers/devfreq/exynos/exynos4_bus.c
@@ -1152,8 +1152,11 @@ static int exynos4_busfreq_probe(struct platform_device *pdev)
 		dev_err(dev, "Cannot determine the device id %d\n", data->type);
 		err = -EINVAL;
 	}
-	if (err)
+	if (err) {
+		dev_err(dev, "Cannot initialize busfreq table %d\n",
+			     data->type);
 		return err;
+	}
 
 	rcu_read_lock();
 	opp = dev_pm_opp_find_freq_floor(dev,
@@ -1176,7 +1179,7 @@ static int exynos4_busfreq_probe(struct platform_device *pdev)
 	if (IS_ERR(data->devfreq)) {
 		dev_err(dev, "Failed to add devfreq device\n");
 		err = PTR_ERR(data->devfreq);
-		goto err_opp;
+		goto err_devfreq;
 	}
 
 	/*
@@ -1185,18 +1188,35 @@ static int exynos4_busfreq_probe(struct platform_device *pdev)
 	 */
 	busfreq_mon_reset(data);
 
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
 
-err_opp:
+err_notifier_pm:
+	devfreq_unregister_opp_notifier(dev, data->devfreq);
+err_notifier_opp:
+	/*
+	 * The devfreq_remove_device() would execute finally devfreq->profile
+	 * ->exit(). To avoid duplicate resource free operation, return directly
+	 * before executing resource free below 'err_devfreq' goto statement.
+	 */
+	devfreq_remove_device(data->devfreq);
+
+	return err;
+
+err_devfreq:
 	regulator_disable(data->vdd_int);
 	if (data->type == TYPE_BUSF_EXYNOS4x12)
 		regulator_disable(data->vdd_mif);
-- 
1.8.0

