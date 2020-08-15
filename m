Return-Path: <SRS0=9a4i=BZ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AE0C433E3
	for <linux-pm@archiver.kernel.org>; Sat, 15 Aug 2020 22:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 507C120639
	for <linux-pm@archiver.kernel.org>; Sat, 15 Aug 2020 22:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597529248;
	bh=aOXvxGmPhzz+32a1KyqhnB8MobO7kDX4GjmwhMfxUXc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=yEOmWHG+kOCxzyv0asaCVp3hwATJ1t5JenUOlaoRIbKcT8hx7xR+XRPnUUggsNl/c
	 N5T8wC561R2X6GdXeiPP1qfaEArm840d6QSeaAJZ/7Pc9TPYFUNPwyCdURofIX9KWb
	 9lupC69pRPA7e8LeCOkIgqAbdeOlj6q8L07uAs6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbgHOWGY (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:06:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729895AbgHOWF1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 15 Aug 2020 18:05:27 -0400
Subject: Re: [GIT PULL] One more power management update for v5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597504982;
        bh=aOXvxGmPhzz+32a1KyqhnB8MobO7kDX4GjmwhMfxUXc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BqnAEZnsuRruaZuAeVk3vn0a1ZVB5u6dHk5te3DEKjVAfZ/8QMb3IVw2Hz1LzeYqB
         Dks3WyqxbbWKxZebCkS+u9/UmFMbg5BJO25QvIjFicnJddJA8BU88XSUbU1akB5iww
         f3kNzXhJ3cc+bD4J4LEm/x6GOcOLKKnkup8WZY6Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0g42_UymEznQCjyaQMaDbO5txyDncAaGXogpSA9R8MZwQ@mail.gmail.com>
References: <CAJZ5v0g42_UymEznQCjyaQMaDbO5txyDncAaGXogpSA9R8MZwQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0g42_UymEznQCjyaQMaDbO5txyDncAaGXogpSA9R8MZwQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.9-rc1-3
X-PR-Tracked-Commit-Id: f3db6de55e95eee6457a14912dd382a6cfc98edd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1a5d9dbbaf3af4d029a081bd58dc83b6a25d109e
Message-Id: <159750498216.10263.591389960235742250.pr-tracker-bot@kernel.org>
Date:   Sat, 15 Aug 2020 15:23:02 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 14 Aug 2020 20:08:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.9-rc1-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1a5d9dbbaf3af4d029a081bd58dc83b6a25d109e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
