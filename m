Return-Path: <SRS0=A9Dn=EC=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64477C2D0A3
	for <linux-pm@archiver.kernel.org>; Tue, 27 Oct 2020 01:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ECCD2080A
	for <linux-pm@archiver.kernel.org>; Tue, 27 Oct 2020 01:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440622AbgJ0BGB (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 26 Oct 2020 21:06:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:5423 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439444AbgJ0BGB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Oct 2020 21:06:01 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CKtn76hkWz6yYb;
        Tue, 27 Oct 2020 09:06:03 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Tue, 27 Oct 2020 09:05:50 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <niklas.soderlund@ragnatech.se>, <rui.zhang@intel.com>,
        <daniel.lezcano@linaro.org>, <amitk@kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] thermal: rcar: replace spin_lock_irqsave by spin_lock in hard IRQ
Date:   Tue, 27 Oct 2020 09:06:30 +0800
Message-ID: <1603760790-37748-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On RT or even on mainline with 'threadirqs' on the command line all
interrupts which are not explicitly requested with IRQF_NO_THREAD
run their handlers in thread context. The same applies to soft interrupts.
That means they are subject to the normal scheduler rules and no other
code is going to acquire that lock from hard interrupt context either,
so the irqsave() here is pointless in all cases.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/thermal/rcar_thermal.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 5c2a13b..6ae757d 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -409,16 +409,15 @@ static irqreturn_t rcar_thermal_irq(int irq, void *data)
 {
 	struct rcar_thermal_common *common = data;
 	struct rcar_thermal_priv *priv;
-	unsigned long flags;
 	u32 status, mask;
 
-	spin_lock_irqsave(&common->lock, flags);
+	spin_lock(&common->lock);
 
 	mask	= rcar_thermal_common_read(common, INTMSK);
 	status	= rcar_thermal_common_read(common, STR);
 	rcar_thermal_common_write(common, STR, 0x000F0F0F & mask);
 
-	spin_unlock_irqrestore(&common->lock, flags);
+	spin_unlock(&common->lock);
 
 	status = status & ~mask;
 
-- 
2.7.4

