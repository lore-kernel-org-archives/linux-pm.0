From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] thermal: int3400_thermal: fix error handling in int3400_thermal_probe()
Date: Sat, 30 Dec 2017 01:05:21 +0300
Message-ID: <1514585121-7038-1-git-send-email-khoroshilov@ispras.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: linux-pm@vger.kernel.org

There are resources that are not dealocated on failure path
in int3400_thermal_probe().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/thermal/int340x_thermal/int3400_thermal.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c b/drivers/thermal/int340x_thermal/int3400_thermal.c
index 8ee38f55c7f3..43b90fd577e4 100644
--- a/drivers/thermal/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
@@ -319,17 +319,21 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 
 	result = sysfs_create_group(&pdev->dev.kobj, &uuid_attribute_group);
 	if (result)
-		goto free_zone;
+		goto free_rel_misc;
 
 	result = acpi_install_notify_handler(
 			priv->adev->handle, ACPI_DEVICE_NOTIFY, int3400_notify,
 			(void *)priv);
 	if (result)
-		goto free_zone;
+		goto free_sysfs;
 
 	return 0;
 
-free_zone:
+free_sysfs:
+	sysfs_remove_group(&pdev->dev.kobj, &uuid_attribute_group);
+free_rel_misc:
+	if (!priv->rel_misc_dev_res)
+		acpi_thermal_rel_misc_device_remove(priv->adev->handle);
 	thermal_zone_device_unregister(priv->thermal);
 free_art_trt:
 	kfree(priv->trts);
-- 
2.7.4
