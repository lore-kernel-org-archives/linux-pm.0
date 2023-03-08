Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BDDC6FD20
	for <linux-pm@archiver.kernel.org>; Wed,  8 Mar 2023 06:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjCHGEG (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 8 Mar 2023 01:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCHGEF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Mar 2023 01:04:05 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC6B2B288;
        Tue,  7 Mar 2023 22:04:01 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VdO7V.f_1678255438;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VdO7V.f_1678255438)
          by smtp.aliyun-inc.com;
          Wed, 08 Mar 2023 14:03:59 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     niklas.soderlund@ragnatech.se
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-renesas-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] thermal/hwmon: Use devm_platform_ioremap_resource()
Date:   Wed,  8 Mar 2023 14:03:57 +0800
Message-Id: <20230308060357.45647-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

According to commit 7945f929f1a7 ("drivers: provide
devm_platform_ioremap_resource()"), convert platform_get_resource(),
devm_ioremap_resource() to a single call to Use 
devm_platform_ioremap_resource(), as this is exactly what this function
does.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/thermal/rcar_thermal.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index b8571f7090aa..ee2dde1fbe2a 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -435,9 +435,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 			 * Then, driver uses common registers
 			 * rcar_has_irq_support() will be enabled
 			 */
-			res = platform_get_resource(pdev, IORESOURCE_MEM,
-						    mres++);
-			common->base = devm_ioremap_resource(dev, res);
+			common->base = devm_platform_ioremap_resource(pdev, mres++);
 			if (IS_ERR(common->base)) {
 				ret = PTR_ERR(common->base);
 				goto error_unregister;
-- 
2.20.1.7.g153144c

