From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 6/6] cpufreq: schedutil: New governor based on scheduler utilization data
Date: Thu, 10 Mar 2016 22:01:53 +0100
Message-ID: <7014450.lrfeLQYxYB@vostro.rjw.lan>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan> <CAJZ5v0hxq=S+huSy-D7=VGoV+30VQfCyA5C5dTBX-rn0XRUS0g@mail.gmail.com> <20160310043034.GB26402@pablo>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160310043034.GB26402@pablo>
Sender: linux-acpi-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, March 10, 2016 11:30:34 AM Juri Lelli wrote:
> On 10/03/16 00:41, Rafael J. Wysocki wrote:
> > On Wed, Mar 9, 2016 at 11:15 AM, Juri Lelli <juri.lelli@arm.com> wrote:
> > > Hi,
> > >
> > > sorry if I didn't reply yet. Trying to cope with jetlag and
> > > talks/meetings these days :-). Let me see if I'm getting what you are
> > > discussing, though.
> > >
> > > On 08/03/16 21:05, Rafael J. Wysocki wrote:
> > >> On Tue, Mar 8, 2016 at 8:26 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > >> > On Tue, Mar 08, 2016 at 07:00:57PM +0100, Rafael J. Wysocki wrote:
> > >> >> On Tue, Mar 8, 2016 at 12:27 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > [...]
> > >
> > >> a = max_freq gives next_freq = max_freq for x = 1, but with that
> > >> choice of a you may never get to x = 1 with frequency invariant
> > >> because of the feedback effect mentioned above, so the 1/n produces
> > >> the extra boost needed for that (n is a positive integer).
> > >>
> > >> Quite frankly, to me it looks like linear really is a better
> > >> approximation for "raw" utilization.  That is, for frequency invariant
> > >> x we should take:
> > >>
> > >>   next_freq = a * x * max_freq / current_freq
> > >>
> > >> (and if x is not frequency invariant, the right-hand side becomes a *
> > >> x).  Then, the extra boost needed to get to x = 1 for frequency
> > >> invariant is produced by the (max_freq / current_freq) factor that is
> > >> greater than 1 as long as we are not running at max_freq and a can be
> > >> chosen as max_freq.
> > >>
> > >
> > > Expanding terms again, your original formula (without the 1.1 factor of
> > > the last version) was:
> > >
> > >  next_freq = util / max_cap * max_freq
> > >
> > > and this doesn't work when we have freq invariance since util won't go
> > > over curr_cap.
> > 
> > Can you please remind me what curr_cap is?
> > 
> 
> The capacity at current frequency.

I see, thanks!

> > > What you propose above is to add another factor, so that we have:
> > >
> > >  next_freq = util / max_cap * max_freq / curr_freq * max_freq
> > >
> > > which should give us the opportunity to reach max_freq also with freq
> > > invariance.
> > >
> > > This should actually be the same of doing:
> > >
> > >  next_freq = util / max_cap * max_cap / curr_cap * max_freq
> > >
> > > We are basically scaling how much the cpu is busy at curr_cap back to
> > > the 0..1024 scale. And we use this to select next_freq. Also, we can
> > > simplify this to:
> > >
> > >  next_freq = util / curr_cap * max_freq
> > >
> > > and we save some ops.
> > >
> > > However, if that is correct, I think we might have a problem, as we are
> > > skewing OPP selection towards higher frequencies. Let's suppose we have
> > > a platform with 3 OPPs:
> > >
> > >   freq     cap
> > >   1200     1024
> > >   900      768
> > >   600      512
> > >
> > > As soon a task reaches an utilization of 257 we will be selecting the
> > > second OPP as
> > >
> > >  next_freq = 257 / 512 * 1200 ~ 602
> > >
> > > While the cpu is only 50% busy in this case. And we will go at max OPP
> > > when reaching ~492 (~64% of 768).
> > >
> > > That said, I guess this might work as a first solution, but we will
> > > probably need something better in the future. I understand Rafael's
> > > concerns regardin margins, but it seems to me that some kind of
> > > additional parameter will be probably needed anyway to fix this.
> > > Just to say again how we handle this in schedfreq, with a -20% margin
> > > applied to the lowest OPP we will get to the next one when utilization
> > > reaches ~410 (80% busy at curr OPP), and so on for the subsequent ones,
> > > which is less aggressive and might be better IMHO.
> > 
> > Well, Peter says that my idea is incorrect, so I'll go for
> > 
> >   next_freq = C * current_freq * util_raw / max
> > 
> > where C > 1 (and likely C < 1.5) instead.
> > 
> > That means C has to be determined somehow or guessed.  The 80% tipping
> > point condition seems reasonable to me, though, which leads to C =
> > 1.25.
> > 
> 
> Right. So, when using freq. invariant util we have:
> 
>  next_freq = C * curr_freq * util / curr_cap
> 
> as
> 
>  util_raw = util * max / curr_cap
> 
> What Vincent is saying makes sense, though. If we use
> arch_scale_freq_capacity() as denominator instead of max, we can use a
> single formula for both cases.

I'm not convinced about that yet, but let me think about it some more. :-)

Thanks,
Rafael

