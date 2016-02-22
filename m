From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH v10 1/3] cpufreq: Add mechanism for registering
 utilization update callbacks
Date: Mon, 22 Feb 2016 09:32:44 +0000
Message-ID: <20160222093244.GB27380@e106622-lin>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
 <CAJZ5v0jthTo8rXMp_ad=k5EcFBcwLgKRMnwPsznqDhois84uYA@mail.gmail.com>
 <20160219080917.GE22643@pablo>
 <5324745.ObXn8lTQ9A@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5324745.ObXn8lTQ9A@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Steve Muckle <steve.muckle@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On 19/02/16 23:14, Rafael J. Wysocki wrote:
> On Friday, February 19, 2016 08:09:17 AM Juri Lelli wrote:
> > Hi Rafael,
> > 
> > On 18/02/16 21:22, Rafael J. Wysocki wrote:
> > > On Mon, Feb 15, 2016 at 10:47 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > 
> > [...]
> > 
> > > 
> > > So if anyone has any issues with this one, please let me know.
> > > 
> > 
> > I'm repeating myself a bit, but I'll try to articulate my only concern
> > once again anyway. I run some tests on a couple of arm boxes and I
> > didn't notice any regression or improvements for ondemand and
> > conservative (FWIW this might also work as a tested-by), so I tend to
> > take this series as a way to replace governor timers, making further
> > cleanups and fixes possibile. I think you already confirmed this and I
> > understand why you'd like this series to go in as I also think that what
> > we have on top is beneficial.
> 
> OK
> 
> > However, I still don't quite get why we want to introduce an interface
> > for explicit passing of util and max if we are not using such parameters
> > yet. Also, I couldn't find any indication of how such parameters will be
> > used in the future. If what we need today is a periodic kick for cpufreq
> > governors that need it, we should simply do how we already do for RT and
> > DL, IMHO. Also because the places where the current hooks reside might
> > not be the correct and useful one once we'll start using the utilization
> > parameters. I could probably make a case for DL where we should place
> > hooks in admission control path (or somewhere else when more
> > sophisticated mechanisms we'll be in place) rather then in the periodic
> > tick.
> 
> Well, the hook in DL is explicitly denoted as a temporary band-aid.
> 
> I and Srinivas have said for multiple times that we are going to use the
> scheduler's utilization data in intel_pstate.  Admittedly, we haven't shown
> any patches implementing that, but that's because Srinivas doesn't regard
> that work as ready yet.
> 
> I also have something for the general cpufreq in the works.  I may be able
> to send it as an RFC over the weekend, depending on how much time I can
> spend on it.
> 

Saw that, thanks. Please allow me some time to review and test. :-)

> That said, if the concern is that there are plans to change the way the
> scheduler computes the utilization numbers and that may become difficult to
> carry out if cpufreq starts to depend on them in their current form, then I
> may agree that it is valid, but I'm not aware of those plans ATM.
> 

No, I don't think there's any substantial discussion going on about the
utilization numbers.

> However, if the numbers are going to stay what they are, I don't see why
> passing them to cpufreq may possibly become problematic at any point.

My concern was mostly on the fact that there is already another RFC
under discussion that uses the same numbers and has different hooks
placed in scheduler code (Steve's sched-freq); so, additional hooks
might generate confusion, IMHO.
 
> > > It has been in linux-next for a few days and seems to be doing well.
> > > 
> > > As I said previously, there is a metric ton of cpufreq improvements
> > > depending on it, so I'd rather not delay integrating it any more.
> > > 
> > 
> > As said. I'm not against these changes since they open up to further
> > substantial fixes.
> 
> Good. :-)
> 
> > I'm only wondering if we are doing the right thing defining an interface
> > that nobody is using and without an indication of how such thing we'll be
> > used in the future.
> 
> That indication may be coming though. :-)
> 

Thanks again. I'm going to have a look at that.

Best,

- Juri
