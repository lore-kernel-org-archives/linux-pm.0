Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258C3C433FE
	for <linux-pm@archiver.kernel.org>; Wed,  8 Sep 2021 07:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05BE761167
	for <linux-pm@archiver.kernel.org>; Wed,  8 Sep 2021 07:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349261AbhIHHOq (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 8 Sep 2021 03:14:46 -0400
Received: from mx20.baidu.com ([111.202.115.85]:59702 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349496AbhIHHOa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 03:14:30 -0400
Received: from BC-Mail-Ex25.internal.baidu.com (unknown [172.31.51.19])
        by Forcepoint Email with ESMTPS id 4E0FB2095F22EE5E22ED;
        Wed,  8 Sep 2021 15:13:21 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex25.internal.baidu.com (172.31.51.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Wed, 8 Sep 2021 15:13:21 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 8 Sep 2021 15:13:20 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Santosh Shilimkar <ssantosh@kernel.org>,
        Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH 2/3] soc: ti: smartreflex: Make use of the helper function devm_platform_ioremap_resource()
Date:   Wed, 8 Sep 2021 15:13:08 +0800
Message-ID: <20210908071310.432-2-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210908071310.432-1-caihuoqing@baidu.com>
References: <20210908071310.432-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex11.internal.baidu.com (10.127.64.34) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use the devm_platform_ioremap_resource() helper instead of
calling platform_get_resource() and devm_ioremap_resource()
separately

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/soc/ti/smartreflex.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/ti/smartreflex.c b/drivers/soc/ti/smartreflex.c
index b5b2fa538d5c..fabbc9f16a3e 100644
--- a/drivers/soc/ti/smartreflex.c
+++ b/drivers/soc/ti/smartreflex.c
@@ -819,7 +819,7 @@ static int omap_sr_probe(struct platform_device *pdev)
 {
 	struct omap_sr *sr_info;
 	struct omap_sr_data *pdata = pdev->dev.platform_data;
-	struct resource *mem, *irq;
+	struct resource *irq;
 	struct dentry *nvalue_dir;
 	int i, ret = 0;
 
@@ -839,8 +839,7 @@ static int omap_sr_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	sr_info->base = devm_ioremap_resource(&pdev->dev, mem);
+	sr_info->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sr_info->base))
 		return PTR_ERR(sr_info->base);
 
-- 
2.25.1

