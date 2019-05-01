From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v4 08/16] PM / devfreq: tegra: Clean up driver's probe / remove
Date: Thu,  2 May 2019 02:38:07 +0300
Message-ID: <20190501233815.32643-9-digetx@gmail.com>
References: <20190501233815.32643-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190501233815.32643-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Reset hardware, disable ACTMON clock, release OPP's and handle all
possible error cases correctly, maintaining the correct tear down
order. Also use devm_platform_ioremap_resource() which is now available
in the kernel.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 83 +++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 36 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index ce1eb97a2090..ea0da05cd7f2 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -610,7 +610,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 {
 	struct tegra_devfreq *tegra;
 	struct tegra_devfreq_device *dev;
-	struct resource *res;
 	unsigned int i;
 	unsigned long rate;
 	int err;
@@ -619,9 +618,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	if (!tegra)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
-	tegra->regs = devm_ioremap_resource(&pdev->dev, res);
+	tegra->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(tegra->regs))
 		return PTR_ERR(tegra->regs);
 
@@ -643,11 +640,10 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		return PTR_ERR(tegra->emc_clock);
 	}
 
-	tegra->rate_change_nb.notifier_call = tegra_actmon_rate_notify_cb;
-	err = clk_notifier_register(tegra->emc_clock, &tegra->rate_change_nb);
-	if (err) {
-		dev_err(&pdev->dev,
-			"Failed to register rate change notifier\n");
+	tegra->irq = platform_get_irq(pdev, 0);
+	if (tegra->irq < 0) {
+		err = tegra->irq;
+		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", err);
 		return err;
 	}
 
@@ -678,54 +674,69 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
 	for (rate = 0; rate <= tegra->max_freq * KHZ; rate++) {
 		rate = clk_round_rate(tegra->emc_clock, rate);
-		dev_pm_opp_add(&pdev->dev, rate, 0);
-	}
 
-	tegra->irq = platform_get_irq(pdev, 0);
-	if (tegra->irq < 0) {
-		err = tegra->irq;
-		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", err);
-		return err;
+		err = dev_pm_opp_add(&pdev->dev, rate, 0);
+		if (err) {
+			dev_err(&pdev->dev, "Failed to add OPP: %d\n", err);
+			goto remove_opps;
+		}
 	}
 
 	platform_set_drvdata(pdev, tegra);
 
+	tegra->rate_change_nb.notifier_call = tegra_actmon_rate_notify_cb;
+	err = clk_notifier_register(tegra->emc_clock, &tegra->rate_change_nb);
+	if (err) {
+		dev_err(&pdev->dev,
+			"Failed to register rate change notifier\n");
+		goto remove_opps;
+	}
+
+	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
+	tegra->devfreq = devfreq_add_device(&pdev->dev,
+					    &tegra_devfreq_profile,
+					    "tegra_actmon",
+					    NULL);
+	if (IS_ERR(tegra->devfreq)) {
+		err = PTR_ERR(tegra->devfreq);
+		goto unreg_notifier;
+	}
+
 	err = devm_request_threaded_irq(&pdev->dev, tegra->irq, NULL,
 					actmon_thread_isr, IRQF_ONESHOT,
 					"tegra-devfreq", tegra);
 	if (err) {
-		dev_err(&pdev->dev, "Interrupt request failed\n");
-		return err;
+		dev_err(&pdev->dev, "Interrupt request failed: %d\n", err);
+		goto remove_devfreq;
 	}
 
-	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
-	tegra->devfreq = devm_devfreq_add_device(&pdev->dev,
-						 &tegra_devfreq_profile,
-						 "tegra_actmon",
-						 NULL);
-
 	return 0;
+
+remove_devfreq:
+	devfreq_remove_device(tegra->devfreq);
+
+unreg_notifier:
+	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
+
+remove_opps:
+	dev_pm_opp_remove_all_dynamic(&pdev->dev);
+
+	reset_control_reset(tegra->reset);
+	clk_disable_unprepare(tegra->clock);
+
+	return err;
 }
 
 static int tegra_devfreq_remove(struct platform_device *pdev)
 {
 	struct tegra_devfreq *tegra = platform_get_drvdata(pdev);
-	int irq = platform_get_irq(pdev, 0);
-	u32 val;
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(actmon_device_configs); i++) {
-		val = device_readl(&tegra->devices[i], ACTMON_DEV_CTRL);
-		val &= ~ACTMON_DEV_CTRL_ENB;
-		device_writel(&tegra->devices[i], val, ACTMON_DEV_CTRL);
-	}
-
-	actmon_write_barrier(tegra);
 
-	devm_free_irq(&pdev->dev, irq, tegra);
+	devfreq_remove_device(tegra->devfreq);
 
 	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
+	dev_pm_opp_remove_all_dynamic(&pdev->dev);
 
+	reset_control_reset(tegra->reset);
 	clk_disable_unprepare(tegra->clock);
 
 	return 0;
-- 
2.21.0
