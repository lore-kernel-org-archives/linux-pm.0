Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78B7C433E0
	for <linux-pm@archiver.kernel.org>; Thu, 25 Mar 2021 11:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB90561A79
	for <linux-pm@archiver.kernel.org>; Thu, 25 Mar 2021 11:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhCYL1j (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 25 Mar 2021 07:27:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231173AbhCYL0f (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Mar 2021 07:26:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BBE661A38;
        Thu, 25 Mar 2021 11:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616671586;
        bh=5lkXy9QAJUzflm//ImAiJZsaODEjkF9zLcTFNlU8a1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R975u3c4jKZ6vIPPk6VxOwk0mzdmhgSgIojkxzs8GfAyO+oi0RNHNvPPhCd85g2yj
         +U5YxMfKA5lbmANcxJ+fZFmwlxbzMUoGA5Owd7AUSne6FTAYxXxCMnnF8W0GUTm1kY
         MVThrKqok9k2rDc/gxMB8zv35shLHMyiNriKGGvi376Pvupk69BcP8p6+wlSAvhJCv
         hy19U3/HH3c1T6qFTE5F04KklEBpZJzPhDd+4u8eY00cX6SmkHCCvUN7fd8KFdNRYY
         2BJSjYL+G1SEnk6UgdEnHSWTdGPDu3KbIYzAaMI+Xzvz+jeh8894wiMJcFVE3EpQ1C
         +P/LOs+jevxBw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 20/39] kernel: freezer should treat PF_IO_WORKER like PF_KTHREAD for freezing
Date:   Thu, 25 Mar 2021 07:25:39 -0400
Message-Id: <20210325112558.1927423-20-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210325112558.1927423-1-sashal@kernel.org>
References: <20210325112558.1927423-1-sashal@kernel.org>
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

