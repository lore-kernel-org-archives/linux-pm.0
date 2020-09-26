Return-Path: <SRS0=Pe0A=DD=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B04DC4727D
	for <linux-pm@archiver.kernel.org>; Sat, 26 Sep 2020 02:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 441FE20866
	for <linux-pm@archiver.kernel.org>; Sat, 26 Sep 2020 02:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbgIZCQh (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 25 Sep 2020 22:16:37 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37518 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727495AbgIZCQh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 25 Sep 2020 22:16:37 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8D543AB9E90372DA0D49;
        Sat, 26 Sep 2020 10:16:31 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Sat, 26 Sep 2020
 10:16:21 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <amitk@kernel.org>, <rui.zhang@intel.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH v2 -next] drivers: thermal: tsens: fix missing put_device error
Date:   Sat, 26 Sep 2020 10:17:26 +0800
Message-ID: <20200926021726.2370085-1-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fixes coccicheck error:

drivers/thermal/qcom/tsens.c:759:4-10: ERROR: missing put_device; call of_find_device_by_node on line 715, but without a corresponding object release within this function.

Fixes: a7ff82976122 ("drivers: thermal: tsens: Merge tsens-common.c into tsens.c")
Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---

v1->v2: fix compile error, sorry for the mistake

 drivers/thermal/qcom/tsens.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index d8ce3a687b80..3c4c0516e58a 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -755,8 +755,10 @@ int __init init_common(struct tsens_priv *priv)
 		for (i = VER_MAJOR; i <= VER_STEP; i++) {
 			priv->rf[i] = devm_regmap_field_alloc(dev, priv->srot_map,
 							      priv->fields[i]);
-			if (IS_ERR(priv->rf[i]))
-				return PTR_ERR(priv->rf[i]);
+			if (IS_ERR(priv->rf[i])) {
+				ret = PTR_ERR(priv->rf[i]);
+				goto err_put_device;
+			}
 		}
 		ret = regmap_field_read(priv->rf[VER_MINOR], &ver_minor);
 		if (ret)
--
2.25.4

