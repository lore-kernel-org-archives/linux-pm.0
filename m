From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 02/10] cpufreq: provide data for frequency-invariant
 load-tracking support
Date: Wed, 12 Jul 2017 09:39:17 +0530
Message-ID: <20170712040917.GG17115@vireshk-i7>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com>
 <CAJZ5v0gBPNDBYWbuHVaB7deNHSZKziaAeybSw3mg+S8V_roO-Q@mail.gmail.com>
 <22f004af-0158-8265-2da5-34743f294bfb@arm.com>
 <12829054.TWIodSo4bb@aspire.rjw.lan>
 <bac850da-6256-2a92-abfe-71d229cc99dc@arm.com>
 <20170711060106.GL2928@vireshk-i7>
 <45224055-7bf1-243b-9366-0f2d3442ef59@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <45224055-7bf1-243b-9366-0f2d3442ef59@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>
List-Id: linux-pm@vger.kernel.org

On 11-07-17, 16:06, Dietmar Eggemann wrote:
> But in the meantime we're convinced that cpufreq_driver_fast_switch() is
> not the right place to call arch_set_freq_scale() since for (future)
> arm/arm64 fast-switch driver, the return value of
> cpufreq_driver->fast_switch() does not give us the information that the
> frequency value did actually change.

Yeah, I saw your discussion with Peter on #linux-rt IRC and TBH I wasn't aware
that we are going to do fast switching that way. Just trying to get
understanding of that idea a bit..

So we will do fast switching from scheduler's point of view, i.e. we wouldn't
schedule a kthread to change the frequency. But the real hardware still can't do
that without sleeping, like if we have I2C somewhere in between. AFAIU, we will
still have some kind of *software* bottom half to do that work, isn't it? And it
wouldn't be that we have pushed some instructions to the hardware, which it can
do a bit later.

For example, the regulator may be accessed via I2C and we need to program that
before changing the clock. So, it will be done by some software code only.

And now I am wondering on why that would be any better than the kthread in
schedutil. Sorry, I haven't understood the idea completely yet :(

-- 
viresh
