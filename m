Return-Path: <SRS0=+SOU=6Z=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5820C47255
	for <linux-pm@archiver.kernel.org>; Mon, 11 May 2020 11:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B89FF206F9
	for <linux-pm@archiver.kernel.org>; Mon, 11 May 2020 11:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbgEKLHJ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 11 May 2020 07:07:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35180 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728638AbgEKLHJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 May 2020 07:07:09 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D74FF84D37ED8A17CD91;
        Mon, 11 May 2020 19:07:03 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 11 May 2020 19:06:55 +0800
From:   Samuel Zou <zou_wei@huawei.com>
To:     <sre@kernel.org>
CC:     <andriy.shevchenko@linux.intel.com>,
        <matti.vaittinen@fi.rohmeurope.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Samuel Zou <zou_wei@huawei.com>
Subject: [PATCH -next] power: supply: Make bd9995x_chip_reset static
Date:   Mon, 11 May 2020 19:12:57 +0800
Message-ID: <1589195577-8723-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix the following sparse warning:

drivers/power/supply/bd99954-charger.c:1028:6: warning: symbol 'bd9995x_chip_reset' was not declared.

The bd9995x_chip_reset() has only one call site within bd99954-charger.c
It should be static

Fixes: 0902f8366491 ("power: supply: Support ROHM bd99954 charger")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Samuel Zou <zou_wei@huawei.com>
---
 drivers/power/supply/bd99954-charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bd99954-charger.c b/drivers/power/supply/bd99954-charger.c
index 3da39c7..ffd8bfa 100644
--- a/drivers/power/supply/bd99954-charger.c
+++ b/drivers/power/supply/bd99954-charger.c
@@ -1025,7 +1025,7 @@ static int bd9995x_fw_probe(struct bd9995x_device *bd)
 	return 0;
 }
 
-void bd9995x_chip_reset(void *bd)
+static void bd9995x_chip_reset(void *bd)
 {
 	__bd9995x_chip_reset(bd);
 }
-- 
2.6.2

