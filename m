From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v2 08/19] PM / devfreq: tegra: Remove OPP entries on driver removal
Date: Mon, 15 Apr 2019 17:54:54 +0300
Message-ID: <20190415145505.18397-9-digetx@gmail.com>
References: <20190415145505.18397-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415145505.18397-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This fixes "_opp_is_duplicate" warning messages on driver's module reload.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index c248c18431d9..98ba27b1e2c4 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -701,7 +701,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 						 NULL);
 	if (IS_ERR(tegra->devfreq)) {
 		err = PTR_ERR(tegra->devfreq);
-		return err;
+		goto remove_opps;
 	}
 
 	tegra->rate_change_nb.notifier_call = tegra_actmon_rate_notify_cb;
@@ -709,10 +709,15 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	if (err) {
 		dev_err(&pdev->dev,
 			"Failed to register rate change notifier\n");
-		return err;
+		goto remove_opps;
 	}
 
 	return 0;
+
+remove_opps:
+	dev_pm_opp_remove_all_dynamic(&pdev->dev);
+
+	return err;
 }
 
 static int tegra_devfreq_remove(struct platform_device *pdev)
@@ -722,6 +727,9 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
 	u32 val;
 	unsigned int i;
 
+	devm_devfreq_remove_device(&pdev->dev, tegra->devfreq);
+	dev_pm_opp_remove_all_dynamic(&pdev->dev);
+
 	for (i = 0; i < ARRAY_SIZE(actmon_device_configs); i++) {
 		val = device_readl(&tegra->devices[i], ACTMON_DEV_CTRL);
 		val &= ~ACTMON_DEV_CTRL_ENB;
-- 
2.21.0
