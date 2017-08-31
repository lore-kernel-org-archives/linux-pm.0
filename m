From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH] thermal: tegra: dereference the pointer after null check
Date: Thu, 31 Aug 2017 16:52:29 -0700
Message-ID: <1504223549-4152-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com
Cc: edubezval@gmail.com, thierry.reding@gmail.com, jonathanh@nvidia.com, wni@nvidia.com, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, srikars@nvidia.com
List-Id: linux-pm@vger.kernel.org

The dev pointer is going through a null check after a dereference.
So this patch just reverses that.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/thermal/tegra/soctherm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 7d2db23..6718799 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -478,7 +478,7 @@ static int throttrip_program(struct device *dev,
 			     struct soctherm_throt_cfg *stc,
 			     int trip_temp)
 {
-	struct tegra_soctherm *ts = dev_get_drvdata(dev);
+	struct tegra_soctherm *ts;
 	int temp, cpu_throt, gpu_throt;
 	unsigned int throt;
 	u32 r, reg_off;
@@ -486,6 +486,8 @@ static int throttrip_program(struct device *dev,
 	if (!dev || !sg || !stc || !stc->init)
 		return -EINVAL;
 
+	ts = dev_get_drvdata(dev);
+
 	temp = enforce_temp_range(dev, trip_temp) / ts->soc->thresh_grain;
 
 	/* Hardcode LIGHT on LEVEL1 and HEAVY on LEVEL2 */
-- 
2.1.4
