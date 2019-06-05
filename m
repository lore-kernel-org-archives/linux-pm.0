Return-Path: <SRS0=jn4m=UE=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D292C28D18
	for <linux-pm@archiver.kernel.org>; Wed,  5 Jun 2019 10:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC33120717
	for <linux-pm@archiver.kernel.org>; Wed,  5 Jun 2019 10:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfFEKhR (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 5 Jun 2019 06:37:17 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60736 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727161AbfFEKhR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Jun 2019 06:37:17 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 161BB20077D;
        Wed,  5 Jun 2019 12:37:14 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 13D4F200774;
        Wed,  5 Jun 2019 12:37:14 +0200 (CEST)
Received: from jana.ea.freescale.net (gw_auto.ea.freescale.net [10.171.94.100])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 881EC205FA;
        Wed,  5 Jun 2019 12:37:13 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Jacky Bai <ping.bai@nxp.com>, Anson Huang <Anson.Huang@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/5] cpufreq: Switch imx7d to imx-cpufreq-dt for speed grading
Date:   Wed,  5 Jun 2019 13:37:06 +0300
Message-Id: <2aa88cb05427d39a005f7315632a9ce2ed92ed6d.1559730963.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1559730963.git.leonard.crestez@nxp.com>
References: <cover.1559730963.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1559730963.git.leonard.crestez@nxp.com>
References: <cover.1559730963.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This driver can handle speed grading bits on imx7d just like on imx8mq
and imx8mm.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 19c1aad57e26..eb282dff9f2c 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -38,11 +38,10 @@ static const struct of_device_id whitelist[] __initconst = {
 	{ .compatible = "hisilicon,hi3660", },
 
 	{ .compatible = "fsl,imx27", },
 	{ .compatible = "fsl,imx51", },
 	{ .compatible = "fsl,imx53", },
-	{ .compatible = "fsl,imx7d", },
 
 	{ .compatible = "marvell,berlin", },
 	{ .compatible = "marvell,pxa250", },
 	{ .compatible = "marvell,pxa270", },
 
@@ -106,10 +105,11 @@ static const struct of_device_id whitelist[] __initconst = {
  */
 static const struct of_device_id blacklist[] __initconst = {
 	{ .compatible = "calxeda,highbank", },
 	{ .compatible = "calxeda,ecx-2000", },
 
+	{ .compatible = "fsl,imx7d", },
 	{ .compatible = "fsl,imx8mq", },
 	{ .compatible = "fsl,imx8mm", },
 
 	{ .compatible = "marvell,armadaxp", },
 
-- 
2.7.4

