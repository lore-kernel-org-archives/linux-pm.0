Return-Path: <SRS0=AobL=AO=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3E1C433DF
	for <linux-pm@archiver.kernel.org>; Fri,  3 Jul 2020 21:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 599B8206E2
	for <linux-pm@archiver.kernel.org>; Fri,  3 Jul 2020 21:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593810917;
	bh=BiiuFfciXWQEYUr5uWX4rxR/KCq8/ad5qu3PDtQ5Fe8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Zay/acDCu5GaRNUkGh80HxrsHrpLgO2z28PeRAlEpECnrM11P6NzUJZ2k7OuXWT9O
	 Bg9sQdsGnm40WPQtryCDWf3moRDtaz6Ftoc8zGFJv7XvSstkQHNENpWMjXuk6MKLIH
	 UoPdSzu3NSb95U7+uKyp1HofTdOHQD85FbjYRoBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgGCVPP (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 3 Jul 2020 17:15:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbgGCVPI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Jul 2020 17:15:08 -0400
Subject: Re: [GIT PULL] ACPI updates for v5.8-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593810908;
        bh=BiiuFfciXWQEYUr5uWX4rxR/KCq8/ad5qu3PDtQ5Fe8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RZRB6+2gEj/oBcy/xyzapKdiPJq8Fj1nwWyq5amoQMbZmxNlarvYBXW1rapylIDjw
         2MvZZUHYi0MImGDrlOYow9ykaBSv9SCZbzhhMUwOgEkPUme9/qU7RD53zmXZapLzBo
         kQq9UonNoO5iUw2S1ya7fBnJPcRvidVjDxQymjCg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0i=ovJcb+0PkVj=_RR4FaUVgSiR4ON0ay1RvOk7t8UUZg@mail.gmail.com>
References: <CAJZ5v0i=ovJcb+0PkVj=_RR4FaUVgSiR4ON0ay1RvOk7t8UUZg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0i=ovJcb+0PkVj=_RR4FaUVgSiR4ON0ay1RvOk7t8UUZg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.8-rc4
X-PR-Tracked-Commit-Id: ef0c44c3e51ba051c500620685ee0b476ef2cbdf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 718b7a570a346323cd80dc28d0a41892036b050b
Message-Id: <159381090808.9451.17608478322776044630.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jul 2020 21:15:08 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 3 Jul 2020 16:50:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.8-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/718b7a570a346323cd80dc28d0a41892036b050b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
