From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 1/3] thermal: exynos: Fix NULL pointer exception during kernel
 booting
Date: Mon, 16 Feb 2015 23:20:12 +0900
Message-ID: <1424096414-4327-2-git-send-email-cw00.choi@samsung.com>
References: <1424096414-4327-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1424096414-4327-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: kgene@kernel.org, b.zolnierkie@samsung.com, kyungmin.park@samsung.com, amit.daniel@samsung.com, l.majewski@samsung.com, a.kesavan@samsung.com, inki.dae@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch fixes the NULL pointer exception during kernel booting. The thermal_zone
_of_sensor_register() registers a sensor to DT thermal zone and then read
the current temperature by '.get_temp' callback. The callback function
of exynos thermal driver is exynos_get_temp() which must need the 'pdata'
instance of exynos_tmu _platform_data structure.
- exynos_get_temp() -> code_to_temp() -> Must need the 'pdata' instance

But, exynos thermal driver is executed before getting the 'pdata' instance.
To avoid the kernel panic, have to get the platform data by executing the
exynos_map_dt_data() before calling thermal_zone_of_sensor_register() .

- kernel panic log
[ 4211.324346] PC is at 0x0
[ 4211.326867] LR is at exynos_get_temp+0x3c/0xe4
[ 4211.331289] pc : [<0000000000000000>] lr : [<ffffffc0004df460>]
[snip]
[ 4211.940625] [<          (null)>]           (null)
[ 4211.945315] [<ffffffc0004de6d8>] of_thermal_get_temp+0x1c/0x30
[ 4211.951132] [<ffffffc0004db86c>] thermal_zone_get_temp+0x48/0x7c
[ 4211.957118] [<ffffffc0004dd278>] thermal_zone_device_update+0x20/0x110
[ 4211.963627] [<ffffffc0004de9c8>] of_thermal_set_mode+0x44/0x68
[ 4211.969443] [<ffffffc0004decb8>] thermal_zone_of_sensor_register+0x15c/0x1d8
[ 4211.976475] [<ffffffc0004dfbe4>] exynos_tmu_probe+0x6c/0x814
[ 4211.982120] [<ffffffc0003ef808>] platform_drv_probe+0x48/0xb8
[ 4211.987846] [<ffffffc0003edb28>] driver_probe_device+0x8c/0x244
[ 4211.993747] [<ffffffc0003eddcc>] __driver_attach+0x98/0xa0
[ 4211.999216] [<ffffffc0003ebea0>] bus_for_each_dev+0x54/0x98
[ 4212.004771] [<ffffffc0003ed66c>] driver_attach+0x1c/0x28
[ 4212.010066] [<ffffffc0003ed2e8>] bus_add_driver+0x150/0x208
[ 4212.015622] [<ffffffc0003ee6a4>] driver_register+0x5c/0x11c
[ 4212.021178] [<ffffffc0003ef73c>] __platform_driver_register+0x5c/0x68
[ 4212.027600] [<ffffffc000b64eb8>] exynos_tmu_driver_init+0x14/0x20
[ 4212.033678] [<ffffffc0000828d4>] do_one_initcall+0x88/0x1a0
[ 4212.039235] [<ffffffc000b34b34>] kernel_init_freeable+0x1bc/0x260
[ 4212.045311] [<ffffffc0007e9fd4>] kernel_init+0xc/0xd8

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index fbeedc0..b8846f1 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1147,17 +1147,17 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, data);
 	mutex_init(&data->lock);
 
+	ret = exynos_map_dt_data(pdev);
+	if (ret)
+		return ret;
+	pdata = data->pdata;
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
-
-	pdata = data->pdata;
 
 	INIT_WORK(&data->irq_work, exynos_tmu_work);
 
-- 
1.8.5.5
