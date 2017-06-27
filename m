From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: dt: Set default policy->transition_delay_ns
Date: Tue, 27 Jun 2017 02:15:12 +0200
Message-ID: <1537403.PHBCuCX8Fr@aspire.rjw.lan>
References: <16157eb75bb26cca73a0da930e49f2549b96fd65.1495429745.git.viresh.kumar@linaro.org> <20170522111738.GB9325@leoy-ThinkPad-T440> <20170522112727.GI6510@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:48381 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751453AbdF0AWh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jun 2017 20:22:37 -0400
In-Reply-To: <20170522112727.GI6510@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>, Brendan Jackman <brendan.jackman@arm.com>, linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>

On Monday, May 22, 2017 04:57:27 PM Viresh Kumar wrote:
> On 22-05-17, 19:17, Leo Yan wrote:
> > This afternoon Amit pointed me for this patch, should fix as below?
> > Otherwise it seems directly assign the same value from unit 'ns' to
> > 'us' but without any value conversion.
> > 
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 76877a6..dcc90fc 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -538,7 +538,7 @@ static int sugov_init(struct cpufreq_policy *policy)
> >                 unsigned int lat;
> >  
> >                 tunables->rate_limit_us = LATENCY_MULTIPLIER;
> > -               lat = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
> > +               lat = policy->cpuinfo.transition_latency / NSEC_PER_MSEC;
> >                 if (lat)
> >                         tunables->rate_limit_us *= lat;
> >         }
> 
> I will let Rafael comment in as well. NSEC_PER_USEC is used in the
> earlier governors as well (ondemand/conservative) in exactly the same
> way as schedutil is using.

The reason why it is used by schedutil is because the other governors used it
that way.  IOW, doesn't matter. :-)

Thanks,
Rafael
