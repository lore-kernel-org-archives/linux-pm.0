From: Colin King <colin.king@canonical.com>
Subject: [PATCH] PM / AVS: SmartReflex: add in missing white space in error message text
Date: Mon, 12 Sep 2016 12:14:55 +0100
Message-ID: <20160912111455.29881-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:60447 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751955AbcILLQ0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Sep 2016 07:16:26 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Several line wrapped literal strings are missing white spaces, add the
whitespace to fix this.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/power/avs/smartreflex.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
index db9973b..40f46a8 100644
--- a/drivers/power/avs/smartreflex.c
+++ b/drivers/power/avs/smartreflex.c
@@ -225,8 +224,7 @@ static int sr_late_init(struct omap_sr *sr_info)
 
 error:
 	list_del(&sr_info->node);
-	dev_err(&sr_info->pdev->dev, "%s: ERROR in registering"
-		"interrupt handler. Smartreflex will"
+	dev_err(&sr_info->pdev->dev, "%s: ERROR in registering interrupt handler. Smartreflex will "
 		"not function as desired\n", __func__);
 
 	return ret;
@@ -387,7 +386,7 @@ int sr_configure_errgen(struct omap_sr *sr)
 		vpboundint_st = ERRCONFIG_VPBOUNDINTST_V2;
 		break;
 	default:
-		dev_err(&sr->pdev->dev, "%s: Trying to Configure smartreflex"
+		dev_err(&sr->pdev->dev, "%s: Trying to Configure smartreflex "
 			"module without specifying the ip\n", __func__);
 		return -EINVAL;
 	}
@@ -440,7 +439,7 @@ int sr_disable_errgen(struct omap_sr *sr)
 		vpboundint_st = ERRCONFIG_VPBOUNDINTST_V2;
 		break;
 	default:
-		dev_err(&sr->pdev->dev, "%s: Trying to Configure smartreflex"
+		dev_err(&sr->pdev->dev, "%s: Trying to Configure smartreflex "
 			"module without specifying the ip\n", __func__);
 		return -EINVAL;
 	}
@@ -504,7 +503,7 @@ int sr_configure_minmax(struct omap_sr *sr)
 		senp_shift = SRCONFIG_SENPENABLE_V2_SHIFT;
 		break;
 	default:
-		dev_err(&sr->pdev->dev, "%s: Trying to Configure smartreflex"
+		dev_err(&sr->pdev->dev, "%s: Trying to Configure smartreflex "
 			"module without specifying the ip\n", __func__);
 		return -EINVAL;
 	}
@@ -537,7 +536,7 @@ int sr_configure_minmax(struct omap_sr *sr)
 			IRQENABLE_MCUBOUNDSINT | IRQENABLE_MCUDISABLEACKINT);
 		break;
 	default:
-		dev_err(&sr->pdev->dev, "%s: Trying to Configure smartreflex"
+		dev_err(&sr->pdev->dev, "%s: Trying to Configure smartreflex "
 			"module without specifying the ip\n", __func__);
 		return -EINVAL;
 	}
@@ -571,7 +570,7 @@ int sr_enable(struct omap_sr *sr, unsigned long volt)
 	volt_data = omap_voltage_get_voltdata(sr->voltdm, volt);
 
 	if (IS_ERR(volt_data)) {
-		dev_warn(&sr->pdev->dev, "%s: Unable to get voltage table"
+		dev_warn(&sr->pdev->dev, "%s: Unable to get voltage table "
 			"for nominal voltage %ld\n", __func__, volt);
 		return PTR_ERR(volt_data);
 	}
@@ -704,7 +703,7 @@ void omap_sr_enable(struct voltagedomain *voltdm)
 		return;
 
 	if (!sr_class || !(sr_class->enable) || !(sr_class->configure)) {
-		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not"
+		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not "
 			"registered\n", __func__);
 		return;
 	}
@@ -736,7 +735,7 @@ void omap_sr_disable(struct voltagedomain *voltdm)
 		return;
 
 	if (!sr_class || !(sr_class->disable)) {
-		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not"
+		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not "
 			"registered\n", __func__);
 		return;
 	}
@@ -768,7 +767,7 @@ void omap_sr_disable_reset_volt(struct voltagedomain *voltdm)
 		return;
 
 	if (!sr_class || !(sr_class->disable)) {
-		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not"
+		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not "
 			"registered\n", __func__);
 		return;
 	}
-- 
2.9.3

