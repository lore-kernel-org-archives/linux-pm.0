Return-Path: <SRS0=Prsx=SX=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAE3C10F14
	for <linux-pm@archiver.kernel.org>; Sun, 21 Apr 2019 08:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D4520869
	for <linux-pm@archiver.kernel.org>; Sun, 21 Apr 2019 08:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfDUIph (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 21 Apr 2019 04:45:37 -0400
Received: from mga09.intel.com ([134.134.136.24]:50332 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbfDUIpg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 21 Apr 2019 04:45:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Apr 2019 01:45:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,377,1549958400"; 
   d="scan'208";a="144561587"
Received: from jzha102-mobl1.ccr.corp.intel.com (HELO rzhang-dell-9360.ccr.corp.intel.com) ([10.249.170.41])
  by fmsmga007.fm.intel.com with ESMTP; 21 Apr 2019 01:45:35 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     rui.zhang@intel.com, bugzilla@colorremedies.com
Subject: [PATCH] thermal/int3403_thermal: favor _TMP instead of PTYP
Date:   Sun, 21 Apr 2019 16:45:11 +0800
Message-Id: <1555836311-3657-1-git-send-email-rui.zhang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All the INT3403 devices with _TMP can be a sensor.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=202671
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/intel/int340x_thermal/int3403_thermal.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
index 0c19fcd5..79a7df2 100644
--- a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
@@ -220,6 +220,7 @@ static int int3403_add(struct platform_device *pdev)
 {
 	struct int3403_priv *priv;
 	int result = 0;
+	unsigned long long tmp;
 	acpi_status status;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(struct int3403_priv),
@@ -234,19 +235,18 @@ static int int3403_add(struct platform_device *pdev)
 		goto err;
 	}
 
-	status = acpi_evaluate_integer(priv->adev->handle, "PTYP",
-				       NULL, &priv->type);
-	if (ACPI_FAILURE(status)) {
-		unsigned long long tmp;
 
-		status = acpi_evaluate_integer(priv->adev->handle, "_TMP",
-					       NULL, &tmp);
+	status = acpi_evaluate_integer(priv->adev->handle, "_TMP",
+				       NULL, &tmp);
+	if (ACPI_FAILURE(status)) {
+		status = acpi_evaluate_integer(priv->adev->handle, "PTYP",
+				       NULL, &priv->type);
 		if (ACPI_FAILURE(status)) {
 			result = -EINVAL;
 			goto err;
-		} else {
-			priv->type = INT3403_TYPE_SENSOR;
 		}
+	} else {
+		priv->type = INT3403_TYPE_SENSOR;
 	}
 
 	platform_set_drvdata(pdev, priv);
-- 
2.7.4

