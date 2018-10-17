From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 12/17] thermal: exynos: enable+check sensor after its
 setup is finished
Date: Wed, 17 Oct 2018 17:52:38 +0200
Message-ID: <1539791563-5959-13-git-send-email-b.zolnierkie@samsung.com>
References: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20181017155428epcas2p1aca0b5e7b30b89db7be7026dfa740fc6@epcas2p1.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Amit kucheria <amit.kucheria@linaro.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Markus Mayer <mmayer@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Heiko Stuebner <heiko@sntech.de>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Keerthy <j-keerthy@ti.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>, Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Enable sensor after doing chipset specific initialization operation and
check sensor after doing chipset specific control operation.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 8ec74a62..796a868 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1109,15 +1109,14 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		goto err_sclk;
 	}
 
-	thermal_zone_set_mode(data->tzd, THERMAL_DEVICE_ENABLED);
-	thermal_zone_device_check(data->tzd);
-
 	ret = exynos_tmu_initialize(pdev);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to initialize TMU\n");
 		goto err_thermal;
 	}
 
+	thermal_zone_set_mode(data->tzd, THERMAL_DEVICE_ENABLED);
+
 	ret = devm_request_irq(&pdev->dev, data->irq, exynos_tmu_irq,
 		IRQF_TRIGGER_RISING | IRQF_SHARED, dev_name(&pdev->dev), data);
 	if (ret) {
@@ -1126,6 +1125,9 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	}
 
 	exynos_tmu_control(pdev, true);
+
+	thermal_zone_device_check(data->tzd);
+
 	return 0;
 
 err_thermal:
-- 
1.9.1
