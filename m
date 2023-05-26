Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AA2C77B73
	for <linux-pm@archiver.kernel.org>; Fri, 26 May 2023 20:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237506AbjEZU6b (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 26 May 2023 16:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237428AbjEZU6b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 May 2023 16:58:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184D219C;
        Fri, 26 May 2023 13:58:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A03C665221;
        Fri, 26 May 2023 20:58:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13064C433EF;
        Fri, 26 May 2023 20:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685134709;
        bh=ZMwZkwqVrSELDeGps070Ew9o3luMJzvHIsSeXcGmACA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MwtX56aRc/ye/ELUn4G+twVFJ9vCEQIilM99+XFL0O8GEyzhb6RtPVW9bQuzH+5zw
         bS+aFtCxH70XKrUa2NAxgomJn4c7Z88QyPkMkNa+fhedCyQzIVT/jz8gqFzB5XcJiG
         H/wOu0dB13InMf/GsfTou9sEK7QUWskHRqTrZ4qbEoc44dHofa1tn1H1xUkD5+XFK0
         Gb4aV88j6LuZaG56n55onpBM7onq8nbc8l16ZTvazkuzjzL416gY6PdzAegmSJoJEw
         eQi0+edAFQH/44lCwkwxiOtFLJ8C5YECCcGZ3vm7Zw6or19X/Mu6e0oUb8CYB+N4jb
         HcqADawtoNWIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC0EFE22B06;
        Fri, 26 May 2023 20:58:28 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v6.4-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gV=NM2Tg7x2fEM8imVQ15D5KpZeP+EyaOEnjwPCmF9gg@mail.gmail.com>
References: <CAJZ5v0gV=NM2Tg7x2fEM8imVQ15D5KpZeP+EyaOEnjwPCmF9gg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gV=NM2Tg7x2fEM8imVQ15D5KpZeP+EyaOEnjwPCmF9gg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.4-rc4
X-PR-Tracked-Commit-Id: 3bf8c6307bad5c0cc09cde982e146d847859b651
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c551afcdc373eb66d12e08ed0434711c9a10ca2b
Message-Id: <168513470895.2904.16452129926854595763.pr-tracker-bot@kernel.org>
Date:   Fri, 26 May 2023 20:58:28 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 26 May 2023 18:32:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.4-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c551afcdc373eb66d12e08ed0434711c9a10ca2b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
