Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0E3C77B72
	for <linux-pm@archiver.kernel.org>; Fri, 14 Apr 2023 17:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjDNRkd (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 14 Apr 2023 13:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjDNRk3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2023 13:40:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF18476B3;
        Fri, 14 Apr 2023 10:40:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 424D460F7C;
        Fri, 14 Apr 2023 17:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AAE1FC433D2;
        Fri, 14 Apr 2023 17:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681494027;
        bh=KnX+BTPv0+8jqkJOnDAbfaYuYSUpx1f3ylLfveceFwk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=E0XJW5VGyuxbtnkf9txeJkpA4iJ9/vyac6xtaDg6K5/JNM01kwbu0WbrkR8U84Ohv
         KEJRiyFuCFrmKG4EeS4D6aTBQXx0J64LfTXckA+jjxnN/X1JeTP/d8Q9DjqK7e31Q0
         GSH3Z9NWA5c1vUizJW81xagaZpaEdLzgs3FroqVvAlp1ntUn5EYDrsfBcrL87THgSx
         A2spADPum02iKvjnNla5cPioM6YwCwoE52Ni19GyhDJuspVt5n+nm+wOilkF7fdVBt
         0fxRQUJAFYMmhZbvcz6y27KUnPkudg+ZAt5ESKKblmXXKFyTyh5m2TzPCMchnGv7ey
         IOjRIgVf/sYZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9160EE52441;
        Fri, 14 Apr 2023 17:40:27 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fix for v6.3-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j9EZH-9DJzqGE+q=sB-y5FeZUv3k=X4BgkthSg-PFx3Q@mail.gmail.com>
References: <CAJZ5v0j9EZH-9DJzqGE+q=sB-y5FeZUv3k=X4BgkthSg-PFx3Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j9EZH-9DJzqGE+q=sB-y5FeZUv3k=X4BgkthSg-PFx3Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.3-rc7
X-PR-Tracked-Commit-Id: 117e4e5bd9d47b89777dbf6b37a709dcfe59520f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d0b85e7e60b83348b022441de9047c60ff555bfa
Message-Id: <168149402759.11053.2841087773125029174.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Apr 2023 17:40:27 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 14 Apr 2023 15:56:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.3-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d0b85e7e60b83348b022441de9047c60ff555bfa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
