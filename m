Return-Path: <SRS0=mZbj=TP=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C078C04E53
	for <linux-pm@archiver.kernel.org>; Wed, 15 May 2019 16:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8DE2089E
	for <linux-pm@archiver.kernel.org>; Wed, 15 May 2019 16:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557936636;
	bh=3yl49mVeBbP+KSgFEV0CCubl636y06G4IGOr52wcoGU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=W3Q4g+7esQ6apvT36cK/QMAROWJ8GBl4GTWHKOQpA5Ow7ul0v3rw0DwTwwRK006rw
	 o2ZmomfCdZ047u/csFuHBREXlqHokR+idgvbIZkrwE3NCCqRzT/W/bxUqJiJ+sptbh
	 EYhychlsgibcOzf0DA5rCBJbcjyO/r2eRDLcq3Wg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfEOQKS (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 15 May 2019 12:10:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbfEOQKR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 May 2019 12:10:17 -0400
Subject: Re: [GIT PULL] More power management updates for v5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557936616;
        bh=3yl49mVeBbP+KSgFEV0CCubl636y06G4IGOr52wcoGU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fHy9m+8JyzC9rgUWidC7OLDyHef3xlNLIDVzpi3llsfdU2HokkNUCCUClH3TA4EZM
         RRoDkO64+C6a+cHLjr+DgQjUeaYlBs5auX00TPI/UWPBgomD9dp0700xTJ6E3Tk3dv
         rOUjHSmU8StgR9T/pqpkeTmL75z1yLULIaH87Lh4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0i-sU2cXVdVUW1CCvbCmaTsqphXYXocS=ufeGFAChYOag@mail.gmail.com>
References: <CAJZ5v0i-sU2cXVdVUW1CCvbCmaTsqphXYXocS=ufeGFAChYOag@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0i-sU2cXVdVUW1CCvbCmaTsqphXYXocS=ufeGFAChYOag@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 pm-5.2-rc1-2
X-PR-Tracked-Commit-Id: 2a8d69f6139b605b2e36c80540cb8e8da2d016be
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bfbfbf7368627860dd769567599d73ad8f6d8191
Message-Id: <155793661622.5377.2666256998734937173.pr-tracker-bot@kernel.org>
Date:   Wed, 15 May 2019 16:10:16 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190515161016.vHJjq7BJDQjQAO2BgE7SRFBWWR9EP_kWjOSYZCsLyx4@z>

The pull request you sent on Wed, 15 May 2019 12:13:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.2-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bfbfbf7368627860dd769567599d73ad8f6d8191

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
