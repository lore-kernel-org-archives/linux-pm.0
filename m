Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CC7C004D4
	for <linux-pm@archiver.kernel.org>; Wed, 18 Jan 2023 09:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjARJRU (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 18 Jan 2023 04:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjARJQl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2023 04:16:41 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF6E4E503;
        Wed, 18 Jan 2023 00:33:20 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NxfCy4cNhz501SY;
        Wed, 18 Jan 2023 16:33:18 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
        by mse-fl2.zte.com.cn with SMTP id 30I8X3Za049168;
        Wed, 18 Jan 2023 16:33:03 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 18 Jan 2023 16:33:05 +0800 (CST)
Date:   Wed, 18 Jan 2023 16:33:05 +0800 (CST)
X-Zmail-TransId: 2af963c7aec14db037f3
X-Mailer: Zmail v1.0
Message-ID: <202301181633059433484@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <daniel.lezcano@linaro.org>
Cc:     <rafael@kernel.org>, <amitk@kernel.org>, <rui.zhang@intel.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSB0aGVybWFsOiBkb3ZlOiBVc2UgZGV2bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2UoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 30I8X3Za049168
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63C7AECE.002/4NxfCy4cNhz501SY
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/thermal/dove_thermal.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/dove_thermal.c b/drivers/thermal/dove_thermal.c
index 73182eb94bc0..056622a58d00 100644
--- a/drivers/thermal/dove_thermal.c
+++ b/drivers/thermal/dove_thermal.c
@@ -122,20 +122,17 @@ static int dove_thermal_probe(struct platform_device *pdev)
 {
 	struct thermal_zone_device *thermal = NULL;
 	struct dove_thermal_priv *priv;
-	struct resource *res;
 	int ret;

 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;

-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->sensor = devm_ioremap_resource(&pdev->dev, res);
+	priv->sensor = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(priv->sensor))
 		return PTR_ERR(priv->sensor);

-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	priv->control = devm_ioremap_resource(&pdev->dev, res);
+	priv->control = devm_platform_get_and_ioremap_resource(pdev, 1, NULL);
 	if (IS_ERR(priv->control))
 		return PTR_ERR(priv->control);

-- 
2.25.1
