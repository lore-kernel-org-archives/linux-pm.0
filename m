Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9193C433DB
	for <linux-pm@archiver.kernel.org>; Thu, 25 Mar 2021 11:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A209561A4B
	for <linux-pm@archiver.kernel.org>; Thu, 25 Mar 2021 11:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhCYL0A (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 25 Mar 2021 07:26:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230115AbhCYLZ1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Mar 2021 07:25:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A040B61A2F;
        Thu, 25 Mar 2021 11:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616671527;
        bh=5lkXy9QAJUzflm//ImAiJZsaODEjkF9zLcTFNlU8a1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lHcXKmpzXmyNSH/C0k1VMriScIicrOfVVOR2XR4Ukylkx9SkreT4bPReZb4FjyqhF
         HzYFzU+3sBwaPFIPXeU5BJmNuTnv+ipF+6sX1Eskja2/2LFgv/Mu9NZ8LGoBu2XwD4
         sQslW8KFkiHHQTX0wR0Jnm1CDUE/R6cTrTxtp2enucrQeVCeOGBle3DZyfXk0Cl8v9
         eCf6SROJ/KgXUz2DfAtHEnFWTLcyUTmDw6LtwG0dtYFdv0HYSvBQJdNZVX3tvEPz8p
         PY2KK59F8NJF5dh0mAE0ASOO7Z92as69lMPFrHOGUKTRPVhHJ58ax2yxc7NHDZbKSV
         /NAjMHsNgcLtQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.11 21/44] kernel: freezer should treat PF_IO_WORKER like PF_KTHREAD for freezing
Date:   Thu, 25 Mar 2021 07:24:36 -0400
Message-Id: <20210325112459.1926846-21-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210325112459.1926846-1-sashal@kernel.org>
References: <20210325112459.1926846-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit 15b2219facadec583c24523eed40fa45865f859f ]

Don't send fake signals to PF_IO_WORKER threads, they don't accept
signals. Just treat them like kthreads in this regard, all they need
is a wakeup as no forced kernel/user transition is needed.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/freezer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/freezer.c b/kernel/freezer.c
index dc520f01f99d..1a2d57d1327c 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -134,7 +134,7 @@ bool freeze_task(struct task_struct *p)
 		return false;
 	}
 
-	if (!(p->flags & PF_KTHREAD))
+	if (!(p->flags & (PF_KTHREAD | PF_IO_WORKER)))
 		fake_signal_wake_up(p);
 	else
 		wake_up_state(p, TASK_INTERRUPTIBLE);
-- 
2.30.1

