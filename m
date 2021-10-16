Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B77C4332F
	for <linux-pm@archiver.kernel.org>; Sat, 16 Oct 2021 16:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C01546101E
	for <linux-pm@archiver.kernel.org>; Sat, 16 Oct 2021 16:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240673AbhJPQZa (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 16 Oct 2021 12:25:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240691AbhJPQZ3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 16 Oct 2021 12:25:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 436F36109E;
        Sat, 16 Oct 2021 16:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634401401;
        bh=kAXHDn40F45bVmPuALqF4C5OchrVOee+Yyq4VWxsvko=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cquUhFFs+F+/PSY8GO67EefKPM4Ez+yEQQ8QosKE6QDcPqAYNOk7hYxCd0qEpHS8g
         0NIOYUso2Ezi8eZzCqM10QE+rJNf6/H/1x2XF8qtxs8jUBIPSEbSKdNXPR2XrRWvqY
         mHOi1wOiFCqa0nG7e8SjDDDi94v3vqnHN4eSZD4vQdljHjF7QdRK3Dz//JiND8OKZk
         mdDtptR+/COalrulHfUt6/CyfHgmsFURdcJGkxVERrxe9sHD+KKpudTLdMTNjuZwcc
         +n/DlROAmvQid2NDh7x46Ii7TAMFuQB0GAxZuqBr2IB229a57c1ihKBFJZMRgjDNhQ
         7xIM2RIgj2DvA==
Subject: Re: [GIT PULL] ACPI fix for v5.15-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jyqT335x5iB1HWnESR5OZbitHQqc369rffhkO4h3wMCQ@mail.gmail.com>
References: <CAJZ5v0jyqT335x5iB1HWnESR5OZbitHQqc369rffhkO4h3wMCQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jyqT335x5iB1HWnESR5OZbitHQqc369rffhkO4h3wMCQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.15-rc6
X-PR-Tracked-Commit-Id: 1ea1dbf1f54c3345072c963b3acf8830e2468c1b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 711c3686676eed0f88d494a187261e6a96c932b1
Message-Id: <163440140124.26929.9690863969001761560.pr-tracker-bot@kernel.org>
Date:   Sat, 16 Oct 2021 16:23:21 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 15 Oct 2021 20:19:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.15-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/711c3686676eed0f88d494a187261e6a96c932b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
