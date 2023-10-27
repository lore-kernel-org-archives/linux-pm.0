Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70857C25B6B
	for <linux-pm@archiver.kernel.org>; Fri, 27 Oct 2023 01:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjJ0B4A (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 26 Oct 2023 21:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJ0Bz7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Oct 2023 21:55:59 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id F0F18AB;
        Thu, 26 Oct 2023 18:55:56 -0700 (PDT)
Received: from localhost.localdomain (unknown [219.141.250.2])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 6CCE26027ECD5;
        Fri, 27 Oct 2023 09:55:40 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From:   Li zeming <zeming@nfschina.com>
To:     rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li zeming <zeming@nfschina.com>
Subject: [PATCH] power: swap: Assign a value when removing the 'error' definition
Date:   Fri, 27 Oct 2023 09:55:33 +0800
Message-Id: <20231027015533.25391-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

'error' first receives the function result before it is used, and it
does not need to be assigned a value during definition.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 kernel/power/swap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 74edbce2320ba..90bb583c57bf7 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -450,7 +450,7 @@ static int get_swap_writer(struct swap_map_handle *handle)
 static int swap_write_page(struct swap_map_handle *handle, void *buf,
 		struct hib_bio_batch *hb)
 {
-	int error = 0;
+	int error;
 	sector_t offset;
 
 	if (!handle->cur)
-- 
2.18.2

