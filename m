From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 02/10] cpufreq: provide data for frequency-invariant
 load-tracking support
Date: Thu, 13 Jul 2017 13:40:39 +0100
Message-ID: <d2b121f1-1fd4-2842-f5bd-110a76997b65@arm.com>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com>
 <12829054.TWIodSo4bb@aspire.rjw.lan> <20170710065443.GG2928@vireshk-i7>
 <4673356.gkeX7KYvlb@aspire.rjw.lan> <20170711063944.GA17115@vireshk-i7>
 <de0feb89-4759-b50c-e44b-a9a51984d396@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <de0feb89-4759-b50c-e44b-a9a51984d396@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>
List-Id: linux-pm@vger.kernel.org



On 11/07/17 16:21, Dietmar Eggemann wrote:
> On 11/07/17 07:39, Viresh Kumar wrote:
>> On 10-07-17, 14:46, Rafael J. Wysocki wrote:
>>> This particular change is about a new feature, so making it in the core is OK
>>> in two cases IMO: (a) when you actively want everyone to be affected by it and
>>
>> IMO this change should be done for the whole ARM architecture. And if some
>> regression happens due to this, then we come back and solve it.
>>
>>> (b) when the effect of it on the old systems should not be noticeable.
>>
>> I am not sure about the effects of this on performance really.
>>
>> @Dietmar: Any inputs for that ?
> 
> Like I said in the other email, since for (future)
> arm/arm64 fast-switch driver, the return value of
> cpufreq_driver->fast_switch() does not give us the information that the
> frequency value did actually change, we have to implement

I was under the impression that we strictly don't care about that
information when I started exploring the fast_switch with the standard
firmware interface on ARM platforms(until if and when ARM provides an
instruction to achieve that).

If f/w failed to change the frequency, will that be not corrected in the
next sample or instance. I would like to know the impact of absence of
such notifications.

> arch_set_freq_scale() in the driver.
> This means that we probably only implement this in the subset of drivers
> which will be used in platforms on which we want to have
> frequency-invariant load-tracking.
> 
> A future aperf/mperf like counter FIE solution can give us arch-wide
> support when those counters are available.
> 

Agreed.

-- 
Regards,
Sudeep
