Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AE5C7EE29
	for <linux-pm@archiver.kernel.org>; Fri, 19 May 2023 18:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjESStv (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 19 May 2023 14:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjESStt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 May 2023 14:49:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B342BE42;
        Fri, 19 May 2023 11:49:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F0E465A94;
        Fri, 19 May 2023 18:49:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90D5CC4339B;
        Fri, 19 May 2023 18:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684522174;
        bh=aUkBUKNUpcALPr+T6nHxvMBylpHvBkOKn3FPBXLttFA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=a+FTHWQiPKgbGp9GE4Sau/ZrloDEjnwxY4GYdMpkkvTBaAo9OSd9Psu5REvQAFjcA
         XpIn6KtqiNQLwaBYyoYdxkDMUXYukvpLeG8ySzaQFdVhiHWADYG2f330aKqMiwxfG9
         hJ6IlZPVV/aD2jdXkJFL/uU+XVi8zWY7eP1aJGFqU2C8rtSQKSlALjD2MbfycoWSAQ
         CibRpm+fzw+2sUY5HviDZgi3u2JvL72Y1kVOjghxHCjDcdIbNfnXQHRjshXDOg6UBP
         XvsT+tI3CkP+B3ACOgVnmwapRYt4vttIZcm1Y+WYlVX20nvvuiRlJBBLW+2tFza9ca
         ttP40FVWdMGYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74123C73FE0;
        Fri, 19 May 2023 18:49:34 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v6.4-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0ifvaf3FBLtKGkSJxEkxLWA8dSatp2hygtYnSbnNRo65w@mail.gmail.com>
References: <CAJZ5v0ifvaf3FBLtKGkSJxEkxLWA8dSatp2hygtYnSbnNRo65w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0ifvaf3FBLtKGkSJxEkxLWA8dSatp2hygtYnSbnNRo65w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.4-rc3
X-PR-Tracked-Commit-Id: 5783ecc90e24a870a563b1acbfd13cad3786e519
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d3f704310cc7e04e89d178ea080a2e74dae9db67
Message-Id: <168452217447.776.12611114623470701626.pr-tracker-bot@kernel.org>
Date:   Fri, 19 May 2023 18:49:34 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 19 May 2023 17:29:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.4-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d3f704310cc7e04e89d178ea080a2e74dae9db67

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
