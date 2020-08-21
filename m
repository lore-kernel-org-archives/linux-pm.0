Return-Path: <SRS0=MHso=B7=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F065C433E1
	for <linux-pm@archiver.kernel.org>; Fri, 21 Aug 2020 22:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77354207C3
	for <linux-pm@archiver.kernel.org>; Fri, 21 Aug 2020 22:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598047557;
	bh=Lqma919Md26IrNr6f7LG6sMH3gMSsaaWA9Z/R390lSg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=QInYWyiHYUUtklyexTxuazMt30N6C/rKNXKFYpftqlc09h3hSCwweNAGK6zVRJc0Z
	 PthueTWLX52XOilswKVBX5uht7YBahaYtb4to5CqcJynNLb6OE6C6OVnIleYEcal8J
	 35ZIL6YCv3/HV33Yiw0bDfHvujqykx2jv96xe2GI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgHUWF4 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 21 Aug 2020 18:05:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbgHUWF4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 21 Aug 2020 18:05:56 -0400
Subject: Re: [GIT PULL] Power management fixes for v5.9-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598047555;
        bh=Lqma919Md26IrNr6f7LG6sMH3gMSsaaWA9Z/R390lSg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MW9+0sed0vuZrYqXHwrUei6aeP1k64POqOYTKH8zPvb7Jx2EP/z3gA8VmDyXDFrbJ
         TvJUh4lLSIRfFUiDogtZVzWUlePhccy3NG1Z/fqj9s3yRmpZe/D6vCkbWwZnJJDlVZ
         lTXGaUFyJMQV95kPVsJXV2ByqJ2xVemfvrYGEgFk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hVw_1b_hf7UWv06ipusZ=xs-0Lhi-a0npqU8Uua26FPQ@mail.gmail.com>
References: <CAJZ5v0hVw_1b_hf7UWv06ipusZ=xs-0Lhi-a0npqU8Uua26FPQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hVw_1b_hf7UWv06ipusZ=xs-0Lhi-a0npqU8Uua26FPQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.9-rc2
X-PR-Tracked-Commit-Id: cc15fd9892e28689b6e17dbd6e28d00c55d62928
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 985c788b6da44dc21b401ce8ce3c2db023ef79e4
Message-Id: <159804755587.4316.7754222427566232989.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Aug 2020 22:05:55 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 21 Aug 2020 20:12:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.9-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/985c788b6da44dc21b401ce8ce3c2db023ef79e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
