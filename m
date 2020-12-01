Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D340C64E90
	for <linux-pm@archiver.kernel.org>; Tue,  1 Dec 2020 00:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B7A120857
	for <linux-pm@archiver.kernel.org>; Tue,  1 Dec 2020 00:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbgLAAzg (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 30 Nov 2020 19:55:36 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:8477 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbgLAAzf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2020 19:55:35 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4ClNsh6sS1zhkBm;
        Tue,  1 Dec 2020 08:54:32 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Tue, 1 Dec 2020 08:54:46 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] power: supply: ab8500_charger: Fix missing IRQF_ONESHOT as only threaded handler
Date:   Tue, 1 Dec 2020 08:55:05 +0800
Message-ID: <1606784105-31729-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Coccinelle noticed:
drivers/power/supply/ab8500_charger.c:3605:8-28: ERROR: Threaded IRQ with
no primary handler requested without IRQF_ONESHOT

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/power/supply/ab8500_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index db65be0..7dbe18d 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -3603,7 +3603,7 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 		}
 
 		ret = request_threaded_irq(irq, NULL, ab8500_charger_irq[i].isr,
-			IRQF_SHARED | IRQF_NO_SUSPEND,
+			IRQF_SHARED | IRQF_NO_SUSPEND | IRQF_ONESHOT,
 			ab8500_charger_irq[i].name, di);
 
 		if (ret != 0) {
-- 
2.7.4

