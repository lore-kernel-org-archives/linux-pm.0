Return-Path: <SRS0=mkYT=3T=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39CFC33C9E
	for <linux-pm@archiver.kernel.org>; Thu, 30 Jan 2020 10:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D755214AF
	for <linux-pm@archiver.kernel.org>; Thu, 30 Jan 2020 10:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgA3KFn (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 30 Jan 2020 05:05:43 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55036 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgA3KFn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jan 2020 05:05:43 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1ix6hd-00070v-NY; Thu, 30 Jan 2020 10:05:37 +0000
From:   Colin King <colin.king@canonical.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Pascal Paillet <p.paillet@st.com>, linux-pm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] thermal: stm32: fix spelling mistake "preprare" -> "prepare"
Date:   Thu, 30 Jan 2020 10:05:37 +0000
Message-Id: <20200130100537.18069-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_err error message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/thermal/st/stm_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index 1cc5e6c5709e..ad9e3bf8fdf6 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -535,7 +535,7 @@ static int stm_thermal_probe(struct platform_device *pdev)
 	/* Configure and enable HW sensor */
 	ret = stm_thermal_prepare(sensor);
 	if (ret) {
-		dev_err(&pdev->dev, "Error preprare sensor: %d\n", ret);
+		dev_err(&pdev->dev, "Error prepare sensor: %d\n", ret);
 		return ret;
 	}
 
-- 
2.24.0

