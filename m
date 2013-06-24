From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH V7 15/30] thermal: exynos: Return success even if no cooling data supplied
Date: Mon, 24 Jun 2013 16:20:36 +0530
Message-ID: <1372071051-3167-16-git-send-email-amit.daniel@samsung.com>
References: <1372071051-3167-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1372071051-3167-1-git-send-email-amit.daniel@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.kachhap@gmail.com, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch removes the error return in the bind/unbind routine
as the platform may not register any cpufreq cooling data.

Acked-by: Kukjin Kim <kgene.kim@samsung.com>
Acked-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>
Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 drivers/thermal/samsung/exynos_thermal_common.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_thermal_common.c b/drivers/thermal/samsung/exynos_thermal_common.c
index c6eab8c..99318e5 100644
--- a/drivers/thermal/samsung/exynos_thermal_common.c
+++ b/drivers/thermal/samsung/exynos_thermal_common.c
@@ -132,7 +132,7 @@ static int exynos_bind(struct thermal_zone_device *thermal,
 	tab_size = data->cooling_data.freq_clip_count;
 
 	if (tab_ptr == NULL || tab_size == 0)
-		return -EINVAL;
+		return 0;
 
 	/* find the cooling device registered*/
 	for (i = 0; i < th_zone->cool_dev_size; i++)
@@ -181,7 +181,7 @@ static int exynos_unbind(struct thermal_zone_device *thermal,
 	tab_size = data->cooling_data.freq_clip_count;
 
 	if (tab_size == 0)
-		return -EINVAL;
+		return 0;
 
 	/* find the cooling device registered*/
 	for (i = 0; i < th_zone->cool_dev_size; i++)
-- 
1.7.1
