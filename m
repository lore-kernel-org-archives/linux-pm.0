Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F47C5517A
	for <linux-pm@archiver.kernel.org>; Wed, 11 Nov 2020 13:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B330720756
	for <linux-pm@archiver.kernel.org>; Wed, 11 Nov 2020 13:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1sw3XIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbgKKNkT (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 11 Nov 2020 08:40:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:34678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727143AbgKKNjd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Nov 2020 08:39:33 -0500
Subject: Re: [GIT PULL] turbostat: update to version 20.09.30
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605101973;
        bh=S9RIwPBQn7hGdnQSVN9mkeaBkvHVpqqoI9NZDpxr65w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=m1sw3XIcNPjm7pWrIMzVmulE6NXySZVEjwEqwm3gJsTXYKDswsjpMBr8afTt1hAf8
         9xzOAw0ezRYTroo0+708tFaFObrNoRiVbtLBL9Qsz6Z43Dt/HnJpntsa8CnLCYNaEo
         BH5s0R0QXTfs0egWokj6we4KzET9LYb9F8W5Qiao=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJvTdKkS9ywVCp3_MK9e_N7J=LvSHFRjTfSb8Q7O+WvVh2zACA@mail.gmail.com>
References: <CAJvTdKkS9ywVCp3_MK9e_N7J=LvSHFRjTfSb8Q7O+WvVh2zACA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJvTdKkS9ywVCp3_MK9e_N7J=LvSHFRjTfSb8Q7O+WvVh2zACA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat
X-PR-Tracked-Commit-Id: 3e9fa9983b9297407c2448114d6d27782d5e2ef2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8bff39bfdc30c9bd6e152eb88a0bd6dd35bdd760
Message-Id: <160510197306.25708.8139404608635356078.pr-tracker-bot@kernel.org>
Date:   Wed, 11 Nov 2020 13:39:33 +0000
To:     Len Brown <lenb@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Tue, 10 Nov 2020 13:00:02 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8bff39bfdc30c9bd6e152eb88a0bd6dd35bdd760

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
