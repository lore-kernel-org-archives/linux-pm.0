Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F297EC433F5
	for <linux-pm@archiver.kernel.org>; Fri,  1 Apr 2022 10:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244369AbiDAKD3 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 1 Apr 2022 06:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239929AbiDAKD2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2022 06:03:28 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B4426D10C;
        Fri,  1 Apr 2022 03:01:39 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 1 Apr 2022
 18:01:38 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Fri, 1 Apr
 2022 18:01:36 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, "Len Brown" <len.brown@intel.com>
CC:     Haowen Bai <baihaowen@meizu.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] PM: hibernate: don't mark comment as kernel-doc
Date:   Fri, 1 Apr 2022 18:01:34 +0800
Message-ID: <1648807295-31682-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-124.meizu.com (172.16.1.124) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Change the comment to a normal (non-kernel-doc) comment to avoid
these kernel-doc warnings:

kernel/power/snapshot.c:335: warning: This comment starts with '/**', but
 isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Data types related to memory bitmaps.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 kernel/power/snapshot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 330d49937692..2a4d7d40161d 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -326,7 +326,7 @@ static void *chain_alloc(struct chain_allocator *ca, unsigned int size)
 	return ret;
 }
 
-/**
+/*
  * Data types related to memory bitmaps.
  *
  * Memory bitmap is a structure consisting of many linked lists of
-- 
2.7.4

