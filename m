From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 01/18] thermal: exynos: fix setting rising_threshold for
 Exynos5433
Date: Thu, 26 Apr 2018 13:51:16 +0200
Message-ID: <1524743493-28113-2-git-send-email-b.zolnierkie@samsung.com>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180426115201epcas2p17e5cdb0f79927903880e58c290b663e6@epcas2p1.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Add missing clearing of the previous value when setting rising
temperature threshold.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index cda716c..523d26e 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -577,6 +577,7 @@ static int exynos5433_tmu_initialize(struct platform_device *pdev)
 		threshold_code = temp_to_code(data, temp);
 
 		rising_threshold = readl(data->base + rising_reg_offset);
+		rising_threshold &= ~(0xff << j * 8);
 		rising_threshold |= (threshold_code << j * 8);
 		writel(rising_threshold, data->base + rising_reg_offset);
 
-- 
1.9.1
