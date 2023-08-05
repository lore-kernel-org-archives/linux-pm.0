Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99ACC04A94
	for <linux-pm@archiver.kernel.org>; Sat,  5 Aug 2023 00:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjHEAQz (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 4 Aug 2023 20:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjHEAQy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Aug 2023 20:16:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66B34EE0;
        Fri,  4 Aug 2023 17:16:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4ADAD62180;
        Sat,  5 Aug 2023 00:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AEC37C433C8;
        Sat,  5 Aug 2023 00:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691194612;
        bh=VRWNxQKi4Bu0qZENug/2QTHVxJRdu2IItYHonFwdqVo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mlFdm3/bMh4Q8dAyNWJ8OquZVOQt99+V+BPbpsB0miNHjrojQAk37O7pXTWAGzHMA
         Lya/bjO1ArrHERlgtochS+2siFJZAfPKkyGFQx8TACbO1wyQ4Djef76WxMxoLqTYVM
         VUcP7balGJB4P32rlIVIYWapgx66us8eYdzz17zCFOUplxuwiVmC7qRqiim1+Cjg4r
         wgcziq2C3WvrNN58b7fX0Bs8w4QW6yMFvBT5F1AcbZ2+D+ajE3uv6XzJOXW8Cglb60
         45QxOL1g9OY9uSw/vaxz3XGp+mJ3SWDyZaWcDLHm0KHbd128z9/P924ttC1zRcwwSN
         CXXdwK3M4y06w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 80233C395F3;
        Sat,  5 Aug 2023 00:16:52 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fix for v6.5-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jz05KdjX51tAbLMUCnLVF_CUhadUt1VVrk7KD-ngrPDg@mail.gmail.com>
References: <CAJZ5v0jz05KdjX51tAbLMUCnLVF_CUhadUt1VVrk7KD-ngrPDg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jz05KdjX51tAbLMUCnLVF_CUhadUt1VVrk7KD-ngrPDg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.5-rc5
X-PR-Tracked-Commit-Id: 16e95a62eed18864aecac404f1e4eed764c363f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea4f142ffa876ee4e7e99bbd8d666e0e81cbcc2c
Message-Id: <169119461252.16730.11579369506083272558.pr-tracker-bot@kernel.org>
Date:   Sat, 05 Aug 2023 00:16:52 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 4 Aug 2023 22:48:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.5-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea4f142ffa876ee4e7e99bbd8d666e0e81cbcc2c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
