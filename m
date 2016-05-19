From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH 3/5] sched: cpufreq: call cpufreq hook from remote CPUs
Date: Thu, 19 May 2016 16:04:19 -0700
Message-ID: <20160519230419.GB15383@graphite.smuckle.net>
References: <1462828814-32530-1-git-send-email-smuckle@linaro.org>
 <1462828814-32530-4-git-send-email-smuckle@linaro.org>
 <CAJZ5v0iWfc=cNaCVuQ9QLK0FMLy1i5zEVcZSutOAK=+1OxaRtg@mail.gmail.com>
 <CAJZ5v0i-9QhNt1o_MN9_kEut6vs53-nwkM44dYq8hnuxynn4eQ@mail.gmail.com>
 <20160519191916.GE17223@graphite.smuckle.net>
 <CAJZ5v0hu=6sp=p+jYXfesSC20ZfKcGL6f5fTpvC+RX1uAEbn=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34792 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755371AbcESXEY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2016 19:04:24 -0400
Received: by mail-pf0-f176.google.com with SMTP id y69so34494699pfb.1
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2016 16:04:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hu=6sp=p+jYXfesSC20ZfKcGL6f5fTpvC+RX1uAEbn=A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>

On Thu, May 19, 2016 at 11:06:14PM +0200, Rafael J. Wysocki wrote:
> > In the case of a remote update the hook has to run (or not) after it is
> > known whether preemption will occur so we don't do needless work or
> > IPIs. If the policy CPUs aren't known in the scheduler then the early
> > hook will always need to be called along with an indication that it is
> > the early hook being called. If it turns out to be a remote update it
> > could then be deferred to the later hook, which would only be called
> > when a remote update has been deferred and preemption has not occurred.
> >
> > This means two hook inovcations for a remote non-preempting wakeup
> > though instead of one.  Perhaps this is a good middle ground on code
> > churn vs. optimization though.
> 
> I would think so.

Ok, I will pursue this approach.

thanks,
Steve
