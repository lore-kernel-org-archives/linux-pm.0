From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 02/10] cpufreq: provide data for frequency-invariant
 load-tracking support
Date: Thu, 13 Jul 2017 13:54:49 +0100
Message-ID: <f6c84094-6eb4-497f-0877-c61c2d031fc0@arm.com>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com>
 <CAJZ5v0gBPNDBYWbuHVaB7deNHSZKziaAeybSw3mg+S8V_roO-Q@mail.gmail.com>
 <22f004af-0158-8265-2da5-34743f294bfb@arm.com>
 <12829054.TWIodSo4bb@aspire.rjw.lan>
 <bac850da-6256-2a92-abfe-71d229cc99dc@arm.com>
 <20170711060106.GL2928@vireshk-i7>
 <45224055-7bf1-243b-9366-0f2d3442ef59@arm.com>
 <20170712040917.GG17115@vireshk-i7>
 <20170712083125.at7jic63ozoxoqap@hirez.programming.kicks-ass.net>
 <20170712092755.GD1679@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38108 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751165AbdGMMyy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Jul 2017 08:54:54 -0400
In-Reply-To: <20170712092755.GD1679@vireshk-i7>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>



On 12/07/17 10:27, Viresh Kumar wrote:
> On 12-07-17, 10:31, Peter Zijlstra wrote:
>> So the problem with the thread is two-fold; one the one hand we like the
>> scheduler to directly set frequency, but then we need to schedule a task
>> to change the frequency, which will change the frequency and around we
>> go.
>>
>> On the other hand, there's very nasty issues with PI. This thread would
>> have very high priority (otherwise the SCHED_DEADLINE stuff won't work)
>> but that then means this thread needs to boost the owner of the i2c
>> mutex. And that then creates a massive bandwidth accounting hole.
>>
>>
>> The advantage of using an interrupt driven state machine is that all
>> those issues go away.
>>
>> But yes, whichever way around you turn things, its crap. But given the
>> hardware its the best we can do.
> 
> Thanks for the explanation Peter.
> 
> IIUC, it will take more time to change the frequency eventually with
> the interrupt-driven state machine as there may be multiple bottom
> halves involved here, for supply, clk, etc, which would run at normal
> priorities now. And those were boosted currently due to the high
> priority sugov thread. And we are fine with that (from performance
> point of view) ?
> 
> Coming back to where we started from (where should we call
> arch_set_freq_scale() from ?).
> 
> I think we would still need some kind of synchronization between
> cpufreq core and the cpufreq drivers to make sure we don't start
> another freq change before the previous one is complete. Otherwise
> the cpufreq drivers would be required to have similar support with
> proper locking in place.
> 

Good point, but with firmware interface we are considering fro
fast-switch, the firmware can override the previous request if it's not
yet started. So I assume that's fine and expected ?

> And if the core is going to get notified about successful freq changes
> (which it should IMHO),

Is that mandatory for even fast-switching ?

-- 
Regards,
Sudeep
