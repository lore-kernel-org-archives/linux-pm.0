Return-Path: <SRS0=MKj8=AH=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644D2C433E0
	for <linux-pm@archiver.kernel.org>; Fri, 26 Jun 2020 19:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C1EC206C0
	for <linux-pm@archiver.kernel.org>; Fri, 26 Jun 2020 19:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593200422;
	bh=fHrqcu0clbzHdKTiUjbgXTySe0DM+hDr3AHi+fKLk+E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=N7KzM9fWzBlei9GSEUL9/6bfEqZP5TaZxiMi27fslUrqR6NwOpm3c6n1Z3w48dpqU
	 PXFfZN979N9AO83jaAe3WQ264CCAf1VFGbtzJdXHWEsNHMUTuTpzb4GsTVhFg+K42f
	 GAYpHWFsIs3woEx6gDfKgtEBHOJs1hlzlENM+n+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbgFZTkV (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 26 Jun 2020 15:40:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgFZTkO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Jun 2020 15:40:14 -0400
Subject: Re: [GIT PULL] Power management fixes for v5.8-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593200414;
        bh=fHrqcu0clbzHdKTiUjbgXTySe0DM+hDr3AHi+fKLk+E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JBqtBd5GDX6AkFzHo5SGA5knVinXAb25iiCqSQoIIy4DCRCgh/Y7z5zIRsf+ieOEL
         a+c0db8IZWDpp53mYQFRNMQu/sBv+/nWiKnYzO5mUhxfSraYHl30crSFxuQOUsed81
         VhnMwefPJcjnOy6yEoDvZtUO6qzM6RnVoLax4FGg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gV3VCoJxuSZcngA2H1Nwqz2mHLtJAd2NoQE3ht9FVTHg@mail.gmail.com>
References: <CAJZ5v0gV3VCoJxuSZcngA2H1Nwqz2mHLtJAd2NoQE3ht9FVTHg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gV3VCoJxuSZcngA2H1Nwqz2mHLtJAd2NoQE3ht9FVTHg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.8-rc3
X-PR-Tracked-Commit-Id: 0e3fb2a128d81bc5baee76dddcc8ddbc8ccae95c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ed3e00e7d6a87c60fcbc5a571b451891d365134e
Message-Id: <159320041413.11855.1656654891567621195.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Jun 2020 19:40:14 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 26 Jun 2020 17:38:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.8-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ed3e00e7d6a87c60fcbc5a571b451891d365134e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
