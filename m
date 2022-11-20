Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8FAC43217
	for <linux-pm@archiver.kernel.org>; Sun, 20 Nov 2022 12:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiKTMfJ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 20 Nov 2022 07:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKTMfI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Nov 2022 07:35:08 -0500
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5713C261E
        for <linux-pm@vger.kernel.org>; Sun, 20 Nov 2022 04:35:07 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id wjXMofNQANKuIwjXMoFRmK; Sun, 20 Nov 2022 13:35:05 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 20 Nov 2022 13:35:05 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH] interconnect: qcom: icc-rpmh: Fix an error handling path in qcom_icc_rpmh_probe()
Date:   Sun, 20 Nov 2022 13:35:03 +0100
Message-Id: <ec929c37c655ede7bb42e426354093c8a1377a0b.1668947686.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If of_platform_populate() fails, some resources need to be freed as already
done in the other error handling paths.

Fixes: 57eb14779dfd ("interconnect: qcom: icc-rpmh: Support child NoC device probe")

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/interconnect/qcom/icc-rpmh.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index fd17291c61eb..5168bbf3d92f 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -235,8 +235,11 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, qp);
 
 	/* Populate child NoC devices if any */
-	if (of_get_child_count(dev->of_node) > 0)
-		return of_platform_populate(dev->of_node, NULL, NULL, dev);
+	if (of_get_child_count(dev->of_node) > 0) {
+		ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
+		if (ret)
+			goto err;
+	}
 
 	return 0;
 err:
-- 
2.34.1

