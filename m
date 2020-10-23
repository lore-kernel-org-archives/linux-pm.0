Return-Path: <SRS0=XRtZ=D6=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06512C388F9
	for <linux-pm@archiver.kernel.org>; Fri, 23 Oct 2020 23:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0C7020708
	for <linux-pm@archiver.kernel.org>; Fri, 23 Oct 2020 23:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603496545;
	bh=wI4w6uky//I0p7iyNkMxzesogyDiGHZrvJRl9xshuDY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=isUl3iEPkZU286VDabKN/E4myec+eLuSSWoWGxdnKqBUaC5f7pD4CFrTn8dwVpIAD
	 WfOi9VANAgkFTfAKgp81VMUj0ie0aQjzt64bwTUa/sSGHTOs/g80J7gd8NMvWQRw08
	 O4QwOtoa2VsKSvnoCrEUKy4UbJmAl1Rzxwp6GQMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758806AbgJWXmS (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 23 Oct 2020 19:42:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758800AbgJWXmR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 23 Oct 2020 19:42:17 -0400
Subject: Re: [GIT PULL] More ACPI updates for v5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603496536;
        bh=wI4w6uky//I0p7iyNkMxzesogyDiGHZrvJRl9xshuDY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MU3SVbiYV3BZI4KOB8KvSVn/IS8dDLkPtMnuk6zCVt29ml2+ph0Otxvn/2sGu/8y0
         PTOp1JxhHBqK2wK+D7ZnAgtxUSwDpAwNZ0bYitH2KNtPrzlfrgr9Mb4+RCJHESncoE
         HZaYKQvXQf0VUuilEabKXY37g3c6z0cQV9Gs8Ipk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hSpDBUG34ahJDQqs4u+io9x5HBSy6wq15RENG6ci3cJA@mail.gmail.com>
References: <CAJZ5v0hSpDBUG34ahJDQqs4u+io9x5HBSy6wq15RENG6ci3cJA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hSpDBUG34ahJDQqs4u+io9x5HBSy6wq15RENG6ci3cJA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.10-rc1-2
X-PR-Tracked-Commit-Id: 2818cc745445ae5866598fe45fe563ef843e30af
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b76f733c3ff83089cf1e3f9ae233533649f999b3
Message-Id: <160349653678.22217.760736587877571681.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Oct 2020 23:42:16 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 23 Oct 2020 19:31:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.10-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b76f733c3ff83089cf1e3f9ae233533649f999b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
