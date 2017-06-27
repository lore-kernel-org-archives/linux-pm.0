From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: dt: Set default policy->transition_delay_ns
Date: Tue, 27 Jun 2017 18:08:43 +0200
Message-ID: <CAJZ5v0hWQ0=3aB1Xp2tU1RyMfVhg-9xZiix8ccpH_MjvqS5PAw@mail.gmail.com>
References: <16157eb75bb26cca73a0da930e49f2549b96fd65.1495429745.git.viresh.kumar@linaro.org>
 <20170522111738.GB9325@leoy-ThinkPad-T440> <20170522112727.GI6510@vireshk-i7>
 <1537403.PHBCuCX8Fr@aspire.rjw.lan> <20170627042041.GA29665@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:33195 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751483AbdF0QIp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jun 2017 12:08:45 -0400
In-Reply-To: <20170627042041.GA29665@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Leo Yan <leo.yan@linaro.org>, Brendan Jackman <brendan.jackman@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Amit Kucheria <amit.kucheria@linaro.org>

Hi,

On Tue, Jun 27, 2017 at 6:20 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 27-06-17, 02:15, Rafael J. Wysocki wrote:
>> On Monday, May 22, 2017 04:57:27 PM Viresh Kumar wrote:
>> > On 22-05-17, 19:17, Leo Yan wrote:
>> > > This afternoon Amit pointed me for this patch, should fix as below?
>> > > Otherwise it seems directly assign the same value from unit 'ns' to
>> > > 'us' but without any value conversion.
>> > >
>> > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
>> > > index 76877a6..dcc90fc 100644
>> > > --- a/kernel/sched/cpufreq_schedutil.c
>> > > +++ b/kernel/sched/cpufreq_schedutil.c
>> > > @@ -538,7 +538,7 @@ static int sugov_init(struct cpufreq_policy *policy)
>> > >                 unsigned int lat;
>> > >
>> > >                 tunables->rate_limit_us = LATENCY_MULTIPLIER;
>> > > -               lat = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
>
> I think the above line is just fine and the below one is incorrect, as
> we wanted to convert transition latency to usec here (i.e. in the
> units of rate_limit_us).
>
>> > > +               lat = policy->cpuinfo.transition_latency / NSEC_PER_MSEC;
>> > >                 if (lat)
>> > >                         tunables->rate_limit_us *= lat;
>> > >         }
>> >
>> > I will let Rafael comment in as well. NSEC_PER_USEC is used in the
>> > earlier governors as well (ondemand/conservative) in exactly the same
>> > way as schedutil is using.
>>
>> The reason why it is used by schedutil is because the other governors used it
>> that way.  IOW, doesn't matter. :-)
>
> But I feel the value of LATENCY_MULTIPLIER (1000) is way too high. It currently
> says that if freq-switching takes time X, then we should wait for 999X time
> before we change the freq again.
>
> Perhaps LATENCY_MULTIPLIER should be just 10 or 20 here. For a platform with
> transition_latency 500 us, rate_limit_us comes to 500 ms. Which is absurd. We
> ideally want it to be around 10-20 ms here. And compared to other ARM platforms,
> 500 us transition_latency is very low. It normally is around 1-3 ms for ARM32
> platforms.
>
> @Rafael: Will it be fine to lower down the value of LATENCY_MULTIPLIER?

We can do that, but then I think we need to compensate for the change
in the old governors code or there may be surprises.

Thanks,
Rafael
