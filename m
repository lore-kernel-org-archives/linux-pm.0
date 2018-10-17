From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 08/17] thermal: qcom: tsens: enable+check sensor after
 its setup is finished
Date: Wed, 17 Oct 2018 17:52:34 +0200
Message-ID: <1539791563-5959-9-git-send-email-b.zolnierkie@samsung.com>
References: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20181017155403epcas2p1ed9777e96c6b2c77c2c5b67466be9843@epcas2p1.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Amit kucheria <amit.kucheria@linaro.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Markus Mayer <mmayer@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Heiko Stuebner <heiko@sntech.de>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Keerthy <j-keerthy@ti.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>, Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Enable+check sensor after setting tmdev->sensor[i].tzd and calling
chipset specific enable operation.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/qcom/tsens.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index dbd2556..01bff96 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -105,13 +105,13 @@ static int tsens_register(struct tsens_device *tmdev)
 		if (IS_ERR(tzd))
 			continue;
 
-		thermal_zone_set_mode(tzd, THERMAL_DEVICE_ENABLED);
-		thermal_zone_device_check(tzd);
-
 		tmdev->sensor[i].tzd = tzd;
 
 		if (tmdev->ops->enable)
 			tmdev->ops->enable(tmdev, i);
+
+		thermal_zone_set_mode(tzd, THERMAL_DEVICE_ENABLED);
+		thermal_zone_device_check(tzd);
 	}
 	return 0;
 }
-- 
1.9.1
