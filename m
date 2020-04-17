Return-Path: <SRS0=fGnz=6B=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452C0C38A2C
	for <linux-pm@archiver.kernel.org>; Fri, 17 Apr 2020 17:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D6B72076D
	for <linux-pm@archiver.kernel.org>; Fri, 17 Apr 2020 17:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587145537;
	bh=BrFJxrqYZDOkpsWsyLDZYY/0Rr6+g3mUhvsS9Jj8SQE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=XbzSySb94QCdhGz/eVitWg+Zm1Uig2uuvhmaO54B74vIGI7JH0t2D/QqTuI63Q/v7
	 id+LL3Fx3LBwkRAL76HZEpm081NtTYWrAusFHQ3AyXJ7P5BEGgjtfVmTokx8CrC/T3
	 v/DuoFkCdgoAYRWm6A4UF6FiTwnWifwlO/kyeduY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbgDQRpZ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 17 Apr 2020 13:45:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729966AbgDQRpX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 17 Apr 2020 13:45:23 -0400
Subject: Re: [GIT PULL] Power management update for v5.7-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587145523;
        bh=BrFJxrqYZDOkpsWsyLDZYY/0Rr6+g3mUhvsS9Jj8SQE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FUHf184zlq+5yZVvTDcARPDGsAZP0TH1NGY9eztIVblzupU1Qr4wjyMLmUNDiUJJk
         9pfS5lQwmW7yZqx+XpJJNYSKMxOJZQxct7B4/rzbjDpbVBNynr0Rv6nM/68t7hMCWY
         bv/5NMxcVxy3feib0c16X9OQ8dVKmzpXhdIA7RJc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hX7hayUrCD3JA8USBhYthRcKKxdu6Ru_EB49=pCYSGKg@mail.gmail.com>
References: <CAJZ5v0hX7hayUrCD3JA8USBhYthRcKKxdu6Ru_EB49=pCYSGKg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hX7hayUrCD3JA8USBhYthRcKKxdu6Ru_EB49=pCYSGKg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.7-rc2
X-PR-Tracked-Commit-Id: 2c127c46ec98ff0f1cdb236321bdd54e6e43fcf5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a32fe48bcc7956f55a1bd2a2799f37020f5a208
Message-Id: <158714552346.1625.3505718386073281658.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Apr 2020 17:45:23 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 17 Apr 2020 16:12:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.7-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a32fe48bcc7956f55a1bd2a2799f37020f5a208

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
