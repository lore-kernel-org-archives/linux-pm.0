From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH 4/8] cpufreq/schedutil: sysfs capacity margin tunable
Date: Wed, 16 Mar 2016 15:03:49 -0700
Message-ID: <20160316220349.11016.67079@quark.deferred.io>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
 <1457932932-28444-5-git-send-email-mturquette+renesas@baylibre.com>
 <20160315212047.GE6344@twins.programming.kicks-ass.net>
 <20160315214043.30639.75507@quark.deferred.io>
 <20160315214821.GM6344@twins.programming.kicks-ass.net>
 <20160315223701.30639.43127@quark.deferred.io> <56E8D4D9.1060202@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33848 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbcCPWD4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 18:03:56 -0400
Received: by mail-pf0-f171.google.com with SMTP id x3so90979743pfb.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Mar 2016 15:03:56 -0700 (PDT)
In-Reply-To: <56E8D4D9.1060202@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>, Patrick Bellasi <patrick.bellasi@arm.com>

Quoting Steve Muckle (2016-03-15 20:36:57)
> On 03/15/2016 03:37 PM, Michael Turquette wrote:
> >>>> Yuck sysfs.. I would really rather we did not expose this per default.
> >>>> > > > And certainly not in this weird form.
> >>> > > 
> >>> > > I'm happy to change capacity_margin to up_threshold and use a
> >>> > > percentage.
> >>> > > 
> >>> > > The sysfs approach has two benefits. First, it is aligned with cpufreq
> >>> > > user expectations. Second, there has been rough consensus that this
> >>> > > value should be tunable and sysfs gets us there quickly and painlessly.
> >>> > > We're already exporting rate_limit_us for schedutil via sysfs. Is there
> >>> > > a better way interface you can recommend?
> >> > 
> >> > It really depends on how tunable you want this to be. Do we always want
> >> > this to be a tunable, or just now while we're playing about with the
> >> > whole thing?
> >
> > I had considered this myself, and I really think that Steve and Juri
> > should chime in as they have spent more time tuning and running the
> > numbers.
> > 
> > I'm inclined to think that a debug version would be good enough, as I
> > don't imagine this value being changed at run-time by some userspace
> > daemon or something.
> > 
> > Then again, maybe this knob will be part of the mythical
> > power-vs-performance slider?
> 
> Patrick Bellasi's schedtune series [0] (which I think is the referenced
> mythical slider) aims to provide a more sophisticated interface for
> tuning scheduler-driven frequency selection. In addition to a global
> boost value it includes a cgroup controller as well for per-task tuning.

/me spends 15 seconds looking schedtune

> 
> I would definitely expect the margin/boost value to be modified at
> runtime, for example if the battery is running low, or the user wants
> 100% performance for a while, or the userspace framework wants to
> temporarily tailor the performance level for a particular set of tasks, etc.

Right, and it looks like schedtune is a kernel solution, not userspace
solution. The following three interfaces from patch #2 could be used by
schedtune:

unsigned long cpufreq_get_cfs_capacity_margin(void);
void cpufreq_set_cfs_capacity_margin(unsigned long margin);
void cpufreq_reset_cfs_capacity_margin(void);

Then we can let schedtune worry about the userspace abi.

So I'll keep the basic idea of this patch, but explore making it
debuggy, instead of sysfsy.

Regards,
Mike

> 
> [0] http://article.gmane.org/gmane.linux.kernel/2022959
