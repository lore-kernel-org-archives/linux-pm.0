Return-Path: <SRS0=jqOB=7X=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD5DC433E0
	for <linux-pm@archiver.kernel.org>; Wed, 10 Jun 2020 18:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79BEB20842
	for <linux-pm@archiver.kernel.org>; Wed, 10 Jun 2020 18:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591815333;
	bh=SipNtjRwgj4SKVtNjglr7ADTNHOzPL6bxlslc8Oj+m4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=EXNEoVlFrfvyxP3iLto++hcVTBYCLPxLrFDkAUwgAIBkxCAIQ6yTqoo5BTHTdJaPd
	 ukEB1+dIb2Bufg8d6S2P6q+B+EWgoSWWJlRIskeceQOiZAoPEjh9Xgd7RX5x0Q5wAm
	 NCLf25DBjGa/BofeGm2xUTSJOPSeEk8NO5zOEW3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbgFJSzY (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 10 Jun 2020 14:55:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729686AbgFJSzW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Jun 2020 14:55:22 -0400
Subject: Re: [GIT PULL] power-supply changes for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591815322;
        bh=SipNtjRwgj4SKVtNjglr7ADTNHOzPL6bxlslc8Oj+m4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=e9+yDEAREMUi60DFLSN/1g16XavRpMkLUIxXufEr5uLm2N7FvgFLiVIVtz3gC1Ixz
         nwVPU/bnHgF7gYOvZqiP7W0CbJhJThSuHO2nxusxiHC7kMn7WcdtxQbuUU64xYWBOd
         aT5BHNupG3KSVew9fRKevxztbUUlG7HYGxSpQtls=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200609153756.rdkntdy4i6zgcpbu@earth.universe>
References: <20200609153756.rdkntdy4i6zgcpbu@earth.universe>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200609153756.rdkntdy4i6zgcpbu@earth.universe>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
 tags/for-v5.8
X-PR-Tracked-Commit-Id: 152204dbdcee6df9406f87c81f9591aeaf1ba55b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a2a8751742133a7bbc49b9d1bcbd52e212edff6
Message-Id: <159181532255.20525.1613703973667409147.pr-tracker-bot@kernel.org>
Date:   Wed, 10 Jun 2020 18:55:22 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Tue, 9 Jun 2020 17:37:56 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a2a8751742133a7bbc49b9d1bcbd52e212edff6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
