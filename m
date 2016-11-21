From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] cpufreq: schedutil: add up/down frequency transition
 rate limits
Date: Mon, 21 Nov 2016 11:19:46 +0100
Message-ID: <20161121101946.GI3102@twins.programming.kicks-ass.net>
References: <c6248ec9475117a1d6c9ff9aafa8894f6574a82f.1479359903.git.viresh.kumar@linaro.org>
 <20161121100805.GB10014@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161121100805.GB10014@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Robin Randhawa <robin.randhawa@arm.com>, Steve Muckle <smuckle.linux@gmail.com>, tkjos@google.com, Morten Rasmussen <morten.rasmussen@arm.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 21, 2016 at 03:38:05PM +0530, Viresh Kumar wrote:
> On 17-11-16, 10:48, Viresh Kumar wrote:
> > From: Steve Muckle <smuckle.linux@gmail.com>
> > 
> > The rate-limit tunable in the schedutil governor applies to transitions
> > to both lower and higher frequencies. On several platforms it is not the
> > ideal tunable though, as it is difficult to get best power/performance
> > figures using the same limit in both directions.
> > 
> > It is common on mobile platforms with demanding user interfaces to want
> > to increase frequency rapidly for example but decrease slowly.
> > 
> > One of the example can be a case where we have short busy periods
> > followed by similar or longer idle periods. If we keep the rate-limit
> > high enough, we will not go to higher frequencies soon enough. On the
> > other hand, if we keep it too low, we will have too many frequency
> > transitions, as we will always reduce the frequency after the busy
> > period.
> > 
> > It would be very useful if we can set low rate-limit while increasing
> > the frequency (so that we can respond to the short busy periods quickly)
> > and high rate-limit while decreasing frequency (so that we don't reduce
> > the frequency immediately after the short busy period and that may avoid
> > frequency transitions before the next busy period).
> > 
> > Implement separate up/down transition rate limits. Note that the
> > governor avoids frequency recalculations for a period equal to minimum
> > of up and down rate-limit. A global mutex is also defined to protect
> > updates to min_rate_limit_us via two separate sysfs files.
> > 
> > Note that this wouldn't change behavior of the schedutil governor for
> > the platforms which wish to keep same values for both up and down rate
> > limits.
> > 
> > This is tested with the rt-app [1] on ARM Exynos, dual A15 processor
> > platform.
> > 
> > Testcase: Run a SCHED_OTHER thread on CPU0 which will emulate work-load
> > for X ms of busy period out of the total period of Y ms, i.e. Y - X ms
> > of idle period. The values of X/Y taken were: 20/40, 20/50, 20/70, i.e
> > idle periods of 20, 30 and 50 ms respectively. These were tested against
> > values of up/down rate limits as: 10/10 ms and 10/40 ms.
> > 
> > For every test we noticed a performance increase of 5-10% with the
> > schedutil governor, which was very much expected.
> > 
> > [Viresh]: Simplified user interface and introduced min_rate_limit_us +
> > 	      mutex, rewrote commit log and included test results.
> > 
> > [1] https://github.com/scheduler-tools/rt-app/
> > 
> > Signed-off-by: Steve Muckle <smuckle.linux@gmail.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 106 +++++++++++++++++++++++++++++++++------
> >  1 file changed, 90 insertions(+), 16 deletions(-)
> 
> (Background story for others from my discussion with Rafael on IRC: Rafael
> proposed that instead of this patch we can add down_rate_limit_delta_us (>0 =)
> which can be added to rate_limit_us (rate limit while increasing freq) to find
> the rate limit to be used in the downward direction. And I raised the point
> that it looks much neater to have separate up and down rate_limit_us. I also
> said that people may have a valid case where they want to keep down_rate_limit
> lower than up_rate_limit and Rafael wasn't fully sure of any such cases).
> 

Urgh...


So no tunables and rate limits here at all please.

During LPC we discussed the rampup and decay issues and decided that we
should very much first address them by playing with the PELT stuff.
Morton was going to play with capping the decay on the util signal. This
should greatly improve the ramp-up scenario and cure some other wobbles.

The decay can be set by changing the over-all pelt decay, if so desired.

Also, there was the idea of; once the above ideas have all been
explored; tying the freq ram rate to the power curve.

So NAK on everything tunable here.
