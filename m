Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2E4C2BBCA
	for <linux-pm@archiver.kernel.org>; Wed, 16 Dec 2020 01:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9D3F23A04
	for <linux-pm@archiver.kernel.org>; Wed, 16 Dec 2020 01:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgLPBB0 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 15 Dec 2020 20:01:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:51034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbgLPBBZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Dec 2020 20:01:25 -0500
Subject: Re: [GIT PULL] Power management updates for v5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608080408;
        bh=hUGd/QJtSNjPJqgc01/6MqGWmfn1WU7Np7+tgNNKhSE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HQBgNjlplKknmzHDENxHKE0Xc7BIq40Vj/DL7XINeYCzFxJwR1n7J0fXTJpni9PiL
         9A4EtjM+GPM47xEMTSpjK2176RARa3Jr53QVfYwwmgJE5YpgiHs4JXdbtWHXLsxvH5
         HboLlxKG5jJfqoSg/UkYCtz2AUAameSBGAF3XCC7Bk/wU3/dEAjAdCvOLWys+yH/4o
         aj/M7tupU2DcMT9W9/ZDXRoO74Os78s5kTzQXTAdb8iVptsj0tnE8ns2NqP0X76Cwh
         q13H/4RN7G+24ECj84H17VVaQe2vAR2CmYQltu4T1UGTo6sg3Wn6Q5tuUon0HOKqhI
         A1hsQ1dsTVL+w==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hpMcY_EEfaCQMSzYwvKyauHgnY00nY5p-OOvEBn0R2dA@mail.gmail.com>
References: <CAJZ5v0hpMcY_EEfaCQMSzYwvKyauHgnY00nY5p-OOvEBn0R2dA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hpMcY_EEfaCQMSzYwvKyauHgnY00nY5p-OOvEBn0R2dA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.11-rc1
X-PR-Tracked-Commit-Id: b3fac817830306328d5195e7f4fb332277f3b146
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b4ec805464a4a0299216a003278351d0b4806450
Message-Id: <160808040853.29502.15091712090405600061.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 01:00:08 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Tue, 15 Dec 2020 18:43:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b4ec805464a4a0299216a003278351d0b4806450

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
