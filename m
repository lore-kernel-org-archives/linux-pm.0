Return-Path: <SRS0=Nxon=DQ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F77C433DF
	for <linux-pm@archiver.kernel.org>; Fri,  9 Oct 2020 19:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0B03222C3
	for <linux-pm@archiver.kernel.org>; Fri,  9 Oct 2020 19:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602271908;
	bh=Dd5vczaDIVbkcDLRT8QiNV6TfYFxZ8ZxSIXugpOIyVQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=VI/jtajBtm+fogzM+vk1bdAjEGzsGCZ+88UcRyrD/qudxUzQrDYLFsrfTBMJ4b3Zx
	 grnAYw52P5dEw+5cxmSvF3qMcFAVvQ2Dvdgo43kdeV52f4YLEqT9JrKGldgtrRqnuS
	 eACH9x6tJPUOCe52dpEkXCy/XL1HcBnOaNdbddkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390671AbgJITbs (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 9 Oct 2020 15:31:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390623AbgJITbs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Oct 2020 15:31:48 -0400
Subject: Re: [GIT PULL] power-supply changes for 5.9-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602271907;
        bh=Dd5vczaDIVbkcDLRT8QiNV6TfYFxZ8ZxSIXugpOIyVQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Y1ZW2UAjBloovq6LwghibdCfXdsjopXiiYOHjehvBc+pGSL8EWcyzwxio7lWhb27W
         MmA0FAxEU6u0ZDeTdW7FAtdO/aJvMbI722y6/v8RpIj5nCjxenYRTG6UpF4/JJx5Zb
         BBv8F6iHkhQzGl8zkGEsMMG1vw8CbMw5sUOS6PyI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201009175505.2wbc5tzsr4q2bx3t@earth.universe>
References: <20201009175505.2wbc5tzsr4q2bx3t@earth.universe>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201009175505.2wbc5tzsr4q2bx3t@earth.universe>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.9-rc
X-PR-Tracked-Commit-Id: e3f2396b7570751a7ddba996812fb608134fd63c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 277e570ae193ddd39a7d16f08e3647f2f110c6a3
Message-Id: <160227190773.24155.1793786571133496938.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Oct 2020 19:31:47 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 9 Oct 2020 19:55:05 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.9-rc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/277e570ae193ddd39a7d16f08e3647f2f110c6a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
