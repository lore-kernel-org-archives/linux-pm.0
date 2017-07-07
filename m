From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v2 02/10] cpufreq: provide data for frequency-invariant
 load-tracking support
Date: Fri, 7 Jul 2017 18:06:30 +0100
Message-ID: <22f004af-0158-8265-2da5-34743f294bfb@arm.com>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com>
 <20170706094948.8779-3-dietmar.eggemann@arm.com>
 <20170706104027.GB13048@vireshk-i7>
 <c92f1bd0-6611-8eec-51d7-f6d7754a5870@arm.com>
 <CAJZ5v0gBPNDBYWbuHVaB7deNHSZKziaAeybSw3mg+S8V_roO-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0gBPNDBYWbuHVaB7deNHSZKziaAeybSw3mg+S8V_roO-Q@mail.gmail.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On 07/07/17 17:18, Rafael J. Wysocki wrote:
> On Fri, Jul 7, 2017 at 6:01 PM, Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
>> On 06/07/17 11:40, Viresh Kumar wrote:
>>> On 06-07-17, 10:49, Dietmar Eggemann wrote:

[...]

>> So what about I call arch_set_freq_scale() in __cpufreq_notify_transition() in the
>> CPUFREQ_POSTCHANGE case for slow-switching and in cpufreq_driver_fast_switch() for
>> fast-switching?
> 
> Why don't you do this in drivers instead of in the core?
> 
> Ultimately, the driver knows what frequency it has requested, so why
> can't it call arch_set_freq_scale()?

That's correct but for arm/arm64 we have a lot of different cpufreq
drivers to deal with. And doing this call to arch_set_freq_scale() once
in the cpufreq core will cover them all.

[...]
