From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v2 02/10] cpufreq: provide data for frequency-invariant
 load-tracking support
Date: Tue, 11 Jul 2017 16:12:57 +0100
Message-ID: <1cfe639d-6402-ea64-f502-dcf07083569f@arm.com>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com>
 <20170711060106.GL2928@vireshk-i7>
 <45224055-7bf1-243b-9366-0f2d3442ef59@arm.com>
 <1883025.xinGhbAdMS@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46406 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932597AbdGKPNB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Jul 2017 11:13:01 -0400
In-Reply-To: <1883025.xinGhbAdMS@aspire.rjw.lan>
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>

On 11/07/17 15:59, Rafael J. Wysocki wrote:
> On Tuesday, July 11, 2017 04:06:01 PM Dietmar Eggemann wrote:
>> On 11/07/17 07:01, Viresh Kumar wrote:
>>> On 10-07-17, 13:02, Dietmar Eggemann wrote:
>>>> Yes, I will change this. The #define approach is not really necessary
>>>> here since we're not in the scheduler hot-path and inlining is not
>>>> really required here.
>>>
>>> It would be part of scheduler hot-path for the fast-switching case, isn't it ?
>>> (I am not arguing against using weak functions, just wanted to correct above
>>> statement).
>>
>> Yes you're right here.
>>
>> But in the meantime we're convinced that cpufreq_driver_fast_switch() is
>> not the right place to call arch_set_freq_scale() since for (future)
>> arm/arm64 fast-switch driver, the return value of
>> cpufreq_driver->fast_switch() does not give us the information that the
>> frequency value did actually change.
>>
>> So we probably have to do this soemwhere in the cpufreq driver(s) to
>> support fast-switching until we have aperf/mperf like counters.
> 
> If that's the case, I'd say call arch_set_freq_scale() from drivers in all
> cases or it will get *really* confusing.

Agreed, we should do it for slow-switching drivers from within the
driver as well in this case.
