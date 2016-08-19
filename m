From: Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH] PM / AVS: SmartReflex: Neaten logging
Date: Fri, 19 Aug 2016 09:15:50 -0700
Message-ID: <20160819161550.31796-1-khilman@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34233 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754146AbcHSQPx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Aug 2016 12:15:53 -0400
Received: by mail-pa0-f50.google.com with SMTP id fi15so17482554pac.1
        for <linux-pm@vger.kernel.org>; Fri, 19 Aug 2016 09:15:52 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, Nishanth Menon <nm@ti.com>, Joe Perches <joe@perches.com>

From: Joe Perches <joe@perches.com>

Use a more common logging style.

Miscellanea:

o Use pr_warn
o Coalesce formats adding missing spaces
o Argument alignment
o Remove unnecessary OOM messages as k.alloc does stack dumps

Signed-off-by: Joe Perches <joe@perches.com>
Acked-by: Nishanth Menon <nm@ti.com>
[khilman: update shortlog]
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
Applies on v4.8-rc1

 drivers/power/avs/smartreflex.c | 115 +++++++++++++++++++---------------------
 1 file changed, 54 insertions(+), 61 deletions(-)

diff --git a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
index db9973bb53f1..fa0f19b975a6 100644
--- a/drivers/power/avs/smartreflex.c
+++ b/drivers/power/avs/smartreflex.c
@@ -136,7 +136,7 @@ static void sr_set_clk_length(struct omap_sr *sr)
 
 	if (IS_ERR(fck)) {
 		dev_err(&sr->pdev->dev, "%s: unable to get fck for device %s\n",
-				__func__, dev_name(&sr->pdev->dev));
+			__func__, dev_name(&sr->pdev->dev));
 		return;
 	}
 
@@ -170,8 +170,8 @@ static void sr_start_vddautocomp(struct omap_sr *sr)
 {
 	if (!sr_class || !(sr_class->enable) || !(sr_class->configure)) {
 		dev_warn(&sr->pdev->dev,
-			"%s: smartreflex class driver not registered\n",
-			__func__);
+			 "%s: smartreflex class driver not registered\n",
+			 __func__);
 		return;
 	}
 
@@ -183,8 +183,8 @@ static void sr_stop_vddautocomp(struct omap_sr *sr)
 {
 	if (!sr_class || !(sr_class->disable)) {
 		dev_warn(&sr->pdev->dev,
-			"%s: smartreflex class driver not registered\n",
-			__func__);
+			 "%s: smartreflex class driver not registered\n",
+			 __func__);
 		return;
 	}
 
@@ -225,9 +225,8 @@ static int sr_late_init(struct omap_sr *sr_info)
 
 error:
 	list_del(&sr_info->node);
-	dev_err(&sr_info->pdev->dev, "%s: ERROR in registering"
-		"interrupt handler. Smartreflex will"
-		"not function as desired\n", __func__);
+	dev_err(&sr_info->pdev->dev, "%s: ERROR in registering interrupt handler. Smartreflex will not function as desired\n",
+		__func__);
 
 	return ret;
 }
@@ -263,7 +262,7 @@ static void sr_v1_disable(struct omap_sr *sr)
 
 	if (timeout >= SR_DISABLE_TIMEOUT)
 		dev_warn(&sr->pdev->dev, "%s: Smartreflex disable timedout\n",
-			__func__);
+			 __func__);
 
 	/* Disable MCUDisableAcknowledge interrupt & clear pending interrupt */
 	sr_modify_reg(sr, ERRCONFIG_V1, ERRCONFIG_MCUDISACKINTEN,
@@ -308,7 +307,7 @@ static void sr_v2_disable(struct omap_sr *sr)
 
 	if (timeout >= SR_DISABLE_TIMEOUT)
 		dev_warn(&sr->pdev->dev, "%s: Smartreflex disable timedout\n",
-			__func__);
+			 __func__);
 
 	/* Disable MCUDisableAcknowledge interrupt & clear pending interrupt */
 	sr_write_reg(sr, IRQENABLE_CLR, IRQENABLE_MCUDISABLEACKINT);
@@ -322,7 +321,7 @@ static struct omap_sr_nvalue_table *sr_retrieve_nvalue_row(
 
 	if (!sr->nvalue_table) {
 		dev_warn(&sr->pdev->dev, "%s: Missing ntarget value table\n",
-			__func__);
+			 __func__);
 		return NULL;
 	}
 
@@ -356,8 +355,8 @@ int sr_configure_errgen(struct omap_sr *sr)
 	u8 senp_shift, senn_shift;
 
 	if (!sr) {
-		pr_warn("%s: NULL omap_sr from %pF\n", __func__,
-			(void *)_RET_IP_);
+		pr_warn("%s: NULL omap_sr from %pF\n",
+			__func__, (void *)_RET_IP_);
 		return -EINVAL;
 	}
 
@@ -387,8 +386,8 @@ int sr_configure_errgen(struct omap_sr *sr)
 		vpboundint_st = ERRCONFIG_VPBOUNDINTST_V2;
 		break;
 	default:
-		dev_err(&sr->pdev->dev, "%s: Trying to Configure smartreflex"
-			"module without specifying the ip\n", __func__);
+		dev_err(&sr->pdev->dev, "%s: Trying to Configure smartreflex module without specifying the ip\n",
+			__func__);
 		return -EINVAL;
 	}
 
@@ -423,8 +422,8 @@ int sr_disable_errgen(struct omap_sr *sr)
 	u32 vpboundint_en, vpboundint_st;
 
 	if (!sr) {
-		pr_warn("%s: NULL omap_sr from %pF\n", __func__,
-			(void *)_RET_IP_);
+		pr_warn("%s: NULL omap_sr from %pF\n",
+			__func__, (void *)_RET_IP_);
 		return -EINVAL;
 	}
 
@@ -440,8 +439,8 @@ int sr_disable_errgen(struct omap_sr *sr)
 		vpboundint_st = ERRCONFIG_VPBOUNDINTST_V2;
 		break;
 	default:
-		dev_err(&sr->pdev->dev, "%s: Trying to Configure smartreflex"
-			"module without specifying the ip\n", __func__);
+		dev_err(&sr->pdev->dev, "%s: Trying to Configure smartreflex module without specifying the ip\n",
+			__func__);
 		return -EINVAL;
 	}
 
@@ -478,8 +477,8 @@ int sr_configure_minmax(struct omap_sr *sr)
 	u8 senp_shift, senn_shift;
 
 	if (!sr) {
-		pr_warn("%s: NULL omap_sr from %pF\n", __func__,
-			(void *)_RET_IP_);
+		pr_warn("%s: NULL omap_sr from %pF\n",
+			__func__, (void *)_RET_IP_);
 		return -EINVAL;
 	}
 
@@ -504,8 +503,8 @@ int sr_configure_minmax(struct omap_sr *sr)
 		senp_shift = SRCONFIG_SENPENABLE_V2_SHIFT;
 		break;
 	default:
-		dev_err(&sr->pdev->dev, "%s: Trying to Configure smartreflex"
-			"module without specifying the ip\n", __func__);
+		dev_err(&sr->pdev->dev, "%s: Trying to Configure smartreflex module without specifying the ip\n",
+			__func__);
 		return -EINVAL;
 	}
 
@@ -537,8 +536,8 @@ int sr_configure_minmax(struct omap_sr *sr)
 			IRQENABLE_MCUBOUNDSINT | IRQENABLE_MCUDISABLEACKINT);
 		break;
 	default:
-		dev_err(&sr->pdev->dev, "%s: Trying to Configure smartreflex"
-			"module without specifying the ip\n", __func__);
+		dev_err(&sr->pdev->dev, "%s: Trying to Configure smartreflex module without specifying the ip\n",
+			__func__);
 		return -EINVAL;
 	}
 
@@ -563,16 +562,16 @@ int sr_enable(struct omap_sr *sr, unsigned long volt)
 	int ret;
 
 	if (!sr) {
-		pr_warn("%s: NULL omap_sr from %pF\n", __func__,
-			(void *)_RET_IP_);
+		pr_warn("%s: NULL omap_sr from %pF\n",
+			__func__, (void *)_RET_IP_);
 		return -EINVAL;
 	}
 
 	volt_data = omap_voltage_get_voltdata(sr->voltdm, volt);
 
 	if (IS_ERR(volt_data)) {
-		dev_warn(&sr->pdev->dev, "%s: Unable to get voltage table"
-			"for nominal voltage %ld\n", __func__, volt);
+		dev_warn(&sr->pdev->dev, "%s: Unable to get voltage table for nominal voltage %ld\n",
+			 __func__, volt);
 		return PTR_ERR(volt_data);
 	}
 
@@ -615,8 +614,8 @@ int sr_enable(struct omap_sr *sr, unsigned long volt)
 void sr_disable(struct omap_sr *sr)
 {
 	if (!sr) {
-		pr_warn("%s: NULL omap_sr from %pF\n", __func__,
-			(void *)_RET_IP_);
+		pr_warn("%s: NULL omap_sr from %pF\n",
+			__func__, (void *)_RET_IP_);
 		return;
 	}
 
@@ -658,13 +657,13 @@ int sr_register_class(struct omap_sr_class_data *class_data)
 	struct omap_sr *sr_info;
 
 	if (!class_data) {
-		pr_warning("%s:, Smartreflex class data passed is NULL\n",
+		pr_warn("%s:, Smartreflex class data passed is NULL\n",
 			__func__);
 		return -EINVAL;
 	}
 
 	if (sr_class) {
-		pr_warning("%s: Smartreflex class driver already registered\n",
+		pr_warn("%s: Smartreflex class driver already registered\n",
 			__func__);
 		return -EBUSY;
 	}
@@ -696,7 +695,7 @@ void omap_sr_enable(struct voltagedomain *voltdm)
 	struct omap_sr *sr = _sr_lookup(voltdm);
 
 	if (IS_ERR(sr)) {
-		pr_warning("%s: omap_sr struct for voltdm not found\n",	__func__);
+		pr_warn("%s: omap_sr struct for voltdm not found\n", __func__);
 		return;
 	}
 
@@ -704,8 +703,8 @@ void omap_sr_enable(struct voltagedomain *voltdm)
 		return;
 
 	if (!sr_class || !(sr_class->enable) || !(sr_class->configure)) {
-		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not"
-			"registered\n", __func__);
+		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not registered\n",
+			 __func__);
 		return;
 	}
 
@@ -728,7 +727,7 @@ void omap_sr_disable(struct voltagedomain *voltdm)
 	struct omap_sr *sr = _sr_lookup(voltdm);
 
 	if (IS_ERR(sr)) {
-		pr_warning("%s: omap_sr struct for voltdm not found\n",	__func__);
+		pr_warn("%s: omap_sr struct for voltdm not found\n", __func__);
 		return;
 	}
 
@@ -736,8 +735,8 @@ void omap_sr_disable(struct voltagedomain *voltdm)
 		return;
 
 	if (!sr_class || !(sr_class->disable)) {
-		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not"
-			"registered\n", __func__);
+		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not registered\n",
+			 __func__);
 		return;
 	}
 
@@ -760,7 +759,7 @@ void omap_sr_disable_reset_volt(struct voltagedomain *voltdm)
 	struct omap_sr *sr = _sr_lookup(voltdm);
 
 	if (IS_ERR(sr)) {
-		pr_warning("%s: omap_sr struct for voltdm not found\n",	__func__);
+		pr_warn("%s: omap_sr struct for voltdm not found\n", __func__);
 		return;
 	}
 
@@ -768,8 +767,8 @@ void omap_sr_disable_reset_volt(struct voltagedomain *voltdm)
 		return;
 
 	if (!sr_class || !(sr_class->disable)) {
-		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not"
-			"registered\n", __func__);
+		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not registered\n",
+			 __func__);
 		return;
 	}
 
@@ -787,8 +786,8 @@ void omap_sr_disable_reset_volt(struct voltagedomain *voltdm)
 void omap_sr_register_pmic(struct omap_sr_pmic_data *pmic_data)
 {
 	if (!pmic_data) {
-		pr_warning("%s: Trying to register NULL PMIC data structure"
-			"with smartreflex\n", __func__);
+		pr_warn("%s: Trying to register NULL PMIC data structure with smartreflex\n",
+			__func__);
 		return;
 	}
 
@@ -801,7 +800,7 @@ static int omap_sr_autocomp_show(void *data, u64 *val)
 	struct omap_sr *sr_info = data;
 
 	if (!sr_info) {
-		pr_warning("%s: omap_sr struct not found\n", __func__);
+		pr_warn("%s: omap_sr struct not found\n", __func__);
 		return -EINVAL;
 	}
 
@@ -815,13 +814,13 @@ static int omap_sr_autocomp_store(void *data, u64 val)
 	struct omap_sr *sr_info = data;
 
 	if (!sr_info) {
-		pr_warning("%s: omap_sr struct not found\n", __func__);
+		pr_warn("%s: omap_sr struct not found\n", __func__);
 		return -EINVAL;
 	}
 
 	/* Sanity check */
 	if (val > 1) {
-		pr_warning("%s: Invalid argument %lld\n", __func__, val);
+		pr_warn("%s: Invalid argument %lld\n", __func__, val);
 		return -EINVAL;
 	}
 
@@ -848,19 +847,13 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	int i, ret = 0;
 
 	sr_info = devm_kzalloc(&pdev->dev, sizeof(struct omap_sr), GFP_KERNEL);
-	if (!sr_info) {
-		dev_err(&pdev->dev, "%s: unable to allocate sr_info\n",
-			__func__);
+	if (!sr_info)
 		return -ENOMEM;
-	}
 
 	sr_info->name = devm_kzalloc(&pdev->dev,
 				     SMARTREFLEX_NAME_LEN, GFP_KERNEL);
-	if (!sr_info->name) {
-		dev_err(&pdev->dev, "%s: unable to allocate SR instance name\n",
-			__func__);
+	if (!sr_info->name)
 		return -ENOMEM;
-	}
 
 	platform_set_drvdata(pdev, sr_info);
 
@@ -912,7 +905,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	if (sr_class) {
 		ret = sr_late_init(sr_info);
 		if (ret) {
-			pr_warning("%s: Error in SR late init\n", __func__);
+			pr_warn("%s: Error in SR late init\n", __func__);
 			goto err_list_del;
 		}
 	}
@@ -923,7 +916,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 		if (IS_ERR_OR_NULL(sr_dbg_dir)) {
 			ret = PTR_ERR(sr_dbg_dir);
 			pr_err("%s:sr debugfs dir creation failed(%d)\n",
-				__func__, ret);
+			       __func__, ret);
 			goto err_list_del;
 		}
 	}
@@ -945,8 +938,8 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 
 	nvalue_dir = debugfs_create_dir("nvalue", sr_info->dbg_dir);
 	if (IS_ERR_OR_NULL(nvalue_dir)) {
-		dev_err(&pdev->dev, "%s: Unable to create debugfs directory"
-			"for n-values\n", __func__);
+		dev_err(&pdev->dev, "%s: Unable to create debugfs directory for n-values\n",
+			__func__);
 		ret = PTR_ERR(nvalue_dir);
 		goto err_debugfs;
 	}
@@ -1053,12 +1046,12 @@ static int __init sr_init(void)
 	if (sr_pmic_data && sr_pmic_data->sr_pmic_init)
 		sr_pmic_data->sr_pmic_init();
 	else
-		pr_warning("%s: No PMIC hook to init smartreflex\n", __func__);
+		pr_warn("%s: No PMIC hook to init smartreflex\n", __func__);
 
 	ret = platform_driver_probe(&smartreflex_driver, omap_sr_probe);
 	if (ret) {
 		pr_err("%s: platform driver register failed for SR\n",
-			__func__);
+		       __func__);
 		return ret;
 	}
 
-- 
2.9.0

