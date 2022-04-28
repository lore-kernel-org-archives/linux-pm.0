Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5901C433F5
	for <linux-pm@archiver.kernel.org>; Thu, 28 Apr 2022 19:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351298AbiD1TGp (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 28 Apr 2022 15:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346460AbiD1TGp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Apr 2022 15:06:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBADF5DA7A;
        Thu, 28 Apr 2022 12:03:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5784961C15;
        Thu, 28 Apr 2022 19:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BFE19C385A9;
        Thu, 28 Apr 2022 19:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651172608;
        bh=ps08Je31HIunR4SXfny+vEl60cuFHyZALXrN4Ffiz3U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WBIm7E3cF7Fo2BlIcHO++UAoWK1LmujMaI8OPSS/2+8l7A5ebsvXKCeGgaMMd0pHi
         0AoYRosVLVTfVS7S8pvzANoXRGwKQByPyr4+f0LZMXGSlrQVECHveiEhilMB3QTtUu
         1HpxsrfYCtuNCITiaFL5LVP+oT7JGckxdo0EXx3av5E+lg1QrNgoEhwZOLxEdGULgB
         e/Kvi5MTzP2OBVse1KEmQKLdXfMB3ExJIPsEhvQcvsOLj1/BShuAKOUqXeT5tp+QAt
         wIPxULzDAhcWqHIffmGsIh05g1dToe1h4eByn2XvOhZ9V4toHtgVmx40sDXQzQxLHw
         Yez7pp6Lo+Arw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C952F03840;
        Thu, 28 Apr 2022 19:03:28 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fixes for v5.18-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gbBq=UJLyXPcKYN6_LEUoagwUSt61i-ttPLHXvLVzaNA@mail.gmail.com>
References: <CAJZ5v0gbBq=UJLyXPcKYN6_LEUoagwUSt61i-ttPLHXvLVzaNA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gbBq=UJLyXPcKYN6_LEUoagwUSt61i-ttPLHXvLVzaNA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-5.18-rc5
X-PR-Tracked-Commit-Id: a12475f91b69cce067e5de905fafa893ae12c3ae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3c76fe74368b79d5341decaccce97f45907395f1
Message-Id: <165117260857.15527.4294011457819165792.pr-tracker-bot@kernel.org>
Date:   Thu, 28 Apr 2022 19:03:28 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Thu, 28 Apr 2022 17:33:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-5.18-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3c76fe74368b79d5341decaccce97f45907395f1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
