From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 09/17] thermal: qoriq: enable/check sensor after its setup
 is finished
Date: Tue, 10 Apr 2018 14:42:03 +0200
Message-ID: <1523364131-31059-10-git-send-email-b.zolnierkie@samsung.com>
References: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180410124355epcas2p272d4a06619ad3a3e58c792186069f0bc@epcas2p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Markus Mayer <mmayer@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Heiko Stuebner <heiko@sntech.de>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Keerthy <j-keerthy@ti.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>, Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Enable/check sensor after enabling monitoring.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/qoriq_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index cdd6f59..2695021 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -242,13 +242,13 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 		goto err_tmu;
 	}
 
-	thermal_zone_device_toggle(data->tz, true);
-	thermal_zone_device_check(data->tz);
-
 	/* Enable monitoring */
 	site |= 0x1 << (15 - data->sensor_id);
 	tmu_write(data, site | TMR_ME | TMR_ALPF, &data->regs->tmr);
 
+	thermal_zone_device_toggle(data->tz, true);
+	thermal_zone_device_check(data->tz);
+
 	return 0;
 
 err_tmu:
-- 
1.9.1
