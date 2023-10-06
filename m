Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54623E94136
	for <linux-pm@archiver.kernel.org>; Fri,  6 Oct 2023 22:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbjJFWvZ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 6 Oct 2023 18:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbjJFWvY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Oct 2023 18:51:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC35B6;
        Fri,  6 Oct 2023 15:51:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4445AC433C8;
        Fri,  6 Oct 2023 22:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696632682;
        bh=j652Gqnm5RMXSEocjqqYIeJBYBsa0Gx7jopD3zxKQDc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=d50HWmPCW5wnb4kwLQ701Scmonh0bY0oEZTTh1HhIxqLXDe6eXVqsaIktX05Z6/Xy
         hYd1nvcVzrDNJ4saWefdX0FzhiqsUnKBEkhreXzQ5kna6IYu0bXCbzDQ6lrmRbvDuX
         kHm0XwCatug1wHA6gwiYDwVjlEa5aT3vQ9dbFIzF+F1Sx3XBTZmFRglfCl7BynriFO
         /uMcD4ykqr/SfGn1eaGjh7CdSk036wtRem6kfO48KoOORoEJey6sPApcYpg6pQqo0W
         +/OU9QOSrsDLqaBEWZqhq8edYmJAlrtNRFkVxtjFiPNROZ0qocpNjXurKLvYABykaJ
         hEIHCALuXO53Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 324F6C41671;
        Fri,  6 Oct 2023 22:51:22 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fix for v6.6-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hwHxOO3qbrLrxkXbJgy2Wrz1BVLXZqKdwFZKzkPd9mEw@mail.gmail.com>
References: <CAJZ5v0hwHxOO3qbrLrxkXbJgy2Wrz1BVLXZqKdwFZKzkPd9mEw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hwHxOO3qbrLrxkXbJgy2Wrz1BVLXZqKdwFZKzkPd9mEw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.6-rc5
X-PR-Tracked-Commit-Id: b21f18ef964b2c71aa0b451df6d17b7bcad8280d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 82714078aee4ccbd6ee7579d5a21f8a72155d0fb
Message-Id: <169663268220.26682.7770011256259635795.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Oct 2023 22:51:22 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 6 Oct 2023 19:17:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.6-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/82714078aee4ccbd6ee7579d5a21f8a72155d0fb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
