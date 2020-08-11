Return-Path: <SRS0=erbm=BV=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC02C433E0
	for <linux-pm@archiver.kernel.org>; Tue, 11 Aug 2020 03:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17D29206C3
	for <linux-pm@archiver.kernel.org>; Tue, 11 Aug 2020 03:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgHKDDe (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 10 Aug 2020 23:03:34 -0400
Received: from inva021.nxp.com ([92.121.34.21]:55292 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbgHKDDe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Aug 2020 23:03:34 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A1B91201D71;
        Tue, 11 Aug 2020 05:03:32 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 37CCC20071A;
        Tue, 11 Aug 2020 05:03:28 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 6CFF0402B0;
        Tue, 11 Aug 2020 05:03:22 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/2] thermal: imx: Use dev_err_probe() to simplify error handling
Date:   Tue, 11 Aug 2020 10:58:34 +0800
Message-Id: <1597114715-1073-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

dev_err_probe() can reduce code size, uniform error handling and record the
defer probe reason etc., use it to simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/thermal/imx_thermal.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 3f74ab4..df7fa73 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -716,14 +716,9 @@ static int imx_thermal_probe(struct platform_device *pdev)
 
 	if (of_find_property(pdev->dev.of_node, "nvmem-cells", NULL)) {
 		ret = imx_init_from_nvmem_cells(pdev);
-		if (ret) {
-			if (ret == -EPROBE_DEFER)
-				return ret;
-
-			dev_err(&pdev->dev, "failed to init from nvmem: %d\n",
-				ret);
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+					     "failed to init from nvmem: %d\n", ret);
 	} else {
 		ret = imx_init_from_tempmon_data(pdev);
 		if (ret) {
@@ -746,14 +741,9 @@ static int imx_thermal_probe(struct platform_device *pdev)
 		     data->socdata->power_down_mask);
 
 	ret = imx_thermal_register_legacy_cooling(data);
-	if (ret) {
-		if (ret == -EPROBE_DEFER)
-			return ret;
-
-		dev_err(&pdev->dev,
-			"failed to register cpufreq cooling device: %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to register cpufreq cooling device: %d\n", ret);
 
 	data->thermal_clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(data->thermal_clk)) {
-- 
2.7.4

