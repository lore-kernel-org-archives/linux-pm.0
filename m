Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F568C4332E
	for <linux-pm@archiver.kernel.org>; Tue, 22 Dec 2020 22:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F9DA239A1
	for <linux-pm@archiver.kernel.org>; Tue, 22 Dec 2020 22:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgLVWYq (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 22 Dec 2020 17:24:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:49840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbgLVWYp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Dec 2020 17:24:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 583A222B2D;
        Tue, 22 Dec 2020 22:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608675845;
        bh=9uE+ZLL0wSwX0x3Lrro9ZLZMX2HzyERMpCjs9kyf/yg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FwyqE3IUaG60WXN/1z0VpYD4oqcomoXjl1adpL6uiuD4vq/mfUM6Msyg9maxfeqSZ
         EJCNfPLqCSMpnXZ5D3bet6daXqtS7QrKOf8hRtGvkrq3ZfgHy0kkzlFVGPv5sG4R5N
         TAy0GAukvLVEUvQBweTAKSscqvUFCvvmEeQxNwnn/7a+pLBPhqITmQ5L+dyy4xHGhU
         UdOQNcFxW7h7Gt6XvN9bhvVa4dElyGPSfEpRnQ8SuFU9GzyMJJr78nzO/5dflzP12J
         4HzuIewgHMshjpM8+UckFlUVT8rgUUd3bt+sKgjl0reTmYYor+gqhL5Ygfv8EuE9Hp
         4magR2KPp39/g==
Subject: Re: [GIT PULL] More ACPI updates for v5.11-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jS2-kDBA70XwStNEg3pUusK_=h5P58d71cOx83zU-WOw@mail.gmail.com>
References: <CAJZ5v0jS2-kDBA70XwStNEg3pUusK_=h5P58d71cOx83zU-WOw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jS2-kDBA70XwStNEg3pUusK_=h5P58d71cOx83zU-WOw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.11-rc1-2
X-PR-Tracked-Commit-Id: 538fcf57aaee6ad78a05f52b69a99baa22b33418
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 614cb5894306cfa2c7d9b6168182876ff5948735
Message-Id: <160867584533.8550.10758431906540958942.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Dec 2020 22:24:05 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Tue, 22 Dec 2020 20:15:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.11-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/614cb5894306cfa2c7d9b6168182876ff5948735

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
