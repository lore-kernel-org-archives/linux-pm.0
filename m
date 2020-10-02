Return-Path: <SRS0=MpoM=DJ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B5BC4363D
	for <linux-pm@archiver.kernel.org>; Fri,  2 Oct 2020 17:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7A3F20758
	for <linux-pm@archiver.kernel.org>; Fri,  2 Oct 2020 17:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601658939;
	bh=MdOs8rfzL8ofy2RvSAwtghYM4Dhu0UuMWOHpgUvDSS0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=hngb3M9ow7Km3QPa1NpKGds/b9S3tV4DyLHygr1Zgj5GvnzReLtJXR5HFpdZvgU4n
	 jKLjjx14Drm9+ndzkDvjyWnbm55mDwqtVvc8YaCwksvbV8RQCNSy2oY1W0z7MJ6k+A
	 tzEDSb3s7P9mmLztjZalcLDoU+NWu4f4PpDDeFtY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388310AbgJBRPb (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 2 Oct 2020 13:15:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388195AbgJBRPQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 2 Oct 2020 13:15:16 -0400
Subject: Re: [GIT PULL] Power management fixes for v5.9-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601658915;
        bh=MdOs8rfzL8ofy2RvSAwtghYM4Dhu0UuMWOHpgUvDSS0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ydg/ejgIaiTTGTjtH3Q7/aWx4VUE/+FHjagC68Sua8hSaqogfXE/RWrbTx1P9Oghk
         8JLTm6tHomB1EEL+yrKNZSTEMq1ZsxHF83BJVQOFcGEFBUzn2MjIk7iXjRBrqiB2IJ
         +xaKCyWrqlzvseRTq/uakDHRaRmlK/BvEaodkzoY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jppvMLqbSu20gx6dL=bZWv6_ZbDRYW6Djg3V1oTJyWAA@mail.gmail.com>
References: <CAJZ5v0jppvMLqbSu20gx6dL=bZWv6_ZbDRYW6Djg3V1oTJyWAA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jppvMLqbSu20gx6dL=bZWv6_ZbDRYW6Djg3V1oTJyWAA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.9-rc8
X-PR-Tracked-Commit-Id: 7bbe8f2a7e7e819c050212a4bc984f03dc85af9d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c5130911033149c18bf84fa094c8e5def26ec8d0
Message-Id: <160165891586.31225.18104820035652557781.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Oct 2020 17:15:15 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 2 Oct 2020 18:47:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.9-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c5130911033149c18bf84fa094c8e5def26ec8d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
