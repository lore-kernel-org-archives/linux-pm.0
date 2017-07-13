From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v2 02/10] cpufreq: provide data for frequency-invariant
 load-tracking support
Date: Thu, 13 Jul 2017 14:08:13 +0100
Message-ID: <acd9c300-8be6-e87b-5583-191fd5bda94c@arm.com>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com>
 <12829054.TWIodSo4bb@aspire.rjw.lan> <20170710065443.GG2928@vireshk-i7>
 <4673356.gkeX7KYvlb@aspire.rjw.lan> <20170711063944.GA17115@vireshk-i7>
 <de0feb89-4759-b50c-e44b-a9a51984d396@arm.com>
 <d2b121f1-1fd4-2842-f5bd-110a76997b65@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d2b121f1-1fd4-2842-f5bd-110a76997b65@arm.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>
List-Id: linux-pm@vger.kernel.org

On 13/07/17 13:40, Sudeep Holla wrote:
> 
> 
> On 11/07/17 16:21, Dietmar Eggemann wrote:
>> On 11/07/17 07:39, Viresh Kumar wrote:
>>> On 10-07-17, 14:46, Rafael J. Wysocki wrote:

[...]

>> Like I said in the other email, since for (future)
>> arm/arm64 fast-switch driver, the return value of
>> cpufreq_driver->fast_switch() does not give us the information that the
>> frequency value did actually change, we have to implement
> 
> I was under the impression that we strictly don't care about that
> information when I started exploring the fast_switch with the standard
> firmware interface on ARM platforms(until if and when ARM provides an
> instruction to achieve that).
> 
> If f/w failed to change the frequency, will that be not corrected in the
> next sample or instance. I would like to know the impact of absence of
> such notifications.

In the meantime we agreed that we have to invoke frequency invariance
from within the cpufreq driver.

For a fast-switch driver I would have to put the call to
arch_set_freq_scale() somewhere where I know that the frequency has been
set.

Without a notification (from the firmware) that the frequency has been
set, I would have to call arch_set_freq_scale() somewhere in the
driver::fast_switch() call assuming that the frequency has been actually
set.

[...]
