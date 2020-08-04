Return-Path: <SRS0=P4yl=BO=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836ACC433DF
	for <linux-pm@archiver.kernel.org>; Tue,  4 Aug 2020 04:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 850F72245C
	for <linux-pm@archiver.kernel.org>; Tue,  4 Aug 2020 04:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596514515;
	bh=RtHRjX5uz60KiT01VyDBusXOp1tmigjG1k003aEivJU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=wiMvrDZTFKCpP/SVx7GbJY0GhgyWTT7CwCxENf3PO15zuEeaK+cVX5WqMkP1J7j8v
	 PNA8X6xdr3gNDSfOaQv0Iu7xUK3Im2CinGOkopbUU+O6LAXvC0EsxrVRyzlbDiTVtX
	 zHgBbzISrJ20K46pjrbrawqnkPbUNgzcElx6G5yI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgHDEPM (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 4 Aug 2020 00:15:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728622AbgHDEPJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 Aug 2020 00:15:09 -0400
Subject: Re: [GIT PULL] ACPI updates for v5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596514509;
        bh=RtHRjX5uz60KiT01VyDBusXOp1tmigjG1k003aEivJU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cj7pm/41HRUjxS90WiANv8rNk3CxH1yoFPhVghX7FPSj2KqL3/z49YrhnsQde6eLY
         e6FYAzYdULzFMMwJsv0NGdGbdkig3pJwAj4WqTlZCQ0nk+FTrdjXN1WNhpQNXWbWfw
         sJ/VwWqvUOjxO9iXXuWP8LZAmlGUhuWKgPmHnARg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hNz4ai_wmrGJzwRe179=swhG9iFMQRzRuyv4NVer2Erg@mail.gmail.com>
References: <CAJZ5v0hNz4ai_wmrGJzwRe179=swhG9iFMQRzRuyv4NVer2Erg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hNz4ai_wmrGJzwRe179=swhG9iFMQRzRuyv4NVer2Erg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.9-rc1
X-PR-Tracked-Commit-Id: db1da2f52ea5477e917957dd80c1da63affa60e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2baa85d6927d11b8d946da2e4ad00dddca5b8da2
Message-Id: <159651450926.27277.12447229148295500184.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Aug 2020 04:15:09 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Mon, 3 Aug 2020 18:52:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2baa85d6927d11b8d946da2e4ad00dddca5b8da2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
