Return-Path: <SRS0=erbm=BV=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BC2C433DF
	for <linux-pm@archiver.kernel.org>; Tue, 11 Aug 2020 07:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 380FC2078E
	for <linux-pm@archiver.kernel.org>; Tue, 11 Aug 2020 07:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgHKHEr (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 11 Aug 2020 03:04:47 -0400
Received: from inva020.nxp.com ([92.121.34.13]:41848 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727915AbgHKHEq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Aug 2020 03:04:46 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 558E41A1E6B;
        Tue, 11 Aug 2020 09:04:44 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CA3DF1A08C8;
        Tue, 11 Aug 2020 09:04:39 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 045DF402A5;
        Tue, 11 Aug 2020 09:04:33 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 2/2] thermal: imx8mm: Use dev_err_probe() to simplify error handling
Date:   Tue, 11 Aug 2020 14:59:45 +0800
Message-Id: <1597129185-8460-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597129185-8460-1-git-send-email-Anson.Huang@nxp.com>
References: <1597129185-8460-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

dev_err_probe() can reduce code size, uniform error handling and record the
defer probe reason etc., use it to simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V1:
	- remove redundant return value print.
---
 drivers/thermal/imx8mm_thermal.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index f5124f1..a1e4f9b 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -146,13 +146,9 @@ static int imx8mm_tmu_probe(struct platform_device *pdev)
 		return PTR_ERR(tmu->base);
 
 	tmu->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(tmu->clk)) {
-		ret = PTR_ERR(tmu->clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"failed to get tmu clock: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(tmu->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(tmu->clk),
+				     "failed to get tmu clock\n");
 
 	ret = clk_prepare_enable(tmu->clk);
 	if (ret) {
-- 
2.7.4

