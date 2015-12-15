From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 2/8] Documentation: arm: define DT cpu capacity
 bindings
Date: Tue, 15 Dec 2015 17:28:37 +0000
Message-ID: <20151215172837.GD8012@leverpostej>
References: <20151210175820.GE14571@e106622-lin>
 <20151211174940.GQ5727@sirena.org.uk>
 <20151214123616.GC3308@e106622-lin>
 <20151214165928.GV5727@sirena.org.uk>
 <20151215122238.GG16007@e106622-lin>
 <20151215133951.GY5727@sirena.org.uk>
 <20151215140135.GI31299@leverpostej>
 <20151215150813.GZ5727@sirena.org.uk>
 <20151215153218.GA7228@leverpostej>
 <20151215171713.GA5727@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151215171713.GA5727-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, morten.rasmussen-5wv7dgnIgG8@public.gmane.org, dietmar.eggemann-5wv7dgnIgG8@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 15, 2015 at 05:17:13PM +0000, Mark Brown wrote:
> On Tue, Dec 15, 2015 at 03:32:19PM +0000, Mark Rutland wrote:
> > On Tue, Dec 15, 2015 at 03:08:13PM +0000, Mark Brown wrote:
> > > On Tue, Dec 15, 2015 at 02:01:36PM +0000, Mark Rutland wrote:
> 
> > > > I really don't want to see a table of magic numbers in the kernel.
> 
> > > Right, there's pitfalls there too although not being part of an ABI
> > > does make them more manageable.  
> 
> > I think that people are very likely to treat them exactly like an ABI,
> > w.r.t. any regressions in performance that result from their addition,
> > modification, or removal. That becomes really horrible when new CPUs
> > appear.
> 
> Obviously people are going to get upset if we introduce performance
> regressions - but that's true always, we can also introduce problems
> with numbers people have put in DT.  It seems like it'd be harder to
> manage regressions due to externally provided magic numbers since
> there's inherently less information there.

It's certainly still possible to have regressions in that case. Those
regressions would be due to code changes in the kernel, given the DT
didn't change.

I'm not sure I follow w.r.t. "inherently less information", unless you
mean trying to debug without access to that DTB?

> > > One thing it's probably helpful to establish here is how much the
> > > specific numbers are going to matter in the grand scheme of things.  If
> > > the specific numbers *are* super important then nobody is going to want
> > > to touch them as they'll be prone to getting tweaked.  If instead the
> > > numbers just need to be ballpark accurate so the scheduler starts off in
> > > roughly the right place and the specific numbers don't matter it's a lot
> > > easier and having a table in the kernel until we think of something
> > > better (if that ever happens) gets a lot easier.
> 
> > I agree that we first need to figure out the importance of these
> > numbers. I disagree that our first step should be to add a table.
> 
> My point there is that if we're not that concerned about the specific
> number something in kernel is safer.

I don't entirely disagree there. I think an in-kernel benchmark is
likely safer.

> > > My expectation is that we just need good enough, not perfect, and that
> > > seems to match what Juri is saying about the expectation that most of
> > > the fine tuning is done via other knobs.
> 
> > My expectation is that if a ballpark figure is good enough, it should be
> > possible to implement something trivial like bogomips / loop_per_jiffy
> > calculation.
> 
> That does have the issue that we need to scale with regard to the
> frequency the benchmark gets run at.  That's not an insurmountable
> obstacle but it's not completely trivial either.

If we change clock frequency, then regardless of where the information
comes from we need to perform scaling, no?

One nice thing about doing a benchmark to derive the numbers is that
when the kernel is that when the frequency is fixed but the kernel
cannot query it, the numbers will be representative.

Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
