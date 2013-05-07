From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH V3 13/21] thermal: exynos: Return success even if no cooling data supplied
Date: Tue,  7 May 2013 18:31:03 +0530
Message-ID: <1367931671-3906-14-git-send-email-amit.daniel@samsung.com>
References: <1367931671-3906-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1367931671-3906-1-git-send-email-amit.daniel@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.kachhap@gmail.com, Kukjin Kim <kgene.kim@samsung.com>, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-pm@vger.kernel.org

This patch removes the error return in the bind/unbind routine
as the platform may not register any cpufreq cooling data.

Acked-by: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 drivers/thermal/samsung/exynos_thermal_common.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_thermal_common.c b/drivers/thermal/samsung/exynos_thermal_common.c
index c0e4bdb..b7ca8a4 100644
--- a/drivers/thermal/samsung/exynos_thermal_common.c
+++ b/drivers/thermal/samsung/exynos_thermal_common.c
@@ -136,7 +136,7 @@ static int exynos_bind(struct thermal_zone_device *thermal,
 	tab_size = data->cooling_data.freq_clip_count;
 
 	if (tab_ptr == NULL || tab_size == 0)
-		return -EINVAL;
+		return 0;
 
 	/* find the cooling device registered*/
 	for (i = 0; i < th_zone->cool_dev_size; i++)
@@ -185,7 +185,7 @@ static int exynos_unbind(struct thermal_zone_device *thermal,
 	tab_size = data->cooling_data.freq_clip_count;
 
 	if (tab_size == 0)
-		return -EINVAL;
+		return 0;
 
 	/* find the cooling device registered*/
 	for (i = 0; i < th_zone->cool_dev_size; i++)
-- 
1.7.1
