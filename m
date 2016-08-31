From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v6 2/8] arm: parse cpu capacity-dmips-mhz from DT
Date: Wed, 31 Aug 2016 10:14:24 +0200
Message-ID: <CAKfTPtDAjedxh9J2rqOwafrmubN6+-wDyTRdNQh6fCAb2HS4RQ@mail.gmail.com>
References: <1468932048-31635-1-git-send-email-juri.lelli@arm.com>
 <1468932048-31635-3-git-send-email-juri.lelli@arm.com> <CAKfTPtBy7LGCW2T4AGoqL5L_1AHtW6KxHigxFVFVc_EU4oUO0g@mail.gmail.com>
 <20160830162853.GF9337@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:35085 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759063AbcHaIOr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Aug 2016 04:14:47 -0400
Received: by mail-lf0-f50.google.com with SMTP id f93so31034944lfi.2
        for <linux-pm@vger.kernel.org>; Wed, 31 Aug 2016 01:14:46 -0700 (PDT)
In-Reply-To: <20160830162853.GF9337@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Mark Brown <broonie@kernel.org>

On 30 August 2016 at 18:28, Juri Lelli <juri.lelli@arm.com> wrote:
> Hi Vincent,
>
> On 16/08/16 10:20, Vincent Guittot wrote:
>> Hi Juri,
>>
>>
>> On 19 July 2016 at 14:40, Juri Lelli <juri.lelli@arm.com> wrote:
>
> [...]
>
>> > +static int
>> > +init_cpu_capacity_callback(struct notifier_block *nb,
>> > +                          unsigned long val,
>> > +                          void *data)
>> > +{
>> > +       struct cpufreq_policy *policy = data;
>> > +       int cpu;
>> > +
>> > +       if (cap_parsing_failed || cap_parsing_done)
>> > +               return 0;
>> > +
>> > +       switch (val) {
>> > +       case CPUFREQ_NOTIFY:
>> > +               pr_debug("cpu_capacity: init cpu capacity for CPUs [%*pbl] (to_visit=%*pbl)\n",
>> > +                               cpumask_pr_args(policy->related_cpus),
>> > +                               cpumask_pr_args(cpus_to_visit));
>> > +               cpumask_andnot(cpus_to_visit,
>> > +                              cpus_to_visit,
>> > +                              policy->related_cpus);
>> > +               for_each_cpu(cpu, policy->related_cpus) {
>> > +                       raw_capacity[cpu] = arch_scale_cpu_capacity(NULL, cpu) *
>> > +                                           policy->max / 1000UL;
>>
>> Should it be policy->cpuinfo.max_freq instead of policy->max ?
>>
>
> Right. I'll fix the arm64 bits as well.
>
>> > +                       capacity_scale = max(raw_capacity[cpu], capacity_scale);
>> > +               }
>> > +               if (cpumask_empty(cpus_to_visit)) {
>> > +                       normalize_cpu_capacity();
>> > +                       kfree(raw_capacity);
>> > +                       pr_debug("cpu_capacity: parsing done\n");
>> > +                       cap_parsing_done = true;
>>
>> ok so you do that once with the 1st governor that will be registered
>> for the CPU. Can't you unregister the notifier then ?
>>
>
> I tried, but the only place I could find to unregister it is from the
> callback itself; and it is not possible to do so AFAIK. Suggestions?

yes, you're right
Can't you queue a work to unregister your callback ?
That's may be overkill but it seems weird to keep this notifier that
will do nothing, registered for the whole life of the system

>
> Thanks for the review.
>
> Best,
>
> - Juri
