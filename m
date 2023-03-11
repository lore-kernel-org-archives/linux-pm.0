Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB24C678D5
	for <linux-pm@archiver.kernel.org>; Sat, 11 Mar 2023 04:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjCKEwM (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 10 Mar 2023 23:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjCKEwK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Mar 2023 23:52:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE1212CBA9;
        Fri, 10 Mar 2023 20:52:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B1AF60A2C;
        Sat, 11 Mar 2023 04:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80160C433EF;
        Sat, 11 Mar 2023 04:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678510328;
        bh=6HMgYhoJX2H0fla8vKWzZwWP4bgC2He/E8oI/YET32o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=T8JE9T85EKPMqwm/8Z5ynBBHTpgsTf2JhFeWpuhv5cUNdVKE/U4v0fZKr2IVEyG3b
         RrUYuouKS8hP9gqLK+mufFHWs2R1vcqoiezgPuk23wF04bjkl0WoNybY6R2qztltI7
         px7mwLOBi1jN5JjZT3fKJbRphfsJWN4N61TMNw3ITn77BzLj/+5s3gJoHkuzFsA1e+
         zZzbjvgGT5Cmu3SKV5WJzaC6dovuS/2MhmXjIBqBrJa6TXLV5wOJlO0mpNrdI+tE8J
         wtxT/peFKW49wxiJ7R5EdCK3gl5nzmqPgaZlbuq3XvJQoWq8N7biIjh/t8KDCTMIbC
         wDBU/AIZs/ynw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69EC6E61B65;
        Sat, 11 Mar 2023 04:52:08 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fix for v6.3-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jbVwQ-NcdbRwru+T2mr9e9AKZRAFkCjNVoFzE31GQJXw@mail.gmail.com>
References: <CAJZ5v0jbVwQ-NcdbRwru+T2mr9e9AKZRAFkCjNVoFzE31GQJXw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jbVwQ-NcdbRwru+T2mr9e9AKZRAFkCjNVoFzE31GQJXw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.3-rc2
X-PR-Tracked-Commit-Id: 52f04f10b9005ac4ce640da14a52ed7a146432fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a0aefd306ebb394ea72e04f53f64d76b05d5e39f
Message-Id: <167851032843.30895.12768799853759211419.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Mar 2023 04:52:08 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 10 Mar 2023 19:07:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.3-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a0aefd306ebb394ea72e04f53f64d76b05d5e39f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
