Return-Path: <SRS0=PYjH=7P=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D73C433DF
	for <linux-pm@archiver.kernel.org>; Tue,  2 Jun 2020 20:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01844207DA
	for <linux-pm@archiver.kernel.org>; Tue,  2 Jun 2020 20:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591130137;
	bh=2rVwh4/siikVrpgwYQuuD+buqge9Sw5sBfNz6/5D/G4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Kjn9IPyl+a+qYIKVsHkLEz1S4u1HhVPbAzl05rr5cwI6AZ5FqVXjfo1wzpHaKLeiS
	 7upk9v4yRP24iZTDe5Dq3JT1sTomh2pizhY20Lgi7UDSj0kBb7RxbdAOBV0c5ta5l1
	 /Af8ci2vPtz8SeX4QmLD8s/3UASA7ru4SvDq+n44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgFBUfa (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 2 Jun 2020 16:35:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728459AbgFBUfG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 2 Jun 2020 16:35:06 -0400
Subject: Re: [GIT PULL] Power management updates for v5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591130106;
        bh=2rVwh4/siikVrpgwYQuuD+buqge9Sw5sBfNz6/5D/G4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DaTHAH+Ih2x/zpFGh+ICXsG43LB4CLkxU33kHtD/QNLxT1+vEP6H0f1vDbrWmymFl
         +o/95tHMuX+6Z+3XQYlMXf1y6f6H29Kb6083QTTHM+nneHBiYOjFCTz5bQWEAaqIod
         VYKiuvCkpQTkLaYEgjCmRReZf858bTknNPNc6P0A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gV2T9BUBGT8TOt+kdO6+T_WwmcO1PPonWu76REGkoorQ@mail.gmail.com>
References: <CAJZ5v0gV2T9BUBGT8TOt+kdO6+T_WwmcO1PPonWu76REGkoorQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gV2T9BUBGT8TOt+kdO6+T_WwmcO1PPonWu76REGkoorQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.8-rc1
X-PR-Tracked-Commit-Id: a34024d98eeaa78e2cd22017180df778800b83fc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 355ba37d756c38962fe9bb616f5f48eb12a7e11e
Message-Id: <159113010624.19446.15600149439571163343.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Jun 2020 20:35:06 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 17:48:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/355ba37d756c38962fe9bb616f5f48eb12a7e11e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
