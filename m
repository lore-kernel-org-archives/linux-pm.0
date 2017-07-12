From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 02/10] cpufreq: provide data for frequency-invariant
 load-tracking support
Date: Wed, 12 Jul 2017 10:31:25 +0200
Message-ID: <20170712083125.at7jic63ozoxoqap@hirez.programming.kicks-ass.net>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com>
 <CAJZ5v0gBPNDBYWbuHVaB7deNHSZKziaAeybSw3mg+S8V_roO-Q@mail.gmail.com>
 <22f004af-0158-8265-2da5-34743f294bfb@arm.com>
 <12829054.TWIodSo4bb@aspire.rjw.lan>
 <bac850da-6256-2a92-abfe-71d229cc99dc@arm.com>
 <20170711060106.GL2928@vireshk-i7>
 <45224055-7bf1-243b-9366-0f2d3442ef59@arm.com>
 <20170712040917.GG17115@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170712040917.GG17115@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 12, 2017 at 09:39:17AM +0530, Viresh Kumar wrote:
> Yeah, I saw your discussion with Peter on #linux-rt IRC and TBH I wasn't aware
> that we are going to do fast switching that way. Just trying to get
> understanding of that idea a bit..
> 
> So we will do fast switching from scheduler's point of view, i.e. we wouldn't
> schedule a kthread to change the frequency. But the real hardware still can't do
> that without sleeping, like if we have I2C somewhere in between. AFAIU, we will
> still have some kind of *software* bottom half to do that work, isn't it? And it
> wouldn't be that we have pushed some instructions to the hardware, which it can
> do a bit later.
> 
> For example, the regulator may be accessed via I2C and we need to program that
> before changing the clock. So, it will be done by some software code only.
> 
> And now I am wondering on why that would be any better than the kthread in
> schedutil. Sorry, I haven't understood the idea completely yet :(

So the problem with the thread is two-fold; one the one hand we like the
scheduler to directly set frequency, but then we need to schedule a task
to change the frequency, which will change the frequency and around we
go.

On the other hand, there's very nasty issues with PI. This thread would
have very high priority (otherwise the SCHED_DEADLINE stuff won't work)
but that then means this thread needs to boost the owner of the i2c
mutex. And that then creates a massive bandwidth accounting hole.


The advantage of using an interrupt driven state machine is that all
those issues go away.

But yes, whichever way around you turn things, its crap. But given the
hardware its the best we can do.
