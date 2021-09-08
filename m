Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E39AC433EF
	for <linux-pm@archiver.kernel.org>; Wed,  8 Sep 2021 07:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 421C461168
	for <linux-pm@archiver.kernel.org>; Wed,  8 Sep 2021 07:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351000AbhIHHsb (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 8 Sep 2021 03:48:31 -0400
Received: from mx21.baidu.com ([220.181.3.85]:39628 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347718AbhIHHsM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 03:48:12 -0400
Received: from BC-Mail-Ex31.internal.baidu.com (unknown [172.31.51.25])
        by Forcepoint Email with ESMTPS id DDA0AC918649E85983D4;
        Wed,  8 Sep 2021 15:47:01 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex31.internal.baidu.com (172.31.51.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Wed, 8 Sep 2021 15:47:01 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 8 Sep 2021 15:47:01 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Niklas Cassel <nks@flawful.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/6] soc: qcom: ocmem: Make use of the helper function devm_platform_ioremap_resource_byname()
Date:   Wed, 8 Sep 2021 15:46:49 +0800
Message-ID: <20210908074651.1025-2-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210908074651.1025-1-caihuoqing@baidu.com>
References: <20210908074651.1025-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex09.internal.baidu.com (172.31.51.49) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use the devm_platform_ioremap_resource_byname() helper instead of
calling platform_get_resource_byname() and devm_ioremap_resource()
separately

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/soc/qcom/ocmem.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/ocmem.c b/drivers/soc/qcom/ocmem.c
index f1875dc31ae2..d2dacbbaafbd 100644
--- a/drivers/soc/qcom/ocmem.c
+++ b/drivers/soc/qcom/ocmem.c
@@ -300,7 +300,6 @@ static int ocmem_dev_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	unsigned long reg, region_size;
 	int i, j, ret, num_banks;
-	struct resource *res;
 	struct ocmem *ocmem;
 
 	if (!qcom_scm_is_available())
@@ -321,8 +320,7 @@ static int ocmem_dev_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctrl");
-	ocmem->mmio = devm_ioremap_resource(&pdev->dev, res);
+	ocmem->mmio = devm_platform_ioremap_resource_byname(pdev, "ctrl");
 	if (IS_ERR(ocmem->mmio)) {
 		dev_err(&pdev->dev, "Failed to ioremap ocmem_ctrl resource\n");
 		return PTR_ERR(ocmem->mmio);
-- 
2.25.1

