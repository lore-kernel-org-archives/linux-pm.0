From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v2 02/10] cpufreq: provide data for frequency-invariant
 load-tracking support
Date: Mon, 10 Jul 2017 13:02:54 +0100
Message-ID: <bac850da-6256-2a92-abfe-71d229cc99dc@arm.com>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com>
 <CAJZ5v0gBPNDBYWbuHVaB7deNHSZKziaAeybSw3mg+S8V_roO-Q@mail.gmail.com>
 <22f004af-0158-8265-2da5-34743f294bfb@arm.com>
 <12829054.TWIodSo4bb@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34696 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752227AbdGJMC6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Jul 2017 08:02:58 -0400
In-Reply-To: <12829054.TWIodSo4bb@aspire.rjw.lan>
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>

On 08/07/17 13:09, Rafael J. Wysocki wrote:
> On Friday, July 07, 2017 06:06:30 PM Dietmar Eggemann wrote:
>> On 07/07/17 17:18, Rafael J. Wysocki wrote:
>>> On Fri, Jul 7, 2017 at 6:01 PM, Dietmar Eggemann
>>> <dietmar.eggemann@arm.com> wrote:
>>>> On 06/07/17 11:40, Viresh Kumar wrote:
>>>>> On 06-07-17, 10:49, Dietmar Eggemann wrote:
>>
>> [...]
>>
>>>> So what about I call arch_set_freq_scale() in __cpufreq_notify_transition() in the
>>>> CPUFREQ_POSTCHANGE case for slow-switching and in cpufreq_driver_fast_switch() for
>>>> fast-switching?
>>>
>>> Why don't you do this in drivers instead of in the core?
>>>
>>> Ultimately, the driver knows what frequency it has requested, so why
>>> can't it call arch_set_freq_scale()?
>>
>> That's correct but for arm/arm64 we have a lot of different cpufreq
>> drivers to deal with. And doing this call to arch_set_freq_scale() once
>> in the cpufreq core will cover them all.
>>
>> [...]
> 
> I'm sort of wondering how many is "a lot" really.  For instance, do you really
> want all of the existing ARM platforms to use the new stuff even though
> it may regress things there in principle?

Yeah, in mainline we probably only care about a couple of them, I know
about cpufreq-dt.c, mt8173-cpufreq.c and arm_big_little.c.
But a lot of development in arm64 still happens outside mainline and we
would have to inform people to provision their cpufreq drivers with this
functionality.

With a solution in cpufreq.c we could just implement the functionality
in the arch which we then connect to the call in cpufreq.c.

> Anyway, if everyone agrees that doing it in the core is the way to go (Peter?),
> why don't you introduce a __weak function for setting policy->cur and
> override it from your arch so as to call arch_set_freq_scale() from there?

Yes, I will change this. The #define approach is not really necessary
here since we're not in the scheduler hot-path and inlining is not
really required here.

Thanks,

-- Dietmar

[...]
