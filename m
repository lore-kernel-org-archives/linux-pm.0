Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2411EB64DA
	for <linux-pm@archiver.kernel.org>; Tue,  4 Jul 2023 18:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjGDSit (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 4 Jul 2023 14:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjGDSis (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jul 2023 14:38:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF32710D5;
        Tue,  4 Jul 2023 11:38:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73B636134C;
        Tue,  4 Jul 2023 18:38:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D801DC433C7;
        Tue,  4 Jul 2023 18:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688495922;
        bh=41unfr46RsAv//K5vaCd++GitPKGWoJWJ0WNHdvQOZk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mdLoWuz+B/5+Esgg2Zg8kdr65LW4DgelT6H1XPXlB4mtusWdI1Em2oETTAsKil7hS
         wLEuHYSrzq6VRjQEwS0R4/xhk9byHljNEjYycIxilKx2mQOpE5P5HZ93RlqrKzy/tw
         IuMS6HnBryjabhko3+nlNSq6DxnvqCvrLsT1+zB3A3XfK4SKSWZMrJClcuWl4M+y+L
         bopEjSbeemRuxpHlB1OhL2Y1dfYJQX3rybqnC+sKTj/KOI6BvS/+u7HNSI1M2p2Zdn
         uZh/729PSdRCmTi1eWwOhCfs2FTNSEJLnLPx1SIF8ektGDPOpBuoVqfg2Zy8jqfT6X
         XCDPLa0xwtFrQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C4F56E5381B;
        Tue,  4 Jul 2023 18:38:42 +0000 (UTC)
Subject: Re: [GIT PULL] More power management updates for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gDV_rDDs0ur=Ct6=4CcCsFQLoO0yGz9-UrnyO0AKLCjw@mail.gmail.com>
References: <CAJZ5v0gDV_rDDs0ur=Ct6=4CcCsFQLoO0yGz9-UrnyO0AKLCjw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gDV_rDDs0ur=Ct6=4CcCsFQLoO0yGz9-UrnyO0AKLCjw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.5-rc1-2
X-PR-Tracked-Commit-Id: 40c565a429d706951f18fe07ccd9f6fded23a4dc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ccf46d85318327e5aebaae53f1fe33cc31ed1fd1
Message-Id: <168849592280.22559.6463310430420506291.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Jul 2023 18:38:42 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Tue, 4 Jul 2023 18:49:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.5-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ccf46d85318327e5aebaae53f1fe33cc31ed1fd1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
