Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8258AC636C8
	for <linux-pm@archiver.kernel.org>; Tue, 20 Jul 2021 06:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 672FD61186
	for <linux-pm@archiver.kernel.org>; Tue, 20 Jul 2021 06:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbhGTFtf (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 20 Jul 2021 01:49:35 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:9104 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238037AbhGTFsp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jul 2021 01:48:45 -0400
X-Greylist: delayed 583 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Jul 2021 01:48:44 EDT
Received: from spf.mail.chinamobile.com (unknown[172.16.121.3]) by rmmx-syy-dmz-app12-12012 (RichMail) with SMTP id 2eec60f66ad00f9-39695; Tue, 20 Jul 2021 14:18:56 +0800 (CST)
X-RM-TRANSID: 2eec60f66ad00f9-39695
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.0.144.134])
        by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee260f66abc482-81c9c;
        Tue, 20 Jul 2021 14:18:56 +0800 (CST)
X-RM-TRANSID: 2ee260f66abc482-81c9c
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] power: supply: cpcap-battery: Use IS_ERR() to check and simplify code
Date:   Tue, 20 Jul 2021 14:18:36 +0800
Message-Id: <20210720061836.29148-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use IS_ERR() and PTR_ERR() instead of PTR_ERR_OR_ZERO() to
simplify code, avoid redundant judgements.

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/power/supply/cpcap-battery.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 90eba3646..7007e5d53 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -912,10 +912,9 @@ static int cpcap_battery_probe(struct platform_device *pdev)
 
 	ddata->psy = devm_power_supply_register(ddata->dev, psy_desc,
 						&psy_cfg);
-	error = PTR_ERR_OR_ZERO(ddata->psy);
-	if (error) {
+	if (IS_ERR(ddata->psy)) {
 		dev_err(ddata->dev, "failed to register power supply\n");
-		return error;
+		return PTR_ERR(ddata->psy);
 	}
 
 	atomic_set(&ddata->active, 1);
-- 
2.20.1.windows.1



