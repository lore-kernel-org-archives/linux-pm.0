From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH 2/6] drivers base/arch_topology: frequency-invariant load-tracking
 support
Date: Tue, 20 Jun 2017 17:31:27 -0700
Message-ID: <5949BE5F.4020502@codeaurora.org>
References: <20170608075513.12475-1-dietmar.eggemann@arm.com> <20170608075513.12475-3-dietmar.eggemann@arm.com> <CAOh2x=k1Zr15vAq8LA0+Sg3Cz7o=dL5C-erkEx_py7g56b7BwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60934 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752534AbdFUAba (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jun 2017 20:31:30 -0400
In-Reply-To: <CAOh2x=k1Zr15vAq8LA0+Sg3Cz7o=dL5C-erkEx_py7g56b7BwA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaor.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>

On 06/19/2017 11:17 PM, Viresh Kumar wrote:
> On Thu, Jun 8, 2017 at 1:25 PM, Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
>
>> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
>
>>   static int __init register_cpufreq_notifier(void)
>>   {
>> +       int ret;
>> +
>>          /*
>>           * on ACPI-based systems we need to use the default cpu capacity
>>           * until we have the necessary code to parse the cpu capacity, so
>> @@ -225,8 +265,14 @@ static int __init register_cpufreq_notifier(void)
>>
>>          cpumask_copy(cpus_to_visit, cpu_possible_mask);
>>
>> -       return cpufreq_register_notifier(&init_cpu_capacity_notifier,
>> -                                        CPUFREQ_POLICY_NOTIFIER);
>> +       ret = cpufreq_register_notifier(&init_cpu_capacity_notifier,
>> +                                       CPUFREQ_POLICY_NOTIFIER);
>
> Wanted to make sure that we all understand the constraints this is going to add
> for the ARM64 platforms.
>
> With the introduction of this transition notifier, we would not be able to use
> the fast-switch path in the schedutil governor. I am not sure if there are any
> ARM platforms that can actually use the fast-switch path in future or not
> though. The requirement of fast-switch path is that the freq can be changed
> without sleeping in the hot-path.
>
> So, will we ever want fast-switching for ARM platforms ?
>

I don't think we should go down a path that'll prevent ARM platform from 
switching over to fast-switching in the future.

Having said that, I'm not sure I fully agree with the decision to 
completely disable notifiers in the fast-switching case. How many of the 
current users of notifiers truly need support for sleeping in the 
notifier? Why not make all the transition notifiers atomic? Or at least 
add atomic transition notifiers that can be registered for separately if 
the client doesn't need the ability to sleep?

Most of the clients don't seem like ones that'll need to sleep.

There are a bunch of generic off-tree drivers (can't upstream them yet 
because it depends on the bus scaling framework) that also depend on 
CPUfreq transition notifiers that are going to stop working if fast 
switching becomes available in the future. So, this decision to disallow 
transition notifiers is painful for other reasons too.

-Saravana


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
