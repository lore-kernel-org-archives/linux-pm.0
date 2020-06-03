Return-Path: <SRS0=265P=7Q=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0A4C433E0
	for <linux-pm@archiver.kernel.org>; Wed,  3 Jun 2020 17:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24E6520679
	for <linux-pm@archiver.kernel.org>; Wed,  3 Jun 2020 17:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgFCRVc (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:21:32 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:46474 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725956AbgFCRVc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jun 2020 13:21:32 -0400
X-Greylist: delayed 3598 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jun 2020 13:21:31 EDT
Received: from [78.134.115.170] (port=59756 helo=melee.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jgW8w-004Hm1-MC; Wed, 03 Jun 2020 18:21:30 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-pm@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] power: reset: gpio-poweroff: add missing '\n' in dev_err()
Date:   Wed,  3 Jun 2020 18:21:18 +0200
Message-Id: <20200603162118.14403-1-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

dev_err() needs a terminating newline.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 drivers/power/reset/gpio-poweroff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/gpio-poweroff.c b/drivers/power/reset/gpio-poweroff.c
index 6a4bbb506551..c5067eb75370 100644
--- a/drivers/power/reset/gpio-poweroff.c
+++ b/drivers/power/reset/gpio-poweroff.c
@@ -54,7 +54,7 @@ static int gpio_poweroff_probe(struct platform_device *pdev)
 	/* If a pm_power_off function has already been added, leave it alone */
 	if (pm_power_off != NULL) {
 		dev_err(&pdev->dev,
-			"%s: pm_power_off function already registered",
+			"%s: pm_power_off function already registered\n",
 		       __func__);
 		return -EBUSY;
 	}
-- 
2.26.2

