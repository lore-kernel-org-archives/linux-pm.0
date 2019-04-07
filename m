Return-Path: <SRS0=LXM6=SJ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93794C282DD
	for <linux-pm@archiver.kernel.org>; Sun,  7 Apr 2019 18:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711222084F
	for <linux-pm@archiver.kernel.org>; Sun,  7 Apr 2019 18:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfDGSNL (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 7 Apr 2019 14:13:11 -0400
Received: from muru.com ([72.249.23.125]:44706 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbfDGSNK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 7 Apr 2019 14:13:10 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id A991B818C;
        Sun,  7 Apr 2019 18:13:25 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 7/7] power: supply: cpcap-charger: Fix pointless EPROBE_DEFER warnings
Date:   Sun,  7 Apr 2019 11:12:54 -0700
Message-Id: <20190407181254.64537-8-tony@atomide.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190407181254.64537-1-tony@atomide.com>
References: <20190407181254.64537-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

With loadable modules we may get the following during init:

could not initialize VBUS or ID IIO: -517

Let's not print any pointless error messages for deferred probe.

Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-charger.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -574,8 +574,9 @@ static int cpcap_charger_init_iio(struct cpcap_charger_ddata *ddata)
 	return 0;
 
 out_err:
-	dev_err(ddata->dev, "could not initialize VBUS or ID IIO: %i\n",
-		error);
+	if (error != -EPROBE_DEFER)
+		dev_err(ddata->dev, "could not initialize VBUS or ID IIO: %i\n",
+			error);
 
 	return error;
 }
-- 
2.21.0
