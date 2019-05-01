From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v4 11/16] PM / devfreq: tegra: Move governor registration to driver's probe
Date: Thu,  2 May 2019 02:38:10 +0300
Message-ID: <20190501233815.32643-12-digetx@gmail.com>
References: <20190501233815.32643-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190501233815.32643-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

There is no need to register the ACTMON's governor separately from
the driver, hence let's move the registration into the driver's probe
function for consistency and to make code cleaner a tad.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 43 +++++++++------------------------
 1 file changed, 12 insertions(+), 31 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 65b3a7c72293..40ce9881f144 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -695,6 +695,12 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		goto remove_opps;
 	}
 
+	err = devfreq_add_governor(&tegra_devfreq_governor);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to add governor: %d\n", err);
+		goto unreg_notifier;
+	}
+
 	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
 	tegra->devfreq = devfreq_add_device(&pdev->dev,
 					    &tegra_devfreq_profile,
@@ -702,7 +708,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 					    NULL);
 	if (IS_ERR(tegra->devfreq)) {
 		err = PTR_ERR(tegra->devfreq);
-		goto unreg_notifier;
+		goto remove_governor;
 	}
 
 	err = devm_request_threaded_irq(&pdev->dev, tegra->irq, NULL,
@@ -718,6 +724,9 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 remove_devfreq:
 	devfreq_remove_device(tegra->devfreq);
 
+remove_governor:
+	devfreq_remove_governor(&tegra_devfreq_governor);
+
 unreg_notifier:
 	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
 
@@ -735,6 +744,7 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
 	struct tegra_devfreq *tegra = platform_get_drvdata(pdev);
 
 	devfreq_remove_device(tegra->devfreq);
+	devfreq_remove_governor(&tegra_devfreq_governor);
 
 	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
 	dev_pm_opp_remove_all_dynamic(&pdev->dev);
@@ -760,36 +770,7 @@ static struct platform_driver tegra_devfreq_driver = {
 		.of_match_table = tegra_devfreq_of_match,
 	},
 };
-
-static int __init tegra_devfreq_init(void)
-{
-	int ret = 0;
-
-	ret = devfreq_add_governor(&tegra_devfreq_governor);
-	if (ret) {
-		pr_err("%s: failed to add governor: %d\n", __func__, ret);
-		return ret;
-	}
-
-	ret = platform_driver_register(&tegra_devfreq_driver);
-	if (ret)
-		devfreq_remove_governor(&tegra_devfreq_governor);
-
-	return ret;
-}
-module_init(tegra_devfreq_init)
-
-static void __exit tegra_devfreq_exit(void)
-{
-	int ret = 0;
-
-	platform_driver_unregister(&tegra_devfreq_driver);
-
-	ret = devfreq_remove_governor(&tegra_devfreq_governor);
-	if (ret)
-		pr_err("%s: failed to remove governor: %d\n", __func__, ret);
-}
-module_exit(tegra_devfreq_exit)
+module_platform_driver(tegra_devfreq_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Tegra devfreq driver");
-- 
2.21.0
