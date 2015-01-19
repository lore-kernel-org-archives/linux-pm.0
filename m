From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH 1/2] thermal: exynos: Reorder exynos_map_dt_data() function
Date: Mon, 19 Jan 2015 12:44:03 +0100
Message-ID: <1421667844-13627-2-git-send-email-l.majewski@samsung.com>
References: <1421667844-13627-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1421667844-13627-1-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-pm@vger.kernel.org

The exynos_map_dt_data() function must be called before
thermal_zone_of_sensor_register(), and hence provide tmu_read() function,
before it is needed.

This change is driven by adding support for enabling thermal_zoneX when
it is properly initialized.

One can read the mode of operation at /sys/class/thermal/thermal_zone0/mode
Such functionality was missing in the of-thermal.c code.

Reported-by: Abhilash Kesavan <a.kesavan@samsung.com>
Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 9d2d685..5d946ab 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -975,15 +975,16 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, data);
 	mutex_init(&data->lock);
 
+	ret = exynos_map_dt_data(pdev);
+	if (ret)
+		goto err_sensor;
+
 	data->tzd = thermal_zone_of_sensor_register(&pdev->dev, 0, data,
 						    &exynos_sensor_ops);
 	if (IS_ERR(data->tzd)) {
 		pr_err("thermal: tz: %p ERROR\n", data->tzd);
 		return PTR_ERR(data->tzd);
 	}
-	ret = exynos_map_dt_data(pdev);
-	if (ret)
-		goto err_sensor;
 
 	pdata = data->pdata;
 
-- 
2.0.0.rc2
