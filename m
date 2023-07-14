Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E7EEB64DC
	for <linux-pm@archiver.kernel.org>; Fri, 14 Jul 2023 18:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbjGNSM7 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 14 Jul 2023 14:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236730AbjGNSMt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jul 2023 14:12:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B27F2117;
        Fri, 14 Jul 2023 11:12:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DB5261DEF;
        Fri, 14 Jul 2023 18:11:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0604C433C7;
        Fri, 14 Jul 2023 18:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689358288;
        bh=Kz1IkzrWv2v5KgLGcmt34hWJsDIzODjdp+hf3eX9wiw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bCUGw++Jbyl8i97bSHUpKH+/SI9uqC+dqE7q6VFPBWVXl3pNOtiBo0SHpl1Lz6BM9
         EXOQwaKMDH2wDK18gXq8UN/NzcoNb2s2OS1HxMSZ4mrBltERGNaZ3BkgFTzxeZgD7j
         NfeIudYs23Es0PeAJI2BqAHK9ANOWEG7xzULwz1wYqHyc4Om7rWWK/os2R0YIwFzLd
         BLpqXTMVGS+mR5NiLL5nVx1DBsORkpRggjDz9rwmTpiq5BDD6+qxNOAeQDkcpQ2VrF
         0+auDuKb7Q1FAYYaLyOyJHOMQhpbjgYN+Hjqyo6nXevuTnAgjunS39R0oySE+DSPaM
         MFvzZlkLR/gng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2869E1B4D6;
        Fri, 14 Jul 2023 18:11:28 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hSU_kJFMGJOBDELFYycNRjCF1tdjZLH+gXc0wp9JN_AQ@mail.gmail.com>
References: <CAJZ5v0hSU_kJFMGJOBDELFYycNRjCF1tdjZLH+gXc0wp9JN_AQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hSU_kJFMGJOBDELFYycNRjCF1tdjZLH+gXc0wp9JN_AQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.5-rc2
X-PR-Tracked-Commit-Id: d121758da6df6829cb505ef0143cf42d28bd865d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bde7f150276bf2a04f92d39beaf34eb40c42c9cc
Message-Id: <168935828866.1072.16329695788174208187.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Jul 2023 18:11:28 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 14 Jul 2023 19:28:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.5-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bde7f150276bf2a04f92d39beaf34eb40c42c9cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
