Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CF3C43331
	for <linux-pm@archiver.kernel.org>; Tue, 22 Dec 2020 22:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE63A239A1
	for <linux-pm@archiver.kernel.org>; Tue, 22 Dec 2020 22:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgLVWYu (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 22 Dec 2020 17:24:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:49824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727790AbgLVWYp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Dec 2020 17:24:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 1F27022AAE;
        Tue, 22 Dec 2020 22:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608675845;
        bh=4JIaH7feDKV4qJ6/KQ+B2hn1+RkXXS52z+Fgf/kNx3o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WxR08dpHjNIzjlhscfrFcdgLTeGmcmp/v8EwuZC7CEo8T09labkNXxXttaVsQIpfE
         PMp3Imr2h9ShNXnHzIOx37BGhZhCiLNdwC42C0f3YGJcj4YQTQ+fS+llIN3BfLJvD+
         hsf9uHWGetLpNiRkETf/KvEAX3OFFedQl6XkfGbf31D6c8QmcLtsFLuZoigW8BTZ+B
         B4QR+xPekmKy4XOxwOY6eA9Sn9EZqZTYutaOGU292oTssfo2W/uH1hcotjKu+0xKmd
         KkKdgSKl4Oqero/IQWAXaJ31Zb3JHklV9JKH9GTZ58ITax96gfa6U8iiyBTgPxWSz1
         O0kvR0z1Sa04w==
Subject: Re: [GIT PULL] More power management updates for v5.11-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iS-Dv2iRkVGPhOLiP5-5D1vx+=9Nr7rtKtVbWmdrx=pg@mail.gmail.com>
References: <CAJZ5v0iS-Dv2iRkVGPhOLiP5-5D1vx+=9Nr7rtKtVbWmdrx=pg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iS-Dv2iRkVGPhOLiP5-5D1vx+=9Nr7rtKtVbWmdrx=pg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.11-rc1-2
X-PR-Tracked-Commit-Id: c3a74f8e25e97166ca0f954414825ae98a3209f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4960821a4d80781fd3e63cd71fb1b38c2dadb915
Message-Id: <160867584509.8550.9502654949229299177.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Dec 2020 22:24:05 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Tue, 22 Dec 2020 20:13:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.11-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4960821a4d80781fd3e63cd71fb1b38c2dadb915

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
