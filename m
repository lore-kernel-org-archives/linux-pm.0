From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 16/17] thermal: zx2967: enable/check sensor after its setup
 is finished
Date: Tue, 10 Apr 2018 14:42:10 +0200
Message-ID: <1523364131-31059-17-git-send-email-b.zolnierkie@samsung.com>
References: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180410124449epcas1p2dd40472146b417f7cb2d2bfdaea232ba@epcas1p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Markus Mayer <mmayer@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Heiko Stuebner <heiko@sntech.de>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Keerthy <j-keerthy@ti.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>, Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Enable/check sensor after checking sensor coefficients.

Cc: Jun Nie <jun.nie@linaro.org>
Cc: Baoyou Xie <baoyou.xie@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/zx2967_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/zx2967_thermal.c b/drivers/thermal/zx2967_thermal.c
index ffd2b07..45ed17f 100644
--- a/drivers/thermal/zx2967_thermal.c
+++ b/drivers/thermal/zx2967_thermal.c
@@ -168,9 +168,6 @@ static int zx2967_thermal_probe(struct platform_device *pdev)
 		goto disable_clk_all;
 	}
 
-	thermal_zone_device_toggle(priv->tzd, true);
-	thermal_zone_device_check(priv->tzd);
-
 	if (priv->tzd->tzp->slope == 0) {
 		thermal_zone_of_sensor_unregister(&pdev->dev, priv->tzd);
 		dev_err(&pdev->dev, "coefficients of sensor is invalid\n");
@@ -178,6 +175,9 @@ static int zx2967_thermal_probe(struct platform_device *pdev)
 		goto disable_clk_all;
 	}
 
+	thermal_zone_device_toggle(priv->tzd, true);
+	thermal_zone_device_check(priv->tzd);
+
 	priv->dev = &pdev->dev;
 	platform_set_drvdata(pdev, priv);
 
-- 
1.9.1
