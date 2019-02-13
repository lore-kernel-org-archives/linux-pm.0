From: Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH]  thermal/qcom/tsens-common : fix possible object reference leak
Date: Wed, 13 Feb 2019 22:53:29 +0800
Message-ID: <1550069609-85581-1-git-send-email-peng.hao2@zte.com.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: amit.kucheria@linaro.org
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
List-Id: linux-pm@vger.kernel.org

of_find_device_by_node() takes a reference to the struct device
when it finds a match via get_device.
We also should make sure to drop the reference to the device
taken by of_find_device_by_node() when returning error.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 drivers/thermal/qcom/tsens-common.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 78652ca..f80c73f 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -144,13 +144,17 @@ int __init init_common(struct tsens_device *tmdev)
 		tmdev->tm_offset = 0;
 		res = platform_get_resource(op, IORESOURCE_MEM, 1);
 		srot_base = devm_ioremap_resource(&op->dev, res);
-		if (IS_ERR(srot_base))
-			return PTR_ERR(srot_base);
+		if (IS_ERR(srot_base)) {
+			ret = PTR_ERR(srot_base);
+			goto err_put_device;
+		}
 
 		tmdev->srot_map = devm_regmap_init_mmio(tmdev->dev, srot_base,
 							&tsens_srot_config);
-		if (IS_ERR(tmdev->srot_map))
-			return PTR_ERR(tmdev->srot_map);
+		if (IS_ERR(tmdev->srot_map)) {
+			ret = PTR_ERR(tmdev->srot_map);
+			goto err_put_device;
+		}
 
 	} else {
 		/* old DTs where SROT and TM were in a contiguous 2K block */
@@ -159,22 +163,31 @@ int __init init_common(struct tsens_device *tmdev)
 
 	res = platform_get_resource(op, IORESOURCE_MEM, 0);
 	tm_base = devm_ioremap_resource(&op->dev, res);
-	if (IS_ERR(tm_base))
-		return PTR_ERR(tm_base);
+	if (IS_ERR(tm_base)) {
+		ret = PTR_ERR(tm_base);
+		goto err_put_device;
+	}
 
 	tmdev->tm_map = devm_regmap_init_mmio(tmdev->dev, tm_base, &tsens_config);
-	if (IS_ERR(tmdev->tm_map))
-		return PTR_ERR(tmdev->tm_map);
+	if (IS_ERR(tmdev->tm_map)) {
+		ret = PTR_ERR(tmdev->tm_map);
+		goto err_put_device;
+	}
 
 	if (tmdev->srot_map) {
 		ret = regmap_read(tmdev->srot_map, ctrl_offset, &code);
 		if (ret)
-			return ret;
+			goto err_put_device;
 		if (!(code & TSENS_EN)) {
 			dev_err(tmdev->dev, "tsens device is not enabled\n");
-			return -ENODEV;
+			ret = -ENODEV;
+			goto err_put_device;
 		}
 	}
 
 	return 0;
+
+err_put_device:
+	put_device(&op->dev);
+	return ret;
 }
-- 
1.8.3.1
