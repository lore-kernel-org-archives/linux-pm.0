Return-Path: <SRS0=1vxP=7N=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53398C433E1
	for <linux-pm@archiver.kernel.org>; Sun, 31 May 2020 21:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 370A6206A1
	for <linux-pm@archiver.kernel.org>; Sun, 31 May 2020 21:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgEaVBG (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 31 May 2020 17:01:06 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:19266 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbgEaVBG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 31 May 2020 17:01:06 -0400
Received: from localhost.localdomain ([93.23.14.197])
        by mwinf5d54 with ME
        id lZ112200V4F5j3x03Z12Co; Sun, 31 May 2020 23:01:04 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 31 May 2020 23:01:04 +0200
X-ME-IP: 93.23.14.197
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] kernel: power: swap: mark a function as __init to save some memory
Date:   Sun, 31 May 2020 23:00:59 +0200
Message-Id: <20200531210059.647066-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

'swsusp_header_init()' is only called via 'core_initcall'.
It can be marked as __init to save a few bytes of memory.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 kernel/power/swap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index ca0fcb5ced71..01e2858b5fe3 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -1590,7 +1590,7 @@ int swsusp_unmark(void)
 }
 #endif
 
-static int swsusp_header_init(void)
+static int __init swsusp_header_init(void)
 {
 	swsusp_header = (struct swsusp_header*) __get_free_page(GFP_KERNEL);
 	if (!swsusp_header)
-- 
2.25.1

