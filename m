Return-Path: <SRS0=aBx4=YT=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19262CA9EA0
	for <linux-pm@archiver.kernel.org>; Sat, 26 Oct 2019 01:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E5620679
	for <linux-pm@archiver.kernel.org>; Sat, 26 Oct 2019 01:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfJZBED (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 25 Oct 2019 21:04:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5188 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725887AbfJZBED (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 25 Oct 2019 21:04:03 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A0EAF6DA20EAAE861033;
        Sat, 26 Oct 2019 09:03:59 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Sat, 26 Oct 2019 09:03:53 +0800
From:   Tian Tao <tiantao6@huawei.com>
To:     <talel@amazon.com>, <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <daniel.lezcano@linaro.org>, <amit.kucheria@verdurent.com>,
        <linux-pm@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH] thermal: no need to set .owner when using module_platform_driver
Date:   Sat, 26 Oct 2019 09:04:35 +0800
Message-ID: <1572051875-35861-1-git-send-email-tiantao6@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

the module_platform_driver will call platform_driver_register.
and It will set the .owner to THIS_MODULE

Signed-off-by: Tian Tao <tiantao6@huawei.com>
---
 drivers/thermal/thermal_mmio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/thermal_mmio.c b/drivers/thermal/thermal_mmio.c
index 40524fa..d0bdf1e 100644
--- a/drivers/thermal/thermal_mmio.c
+++ b/drivers/thermal/thermal_mmio.c
@@ -110,7 +110,6 @@ static struct platform_driver thermal_mmio_driver = {
 	.probe = thermal_mmio_probe,
 	.driver = {
 		.name = "thermal-mmio",
-		.owner = THIS_MODULE,
 		.of_match_table = of_match_ptr(thermal_mmio_id_table),
 	},
 };
-- 
2.7.4

