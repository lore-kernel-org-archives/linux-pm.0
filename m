From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 13/18] thermal: exynos: set trips in ascending order in
 exynos7_tmu_initialize()
Date: Thu, 26 Apr 2018 13:51:28 +0200
Message-ID: <1524743493-28113-14-git-send-email-b.zolnierkie@samsung.com>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180426115231epcas2p3727de5409903e05811c2b5ed10ee0a51@epcas2p3.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Set trips in ascending order in exynos7_tmu_initialize() (it should
make no difference in driver operation). This prepares the driver
code to moving trips setting from ->tmu_initialize method to
exynos_tmu_initialize().

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 12b60e2..571511f 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -618,7 +618,7 @@ static void exynos7_tmu_initialize(struct platform_device *pdev)
 	sanitize_temp_error(data, trim_info);
 
 	/* Write temperature code for rising and falling threshold */
-	for (i = (of_thermal_get_ntrips(tz) - 1); i >= 0; i--) {
+	for (i = 0; i < of_thermal_get_ntrips(tz); i++) {
 		tz->ops->get_trip_temp(tz, i, &temp);
 		temp /= MCELSIUS;
 		exynos7_tmu_set_trip_temp(data, i, temp);
-- 
1.9.1
