Return-Path: <SRS0=unav=Z3=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0363EC43603
	for <linux-pm@archiver.kernel.org>; Thu,  5 Dec 2019 20:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C742624670
	for <linux-pm@archiver.kernel.org>; Thu,  5 Dec 2019 20:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575578725;
	bh=K3G2xfF85qnI+L6YrE0WXy/VTwCuslOtU0yJMagB8Rg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=OFbbfDpcuC5PwPKCP2qakd0uMyBehZLWcPGIblrucZpTsT3qcNEac+KhKyWnzCOMz
	 faPoGJvPdEKT8nzHIA3Z4YXmIzYrH9EuX6eIpVtlmUShp9dz0rxIOaIP7He8EKYyRH
	 1PWtw2FZnLcpO6vsx9z/O499LZXuyReX8V/dK5Ik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbfLEUpZ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 5 Dec 2019 15:45:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:43248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfLEUpZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Dec 2019 15:45:25 -0500
Subject: Re: [GIT PULL] Thermal management updates for v5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575578724;
        bh=K3G2xfF85qnI+L6YrE0WXy/VTwCuslOtU0yJMagB8Rg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=c2pK//Kl1GIGyc7Y4/TuzeoBreUWWmnKOyEuiHOlT2fAjEO1gtY0oB/i4wHn3TUXi
         QoWcXsQthWfV3KTe+NF9K6jCHEvjx0mkmQTVE6MjMPeAWiDlqFUbfRaXgBOIcWQ9Xu
         FzOg554uD+zXtbqqedKaqVzh49wMTby+mNLtPSt0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <7f4da1c663268f53f2123424c1b8abdbe8316556.camel@intel.com>
References: <7f4da1c663268f53f2123424c1b8abdbe8316556.camel@intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <7f4da1c663268f53f2123424c1b8abdbe8316556.camel@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git thermal/next
X-PR-Tracked-Commit-Id: 163b00cde7cf2206e248789d2780121ad5e6a70b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb3da48a8640f634242a0c61b78c3a5c724c5004
Message-Id: <157557872460.26858.8137883580141541225.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Dec 2019 20:45:24 +0000
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Zhang, Rui" <rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Wed, 04 Dec 2019 14:16:55 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git thermal/next

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb3da48a8640f634242a0c61b78c3a5c724c5004

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
