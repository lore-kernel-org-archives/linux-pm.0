From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 2/8] Documentation: arm: define DT cpu capacity
 bindings
Date: Tue, 15 Dec 2015 17:15:19 +0000
Message-ID: <20151215171518.GC8012@leverpostej>
References: <20151215122238.GG16007@e106622-lin>
 <20151215133951.GY5727@sirena.org.uk>
 <20151215140135.GI31299@leverpostej>
 <20151215150813.GZ5727@sirena.org.uk>
 <20151215153218.GA7228@leverpostej>
 <20151215154651.GK16007@e106622-lin>
 <20151215155737.GB7619@leverpostej>
 <20151215162317.GB24286@e104818-lin.cambridge.arm.com>
 <20151215164145.GA8012@leverpostej>
 <CAKfTPtAuosPcL8bbQ27Y-vUE1h4QRY8hGESnm4YrxqRAQ3K=5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKfTPtAuosPcL8bbQ27Y-vUE1h4QRY8hGESnm4YrxqRAQ3K=5g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Morten Rasmussen <morten.rasmussen-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Dietmar Eggemann <dietmar.eggemann-5wv7dgnIgG8@public.gmane.org>, LAK <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>linux-kernel <linux>
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 15, 2015 at 05:59:34PM +0100, Vincent Guittot wrote:
> On 15 December 2015 at 17:41, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:
> > On Tue, Dec 15, 2015 at 04:23:18PM +0000, Catalin Marinas wrote:
> >> On Tue, Dec 15, 2015 at 03:57:37PM +0000, Mark Rutland wrote:
> >> > On Tue, Dec 15, 2015 at 03:46:51PM +0000, Juri Lelli wrote:
> >> > > On 15/12/15 15:32, Mark Rutland wrote:
> >> > > > On Tue, Dec 15, 2015 at 03:08:13PM +0000, Mark Brown wrote:
> >> > > > > My expectation is that we just need good enough, not perfect, and that
> >> > > > > seems to match what Juri is saying about the expectation that most of
> >> > > > > the fine tuning is done via other knobs.
> >> > > >
> >> > > > My expectation is that if a ballpark figure is good enough, it should be
> >> > > > possible to implement something trivial like bogomips / loop_per_jiffy
> >> > > > calculation.
> >> > >
> >> > > I didn't really followed that, so I might be wrong here, but isn't
> >> > > already happened a discussion about how we want/like to stop exposing
> >> > > bogomips info or rely on it for anything but in kernel delay loops?
> >> >
> >> > I meant that we could have a benchmark of that level of complexity,
> >> > rather than those specific values.
> >>
> >> Or we could simply let user space use whatever benchmarks or hard-coded
> >> values it wants and set the capacity via sysfs (during boot). By
> >> default, the kernel would assume all CPUs equal.
> >
> > I assume that a userspace override would be available regardless of
> > whatever mechanism the kernel uses to determine relative
> > performance/effinciency.
> 
> Don't you think that if we let a complete latitude to the userspace
> to set whatever it wants, it will be used to abuse the kernel (and the
> scheduler in particular ) and that this will finish in a real mess to
> understand what is wrong when a task is not placed where it should be.

I'm not sure I follow what you mean by "abuse" here. Userspace currently
can force the scheduler to make sub-optimal decisions in a number of
ways, e.g.

* Hot-unplugging the preferred CPUs
* Changing a task's affinity mask
* Setting the nice value of a task
* Using rlimits and/or cgroups
* Using a cpufreq governor
* Fork-bombing

Practically all of these are prvileged operations. I would envisage the
userspace interface for "capacity" management to be similar.

> We can probably provide a debug mode to help soc manufacturer to
> define their capacity value but IMHO we should not let complete
> latitude in normal operation

In normal operation userspace wouldn't mess with this, as with most of
the cases above. Userspace can already shooti tself in the foot.

> In normal operation we need to give some methods to tweak the value to
> reflect a memory bounded or integer calculation work  or other kind of
> work that currently runs on the cpu but not more

You can already do that with the mechanisms above, to some extent. I'm
not sure I follow.

Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
