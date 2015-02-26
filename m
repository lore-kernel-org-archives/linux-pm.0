From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] thermal: int340x_thermal: Ignore missing _ART, _TRT tables
Date: Wed, 25 Feb 2015 18:31:50 -0800
Message-ID: <1424917910-18441-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:19842 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751479AbbBZCdZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 25 Feb 2015 21:33:25 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

It is possible that _ART/_TRT tables are missing or have errors.
Ignore those failures, as INT3400 thermal zone is still required
for _OSC or mode switch.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/int340x_thermal/int3400_thermal.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c b/drivers/thermal/int340x_thermal/int3400_thermal.c
index 25d244c..031018e 100644
--- a/drivers/thermal/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
@@ -262,13 +262,12 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 	result = acpi_parse_art(priv->adev->handle, &priv->art_count,
 				&priv->arts, true);
 	if (result)
-		goto free_priv;
-
+		dev_dbg(&pdev->dev, "_ART table parsing error\n");
 
 	result = acpi_parse_trt(priv->adev->handle, &priv->trt_count,
 				&priv->trts, true);
 	if (result)
-		goto free_art;
+		dev_dbg(&pdev->dev, "_TRT table parsing error\n");
 
 	platform_set_drvdata(pdev, priv);
 
@@ -281,7 +280,7 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 						&int3400_thermal_params, 0, 0);
 	if (IS_ERR(priv->thermal)) {
 		result = PTR_ERR(priv->thermal);
-		goto free_trt;
+		goto free_art_trt;
 	}
 
 	priv->rel_misc_dev_res = acpi_thermal_rel_misc_device_add(
@@ -295,9 +294,8 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 
 free_zone:
 	thermal_zone_device_unregister(priv->thermal);
-free_trt:
+free_art_trt:
 	kfree(priv->trts);
-free_art:
 	kfree(priv->arts);
 free_priv:
 	kfree(priv);
-- 
1.9.1

