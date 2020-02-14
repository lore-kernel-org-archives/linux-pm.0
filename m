Return-Path: <SRS0=AHLa=4C=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F3EC2BA83
	for <linux-pm@archiver.kernel.org>; Fri, 14 Feb 2020 14:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1DC2187F
	for <linux-pm@archiver.kernel.org>; Fri, 14 Feb 2020 14:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgBNOGe (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 14 Feb 2020 09:06:34 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:51365 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729092AbgBNOGd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Feb 2020 09:06:33 -0500
Received: from localhost (lfbn-lyo-1-1670-129.w90-65.abo.wanadoo.fr [90.65.102.129])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 1E400200014;
        Fri, 14 Feb 2020 14:06:32 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] PM / hibernate: fix typo "reserverd_size" -> "reserved_size"
Date:   Fri, 14 Feb 2020 15:06:21 +0100
Message-Id: <20200214140621.19796-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix a mistake in a variable name in a comment.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 kernel/power/snapshot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index ddade80ad276..d82b7b88d616 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1681,7 +1681,7 @@ static unsigned long minimum_image_size(unsigned long saveable)
  * hibernation for allocations made while saving the image and for device
  * drivers, in case they need to allocate memory from their hibernation
  * callbacks (these two numbers are given by PAGES_FOR_IO (which is a rough
- * estimate) and reserverd_size divided by PAGE_SIZE (which is tunable through
+ * estimate) and reserved_size divided by PAGE_SIZE (which is tunable through
  * /sys/power/reserved_size, respectively).  To make this happen, we compute the
  * total number of available page frames and allocate at least
  *
-- 
2.24.1

