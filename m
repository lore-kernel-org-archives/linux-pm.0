From: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 2/8] Documentation: arm: define DT cpu capacity
 bindings
Date: Mon, 14 Dec 2015 12:36:16 +0000
Message-ID: <20151214123616.GC3308@e106622-lin>
References: <1448288921-30307-1-git-send-email-juri.lelli@arm.com>
 <1448288921-30307-3-git-send-email-juri.lelli@arm.com>
 <20151124020631.GA15165@rob-hp-laptop>
 <20151210153004.GA26758@sirena.org.uk>
 <20151210175820.GE14571@e106622-lin>
 <20151211174940.GQ5727@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151211174940.GQ5727-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, morten.rasmussen-5wv7dgnIgG8@public.gmane.org, dietmar.eggemann-5wv7dgnIgG8@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Mark,

On 11/12/15 17:49, Mark Brown wrote:
> On Thu, Dec 10, 2015 at 05:58:20PM +0000, Juri Lelli wrote:
> > On 10/12/15 15:30, Mark Brown wrote:
> > > On Mon, Nov 23, 2015 at 08:06:31PM -0600, Rob Herring wrote:
> 
> > > > In other words, I want to see these numbers have a defined method 
> > > > of determining them and don't want to see random values from every 
> > > > vendor. ARM, Ltd. says core X has a value of Y would be good enough for 
> > > > me. Vendor X's A57 having a value of 2 and Vendor Y's A57 having a 
> > > > value of 1024 is not what I want to see. Of course things like cache 
> > > > sizes can vary the performance, but is a baseline value good enough? 
> 
> > > > However, no vendor will want to publish their values if these are 
> > > > absolute values relative to other vendors.
> 
> > > > If you expect these to need frequent tuning, then don't put them in DT.
> 
> > > I agree strongly.  Putting what are essentially tuning numbers for the
> > > system into the ABI is going to lead us into a mess long term since if
> > > we change anything related to the performance of the system the numbers
> > > may become invalid and we've no real way of recovering sensible
> > > information.
> 
> > I'm not entirely getting here why you consider capacity values to be
> > tunables. As part of the EAS effort, we are proposing ways in which users
> 
> The purpose of the capacity values is to influence the scheduler
> behaviour and hence performance.  Without a concrete definition they're
> just magic numbers which have meaining only in terms of their effect on
> the performance of the system.  That is a sufficiently complex outcome
> to ensure that there will be an element of taste in what the desired
> outcomes are.  Sounds like tuneables to me.
> 

Capacity values are meant to describe asymmetry (if any) of the system
CPUs to the scheduler. The scheduler can then use this additional bit of
information to try to do better scheduling decisions. Yes, having these
values available will end up giving you better performance, but I guess
this apply to any information we provide to the kernel (and scheduler);
the less dumb a subsystem is, the better we can make it work.

> > should be able to fine tune their system as needed, when required
> > (don't know if you had a chance to have a look at the SchedTune posting
> > back in August for example [1]). This patch tries to only standardize
> > where do we get default values from and how we specify them. I'm not
> > seeing them changing much after an initial benchmarking phase has been
> > done. Tuning should happen using different methods, not by changing
> > these values, IMHO.
> 
> If you are saying people should use other, more sensible, ways of
> specifying the final values that actually get used in production then
> why take the defaults from direct numbers DT in the first place?  If you
> are saying that people should tune and then put the values in here then
> that's problematic for the reasons I outlined.
> 

IMHO, people should come up with default values that describe
heterogeneity in their system. Then use other ways to tune the system at
run time (depending on the workload maybe).

As said, I understand your concerns; but, what I don't still get is
where CPU capacity values are so different from, say, idle states
min-residency-us. AFAIK there is a per-SoC benchmarking phase required
to come up with that values as well; you have to pick some benchmark
that stresses worst case entry/exit while measuring energy, then make
calculations that tells you when it is wise to enter a particular idle
state. Ideally we should derive min residency from specs, but I'm not
sure is how it works in practice.

> > > It would be better to have the DT describe concrete physical properties
> > > of the system which we can then map onto numbers we like, that way if we
> > > get better information in future or just decide that completely
> > > different metrics are appropriate for tuning we can just do that without
> > > having to worry about translating the old metrics into new ones.  We can
> > > then expose the tuning knobs to userspace for override if that's needed.
> > > If doing system specific tuning on vertically integrated systems really
> > > is terribly important it's not going to matter too much where the tuning
> > > is but we also have to consider more general purpose systems.
> 
> > As replied to Rob, I'm not sure it is so easy to find any physical
> > property that expresses what we essentially need (without maybe relying
> > on a complex mix of hardware details and a model to extract numbers from
> > them). Instead, we propose to have reasonable, per SoC, default numbers;
> > and then let users fine tune their platform afterwards, without changing
> > those default values.
> 
> If users are supposed to do fine tuning elsewhere after the fact why
> bother with this initial callibration?  Something that's ballpark good
> enough like just knowing the core used and perhaps some important
> options on it should give an adequate starting point and not have the
> issues with having the tuning numbers present as magic numbers.  Perhaps
> we might also feed cache information in at some point.  If in future
> we're able to improve those default numbers (or just adapt at runtime)
> then even better.
> 
> It also seems a bit strange to expect people to do some tuning in one
> place initially and then additional tuning somewhere else later, from
> a user point of view I'd expect to always do my tuning in the same
> place.
> 

I think that runtime tuning needs are much more complex and have finer
grained needs than what you can achieve by playing with CPU capacities.
And I agree with you, users should only play with these other methods
I'm referring to; they should not mess around with platform description
bits. They should provide information about runtime needs, then the
scheduler (in this case) will do its best to give them acceptable
performance using improved knowledge about the platform.

> > > We're not going to get out of having to pick numbers at some point,
> > > pushing them into DT doesn't get us out of that but it does make the
> > > situation harder to manage long term and makes the performance for the
> > > general user less relaible.  It's also just more work all round,
> > > everyone doing the DT for a SoC is going to have to do some combination
> > > of cargo culting or repeating the callibration.
> 
> > I'm most probably a bit naive here, but I see the calibration phase
> > happening only once, after the platform is stable. You get default
> > capacity values by running a pretty simple benchmark on a fixed
> > configuration; and you put them somewhere (DTs still seem to be a
> > sensible place to me). Then you'll be able to suit tuning needs using
> > different interfaces.
> 
> My point is that everyone making any kind of SoC with asymmetries is
> expected to go and do some kind of callibration based on some unclear
> criteria, if these are just ballpark accurate starting points that seems
> like wasted effort - the kernel should be making a reasonable effort to
> do something sensible without this information which is going to be less
> effort all round.  It doesn't need to wait for real silicon (this seems
> like the sort of core bit of DT which will be being written pre-tapeout)
> and doesn't have marketing implications.
> 
> Doing that and then switching to some other interface for real tuning
> seems especially odd and I'm not sure that's something that users are
> going to expect or understand.

As I'm saying above, users should not care about this first step of
platform description; not more than how much they care about other bits
in DTs that describe their platform.

Thanks,

- Juri
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
