Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18613C4332B
	for <linux-pm@archiver.kernel.org>; Tue,  9 Mar 2021 13:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEE846525D
	for <linux-pm@archiver.kernel.org>; Tue,  9 Mar 2021 13:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhCINMz (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 9 Mar 2021 08:12:55 -0500
Received: from inva020.nxp.com ([92.121.34.13]:46912 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229916AbhCINM3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Mar 2021 08:12:29 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 789AB1A09B2;
        Tue,  9 Mar 2021 14:12:28 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4D7F41A1018;
        Tue,  9 Mar 2021 14:12:22 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id EAFBF4031B;
        Tue,  9 Mar 2021 14:12:12 +0100 (CET)
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, abel.vesa@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 05/11] PM / devfreq: use more accurate returned new_freq as resume_freq
Date:   Tue,  9 Mar 2021 20:58:35 +0800
Message-Id: <1615294733-22761-6-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use the more accurate returned new_freq as resume_freq.
It's the same as how devfreq->previous_freq was updated.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 6e80bf70e7b3..ce569bd9adfa 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -390,7 +390,7 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
 	devfreq->previous_freq = new_freq;
 
 	if (devfreq->suspend_freq)
-		devfreq->resume_freq = cur_freq;
+		devfreq->resume_freq = new_freq;
 
 	return err;
 }
-- 
2.25.1

