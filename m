Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB22C433E9
	for <linux-pm@archiver.kernel.org>; Sat,  2 Jan 2021 20:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95D49207A1
	for <linux-pm@archiver.kernel.org>; Sat,  2 Jan 2021 20:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbhABU1H (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 2 Jan 2021 15:27:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:34354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbhABU1H (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 2 Jan 2021 15:27:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 864BC20796;
        Sat,  2 Jan 2021 20:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609619186;
        bh=GdOkUQkIyXYCfeFxIBwC+3/AFItGJqJoa4HOHlJd6t8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Qq+LyLxlSZL0phtydjxOH/ONDk95cOJDx9YGoImhqSHVe/C76Weo1SH+5PKDD/poX
         yTlIkOv9i7gYf4sT3OTc6gr9tMlZsMOQVCrM06dYLQOUEio/wk80E+1fNf8wcsEwFW
         b0hO79YeAVXKabjgweB1eyDwJIdkRi93NC6meZD7V13YQoc7f7cQJUpULw0cg934Mo
         v+dSYsUBDHmMufW6mXjHOHa0GEPzbjG/+2oJdNVAXq+BJSK+gkvP+189nyO8cBvFqX
         IE3jCNyGNN9hPcB6Uq8xZXZL15axFVtZZH8/7jTme571Q932XLvBS0a1UJB3tp4M79
         /QGKEpYwNvGHg==
Subject: Re: [GIT PULL][Resend] Power management updates for v5.11-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j-4z07zeqcMNKCjG5dt59GAbKHq2xGnzAxUnNnFf3soA@mail.gmail.com>
References: <CAJZ5v0j-4z07zeqcMNKCjG5dt59GAbKHq2xGnzAxUnNnFf3soA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j-4z07zeqcMNKCjG5dt59GAbKHq2xGnzAxUnNnFf3soA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.11-rc2
X-PR-Tracked-Commit-Id: 89ecf09e0b93de54415de45be241649ec1b162de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d9296a7bd9c87321766beeb041dc5b55326d9903
Message-Id: <160961918639.18509.12643665966172421312.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Jan 2021 20:26:26 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Sat, 2 Jan 2021 10:25:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.11-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d9296a7bd9c87321766beeb041dc5b55326d9903

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
