Return-Path: <SRS0=phhj=DV=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FFCC433DF
	for <linux-pm@archiver.kernel.org>; Wed, 14 Oct 2020 18:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD7DF22246
	for <linux-pm@archiver.kernel.org>; Wed, 14 Oct 2020 18:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602701597;
	bh=nErTft64H5nzbKtlIJLoG3X6uTJxyM20ulWm6vz5q4Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=eSHaopzHGXOnUS6rcw6ZHqnKyXcC2qz0aNEtuKsZbRUc/ZMg31yovv5x4z9BRi5VN
	 WJKB2IOdrJKslphUIoYhmCclO9AFxt5Bm5tnbeCPZVdAPXhhnv/cmktbVEaKd3Nd4L
	 uci+H7E9e2p4HV1hJn7/APtB2m3sn7gYv8TROXuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389463AbgJNSxM (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 14 Oct 2020 14:53:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389365AbgJNSxM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 14 Oct 2020 14:53:12 -0400
Subject: Re: [GIT PULL] ACPI updates for v5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602701591;
        bh=nErTft64H5nzbKtlIJLoG3X6uTJxyM20ulWm6vz5q4Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nm3uFStr9DDRDrHkwcdPTr1VWK5CWU4xZVyCUXEv4tki4bOm0CynR+yVZ4auNwZvU
         3SkMgHqImQqaDuZaH4/BoMEW03GIjazxgdKP6BYY/Ngql4u5qkge4s2W/oJYR4v8cS
         m1isMpz2IMgQMBEqo1DMvURS3jw7Rs46KA/hPW3s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j7XkDh9ddK0BtjWjHqC=xkcyiEEDzTJN=Lykje5-wf3w@mail.gmail.com>
References: <CAJZ5v0j7XkDh9ddK0BtjWjHqC=xkcyiEEDzTJN=Lykje5-wf3w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j7XkDh9ddK0BtjWjHqC=xkcyiEEDzTJN=Lykje5-wf3w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.10-rc1
X-PR-Tracked-Commit-Id: 8be2362d10e8b0ea9844706d8c388480d37226d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf1d2b44f6c701ffff58606b5b8a8996190d6e7d
Message-Id: <160270159174.3085.10357270487041944176.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Oct 2020 18:53:11 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Tue, 13 Oct 2020 19:33:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf1d2b44f6c701ffff58606b5b8a8996190d6e7d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
