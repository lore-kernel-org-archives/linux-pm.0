From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v2 02/10] cpufreq: provide data for frequency-invariant
 load-tracking support
Date: Tue, 11 Jul 2017 16:21:06 +0100
Message-ID: <de0feb89-4759-b50c-e44b-a9a51984d396@arm.com>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com>
 <12829054.TWIodSo4bb@aspire.rjw.lan> <20170710065443.GG2928@vireshk-i7>
 <4673356.gkeX7KYvlb@aspire.rjw.lan> <20170711063944.GA17115@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46514 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932291AbdGKPVJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Jul 2017 11:21:09 -0400
In-Reply-To: <20170711063944.GA17115@vireshk-i7>
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>

On 11/07/17 07:39, Viresh Kumar wrote:
> On 10-07-17, 14:46, Rafael J. Wysocki wrote:
>> This particular change is about a new feature, so making it in the core is OK
>> in two cases IMO: (a) when you actively want everyone to be affected by it and
> 
> IMO this change should be done for the whole ARM architecture. And if some
> regression happens due to this, then we come back and solve it.
> 
>> (b) when the effect of it on the old systems should not be noticeable.
> 
> I am not sure about the effects of this on performance really.
> 
> @Dietmar: Any inputs for that ?

Like I said in the other email, since for (future)
arm/arm64 fast-switch driver, the return value of
cpufreq_driver->fast_switch() does not give us the information that the
frequency value did actually change, we have to implement
arch_set_freq_scale() in the driver.
This means that we probably only implement this in the subset of drivers
which will be used in platforms on which we want to have
frequency-invariant load-tracking.

A future aperf/mperf like counter FIE solution can give us arch-wide
support when those counters are available.
