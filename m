Return-Path: <SRS0=Jmv8=A3=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D5DC433E7
	for <linux-pm@archiver.kernel.org>; Thu, 16 Jul 2020 19:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A4F7207FB
	for <linux-pm@archiver.kernel.org>; Thu, 16 Jul 2020 19:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594926315;
	bh=2lv2moTnU2N6dASfaQw7diBNj1rlFRlEn5eGBC9WFxE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=bJ6gAHDfNDLrr+XSlPPxjHlXnE3FDFZ0Jm+BVZew6hPajL4hnnVWJGrtW4vaVl+8I
	 bQJDxDNzszHu532YKcXbpKYtE8CqrqRbyW1SM+koDv0Ll5yRh6wXvuxZCcXc2WEewU
	 cOLCexdZtWGY25cUrGGl20J+aywWW62ont6rI16A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgGPTFN (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 16 Jul 2020 15:05:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729518AbgGPTFF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Jul 2020 15:05:05 -0400
Subject: Re: [GIT PULL] Power management fixes for v5.8-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594926305;
        bh=2lv2moTnU2N6dASfaQw7diBNj1rlFRlEn5eGBC9WFxE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mw8Zj3cmoERxWTGx72bxmYcGct+hXlvO78/kRpS6gefO3bIYVBDfvvxPL5ITRYvV3
         bBDMozy02qr5aPbX4CIGVrwTi1sa5edcLUO03yxFp6F+cAuyBCtnwx+/CRpQuEdpnA
         2xXRw3manyVJtIXWIzejx3BpeFBr03rTbepL0f/w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iikebC7mujzog-Vge8=OhrZwQU0ii2FMZO215NfBpvhA@mail.gmail.com>
References: <CAJZ5v0iikebC7mujzog-Vge8=OhrZwQU0ii2FMZO215NfBpvhA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iikebC7mujzog-Vge8=OhrZwQU0ii2FMZO215NfBpvhA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.8-rc6
X-PR-Tracked-Commit-Id: 1740f21af58b89a072f33ae0912d5acf95314f22
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 07a56bb875afbe39dabbf6ba7b83783d166863db
Message-Id: <159492630552.21154.16615393976916437508.pr-tracker-bot@kernel.org>
Date:   Thu, 16 Jul 2020 19:05:05 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Thu, 16 Jul 2020 19:29:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.8-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/07a56bb875afbe39dabbf6ba7b83783d166863db

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
