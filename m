Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC01C07E9D
	for <linux-pm@archiver.kernel.org>; Sat, 24 Sep 2022 01:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbiIXBQh (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 23 Sep 2022 21:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiIXBQg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Sep 2022 21:16:36 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EB813A948;
        Fri, 23 Sep 2022 18:16:32 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MZ9yy1ZTTzHqSK;
        Sat, 24 Sep 2022 09:14:18 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 09:16:30 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 24 Sep
 2022 09:16:29 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@somainline.org>, <djakov@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC:     <krzysztof.kozlowski@linaro.org>, <shangxiaojing@huawei.com>
Subject: [PATCH -next v2] interconnect: qcom: icc-rpm: Remove redundant dev_err call
Date:   Sat, 24 Sep 2022 09:50:43 +0800
Message-ID: <20220924015043.25130-1-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

devm_ioremap_resource() prints error message in itself. Remove the
dev_err call to avoid redundant error message.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
changes in v2:
- delete the empty line
---
 drivers/interconnect/qcom/icc-rpm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 39e43b957599..ba6781f54ab7 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -477,11 +477,8 @@ int qnoc_probe(struct platform_device *pdev)
 		}
 
 		mmio = devm_ioremap_resource(dev, res);
-
-		if (IS_ERR(mmio)) {
-			dev_err(dev, "Cannot ioremap interconnect bus resource\n");
+		if (IS_ERR(mmio))
 			return PTR_ERR(mmio);
-		}
 
 		qp->regmap = devm_regmap_init_mmio(dev, mmio, desc->regmap_cfg);
 		if (IS_ERR(qp->regmap)) {
-- 
2.17.1

