Return-Path: <SRS0=5rfv=43=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61EDC10DCE
	for <linux-pm@archiver.kernel.org>; Tue, 10 Mar 2020 05:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796622071B
	for <linux-pm@archiver.kernel.org>; Tue, 10 Mar 2020 05:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgCJFys (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 10 Mar 2020 01:54:48 -0400
Received: from inva021.nxp.com ([92.121.34.21]:44138 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgCJFyr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Mar 2020 01:54:47 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4439F200431;
        Tue, 10 Mar 2020 06:54:46 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8A960200438;
        Tue, 10 Mar 2020 06:54:40 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 79D9B40245;
        Tue, 10 Mar 2020 13:54:33 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        abel.vesa@nxp.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] cpufreq: imx-cpufreq-dt: Correct i.MX8MP's market segment fuse location
Date:   Tue, 10 Mar 2020 13:48:16 +0800
Message-Id: <1583819296-7763-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

i.MX8MP's market segment fuse field is bit[6:5], correct it.

Fixes: 83fe39ad0a48 ("cpufreq: imx-cpufreq-dt: Add i.MX8MP support")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/cpufreq/imx-cpufreq-dt.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/imx-cpufreq-dt.c b/drivers/cpufreq/imx-cpufreq-dt.c
index 0e29d88..de206d2 100644
--- a/drivers/cpufreq/imx-cpufreq-dt.c
+++ b/drivers/cpufreq/imx-cpufreq-dt.c
@@ -19,6 +19,8 @@
 #define IMX8MN_OCOTP_CFG3_SPEED_GRADE_MASK	(0xf << 8)
 #define OCOTP_CFG3_MKT_SEGMENT_SHIFT    6
 #define OCOTP_CFG3_MKT_SEGMENT_MASK     (0x3 << 6)
+#define IMX8MP_OCOTP_CFG3_MKT_SEGMENT_SHIFT    5
+#define IMX8MP_OCOTP_CFG3_MKT_SEGMENT_MASK     (0x3 << 5)
 
 /* cpufreq-dt device registered by imx-cpufreq-dt */
 static struct platform_device *cpufreq_dt_pdev;
@@ -45,7 +47,13 @@ static int imx_cpufreq_dt_probe(struct platform_device *pdev)
 	else
 		speed_grade = (cell_value & OCOTP_CFG3_SPEED_GRADE_MASK)
 			      >> OCOTP_CFG3_SPEED_GRADE_SHIFT;
-	mkt_segment = (cell_value & OCOTP_CFG3_MKT_SEGMENT_MASK) >> OCOTP_CFG3_MKT_SEGMENT_SHIFT;
+
+	if (of_machine_is_compatible("fsl,imx8mp"))
+		mkt_segment = (cell_value & IMX8MP_OCOTP_CFG3_MKT_SEGMENT_MASK)
+			       >> IMX8MP_OCOTP_CFG3_MKT_SEGMENT_SHIFT;
+	else
+		mkt_segment = (cell_value & OCOTP_CFG3_MKT_SEGMENT_MASK)
+			       >> OCOTP_CFG3_MKT_SEGMENT_SHIFT;
 
 	/*
 	 * Early samples without fuses written report "0 0" which may NOT
-- 
2.7.4

