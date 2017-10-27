From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH] thermal: tegra: allow sensor registeration to fail
Date: Fri, 27 Oct 2017 16:54:13 -0700
Message-ID: <1509148453-11388-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: srikars@nvidia.com, thierry.reding@gmail.com, jonathanh@nvidia.com, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Not all sensors may be used on a platform. So there could be
some missing thermal zones in the Device Tree. However, the
the driver now errors out whenever a sensor fails to register
the thermal zone.

Since the driver could live with other sensors, this change
allows other sensors to continue the registerations even if
one sensor fails to register.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/thermal/tegra/soctherm.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 455b58c..73fcd48 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -1280,7 +1280,7 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 	struct tsensor_shared_calib shared_calib;
 	struct resource *res;
 	struct tegra_soctherm_soc *soc;
-	unsigned int i;
+	unsigned int i, e;
 	int err;
 
 	match = of_match_node(tegra_soctherm_of_match, pdev->dev.of_node);
@@ -1377,7 +1377,7 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 
 	soctherm_init(pdev);
 
-	for (i = 0; i < soc->num_ttgs; ++i) {
+	for (i = 0, e = 0; i < soc->num_ttgs; ++i) {
 		struct tegra_thermctl_zone *zone =
 			devm_kzalloc(&pdev->dev, sizeof(*zone), GFP_KERNEL);
 		if (!zone) {
@@ -1397,7 +1397,10 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 			err = PTR_ERR(z);
 			dev_err(&pdev->dev, "failed to register sensor: %d\n",
 				err);
-			goto disable_clocks;
+			/* Check if all sensors failed to register */
+			if (++e == soc->num_ttgs)
+				goto disable_clocks;
+			continue;
 		}
 
 		zone->tz = z;
@@ -1459,6 +1462,9 @@ static int __maybe_unused soctherm_resume(struct device *dev)
 		struct thermal_zone_device *tz;
 
 		tz = tegra->thermctl_tzs[soc->ttgs[i]->id];
+		if (!tz)
+			continue;
+
 		err = tegra_soctherm_set_hwtrips(dev, soc->ttgs[i], tz);
 		if (err) {
 			dev_err(&pdev->dev,
-- 
2.1.4
