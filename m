Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F83C2D0E4
	for <linux-pm@archiver.kernel.org>; Mon, 16 Nov 2020 01:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 381E42224B
	for <linux-pm@archiver.kernel.org>; Mon, 16 Nov 2020 01:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgKPBHD (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 15 Nov 2020 20:07:03 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7500 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728319AbgKPBHD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Nov 2020 20:07:03 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CZ9rj2dJvzhbBv;
        Mon, 16 Nov 2020 09:06:45 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Mon, 16 Nov 2020 09:06:51 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] power: supply: Fix missing IRQF_ONESHOT as only threaded handler
Date:   Mon, 16 Nov 2020 09:07:19 +0800
Message-ID: <1605488839-44453-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Coccinelle noticed:
drivers/power/supply/ab8500_btemp.c:1107:8-28: ERROR: Threaded IRQ with
no primary handler requested without IRQF_ONESHOT.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/power/supply/ab8500_btemp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index 909f024..e0b662b 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -1105,7 +1105,7 @@ static int ab8500_btemp_probe(struct platform_device *pdev)
 		}
 
 		ret = request_threaded_irq(irq, NULL, ab8500_btemp_irq[i].isr,
-			IRQF_SHARED | IRQF_NO_SUSPEND,
+			IRQF_SHARED | IRQF_NO_SUSPEND | IRQF_ONESHOT,
 			ab8500_btemp_irq[i].name, di);
 
 		if (ret) {
-- 
2.7.4

