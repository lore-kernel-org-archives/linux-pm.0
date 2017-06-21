From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH 2/6] drivers base/arch_topology: frequency-invariant
 load-tracking support
Date: Wed, 21 Jun 2017 18:08:25 +0100
Message-ID: <07ba559a-a270-db37-d43f-1540555a6369@arm.com>
References: <20170608075513.12475-1-dietmar.eggemann@arm.com>
 <20170608075513.12475-3-dietmar.eggemann@arm.com>
 <CAOh2x=k1Zr15vAq8LA0+Sg3Cz7o=dL5C-erkEx_py7g56b7BwA@mail.gmail.com>
 <5949BE5F.4020502@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55852 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751126AbdFURI2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Jun 2017 13:08:28 -0400
In-Reply-To: <5949BE5F.4020502@codeaurora.org>
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>

On 21/06/17 01:31, Saravana Kannan wrote:
> On 06/19/2017 11:17 PM, Viresh Kumar wrote:
>> On Thu, Jun 8, 2017 at 1:25 PM, Dietmar Eggemann
>> <dietmar.eggemann@arm.com> wrote:
>>
>>> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
>>
>>>   static int __init register_cpufreq_notifier(void)
>>>   {
>>> +       int ret;
>>> +
>>>          /*
>>>           * on ACPI-based systems we need to use the default cpu
>>> capacity
>>>           * until we have the necessary code to parse the cpu
>>> capacity, so
>>> @@ -225,8 +265,14 @@ static int __init register_cpufreq_notifier(void)
>>>
>>>          cpumask_copy(cpus_to_visit, cpu_possible_mask);
>>>
>>> -       return cpufreq_register_notifier(&init_cpu_capacity_notifier,
>>> -                                        CPUFREQ_POLICY_NOTIFIER);
>>> +       ret = cpufreq_register_notifier(&init_cpu_capacity_notifier,
>>> +                                       CPUFREQ_POLICY_NOTIFIER);
>>
>> Wanted to make sure that we all understand the constraints this is
>> going to add
>> for the ARM64 platforms.
>>
>> With the introduction of this transition notifier, we would not be
>> able to use
>> the fast-switch path in the schedutil governor. I am not sure if there
>> are any
>> ARM platforms that can actually use the fast-switch path in future or not
>> though. The requirement of fast-switch path is that the freq can be
>> changed
>> without sleeping in the hot-path.
>>
>> So, will we ever want fast-switching for ARM platforms ?
>>
> 
> I don't think we should go down a path that'll prevent ARM platform from
> switching over to fast-switching in the future.

Understood. But IMHO implementing a cpufreq transition notifier based
Frequency Invariance Engine (FIE) which provides frequency-invariant
accounting for 100% of today's arm/arm64 system is legitimate.

Like I said in the other email in this thread today, I can make sure
that I only register the cpufreq transition notifier if none of the
policies support fast frequency switching. In this case people can use
mainline to experiment with cpufreq drivers supporting fast frequency
switching (without FIE support).

> Having said that, I'm not sure I fully agree with the decision to
> completely disable notifiers in the fast-switching case. How many of the
> current users of notifiers truly need support for sleeping in the
> notifier? Why not make all the transition notifiers atomic? Or at least
> add atomic transition notifiers that can be registered for separately if
> the client doesn't need the ability to sleep?

IMHO, that's a different construction side inside the cpufreq framework.
Patches which introduced the fast frequency switching support in cpufreq
clearly state that "... fast frequency switching is inherently
incompatible with cpufreq transition notifiers ...".

If we can get rid of this restriction, the cpufreq transition notifier
based FIE implementation could stay. Otherwise we need a FIE for systems
with fast frequency switching based on something else, e.g. performance
counters.

> Most of the clients don't seem like ones that'll need to sleep.
> 
> There are a bunch of generic off-tree drivers (can't upstream them yet
> because it depends on the bus scaling framework) that also depend on
> CPUfreq transition notifiers that are going to stop working if fast
> switching becomes available in the future. So, this decision to disallow
> transition notifiers is painful for other reasons too.

Falls into the same bucket for me ... you have a requirement against the
cpufreq framework to let cpufreq transition notifier work for fast
frequency switching drivers.

[...]
