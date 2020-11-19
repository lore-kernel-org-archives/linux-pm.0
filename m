Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AB3C6379D
	for <linux-pm@archiver.kernel.org>; Thu, 19 Nov 2020 19:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 315AC205F4
	for <linux-pm@archiver.kernel.org>; Thu, 19 Nov 2020 19:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGW8g3vh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgKSTR4 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 19 Nov 2020 14:17:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:36614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728214AbgKSTRz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Nov 2020 14:17:55 -0500
Subject: Re: [GIT PULL] Power management fixes for v5.10-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605813472;
        bh=ejxItLtjAUsfwaXAd8x+kBdH3zC/gENtYyELlUJYpZQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mGW8g3vhUqdsF6k6JzBV7Ywe3PdVgebarvnSpKZLCE7AZxLbc7ppQKesKBDzXpnXr
         UdNwpsNKECkCEx7sB8ERveSiu73GJmhr8TMhWI5cFG4a8cZKUhHemKxBJx92Qaa7E/
         19HYvey0csIIJ5h8oNbaG6cD1+yfU1EKZNht5xE8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jBUToP9sxeuhw_AVwoPNc8RwJD_31WoCLSOiXH6Dcy8A@mail.gmail.com>
References: <CAJZ5v0jBUToP9sxeuhw_AVwoPNc8RwJD_31WoCLSOiXH6Dcy8A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jBUToP9sxeuhw_AVwoPNc8RwJD_31WoCLSOiXH6Dcy8A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.10-rc5
X-PR-Tracked-Commit-Id: 3a8ac4d39651c71d6d2f3376b13d0bad1484249a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ca35b4f45092634df21dada47746571a34cc09c
Message-Id: <160581347268.16071.9742795392696011236.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Nov 2020 19:17:52 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Thu, 19 Nov 2020 19:27:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.10-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ca35b4f45092634df21dada47746571a34cc09c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
