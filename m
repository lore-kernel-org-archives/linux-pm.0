From: sathyanarayanan.kuppuswamy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Subject: [PATCH v5 6/8] mfd: intel_soc_pmic_bxtwc: Utilize devm_* functions in driver probe
Date: Wed, 31 May 2017 15:37:14 -0700
Message-ID: <423581e996e0524b4ea4e73f9dfda634d8cf7046.1496266871.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20170531070225.bymdhhpclidwwtpt@dell>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170531070225.bymdhhpclidwwtpt@dell>
In-Reply-To: <cover.1496266871.git.sathyanarayanan.kuppuswamy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
References: <cover.1496266871.git.sathyanarayanan.kuppuswamy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dvhart-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, andy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sathyaosid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Cleanup the resource allocation/free code in probe function by using
devm_* calls.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Acked-for-MFD-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/mfd/intel_soc_pmic_bxtwc.c | 54 +++++++++++++-------------------------
 1 file changed, 18 insertions(+), 36 deletions(-)

Changes since v1:
 * None

Changes since v2:
 * Rebased on top of latest release.

Changes since v3:
 * None

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index af11c43..feeda6e 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -399,45 +399,44 @@ static int bxtwc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = regmap_add_irq_chip(pmic->regmap, pmic->irq,
-				  IRQF_ONESHOT | IRQF_SHARED,
-				  0, &bxtwc_regmap_irq_chip,
-				  &pmic->irq_chip_data);
+	ret = devm_regmap_add_irq_chip(&pdev->dev, pmic->regmap, pmic->irq,
+				       IRQF_ONESHOT | IRQF_SHARED,
+				       0, &bxtwc_regmap_irq_chip,
+				       &pmic->irq_chip_data);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to add IRQ chip\n");
 		return ret;
 	}
 
-	ret = regmap_add_irq_chip(pmic->regmap, pmic->irq,
-				  IRQF_ONESHOT | IRQF_SHARED,
-				  0, &bxtwc_regmap_irq_chip_level2,
-				  &pmic->irq_chip_data_level2);
+	ret = devm_regmap_add_irq_chip(&pdev->dev, pmic->regmap, pmic->irq,
+				       IRQF_ONESHOT | IRQF_SHARED,
+				       0, &bxtwc_regmap_irq_chip_level2,
+				       &pmic->irq_chip_data_level2);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to add secondary IRQ chip\n");
-		goto err_irq_chip_level2;
+		return ret;
 	}
 
-	ret = regmap_add_irq_chip(pmic->regmap, pmic->irq,
-				  IRQF_ONESHOT | IRQF_SHARED,
-				  0, &bxtwc_regmap_irq_chip_tmu,
-				  &pmic->irq_chip_data_tmu);
+	ret = devm_regmap_add_irq_chip(&pdev->dev, pmic->regmap, pmic->irq,
+				       IRQF_ONESHOT | IRQF_SHARED,
+				       0, &bxtwc_regmap_irq_chip_tmu,
+				       &pmic->irq_chip_data_tmu);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to add TMU IRQ chip\n");
-		goto err_irq_chip_tmu;
+		return ret;
 	}
 
-	ret = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE, bxt_wc_dev,
-			      ARRAY_SIZE(bxt_wc_dev), NULL, 0,
-			      NULL);
+	ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE, bxt_wc_dev,
+				   ARRAY_SIZE(bxt_wc_dev), NULL, 0, NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to add devices\n");
-		goto err_mfd;
+		return ret;
 	}
 
 	ret = sysfs_create_group(&pdev->dev.kobj, &bxtwc_group);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to create sysfs group %d\n", ret);
-		goto err_sysfs;
+		return ret;
 	}
 
 	/*
@@ -451,28 +450,11 @@ static int bxtwc_probe(struct platform_device *pdev)
 				BXTWC_MIRQLVL1_MCHGR, 0);
 
 	return 0;
-
-err_sysfs:
-	mfd_remove_devices(&pdev->dev);
-err_mfd:
-	regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data_tmu);
-err_irq_chip_tmu:
-	regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data_level2);
-err_irq_chip_level2:
-	regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data);
-
-	return ret;
 }
 
 static int bxtwc_remove(struct platform_device *pdev)
 {
-	struct intel_soc_pmic *pmic = dev_get_drvdata(&pdev->dev);
