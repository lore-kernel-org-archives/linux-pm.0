Return-Path: <SRS0=Sohe=TC=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF1CC43219
	for <linux-pm@archiver.kernel.org>; Thu,  2 May 2019 18:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9843C204FD
	for <linux-pm@archiver.kernel.org>; Thu,  2 May 2019 18:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfEBSkT (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 2 May 2019 14:40:19 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42054 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfEBSkT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2019 14:40:19 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gportay)
        with ESMTPSA id 9E3AF263A2A
From:   =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org
Cc:     =?utf-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>
Subject: [PATCH] PM / devfreq: rk3399_dmc: Fix spelling typo
Date:   Thu,  2 May 2019 14:40:13 -0400
Message-Id: <20190502184013.11836-1-gael.portay@collabora.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Reorder 'i' and 'v' in "drvier".

Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
---
 drivers/devfreq/rk3399_dmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index e795ad2b3f6b..0d6d77b1a779 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -336,7 +336,7 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 
 	/*
 	 * Get dram timing and pass it to arm trust firmware,
-	 * the dram drvier in arm trust firmware will get these
+	 * the dram driver in arm trust firmware will get these
 	 * timing and to do dram initial.
 	 */
 	if (!of_get_ddr_timings(&data->timing, np)) {
-- 
2.21.0

