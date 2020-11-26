Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F23C56202
	for <linux-pm@archiver.kernel.org>; Thu, 26 Nov 2020 19:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B0F22145D
	for <linux-pm@archiver.kernel.org>; Thu, 26 Nov 2020 19:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMjtWxFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbgKZTSo (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 26 Nov 2020 14:18:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:50592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729715AbgKZTSo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Nov 2020 14:18:44 -0500
Subject: Re: [GIT PULL] Power management fix for v5.10-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606418323;
        bh=5Fvu1OhRwwBLBNUiuBuWz+I4u1KnBE45nJ6sPQCV5d0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sMjtWxFHzWL0Bm69AaK8D0D0/8bcYGHJShV9dK20Dr3gx0fq1HHgVuK53PNAZrwHb
         CPZIf2MdKlWKaGWlTjajrGQcZwQDwiLEgiRfuLc+vuciSSatxCI+HqpAXV7uwaNJ9G
         DtXqyzm5MU/ktqOu01+DmcjIRNuwG89K1cZEqpeU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iYMoRORnZerF4Za84aQZ4Dg70rYgfJkOP3rECBNALRbw@mail.gmail.com>
References: <CAJZ5v0iYMoRORnZerF4Za84aQZ4Dg70rYgfJkOP3rECBNALRbw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iYMoRORnZerF4Za84aQZ4Dg70rYgfJkOP3rECBNALRbw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.10-rc6
X-PR-Tracked-Commit-Id: 05b8955f43536c3e1e73edc39639aac9ae32edd8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 85a2c56cb4454c73f56d3099d96942e7919b292f
Message-Id: <160641832360.22369.9400905519198904428.pr-tracker-bot@kernel.org>
Date:   Thu, 26 Nov 2020 19:18:43 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Thu, 26 Nov 2020 19:57:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.10-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/85a2c56cb4454c73f56d3099d96942e7919b292f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
