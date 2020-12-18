Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949D2C2BBD5
	for <linux-pm@archiver.kernel.org>; Fri, 18 Dec 2020 20:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DB1323DB3
	for <linux-pm@archiver.kernel.org>; Fri, 18 Dec 2020 20:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgLRUzY (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 18 Dec 2020 15:55:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:50768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgLRUzY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 18 Dec 2020 15:55:24 -0500
Subject: Re: [GIT PULL] thermal for v5.11 #2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608324883;
        bh=uyVz2yXarp1KJ7xXfBPqP0kc0ab5OBKStCBK4LNp7Lc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eUDT4X5x2apPKI9SPw/4yHES1dxGFZIRCnaqkpudvefhYAJatTksnKfgfLhD7U7n6
         jNi9aHr9yV9haWMpojfUMLX7PSiMuVC2XdvEsP+cNqwIqBtXm8HhGV9yUPDx6MG76F
         gRmrAdS21x13i1PHAzfYoz9gwSVIzlIxr9Bn4amVK4lDHIIzaoROi2/2fLosuBU37g
         ZBEd9nyQfMektRAEpTfKnYJ+Fu3Lpvlj4ufguztq5Cu8tss3CRrRAnODxFRUraOZ6v
         U9zqduG6eSYpu1t3orCaCmPdDdUwwh3vvNYisKhKNZ+whKbrBKVF64w7+SpR3E2oUu
         1mTjMHUWSDhew==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <bdda0e0b-56b7-025b-ad86-f790517c65b8@linaro.org>
References: <bdda0e0b-56b7-025b-ad86-f790517c65b8@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <bdda0e0b-56b7-025b-ad86-f790517c65b8@linaro.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git tags/thermal-v5.11-2-rc1
X-PR-Tracked-Commit-Id: 67698880ac9d56367ebf22f8336ccab6234f9feb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 432c19a8d965aa0123e0a81492492a7cb1da5257
Message-Id: <160832488331.19372.589470332204463342.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Dec 2020 20:54:43 +0000
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 18 Dec 2020 09:11:51 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git tags/thermal-v5.11-2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/432c19a8d965aa0123e0a81492492a7cb1da5257

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
