Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1514EC433B4
	for <linux-pm@archiver.kernel.org>; Wed, 28 Apr 2021 23:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9E0461449
	for <linux-pm@archiver.kernel.org>; Wed, 28 Apr 2021 23:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhD1XNy (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 28 Apr 2021 19:13:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230294AbhD1XNw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 28 Apr 2021 19:13:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 11CAE6144B;
        Wed, 28 Apr 2021 23:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619651587;
        bh=lZHzaWFOrHoF7CvYIXypgBgZzssqMSd9Bpud0SK07g8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ff4CZRQRNzpsZms1WiAFbdiS5wXCPMRkpvjjMpFDj7MVnlyoFwjAv5uMIcqL5aN+G
         SmE/yt+G1yVQt0yISblbAeVSU6GuPwEag3SI6gV0RcDdQYAVG3m88/VOvV8vKFdZ7H
         v6VqLKSoIgm8+sxyXbRN23heZr4hhu1hmTfgCYWGQF1UQIKKDbbSD7GL+ZwfPwQCNd
         x5idzs2oQgzHwhSin0F+td0oPg8fvoiCp9zutEY5tK9Gelp5O5OXyJn6r75LDIoBB8
         +bPegDF4T6vabg4I35ofNyl9ZtgtjtOB0p5YfZZ8NYi/Su0w9/Ddbh3gMV2DFSBICC
         JEvaZwoem8Pyg==
Subject: Re: [GIT PULL] power-supply changes for 5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210427185105.j5lsytdmg4m5ow7v@earth.universe>
References: <20210427185105.j5lsytdmg4m5ow7v@earth.universe>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210427185105.j5lsytdmg4m5ow7v@earth.universe>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.13
X-PR-Tracked-Commit-Id: d0a43c12ee9f57ddb284272187bd18726c2c2c98
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a69e9bce9984806029926f405b4517878e703e2
Message-Id: <161965158703.11634.4239456421105840217.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Apr 2021 23:13:07 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Tue, 27 Apr 2021 20:51:05 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a69e9bce9984806029926f405b4517878e703e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
