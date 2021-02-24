Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02ADC433E0
	for <linux-pm@archiver.kernel.org>; Wed, 24 Feb 2021 07:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6CB064EBB
	for <linux-pm@archiver.kernel.org>; Wed, 24 Feb 2021 07:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbhBXHQL (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 24 Feb 2021 02:16:11 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:47789 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232560AbhBXHQC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Feb 2021 02:16:02 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UPQXqKn_1614150912;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UPQXqKn_1614150912)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 24 Feb 2021 15:15:16 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     sre@kernel.org
Cc:     lgirdwood@gmail.com, broonie@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] power: supply: max8997-charger: remove unneeded semicolon
Date:   Wed, 24 Feb 2021 15:15:10 +0800
Message-Id: <1614150910-21023-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix the following coccicheck warnings:

./drivers/power/supply/max8997_charger.c:266:3-4: Unneeded semicolon.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/power/supply/max8997_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/max8997_charger.c b/drivers/power/supply/max8997_charger.c
index 321bd6b..a90c018 100644
--- a/drivers/power/supply/max8997_charger.c
+++ b/drivers/power/supply/max8997_charger.c
@@ -263,7 +263,7 @@ static int max8997_battery_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(&pdev->dev, "failed to register extcon notifier\n");
 			return ret;
-		};
+		}
 	}
 
 	return 0;
-- 
1.8.3.1

