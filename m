Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2F7C433E9
	for <linux-pm@archiver.kernel.org>; Tue,  9 Mar 2021 13:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D896765259
	for <linux-pm@archiver.kernel.org>; Tue,  9 Mar 2021 13:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhCINM7 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 9 Mar 2021 08:12:59 -0500
Received: from inva021.nxp.com ([92.121.34.21]:58250 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230473AbhCINMo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Mar 2021 08:12:44 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 256B3200FA9;
        Tue,  9 Mar 2021 14:12:43 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F15C2200FC7;
        Tue,  9 Mar 2021 14:12:36 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 1372240310;
        Tue,  9 Mar 2021 14:12:28 +0100 (CET)
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, abel.vesa@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 04/11] PM / devfreq: bail out early if no freq changes in devfreq_set_target
Date:   Tue,  9 Mar 2021 20:58:46 +0800
Message-Id: <1615294733-22761-17-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It's unnecessary to set the same freq again and run notifier calls.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/devfreq/devfreq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index bf3047896e41..6e80bf70e7b3 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -358,6 +358,9 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
 	else
 		cur_freq = devfreq->previous_freq;
 
+	if (new_freq == cur_freq)
+		return 0;
+
 	freqs.old = cur_freq;
 	freqs.new = new_freq;
 	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
@@ -374,7 +377,7 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
 	 * and DEVFREQ_POSTCHANGE because for showing the correct frequency
 	 * change order of between devfreq device and passive devfreq device.
 	 */
-	if (trace_devfreq_frequency_enabled() && new_freq != cur_freq)
+	if (trace_devfreq_frequency_enabled())
 		trace_devfreq_frequency(devfreq, new_freq, cur_freq);
 
 	freqs.new = new_freq;
-- 
2.25.1

