From: Wei Ni <wni@nvidia.com>
Subject: [PATCH V9 12/14] thermal: tegra: add PM support
Date: Tue, 29 Mar 2016 17:18:36 +0800
Message-ID: <1459243116-25676-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com, thierry.reding@gmail.com
Cc: MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Wei Ni <wni@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Add suspend/resume function in soctherm driver.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/thermal/tegra/soctherm.c | 46 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index d2b7c255d71f..559c74279eb8 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -88,6 +88,7 @@ struct tegra_soctherm {
 	struct clk *clock_tsensor;
 	struct clk *clock_soctherm;
 	void __iomem *regs;
+	struct thermal_zone_device **thermctl_tzs;
 
 	u32 *calib;
 	struct tegra_soctherm_soc *soc;
@@ -566,6 +567,12 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 			return err;
 	}
 
+	tegra->thermctl_tzs = devm_kzalloc(&pdev->dev,
+					   sizeof(*z) * soc->num_ttgs,
+					   GFP_KERNEL);
+	if (!tegra->thermctl_tzs)
+		return -ENOMEM;
+
 	err = soctherm_clk_enable(pdev, true);
 	if (err)
 		return err;
@@ -595,6 +602,7 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 		}
 
 		zone->tz = z;
+		tegra->thermctl_tzs[soc->ttgs[i]->id] = z;
 
 		/* Configure hw trip points */
 		tegra_soctherm_set_hwtrips(&pdev->dev, soc->ttgs[i], z);
@@ -621,11 +629,49 @@ static int tegra_soctherm_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int soctherm_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+
+	soctherm_clk_enable(pdev, false);
+
+	return 0;
+}
+
+static int soctherm_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct tegra_soctherm *tegra = platform_get_drvdata(pdev);
+	struct tegra_soctherm_soc *soc = tegra->soc;
+	int err, i;
+
+	err = soctherm_clk_enable(pdev, true);
+	if (err) {
+		dev_err(&pdev->dev,
+			"Resume failed: enable clocks failed\n");
+		return err;
+	}
+
+	soctherm_init(pdev);
+
+	for (i = 0; i < soc->num_ttgs; ++i) {
+		struct thermal_zone_device *tz;
+
+		tz = tegra->thermctl_tzs[soc->ttgs[i]->id];
+		tegra_soctherm_set_hwtrips(dev, soc->ttgs[i], tz);
+	}
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(tegra_soctherm_pm, soctherm_suspend, soctherm_resume);
+
 static struct platform_driver tegra_soctherm_driver = {
 	.probe = tegra_soctherm_probe,
 	.remove = tegra_soctherm_remove,
 	.driver = {
 		.name = "tegra_soctherm",
+		.pm = &tegra_soctherm_pm,
 		.of_match_table = tegra_soctherm_of_match,
 	},
 };
-- 
1.9.1
