Return-Path: <SRS0=HvZr=5W=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38DAC2BA18
	for <linux-pm@archiver.kernel.org>; Mon,  6 Apr 2020 05:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A434F2074F
	for <linux-pm@archiver.kernel.org>; Mon,  6 Apr 2020 05:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgDFFGx (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 6 Apr 2020 01:06:53 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:5392 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgDFFGx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2020 01:06:53 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.15]) by rmmx-syy-dmz-app10-12010 (RichMail) with SMTP id 2eea5e8ab8d4e13-9af74; Mon, 06 Apr 2020 13:06:29 +0800 (CST)
X-RM-TRANSID: 2eea5e8ab8d4e13-9af74
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.1.173.122])
        by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee85e8ab8d204d-b87e0;
        Mon, 06 Apr 2020 13:06:28 +0800 (CST)
X-RM-TRANSID: 2ee85e8ab8d204d-b87e0
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] [PATCH v2] power:supply:88pm860x_battery:remove redundant dev_err message
Date:   Mon,  6 Apr 2020 13:07:57 +0800
Message-Id: <20200406050757.13796-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In the pm860x_battery_probe(),when get irq failed, the function
platform_get_irq() can log an dev_err message,so remove redundant
message here.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
Changes from v1
 - changed the theme、commit message and the code,but the purpose is the same.
   The original piece is:https://lore.kernel.org/linux-pm/20200402111222.15204-1-tangbin@cmss.chinamobile.com/
---
 drivers/power/supply/88pm860x_battery.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/88pm860x_battery.c b/drivers/power/supply/88pm860x_battery.c
index 5ca047b3f..1308f3a18 100644
--- a/drivers/power/supply/88pm860x_battery.c
+++ b/drivers/power/supply/88pm860x_battery.c
@@ -919,16 +919,12 @@ static int pm860x_battery_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	info->irq_cc = platform_get_irq(pdev, 0);
-	if (info->irq_cc <= 0) {
-		dev_err(&pdev->dev, "No IRQ resource!\n");
+	if (info->irq_cc <= 0)
 		return -EINVAL;
-	}
 
 	info->irq_batt = platform_get_irq(pdev, 1);
-	if (info->irq_batt <= 0) {
-		dev_err(&pdev->dev, "No IRQ resource!\n");
+	if (info->irq_batt <= 0)
 		return -EINVAL;
-	}
 
 	info->chip = chip;
 	info->i2c =
-- 
2.20.1.windows.1



