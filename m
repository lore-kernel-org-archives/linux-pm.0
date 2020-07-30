Return-Path: <SRS0=1on1=BJ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FBAC433E0
	for <linux-pm@archiver.kernel.org>; Thu, 30 Jul 2020 10:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F7C12083B
	for <linux-pm@archiver.kernel.org>; Thu, 30 Jul 2020 10:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgG3KXz (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 30 Jul 2020 06:23:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:32790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgG3KXy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 30 Jul 2020 06:23:54 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4D202082E;
        Thu, 30 Jul 2020 10:23:51 +0000 (UTC)
Date:   Thu, 30 Jul 2020 11:23:49 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qian Cai <cai@lca.pw>, Sudeep Holla <sudeep.holla@arm.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] arm, arm64: Fix selection of
 CONFIG_SCHED_THERMAL_PRESSURE
Message-ID: <20200730102348.GF25149@gaia>
References: <20200729135718.1871-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729135718.1871-1-valentin.schneider@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 29, 2020 at 02:57:18PM +0100, Valentin Schneider wrote:
> Qian reported that the current setup forgoes the Kconfig dependencies and
> results in warnings such as:
> 
>   WARNING: unmet direct dependencies detected for SCHED_THERMAL_PRESSURE
>     Depends on [n]: SMP [=y] && CPU_FREQ_THERMAL [=n]
>     Selected by [y]:
>     - ARM64 [=y]
> 
> Revert commit
> 
>   e17ae7fea871 ("arm, arm64: Select CONFIG_SCHED_THERMAL_PRESSURE")
> 
> and re-implement it by making the option default to 'y' for arm64 and arm,
> which respects Kconfig dependencies (i.e. will remain 'n' if
> CPU_FREQ_THERMAL=n).
> 
> Fixes: e17ae7fea871 ("arm, arm64: Select CONFIG_SCHED_THERMAL_PRESSURE")
> Reported-by: Qian Cai <cai@lca.pw>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  arch/arm/Kconfig   | 1 -
>  arch/arm64/Kconfig | 1 -
>  init/Kconfig       | 2 ++
>  3 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
