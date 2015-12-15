From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC PATCH 2/8] Documentation: arm: define DT cpu capacity bindings
Date: Tue, 15 Dec 2015 14:55:12 +0100
Message-ID: <CAKfTPtBJVFOiS7Ci8rgEP_tWWb+nW=DnvJeQ6+HywK5+Ncq+Ng@mail.gmail.com>
References: <1448288921-30307-1-git-send-email-juri.lelli@arm.com>
 <1448288921-30307-3-git-send-email-juri.lelli@arm.com> <20151124020631.GA15165@rob-hp-laptop>
 <20151210153004.GA26758@sirena.org.uk> <20151210175820.GE14571@e106622-lin>
 <20151211174940.GQ5727@sirena.org.uk> <20151214123616.GC3308@e106622-lin>
 <20151214165928.GV5727@sirena.org.uk> <20151215122238.GG16007@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:35409 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933369AbbLONzd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2015 08:55:33 -0500
Received: by mail-lb0-f180.google.com with SMTP id u9so6084636lbp.2
        for <linux-pm@vger.kernel.org>; Tue, 15 Dec 2015 05:55:32 -0800 (PST)
In-Reply-To: <20151215122238.GG16007@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Olof Johansson <olof@lixom.net>, Gregory CLEMENT <gregory.clement@f>

On 15 December 2015 at 13:22, Juri Lelli <juri.lelli@arm.com> wrote:
> On 14/12/15 16:59, Mark Brown wrote:
>> On Mon, Dec 14, 2015 at 12:36:16PM +0000, Juri Lelli wrote:
>> > On 11/12/15 17:49, Mark Brown wrote:
>>
>> > > The purpose of the capacity values is to influence the scheduler
>> > > behaviour and hence performance.  Without a concrete definition they're
>> > > just magic numbers which have meaining only in terms of their effect on
>> > > the performance of the system.  That is a sufficiently complex outcome
>> > > to ensure that there will be an element of taste in what the desired
>> > > outcomes are.  Sounds like tuneables to me.
>>
>> > Capacity values are meant to describe asymmetry (if any) of the system
>> > CPUs to the scheduler. The scheduler can then use this additional bit of
>> > information to try to do better scheduling decisions. Yes, having these
>> > values available will end up giving you better performance, but I guess
>> > this apply to any information we provide to the kernel (and scheduler);
>> > the less dumb a subsystem is, the better we can make it work.
>>
>> This information is a magic number, there's never going to be a right
>> answer.  If it needs changing it's not like the kernel is modeling a
>> concrete thing like the relative performance of the A53 and A57 poorly
>> or whatever, it's just that the relative values of number A and number B
>> are not what the system integrator desires.
>>
>> > > If you are saying people should use other, more sensible, ways of
>> > > specifying the final values that actually get used in production then
>> > > why take the defaults from direct numbers DT in the first place?  If you
>> > > are saying that people should tune and then put the values in here then
>> > > that's problematic for the reasons I outlined.
>>
>> > IMHO, people should come up with default values that describe
>> > heterogeneity in their system. Then use other ways to tune the system at
>> > run time (depending on the workload maybe).
>>
>> My argument is that they should be describing the hetrogeneity of their
>> system by describing concrete properties of their system rather than by
>> providing magic numbers.
>>
>> > As said, I understand your concerns; but, what I don't still get is
>> > where CPU capacity values are so different from, say, idle states
>> > min-residency-us. AFAIK there is a per-SoC benchmarking phase required
>> > to come up with that values as well; you have to pick some benchmark
>> > that stresses worst case entry/exit while measuring energy, then make
>> > calculations that tells you when it is wise to enter a particular idle
>> > state. Ideally we should derive min residency from specs, but I'm not
>> > sure is how it works in practice.
>>
>> Those at least have a concrete physical value that it is possible to
>> measure in a describable way that is unlikely to change based on the
>> internals of the kernel.  It would be kind of nice to have the broken
>> down numbers for entry time, exit time and power burn in suspend but
>> it's not clear it's worth the bother.  It's also one of these things
>> where we don't have any real proxies that get us anywhere in the
>> ballpark of where we want to be.
>>
>
> I'm proposing to add a new value because I couldn't find any proxies in
> the current bindings that bring us any close to what we need. If I
> failed in looking for them, and they actually exists, I'll personally be
> more then happy to just rely on them instead of adding more stuff :-).
>
> Interestingly, to me it sounds like we could actually use your first
> paragraph above almost as it is to describe how to come up with capacity
> values. In the documentation I put the following:
>
> "One simple way to estimate CPU capacities is to iteratively run a
> well-known CPU user space benchmark (e.g, sysbench, dhrystone, etc.) on
> each CPU at maximum frequency and then normalize values w.r.t.  the best
> performing CPU."
>
> I don't see why this should change if we decide that the scheduler has
> to change in the future.
>
> Also, looking again at section 2 of idle-states bindings docs, we have a
> nice and accurate description of what min-residency is, but not much
> info about how we can actually measure that. Maybe, expanding the docs
> section regarding CPU capacity could help?
>
>> > > It also seems a bit strange to expect people to do some tuning in one
>> > > place initially and then additional tuning somewhere else later, from
>> > > a user point of view I'd expect to always do my tuning in the same
>> > > place.
>>
>> > I think that runtime tuning needs are much more complex and have finer
>> > grained needs than what you can achieve by playing with CPU capacities.
>> > And I agree with you, users should only play with these other methods
>> > I'm referring to; they should not mess around with platform description
>> > bits. They should provide information about runtime needs, then the
>> > scheduler (in this case) will do its best to give them acceptable
>> > performance using improved knowledge about the platform.
>>
>> So then why isn't it adequate to just have things like the core types in
>> there and work from there?  Are we really expecting the tuning to be so
>> much better than it's possible to come up with something that's so much
>> better on the scale that we're expecting this to be accurate that it's
>> worth just jumping straight to magic numbers?
>>
>
> I take your point here that having fine grained values might not really
> give us appreciable differences (that is also why I proposed the
> capacity-scale in the first instance), but I'm not sure I'm getting what
> you are proposing here.
>
> Today, and for arm only, we have a static table representing CPUs
> "efficiency":
>
>  /*
>   * Table of relative efficiency of each processors
>   * The efficiency value must fit in 20bit and the final
>   * cpu_scale value must be in the range
>   *   0 < cpu_scale < 3*SCHED_CAPACITY_SCALE/2
>   * in order to return at most 1 when DIV_ROUND_CLOSEST
>   * is used to compute the capacity of a CPU.
>   * Processors that are not defined in the table,
>   * use the default SCHED_CAPACITY_SCALE value for cpu_scale.
>   */
>  static const struct cpu_efficiency table_efficiency[] = {
>         {"arm,cortex-a15", 3891},
>         {"arm,cortex-a7",  2048},
>         {NULL, },
>  };
>
> When clock-frequency property is defined in DT, we try to find a match
> for the compatibility string in the table above and then use the
> associate number to compute the capacity. Are you proposing to have
> something like this for arm64 as well?
>
> BTW, the only info I could find about those numbers is from this thread
>
>  http://lists.infradead.org/pipermail/linux-arm-kernel/2012-June/104072.html
>
> Vincent, do we have more precise information about these numbers
> somewhere else?

These numbers come from a document from ARM in which they compared A15
and A7 . I just used the number provided by this white paper and scale
it in a more appropriate range than DMIPS/Mhz

>
> If I understand how that table was created, how do we think we will
> extend it in the future to allow newer core types (say we replicate this
> solution for arm64)?  It seems that we have to change it, rescaling
> values, each time we have a new core on the market. How can we come up
> with relative numbers, in the future, comparing newer cores to old ones
> (that might be already out of the market by that time)?
>
>> > > Doing that and then switching to some other interface for real tuning
>> > > seems especially odd and I'm not sure that's something that users are
>> > > going to expect or understand.
>>
>> > As I'm saying above, users should not care about this first step of
>> > platform description; not more than how much they care about other bits
>> > in DTs that describe their platform.
>>
>> That may be your intention but I don't see how it is realistic to expect
>> that this is what people will actually understand.  It's a number, it
>> has an effect and it's hard to see that people won't tune it, it's not
>> like people don't have to edit DTs during system integration.  People
>> won't reliably read documentation or look in mailing list threads and
>> other that that it has all the properties of a tuning interface.
>>
>
> Eh, sad but true. I guess we can, as we usually do, put more effort in
> documenting how things are supposed to be used. Then, if people think
> that they can make their system perform better without looking at
> documentation or asking around, I'm not sure there is much we could do
> to prevent them to do things wrong. There are already lot of things
> people shouldn't touch if they don't know what they are doing. :-/
>
>> There's a tension here between what you're saying about people not being
>> supposed to care much about the numbers for tuning and the very fact
>> that there's a need for the DT to carry explicit numbers.
>
> My point is that people with tuning needs shouldn't even look at DTs,
> but put all their efforts in describing (using appropriate APIs) their
> needs and how they apply to the workload they care about. Our job is to
> put together information coming from users and knowledge of system
> configuration to provide people the desired outcomes.
>
> Best,
>
> - Juri
