Return-Path: <SRS0=AVup=YI=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F58AECE58E
	for <linux-pm@archiver.kernel.org>; Tue, 15 Oct 2019 08:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4BA2064B
	for <linux-pm@archiver.kernel.org>; Tue, 15 Oct 2019 08:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfJOIfG (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 15 Oct 2019 04:35:06 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3759 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726220AbfJOIfF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Oct 2019 04:35:05 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 08D43DEA40856607C56D;
        Tue, 15 Oct 2019 16:35:04 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Tue, 15 Oct 2019 16:34:55 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <rjw@rjwysocki.net>, <pavel@ucw.cz>, <linux-pm@vger.kernel.org>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH 1/1] PM / wakeirq: remove unnecessary parentheses
Date:   Tue, 15 Oct 2019 16:31:30 +0800
Message-ID: <1571128290-55488-1-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Remove unnecessary parentheses found by code review.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/base/power/wakeirq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
index 5ce77d1..8e02108 100644
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -272,7 +272,7 @@ void dev_pm_enable_wake_irq_check(struct device *dev,
 {
 	struct wake_irq *wirq = dev->power.wakeirq;
 
-	if (!wirq || !((wirq->status & WAKE_IRQ_DEDICATED_MASK)))
+	if (!wirq || !(wirq->status & WAKE_IRQ_DEDICATED_MASK))
 		return;
 
 	if (likely(wirq->status & WAKE_IRQ_DEDICATED_MANAGED)) {
@@ -299,7 +299,7 @@ void dev_pm_disable_wake_irq_check(struct device *dev)
 {
 	struct wake_irq *wirq = dev->power.wakeirq;
 
-	if (!wirq || !((wirq->status & WAKE_IRQ_DEDICATED_MASK)))
+	if (!wirq || !(wirq->status & WAKE_IRQ_DEDICATED_MASK))
 		return;
 
 	if (wirq->status & WAKE_IRQ_DEDICATED_MANAGED)
-- 
2.8.1

