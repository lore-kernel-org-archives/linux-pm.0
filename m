Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B3BC433EF
	for <linux-pm@archiver.kernel.org>; Tue,  1 Mar 2022 08:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiCAIRF (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 1 Mar 2022 03:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiCAIRE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2022 03:17:04 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF8F83026;
        Tue,  1 Mar 2022 00:16:23 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V5vTaqf_1646122580;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V5vTaqf_1646122580)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Mar 2022 16:16:20 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     sre@kernel.org
Cc:     support.opensource@diasemi.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] power: supply: da9150-fg: Remove unnecessary print function dev_err()
Date:   Tue,  1 Mar 2022 16:16:19 +0800
Message-Id: <20220301081619.121904-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The print function dev_err() is redundant because
platform_get_irq_byname() already prints an error.

Eliminate the follow coccicheck warning:
./drivers/power/supply/da9150-fg.c:524:2-9: line 524 is redundant
because platform_get_irq() already prints an error

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/power/supply/da9150-fg.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/supply/da9150-fg.c b/drivers/power/supply/da9150-fg.c
index e63fa62d1943..8c5e2c49d6c1 100644
--- a/drivers/power/supply/da9150-fg.c
+++ b/drivers/power/supply/da9150-fg.c
@@ -520,10 +520,8 @@ static int da9150_fg_probe(struct platform_device *pdev)
 
 	/* Register IRQ */
 	irq = platform_get_irq_byname(pdev, "FG");
-	if (irq < 0) {
-		dev_err(dev, "Failed to get IRQ FG: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_threaded_irq(dev, irq, NULL, da9150_fg_irq,
 					IRQF_ONESHOT, "FG", fg);
-- 
2.20.1.7.g153144c

