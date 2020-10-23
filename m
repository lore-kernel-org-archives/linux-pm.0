Return-Path: <SRS0=XRtZ=D6=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB25AC5517A
	for <linux-pm@archiver.kernel.org>; Fri, 23 Oct 2020 23:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7B0F20708
	for <linux-pm@archiver.kernel.org>; Fri, 23 Oct 2020 23:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603496546;
	bh=IopQKtI70nmqa2GR2ocD5+Y4WGKBoJzhpAciTOk3XL0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=BfZFOGqxQirzYpVE6LBfwW1gb5UuQeAzxlVzixU+DTa9Ul9gWih+6QCjfsdMJHjYv
	 ElHMDHmbHvdJ6WXl+M0cTml72ZM4nLjE1i4xhcUdWPQkWPqthiBD/EVx2F4VutHfo+
	 oLKqo0PVOlkdi94FQMh5UOdkX6njO05CdHdFaJIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758803AbgJWXmR (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 23 Oct 2020 19:42:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758779AbgJWXmR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 23 Oct 2020 19:42:17 -0400
Subject: Re: [GIT PULL] More power management updates for v5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603496536;
        bh=IopQKtI70nmqa2GR2ocD5+Y4WGKBoJzhpAciTOk3XL0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hxbkv99weAPzORBDwX4uIV2MZ0aK0XIASD4fBWQmkpYSa1uMzW3ldlnnwqTSi8TtW
         cQpFpcaOxXMUY81t76Q2dtdkn5udb6yi4493TYWK0Ipi6u70R2L0aGYMackGh72N9J
         an1Pq7RsqONpQRkZCtGZ/AwrKK84FaYoJU5//xss=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jJq1myATF3gG=4JwCbBnn3X-MsPXA=nN=WVMcSuDGVzg@mail.gmail.com>
References: <CAJZ5v0jJq1myATF3gG=4JwCbBnn3X-MsPXA=nN=WVMcSuDGVzg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jJq1myATF3gG=4JwCbBnn3X-MsPXA=nN=WVMcSuDGVzg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.10-rc1-2
X-PR-Tracked-Commit-Id: 41c169d9ae2c890552044e129d101995b62c8a02
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 41f762a15a6324f67c3f084ece694c26f196cece
Message-Id: <160349653650.22217.16361775469553406430.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Oct 2020 23:42:16 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 23 Oct 2020 19:29:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.10-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/41f762a15a6324f67c3f084ece694c26f196cece

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
