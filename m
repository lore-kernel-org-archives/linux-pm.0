Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75A9C001C7
	for <linux-pm@archiver.kernel.org>; Tue,  9 Mar 2021 13:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E1DE6514A
	for <linux-pm@archiver.kernel.org>; Tue,  9 Mar 2021 13:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhCINNA (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 9 Mar 2021 08:13:00 -0500
Received: from inva020.nxp.com ([92.121.34.13]:47282 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230483AbhCINMr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Mar 2021 08:12:47 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F11DE1A1013;
        Tue,  9 Mar 2021 14:12:45 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CD31E1A09B2;
        Tue,  9 Mar 2021 14:12:39 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B153940339;
        Tue,  9 Mar 2021 14:12:31 +0100 (CET)
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, abel.vesa@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 06/11] PM / devfreq: drop the unnecessary low variable initialization
Date:   Tue,  9 Mar 2021 20:58:48 +0800
Message-Id: <1615294733-22761-19-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

drop the unnecessary low variable initialization and make the return
more straightforward.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/devfreq/devfreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index ce569bd9adfa..7231fe6862a2 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -351,7 +351,7 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
 {
 	struct devfreq_freqs freqs;
 	unsigned long cur_freq;
-	int err = 0;
+	int err;
 
 	if (devfreq->profile->get_cur_freq)
 		devfreq->profile->get_cur_freq(devfreq->dev.parent, &cur_freq);
@@ -392,7 +392,7 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
 	if (devfreq->suspend_freq)
 		devfreq->resume_freq = new_freq;
 
-	return err;
+	return 0;
 }
 
 /**
-- 
2.25.1

