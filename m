Return-Path: <SRS0=kFxE=5P=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D7CC43331
	for <linux-pm@archiver.kernel.org>; Mon, 30 Mar 2020 22:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A2A20774
	for <linux-pm@archiver.kernel.org>; Mon, 30 Mar 2020 22:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585607711;
	bh=jMq2T4Mf2LkqrJuXK6f8uYcGgFriY9O6ThWQhMT60Cc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ul16G4QcPj6e0XEYT/Bh8/4j8lM6t4LPcGaq3zNRlpFngIsBDla1k/ihPRIYjzQJp
	 9EG5GndyKxMrBTtdbWyGw4+sT8fjFIckYT2lm4XOgGBqoc7YvMQpYrOGPm6HWrlvY9
	 UNfIWwO/D86EneNeUiitelkgXGWtGl3tNKIlUCLo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgC3WfK (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 30 Mar 2020 18:35:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:49426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728876AbgC3WfK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Mar 2020 18:35:10 -0400
Subject: Re: [GIT PULL] Power management updates for v5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585607709;
        bh=jMq2T4Mf2LkqrJuXK6f8uYcGgFriY9O6ThWQhMT60Cc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=F8+nmvF9JiOBOVz5RIDcByDgZ66cTXCtTBcFr0BfImBPKdY9bY3JE0eEovylIm9WL
         gGRzOLQJgkTNc/NwwnNeYth4FjZ3dQSeXW7v0K4WyEGKk4RKDuMk6TwJ555nhEan7o
         Kmx4lefVodLfCflxmGg+mRywxK9tIqyL3JyMqSfE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0g=DNuHWVqxgJunTDm0bwPXTfo02gEZLy+eAfZJptVNkQ@mail.gmail.com>
References: <CAJZ5v0g=DNuHWVqxgJunTDm0bwPXTfo02gEZLy+eAfZJptVNkQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0g=DNuHWVqxgJunTDm0bwPXTfo02gEZLy+eAfZJptVNkQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.7-rc1
X-PR-Tracked-Commit-Id: 2409000a0cad2242fd4e2578f761f97069625478
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 49835c15a55225e9b3ff9cc9317135b334ea2d49
Message-Id: <158560770946.3567.616164261452066926.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Mar 2020 22:35:09 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 17:20:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/49835c15a55225e9b3ff9cc9317135b334ea2d49

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
