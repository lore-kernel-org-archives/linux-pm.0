From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v2 11/19] PM / devfreq: tegra: De-initialize properly on driver's probe error
Date: Mon, 15 Apr 2019 17:54:57 +0300
Message-ID: <20190415145505.18397-12-digetx@gmail.com>
References: <20190415145505.18397-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415145505.18397-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Reset hardware, disable ACTMON clock, release OPP's and free IRQ before
removing devfreq device since there is no guarantee that interrupt
handling won't run after masking interrupt in hardware.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 53 ++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 69b557df5084..a668e4fbc874 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -663,28 +663,28 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", irq);
-		return irq;
+		err = irq;
+		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", err);
+		goto remove_opps;
 	}
 
 	platform_set_drvdata(pdev, tegra);
 
 	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
-	tegra->devfreq = devm_devfreq_add_device(&pdev->dev,
-						 &tegra_devfreq_profile,
-						 "tegra_actmon",
-						 NULL);
+	tegra->devfreq = devfreq_add_device(&pdev->dev,
+					    &tegra_devfreq_profile,
+					    "tegra_actmon",
+					    NULL);
 	if (IS_ERR(tegra->devfreq)) {
 		err = PTR_ERR(tegra->devfreq);
-		return err;
+		goto remove_opps;
 	}
 
-	err = devm_request_threaded_irq(&pdev->dev, irq, NULL,
-					actmon_thread_isr, IRQF_ONESHOT,
-					"tegra-devfreq", tegra);
+	err = request_threaded_irq(irq, NULL, actmon_thread_isr, IRQF_ONESHOT,
+				   "tegra-devfreq", tegra);
 	if (err) {
 		dev_err(&pdev->dev, "Interrupt request failed\n");
-		goto remove_opps;
+		goto remove_devfreq;
 	}
 
 	tegra->rate_change_nb.notifier_call = tegra_actmon_rate_notify_cb;
@@ -692,14 +692,23 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	if (err) {
 		dev_err(&pdev->dev,
 			"Failed to register rate change notifier\n");
-		goto remove_opps;
+		goto disable_interrupt;
 	}
 
 	return 0;
 
+disable_interrupt:
+	free_irq(irq, tegra);
+
+remove_devfreq:
+	devfreq_remove_device(tegra->devfreq);
+
 remove_opps:
 	dev_pm_opp_remove_all_dynamic(&pdev->dev);
 
+	reset_control_reset(tegra->reset);
+	clk_disable_unprepare(tegra->clock);
+
 	return err;
 }
 
@@ -707,24 +716,14 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
 {
 	struct tegra_devfreq *tegra = platform_get_drvdata(pdev);
 	int irq = platform_get_irq(pdev, 0);
-	u32 val;
-	unsigned int i;
-
-	devm_devfreq_remove_device(&pdev->dev, tegra->devfreq);
-	dev_pm_opp_remove_all_dynamic(&pdev->dev);
-
-	for (i = 0; i < ARRAY_SIZE(actmon_device_configs); i++) {
-		val = device_readl(&tegra->devices[i], ACTMON_DEV_CTRL);
-		val &= ~ACTMON_DEV_CTRL_ENB;
-		device_writel(&tegra->devices[i], val, ACTMON_DEV_CTRL);
-	}
-
-	actmon_write_barrier(tegra);
-
-	devm_free_irq(&pdev->dev, irq, tegra);
 
 	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
+	free_irq(irq, tegra);
+
+	devfreq_remove_device(tegra->devfreq);
+	dev_pm_opp_remove_all_dynamic(&pdev->dev);
 
+	reset_control_reset(tegra->reset);
 	clk_disable_unprepare(tegra->clock);
 
 	return 0;
-- 
2.21.0
