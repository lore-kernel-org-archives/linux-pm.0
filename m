Return-Path: <SRS0=HvZr=5W=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75C6C2BA1B
	for <linux-pm@archiver.kernel.org>; Mon,  6 Apr 2020 18:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B52A620731
	for <linux-pm@archiver.kernel.org>; Mon,  6 Apr 2020 18:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586196924;
	bh=zhxeOaGtcKfyiLmmMtq/+kY1GCO6x1vK9xvn6tackk0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0Te8f9IF8JurSMfqFGh5DcyEYQazVU3FT0toP7lowoADSu75NHEhPmVaTvyex9zHX
	 Co4zXkFxJ1JNZYWEsKxSqs4q/5uXBOJ/G07eLXeBZc6rNu2Uh7vDJSU8f8cGDRuEiQ
	 WcVNVOsCQJ0GKONePtv2HgZ0hX6CI9/IZtCKOBsU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgDFSPY (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:15:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbgDFSPX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 6 Apr 2020 14:15:23 -0400
Subject: Re: [GIT PULL] More power management updates for v5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586196923;
        bh=zhxeOaGtcKfyiLmmMtq/+kY1GCO6x1vK9xvn6tackk0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OBI9A5S4lB/pn2R/7H46CbfSU3ctGekA4IUpV7eZ7tTH+51kIdGAQ6VXPjfAubU1C
         oCySRhSxxGDkSyZZaXwWGJmlFjsYpF27lQKDtxf8mL6ZqR5SPEK7Po6a+cCM0HNU62
         10ixcOOd9bqekOiGu5H0NR/0NYZqCKSBCxPAhYd8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0ji9p4_whgcJbh6mm8cdYpruHEzOsTqje7JedD45wH5Dg@mail.gmail.com>
References: <CAJZ5v0ji9p4_whgcJbh6mm8cdYpruHEzOsTqje7JedD45wH5Dg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0ji9p4_whgcJbh6mm8cdYpruHEzOsTqje7JedD45wH5Dg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 pm-5.7-rc1-2
X-PR-Tracked-Commit-Id: 54032b863b56b0e5313bfcd6ef0818943c59c4f4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef05db16bbd81c0afc4e97806ab338665863bd3b
Message-Id: <158619692333.24927.12793948460579407311.pr-tracker-bot@kernel.org>
Date:   Mon, 06 Apr 2020 18:15:23 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Mon, 6 Apr 2020 17:11:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.7-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef05db16bbd81c0afc4e97806ab338665863bd3b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
