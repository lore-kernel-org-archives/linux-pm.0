Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76858C43460
	for <linux-pm@archiver.kernel.org>; Thu,  8 Apr 2021 09:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44A12610A6
	for <linux-pm@archiver.kernel.org>; Thu,  8 Apr 2021 09:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbhDHJr7 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 8 Apr 2021 05:47:59 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16406 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbhDHJr6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 05:47:58 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FGGbm6cgkzkjWR;
        Thu,  8 Apr 2021 17:45:56 +0800 (CST)
Received: from huawei.com (10.67.174.117) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 17:47:38 +0800
From:   Ruiqi Gong <gongruiqi1@huawei.com>
To:     <gongruiqi1@huawei.com>, Talel Shenhar <talel@amazon.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Wang Weiyang <wangweiyang2@huawei.com>, <linux-pm@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] thermal: thermal_mmio: remove redundant dev_err call in thermal_mmio_probe()
Date:   Thu, 8 Apr 2021 06:01:44 -0400
Message-ID: <20210408100144.7494-1-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.174.117]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ruiqi Gong <gongruiqi1@huawei.com>
---
 drivers/thermal/thermal_mmio.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_mmio.c b/drivers/thermal/thermal_mmio.c
index d0bdf1ea3331..ded1dd0d4ef7 100644
--- a/drivers/thermal/thermal_mmio.c
+++ b/drivers/thermal/thermal_mmio.c
@@ -54,11 +54,8 @@ static int thermal_mmio_probe(struct platform_device *pdev)
 
 	resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	sensor->mmio_base = devm_ioremap_resource(&pdev->dev, resource);
-	if (IS_ERR(sensor->mmio_base)) {
-		dev_err(&pdev->dev, "failed to ioremap memory (%ld)\n",
-			PTR_ERR(sensor->mmio_base));
+	if (IS_ERR(sensor->mmio_base))
 		return PTR_ERR(sensor->mmio_base);
-	}
 
 	sensor_init_func = device_get_match_data(&pdev->dev);
 	if (sensor_init_func) {

