From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3 09/10] cpufreq: cpu0: rename driver and internals to 'cpufreq_generic'
Date: Tue, 09 Sep 2014 01:39:32 +0200
Message-ID: <1721663.ItCsG3Tt8O@vostro.rjw.lan>
References: <cover.1409201048.git.viresh.kumar@linaro.org> <1841344.yBggYEARvr@vostro.rjw.lan> <540E3933.8000904@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59684 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755079AbaIHXUG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Sep 2014 19:20:06 -0400
In-Reply-To: <540E3933.8000904@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, shawn.guo@linaro.org, linux-arm-msm@vger.kernel.org, spk.linux@gmail.com, thomas.ab@samsung.com, santosh.shilimkar@ti.com, thomas.petazzoni@free-electrons.com, pramod.gurav@smartplayin.com

On Monday, September 08, 2014 04:18:11 PM Stephen Boyd wrote:
> On 09/08/14 16:34, Rafael J. Wysocki wrote:
> > On Thursday, August 28, 2014 11:22:31 AM Viresh Kumar wrote:
> >> The naming convention of this driver was always under the scanner, people
> >> complained that it should have a more generic name than cpu0, as it manages all
> >> CPUs that are sharing clock lines.
> >>
> >> Also, in future it will be modified to support any number of clusters with
> >> separate clock/voltage lines.
> >>
> >> Lets rename it to 'cpufreq_generic' from 'cpufreq_cpu0'.
> > I'm not a big fan of changes like this to be honest, because they kind of
> > hide history.  For example, if you do a "git blame" on the new file, it will
> > show your commit and nothing before it.
> 
> Sounds like a tooling problem. But git blame doesn't have that behavior
> so there isn't actually any problem?

Ah, OK

It used to some time ago or maybe it depends on how you carry out the rename.

> $ git blame -- drivers/cpufreq/cpufreq-generic.c | head -10
> 95ceafd46359d drivers/cpufreq/cpufreq-cpu0.c    (Shawn Guo               2012-09-06 07:09:11 +0000   1) /*
> 95ceafd46359d drivers/cpufreq/cpufreq-cpu0.c    (Shawn Guo               2012-09-06 07:09:11 +0000   2)  * Copyright (C) 2012 Freescale Semiconductor, Inc.
> 95ceafd46359d drivers/cpufreq/cpufreq-cpu0.c    (Shawn Guo               2012-09-06 07:09:11 +0000   3)  *
> da1a765bf681c drivers/cpufreq/cpufreq-cpu0.c    (Viresh Kumar            2014-06-30 10:15:22 +0530   4)  * Copyright (C) 2014 Linaro.
> da1a765bf681c drivers/cpufreq/cpufreq-cpu0.c    (Viresh Kumar            2014-06-30 10:15:22 +0530   5)  * Viresh Kumar <viresh.kumar@linaro.org>
> da1a765bf681c drivers/cpufreq/cpufreq-cpu0.c    (Viresh Kumar            2014-06-30 10:15:22 +0530   6)  *
> ac4f646b8a5f3 drivers/cpufreq/cpufreq-generic.c (Viresh Kumar            2014-06-27 10:58:51 +0530   7)  * The OPP code in function set_target() is reused from
> 95ceafd46359d drivers/cpufreq/cpufreq-cpu0.c    (Shawn Guo               2012-09-06 07:09:11 +0000   8)  * drivers/cpufreq/omap-cpufreq.c
> 95ceafd46359d drivers/cpufreq/cpufreq-cpu0.c    (Shawn Guo               2012-09-06 07:09:11 +0000   9)  *
> 95ceafd46359d drivers/cpufreq/cpufreq-cpu0.c    (Shawn Guo               2012-09-06 07:09:11 +0000  10)  * This program is free software; you can redistribute it and/or modify
> 
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
