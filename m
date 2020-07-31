Return-Path: <SRS0=1j1E=BK=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5661C433DF
	for <linux-pm@archiver.kernel.org>; Fri, 31 Jul 2020 06:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEA262083B
	for <linux-pm@archiver.kernel.org>; Fri, 31 Jul 2020 06:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596176208;
	bh=WHR8jRh3qw/PGsoIxzFulqDz9Zu+JVeoIc2MSsUYN/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lOqL4h+x5xw993q+WTLAv07Hxii+YT0RIt0w982kgOmBpE+92TzHCpZ4IknIbvhdb
	 R834MQVhacbdlyQjwuSwoc1xz6c42PydBA/7+gpl8+fbNE1IT7JA18Yi5tF+elnWJ/
	 Ga2G+xibpp6SIw/NZ0D9WUJiFkGnZLP++K02yIJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731297AbgGaGQs (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 31 Jul 2020 02:16:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731152AbgGaGQs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 Jul 2020 02:16:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D272F20663;
        Fri, 31 Jul 2020 06:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596176207;
        bh=WHR8jRh3qw/PGsoIxzFulqDz9Zu+JVeoIc2MSsUYN/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OI5lVO20EM3bWyyFImTT9FJvGHHPbgWeedyvuONmw7eQzwK2guodFYtmM8wMtPQo7
         84E9DviWGEsGT/vuijIg0pZsD91cb3fTYtBZzPAsf09vLA3IFwP3MyIMVuZC5x4YES
         PRf7eWSVxUIqpW41z3Nb3Tm1G6btg7r5zEwIz+Do=
Date:   Fri, 31 Jul 2020 08:16:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dongdong Yang <contribute.kernel@gmail.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        devel@driverdev.osuosl.org, gulinghua@xiaomi.com,
        tanggeliang@xiaomi.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, yangdongdong@xiaomi.com,
        duhui@xiaomi.com, zhangguoquan@xiaomi.com, fengwei@xiaomi.com,
        taojun@xiaomi.com, rocking@linux.alibaba.com, huangqiwu@xiaomi.com
Subject: Re: [PATCH] sched: Provide USF for the portable equipment.
Message-ID: <20200731061634.GA1508201@kroah.com>
References: <cover.1596101307.git.yangdongdong@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1596101307.git.yangdongdong@xiaomi.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 30, 2020 at 09:35:42PM +0800, Dongdong Yang wrote:
> From: Dongdong Yang <yangdongdong@xiaomi.com>
> 
> This patch provides USF(User Sensitive Feedback factor)
> auxiliary cpufreq governor to support high level layer
> sysfs inodes setting for utils adjustment purpose from
> the identified scenario on portable equipment.
> Because the power consumption and UI response are more
> cared for by portable equipment users. And the "screen
> off" status stands for no request from the user, however,
> the kernel is still expected to notify the user in time
> on modem, network or powerkey events occur. USF provides
> "sched_usf_non_ux_r" sysfs inode to cut down the utils
> from user space tasks according to high level scenario.
> In addition, it usually hints more cpufreq demand that
> the preemptive counts of the tasks on the cpu burst and
> over the user expecting completed time such as the ratio
> sysctl_sched_latency to sysctl_sched_min_granularity
> on "screen on" status, which more likely with more UI.
> The sysfs inodes "sched_usf_up_l0_r" and "sched_usf_down_r"
> have been provided to adjust the utils according to high
> level identified scenario to alloc the cpufreq in time.
> 
> Dongdong Yang (1):
>   sched: Provide USF for portable equipment.
> 
>  drivers/staging/Kconfig          |   2 +
>  drivers/staging/Makefile         |   1 +
>  drivers/staging/fbsched/Kconfig  |  10 ++
>  drivers/staging/fbsched/Makefile |   2 +
>  drivers/staging/fbsched/usf.c    | 351 +++++++++++++++++++++++++++++++++++++++
>  kernel/sched/cpufreq_schedutil.c |  11 +-
>  6 files changed, 376 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/staging/fbsched/Kconfig
>  create mode 100644 drivers/staging/fbsched/Makefile
>  create mode 100644 drivers/staging/fbsched/usf.c

For new staging drivers/code, we need a TODO file that lists what
remains to be done on the code to get it out of staging/

I don't see any good reason why this has to go to staging now, what
prevents it from being merged to the "real" part of the kernel today?

thanks,

greg k-h
