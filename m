Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B27C5519F
	for <linux-pm@archiver.kernel.org>; Thu, 12 Nov 2020 19:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDBE52224D
	for <linux-pm@archiver.kernel.org>; Thu, 12 Nov 2020 19:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/xj7ou8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgKLTKR (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 12 Nov 2020 14:10:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:56052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbgKLTKQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 12 Nov 2020 14:10:16 -0500
Subject: Re: [GIT PULL] ACPI updates for v5.10-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605208216;
        bh=0hImEp/vPsrachQbQ364mD6Sxx+9bH+0NFF20xIciAg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=m/xj7ou8+3RjYgoQsQbiKTQaEXorMMJ03jSZG+EHiePPZTsMK08TDa7RdFMxyG6Gp
         L5TDMwGjDUTo3eVbDzGWl7aXF75zdXE63XWHtG8pc8MuEXpGSiAzhQBErgXQcXRsqW
         DXtBf7vlumvBaWyXLu8U6nFYCHTndkLX5ipD0Nds=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gNPL6kbg9f5JgZOvH7k-GLC8yrvvidwj_VCq09ie9NYg@mail.gmail.com>
References: <CAJZ5v0gNPL6kbg9f5JgZOvH7k-GLC8yrvvidwj_VCq09ie9NYg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gNPL6kbg9f5JgZOvH7k-GLC8yrvvidwj_VCq09ie9NYg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.10-rc4
X-PR-Tracked-Commit-Id: 7222a8a52c9ec59affc4d6c4e2632b3e4a44cd27
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: af5043c89a8ef6b6949a245fff355a552eaed240
Message-Id: <160520821603.3788.731983445052011388.pr-tracker-bot@kernel.org>
Date:   Thu, 12 Nov 2020 19:10:16 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Thu, 12 Nov 2020 17:00:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.10-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/af5043c89a8ef6b6949a245fff355a552eaed240

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
