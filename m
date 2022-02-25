Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19D2C433F5
	for <linux-pm@archiver.kernel.org>; Fri, 25 Feb 2022 20:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236999AbiBYUpE (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 25 Feb 2022 15:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236961AbiBYUpE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Feb 2022 15:45:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5F31AAFFE;
        Fri, 25 Feb 2022 12:44:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B00761A05;
        Fri, 25 Feb 2022 20:44:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CEBDC340E8;
        Fri, 25 Feb 2022 20:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645821870;
        bh=3WvmoK4cfCHhUZncJUwgRmNS10Feq/ziaKRMJlpNL2Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IJyGIWcUunKHY/gPqbb/X6Cvx0m9+IF4wBTkBj07CHKftpV4QIw7/FDUwO8dIwc5/
         jFUyKCkssmc5/rPviCK4qgy7r7IUImko5TLPfgaWYumLiml3ggKgUMYckJlzKYhHDE
         fbbAthwWWZr5MbcbVOQzUaVSE6utDNQ7+AChZ8wGaMMKhd0YvIaBfeKc2Az1vaKnSo
         lsqX/vIWtbBesgMVuTh+3K+BID6ooOZU2a0Un14IJKXeP9fv9QFHoQ1lyrcNBq1RfG
         69l4aUTx0MbyxCAw/L3xglRMNktj+g0vWYymoNXeKmO1XyZI0GELPjAIyF/DgJBGf2
         WIWkO54mowWhg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84F9FE6D453;
        Fri, 25 Feb 2022 20:44:30 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v5.17-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jOz82pc7KvQrmBojyOAdL6tGnNtfqspROFf3j0+5enGA@mail.gmail.com>
References: <CAJZ5v0jOz82pc7KvQrmBojyOAdL6tGnNtfqspROFf3j0+5enGA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jOz82pc7KvQrmBojyOAdL6tGnNtfqspROFf3j0+5enGA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.17-rc6
X-PR-Tracked-Commit-Id: c5eb92f57de2446e0071c3af70ea54f237eb05d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2800b6d0fc390d7c3f22109a408d5ed72746588c
Message-Id: <164582187054.27616.2524760008743604650.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Feb 2022 20:44:30 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 25 Feb 2022 16:32:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.17-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2800b6d0fc390d7c3f22109a408d5ed72746588c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
