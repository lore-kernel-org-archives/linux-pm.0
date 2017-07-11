From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 02/10] cpufreq: provide data for frequency-invariant load-tracking support
Date: Tue, 11 Jul 2017 16:59:54 +0200
Message-ID: <1883025.xinGhbAdMS@aspire.rjw.lan>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com> <20170711060106.GL2928@vireshk-i7> <45224055-7bf1-243b-9366-0f2d3442ef59@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <45224055-7bf1-243b-9366-0f2d3442ef59@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday, July 11, 2017 04:06:01 PM Dietmar Eggemann wrote:
> On 11/07/17 07:01, Viresh Kumar wrote:
> > On 10-07-17, 13:02, Dietmar Eggemann wrote:
> >> Yes, I will change this. The #define approach is not really necessary
> >> here since we're not in the scheduler hot-path and inlining is not
> >> really required here.
> > 
> > It would be part of scheduler hot-path for the fast-switching case, isn't it ?
> > (I am not arguing against using weak functions, just wanted to correct above
> > statement).
> 
> Yes you're right here.
> 
> But in the meantime we're convinced that cpufreq_driver_fast_switch() is
> not the right place to call arch_set_freq_scale() since for (future)
> arm/arm64 fast-switch driver, the return value of
> cpufreq_driver->fast_switch() does not give us the information that the
> frequency value did actually change.
> 
> So we probably have to do this soemwhere in the cpufreq driver(s) to
> support fast-switching until we have aperf/mperf like counters.

If that's the case, I'd say call arch_set_freq_scale() from drivers in all
cases or it will get *really* confusing.

Thanks,
Rafael
