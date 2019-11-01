Return-Path: <SRS0=AJ/8=YZ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C683CA9ECF
	for <linux-pm@archiver.kernel.org>; Fri,  1 Nov 2019 17:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00D01218AC
	for <linux-pm@archiver.kernel.org>; Fri,  1 Nov 2019 17:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572628214;
	bh=l1Kko6zIKsqjrtUyfFoFoSSLPvcqDcVUr8D7mPoyI/o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=FYJdY+7T8mI90LGf03b4zWg4hW6K0Uov8dMHN6fBA7SF8SRPuhfV7tRuioTlq/KO8
	 mmLF9AnFbqEbb2mQshQLWebcmjPsOsCL1roysLU9Q/+m1jvdQW4fwWYddv9nvgffku
	 2SANNX0X1dwVMr5a7UzRuSCxw6ywSfF+UDw8i7ZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbfKARKG (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 1 Nov 2019 13:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728972AbfKARKG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 1 Nov 2019 13:10:06 -0400
Subject: Re: [GIT PULL] Power management fix for v5.4-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572628205;
        bh=l1Kko6zIKsqjrtUyfFoFoSSLPvcqDcVUr8D7mPoyI/o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oixOAemGXJkUMgcDz0DP0dherIA5VGu+vMPonMF/Vq3t7hzxeHfmC0eKVWgaXGTfs
         v5PvYL2LD3XOHZbkJ0FG0SmzpqTDKYahpVBGWfliUUSf03b8gpXMkGVRwXWZCEez+z
         sMEbu9w2VfPyVXNqA8XQKnrB16JqynmTJZoE7HyE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gSz1Pk=7u0s-cgjc9_0ibCyA6RNCcVHw7+GLWWoCj22g@mail.gmail.com>
References: <CAJZ5v0gSz1Pk=7u0s-cgjc9_0ibCyA6RNCcVHw7+GLWWoCj22g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gSz1Pk=7u0s-cgjc9_0ibCyA6RNCcVHw7+GLWWoCj22g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.4-rc6
X-PR-Tracked-Commit-Id: e82b7457909afd2e973ebd251ad79945d04ca376
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 65a5bf1c790039dc194507563478137b4314a59d
Message-Id: <157262820561.11375.9184455321473410481.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Nov 2019 17:10:05 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Thu, 31 Oct 2019 22:08:58 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.4-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/65a5bf1c790039dc194507563478137b4314a59d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
