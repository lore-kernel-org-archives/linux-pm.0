Return-Path: <SRS0=UdxF=CN=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C14AC43461
	for <linux-pm@archiver.kernel.org>; Fri,  4 Sep 2020 20:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C0BF20C09
	for <linux-pm@archiver.kernel.org>; Fri,  4 Sep 2020 20:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599252561;
	bh=trbrAlynvbWshtid7fIHyNMSxTfThqHzhHqSdYOEsYU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Xi9mo9LOlksX2YV+1j3GFCHbn+c4nslGtH2xbPqoavjiYjzxtxNLiW1Gv5skYNFau
	 e2KS+2TQAEpCYVWfxkf9fPe1EHY3gbl/P4loFKc+59kDJxgplYbqiGaaLDlcd5oCJh
	 P9ufFEoOrk8D6m3bPpbpfVwk6NnsdjqGK2m7RW8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgIDUtT (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 4 Sep 2020 16:49:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:32880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728120AbgIDUtS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 4 Sep 2020 16:49:18 -0400
Subject: Re: [GIT PULL] Power management fixes for v5.9-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599252557;
        bh=trbrAlynvbWshtid7fIHyNMSxTfThqHzhHqSdYOEsYU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TvHr0he0uYtMa5cOOcDV6NfH9JHHhVUn9OYu/v7fZhjiJ0I/ftFSQIvWYU0LRuuMS
         8IFEMiL/n719rpB25A+3t3iTPB358zlyWVJBppbcWMjU8TTynfdCDM8O8aHIYDj7eY
         ifGPcdzpvEotrjfMMe4L0d8ySDudoS7DDtydT6IY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hTogaEjc9GAwBN15kgC5+aiRLSohn3DATr51BU9rwy6A@mail.gmail.com>
References: <CAJZ5v0hTogaEjc9GAwBN15kgC5+aiRLSohn3DATr51BU9rwy6A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hTogaEjc9GAwBN15kgC5+aiRLSohn3DATr51BU9rwy6A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.9-rc4
X-PR-Tracked-Commit-Id: f7ce2c3afc938b7d743ee8e5563560c04e17d7be
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f162626a038ec06da98ac38ce3d6bdbd715e9c5f
Message-Id: <159925255778.25529.13168777069493769306.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Sep 2020 20:49:17 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 4 Sep 2020 18:56:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.9-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f162626a038ec06da98ac38ce3d6bdbd715e9c5f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
