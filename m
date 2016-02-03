From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/5] cpufreq: governor: Create separate sysfs-ops
Date: Wed, 3 Feb 2016 16:25:13 +0530
Message-ID: <20160203105513.GA3469@vireshk>
References: <20160202154717.GI3947@e106622-lin>
 <CAJZ5v0h3k_CVDkmc8QKczr0MxCuGd+Rm_wSMXO=UHBvOjae0Uw@mail.gmail.com>
 <20160202170144.GL3947@e106622-lin>
 <CAJZ5v0hL4sybqiWCYJpornfJcpMXeAg4E2UNKcCxRB08dhaFPA@mail.gmail.com>
 <56B12BEC.9070603@codeaurora.org>
 <CAJZ5v0jjp7stM6O4XbDjATOUjntpYY-85FeiCC-WUeRVaQwTLA@mail.gmail.com>
 <CAJZ5v0i3WLgu8U5cmEQtfUDy6-LXN3g7auSVjOaMEHd_gqVzvg@mail.gmail.com>
 <56B158A0.6060604@codeaurora.org>
 <20160203065442.GV31828@vireshk>
 <20160203105107.GQ3947@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34152 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbcBCKzQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Feb 2016 05:55:16 -0500
Received: by mail-pa0-f53.google.com with SMTP id uo6so12031948pac.1
        for <linux-pm@vger.kernel.org>; Wed, 03 Feb 2016 02:55:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160203105107.GQ3947@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Saravana Kannan <skannan@codeaurora.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 03-02-16, 10:51, Juri Lelli wrote:
> I also think that sched-dvfs should not use cpufreq_governor.c.  It is
> useful boilerplate code for ondemand and conservative, as they share lot
> of data structures and how they work, but it doesn't necessarily suit
> everybody's needs, IMHO.
> 
> OTOH, fixing the current issue in the best way we can come up with has
> still value of course :).

Right. cpufreq_governor.c is more about the technique where we do load
evaluation using deferred timers and workqueues, which isn't required
for sched-dvfs.

We can just move the common parts, like, governor_show/governor_store
routines, and the new macros being added here.

-- 
viresh
