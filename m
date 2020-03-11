Return-Path: <SRS0=+pCq=44=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FF2C10F27
	for <linux-pm@archiver.kernel.org>; Wed, 11 Mar 2020 09:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75E62192A
	for <linux-pm@archiver.kernel.org>; Wed, 11 Mar 2020 09:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgCKJIV (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 11 Mar 2020 05:08:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:41164 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728637AbgCKJIV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Mar 2020 05:08:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BC7EAAE85;
        Wed, 11 Mar 2020 09:08:19 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH] power: twl4030: Use scnprintf() for avoiding potential buffer overflow
Date:   Wed, 11 Mar 2020 10:08:18 +0100
Message-Id: <20200311090818.20797-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/power/supply/twl4030_charger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index 648ab80288c9..1bc49b2e12e8 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -726,10 +726,10 @@ twl4030_bci_mode_show(struct device *dev,
 
 	for (i = 0; i < ARRAY_SIZE(modes); i++)
 		if (mode == i)
-			len += snprintf(buf+len, PAGE_SIZE-len,
+			len += scnprintf(buf+len, PAGE_SIZE-len,
 					"[%s] ", modes[i]);
 		else
-			len += snprintf(buf+len, PAGE_SIZE-len,
+			len += scnprintf(buf+len, PAGE_SIZE-len,
 					"%s ", modes[i]);
 	buf[len-1] = '\n';
 	return len;
-- 
2.16.4

