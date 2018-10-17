From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 05/17] thermal: bcm2835: enable+check sensor after its
 setup is finished
Date: Wed, 17 Oct 2018 17:52:31 +0200
Message-ID: <1539791563-5959-6-git-send-email-b.zolnierkie@samsung.com>
References: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20181017155345epcas1p18dee37b9a46f2bf0b68aa3ded43f2717@epcas1p1.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Amit kucheria <amit.kucheria@linaro.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Markus Mayer <mmayer@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Heiko Stuebner <heiko@sntech.de>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Keerthy <j-keerthy@ti.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>, Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Enable+check sensor after HW-block setup (if necessary) and setting
data->tz.

Cc: Eric Anholt <eric@anholt.net>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/broadcom/bcm2835_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index 687a00c..ec82fef 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -227,9 +227,6 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 		goto err_clk;
 	}
 
-	thermal_zone_set_mode(tz, THERMAL_DEVICE_ENABLED);
-	thermal_zone_device_check(tz);
-
 	/*
 	 * right now the FW does set up the HW-block, so we are not
 	 * touching the configuration registers.
@@ -276,6 +273,9 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 
 	data->tz = tz;
 
+	thermal_zone_set_mode(tz, THERMAL_DEVICE_ENABLED);
+	thermal_zone_device_check(tz);
+
 	platform_set_drvdata(pdev, tz);
 
 	bcm2835_thermal_debugfs(pdev);
-- 
1.9.1
