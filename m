From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH] cpufreq: dt: Set default policy->transition_delay_ns
Date: Mon, 22 May 2017 19:17:38 +0800
Message-ID: <20170522111738.GB9325@leoy-ThinkPad-T440>
References: <16157eb75bb26cca73a0da930e49f2549b96fd65.1495429745.git.viresh.kumar@linaro.org>
 <87h90d2mqm.fsf@arm.com>
 <20170522105522.GG6510@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35110 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752927AbdEVLRt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 May 2017 07:17:49 -0400
Received: by mail-pf0-f181.google.com with SMTP id n23so79416469pfb.2
        for <linux-pm@vger.kernel.org>; Mon, 22 May 2017 04:17:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170522105522.GG6510@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Brendan Jackman <brendan.jackman@arm.com>, linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>

On Mon, May 22, 2017 at 04:25:22PM +0530, Viresh Kumar wrote:
> On 22-05-17, 11:45, Brendan Jackman wrote:
> > Hi Viresh,
> > 
> > On Mon, May 22 2017 at 05:10, Viresh Kumar wrote:
> > > The rate_limit_us for the schedutil governor is getting set to 500 ms by
> > > default for the ARM64 hikey board. And its way too much, even for the
> > > default value. Lets set the default transition_delay_ns to something
> > > more realistic (10 ms), while the userspace always have a chance to set
> > > something it wants.
> > 
> > Just a thought - do you think we can treat the reported transition
> > latency as a proxy for the "cost" of freq transitions?  I.e. assume that
> > on platforms with very fast frequency switching it's probably cheap to
> > switch frequency and we want schedutil to respond quickly, whereas on
> > platforms with big latencies, frequency switches might be expensive and
> > we probably want hysteresis.
> > 
> > If that makes sense then maybe we could use 10 * transition_latency /
> > NSEC_PER_USEC, when transition_latency is reported? Otherwise 10ms seems
> > sensible to me..
> 
> So my platform (hikey) does provide transition-latency as 500 us. But
> schedutil multiplies that with LATENCY_MULTIPLIER (1000) and that
> makes it 500000 rate_limit_us, which is unacceptable.
> 
> @Rafael: Why does the LATENCY_MULTIPLIER has such a high value? I am
> not sure I understood completely on why we have this multiplier :(

This afternoon Amit pointed me for this patch, should fix as below?
Otherwise it seems directly assign the same value from unit 'ns' to
'us' but without any value conversion.

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 76877a6..dcc90fc 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -538,7 +538,7 @@ static int sugov_init(struct cpufreq_policy *policy)
                unsigned int lat;
 
                tunables->rate_limit_us = LATENCY_MULTIPLIER;
-               lat = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
+               lat = policy->cpuinfo.transition_latency / NSEC_PER_MSEC;
                if (lat)
                        tunables->rate_limit_us *= lat;
        }

Thanks,
Leo Yan
