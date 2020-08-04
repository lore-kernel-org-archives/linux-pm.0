Return-Path: <SRS0=P4yl=BO=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AE4C433E0
	for <linux-pm@archiver.kernel.org>; Tue,  4 Aug 2020 04:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C6B82245C
	for <linux-pm@archiver.kernel.org>; Tue,  4 Aug 2020 04:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596514512;
	bh=+2EsRC+Qic0KkQ3kzuRBcNtXJGYrxA9ONzB9tygN+xA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=C8BdvTdHeYCa2elJkRN24sjKA/BjHEGCP8vtSZpOV9glKgB0O2ohgLcl1bdmZfFJh
	 OBtCrz51gJI17TFYs77A4Vw9pEBxKpHtuqmlT+PqwZgmZ1NgB2pcK3XI3Ns31yKAb5
	 tYO2Zf5QElF+Ye3a+SfWswtIbAFkIdV0m5mIcuJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgHDEPJ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 4 Aug 2020 00:15:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbgHDEPJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 Aug 2020 00:15:09 -0400
Subject: Re: [GIT PULL] Power management fixes for v5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596514508;
        bh=+2EsRC+Qic0KkQ3kzuRBcNtXJGYrxA9ONzB9tygN+xA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DDFm0Vdozzy+J19hWwK5ioxApI/bI6Z9dY7nHaxHPU0K8kYWE3xglS2ulpNRUu52u
         kfS7RfrLyBWNthffXxJ/4V5hvJSepxWn1vQMSlmxZdM1vc8MvqIbRnJIieoEaKJcWj
         NUkqAocAI08toKJwddLeV5ItpLhgJgbCRcxeGQms=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gu2wsaPqb=qTVh1+AfQJQviHF=33EyB5kYS6-ZqZTE8Q@mail.gmail.com>
References: <CAJZ5v0gu2wsaPqb=qTVh1+AfQJQviHF=33EyB5kYS6-ZqZTE8Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gu2wsaPqb=qTVh1+AfQJQviHF=33EyB5kYS6-ZqZTE8Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.9-rc1
X-PR-Tracked-Commit-Id: 86ba54fb0816480941cda78a99f107ab2bbd4249
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 04084978003c1a1810a0b1fea581078106394a32
Message-Id: <159651450873.27277.14268882515890352291.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Aug 2020 04:15:08 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Mon, 3 Aug 2020 18:50:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/04084978003c1a1810a0b1fea581078106394a32

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
