Return-Path: <SRS0=Jmv8=A3=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198DEC433E0
	for <linux-pm@archiver.kernel.org>; Thu, 16 Jul 2020 19:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E03372083B
	for <linux-pm@archiver.kernel.org>; Thu, 16 Jul 2020 19:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594926304;
	bh=BFbwfWJpiL95LXiR69gz6/hzOi80cRnQ5OsZptnMVPo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=D3WNmXKx7zUpEN+qEo5YhRCJRSPFz2kfcdzdtL6hja1VUepavMia1NXQFEU83CFqh
	 b0d9tTFu5YsetZg4affUkfSnZopAFCfdMB6ivOxCnaNsAAx7ktQbb/CngSFGlTMLQY
	 9Yd8MYuGYMZFutZxqdSNuxHmF3hpx9L9nQxgi3WU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgGPTFE (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 16 Jul 2020 15:05:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728163AbgGPTFE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Jul 2020 15:05:04 -0400
Subject: Re: [GIT PULL] thermal fixes for v5.8-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594926303;
        bh=BFbwfWJpiL95LXiR69gz6/hzOi80cRnQ5OsZptnMVPo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ORlDRut9Pv4L4r4DjpDFxQg24kvM0D0KIvLPep06yo/cYdWMsfaFJO/lsCZF0n0Qx
         9VYHHRC5VVv1nnIyr3WQqfNCGnWa8lQ9B8nTzgMkgAZKtfxiPjfgphVFrnvuLRAxRm
         C1en6Ra0IcNK7wHMdaAd4hI6d1TG+jBiXFL64O28=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <40ec1ad2-1938-81ee-5ddb-965c18ddd25f@linaro.org>
References: <40ec1ad2-1938-81ee-5ddb-965c18ddd25f@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <40ec1ad2-1938-81ee-5ddb-965c18ddd25f@linaro.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
 tags/thermal-v5.8-rc6
X-PR-Tracked-Commit-Id: a8f62f183021be389561570ab5f8c701a5e70298
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7e8d2f6d4d8fa6adc5075d39184c2ce713ce168e
Message-Id: <159492630380.21154.11953236217402014309.pr-tracker-bot@kernel.org>
Date:   Thu, 16 Jul 2020 19:05:03 +0000
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        alex.hung@canonical.com, bsz@semihalf.com
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Thu, 16 Jul 2020 15:21:18 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git tags/thermal-v5.8-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7e8d2f6d4d8fa6adc5075d39184c2ce713ce168e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
