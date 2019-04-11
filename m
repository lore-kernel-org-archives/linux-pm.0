From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v1 7/8] PM / devfreq: tegra: Remove OPP entries on driver removal
Date: Fri, 12 Apr 2019 01:29:13 +0300
Message-ID: <20190411222914.25539-8-digetx@gmail.com>
References: <20190411222914.25539-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190411222914.25539-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This fixes "_opp_is_duplicate" warning messages on driver's module reload.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 96f1e8e64e46..0985c02b75fe 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -691,10 +691,10 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	}
 
 	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
-	tegra->devfreq = devm_devfreq_add_device(&pdev->dev,
-						 &tegra_devfreq_profile,
-						 "tegra_actmon",
-						 NULL);
+	tegra->devfreq = devfreq_add_device(&pdev->dev,
+					    &tegra_devfreq_profile,
+					    "tegra_actmon",
+					    NULL);
 
 	return 0;
 }
@@ -705,6 +705,9 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
 	u32 val;
 	unsigned int i;
 
+	devfreq_remove_device(tegra->devfreq);
+	dev_pm_opp_remove_all_dynamic(&pdev->dev);
+
 	for (i = 0; i < ARRAY_SIZE(actmon_device_configs); i++) {
 		val = device_readl(&tegra->devices[i], ACTMON_DEV_CTRL);
 		val &= ~ACTMON_DEV_CTRL_ENB;
-- 
2.21.0
