From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC PATCH 2/8] Documentation: arm: define DT cpu capacity bindings
Date: Tue, 15 Dec 2015 18:47:20 +0100
Message-ID: <CAKfTPtBzWcNHx+Fi7hUabNpPsd1thFAkPnLcpsnqbQp6Qq24cQ@mail.gmail.com>
References: <20151215122238.GG16007@e106622-lin> <20151215133951.GY5727@sirena.org.uk>
 <20151215140135.GI31299@leverpostej> <20151215150813.GZ5727@sirena.org.uk>
 <20151215153218.GA7228@leverpostej> <20151215154651.GK16007@e106622-lin>
 <20151215155737.GB7619@leverpostej> <20151215162317.GB24286@e104818-lin.cambridge.arm.com>
 <20151215164145.GA8012@leverpostej> <CAKfTPtAuosPcL8bbQ27Y-vUE1h4QRY8hGESnm4YrxqRAQ3K=5g@mail.gmail.com>
 <20151215171518.GC8012@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:34686 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933445AbbLORrl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2015 12:47:41 -0500
Received: by mail-lb0-f178.google.com with SMTP id cs9so10687739lbb.1
        for <linux-pm@vger.kernel.org>; Tue, 15 Dec 2015 09:47:41 -0800 (PST)
In-Reply-To: <20151215171518.GC8012@leverpostej>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Juri Lelli <juri.lelli@arm.com>, Peter Zijlstra <peterz@infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will.deacon@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Mark Brown <broonie@kernel.org>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Dietmar Eggemann <dietmar.eggemann@arm.com>, LAK <linux-arm-kernel@lists.infradead.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Paul Walmsley <paul@pwsan.com>linux-kernel <linux>

On 15 December 2015 at 18:15, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Dec 15, 2015 at 05:59:34PM +0100, Vincent Guittot wrote:
>> On 15 December 2015 at 17:41, Mark Rutland <mark.rutland@arm.com> wrote:
>> > On Tue, Dec 15, 2015 at 04:23:18PM +0000, Catalin Marinas wrote:
>> >> On Tue, Dec 15, 2015 at 03:57:37PM +0000, Mark Rutland wrote:
>> >> > On Tue, Dec 15, 2015 at 03:46:51PM +0000, Juri Lelli wrote:
>> >> > > On 15/12/15 15:32, Mark Rutland wrote:
>> >> > > > On Tue, Dec 15, 2015 at 03:08:13PM +0000, Mark Brown wrote:
>> >> > > > > My expectation is that we just need good enough, not perfect, and that
>> >> > > > > seems to match what Juri is saying about the expectation that most of
>> >> > > > > the fine tuning is done via other knobs.
>> >> > > >
>> >> > > > My expectation is that if a ballpark figure is good enough, it should be
>> >> > > > possible to implement something trivial like bogomips / loop_per_jiffy
>> >> > > > calculation.
>> >> > >
>> >> > > I didn't really followed that, so I might be wrong here, but isn't
>> >> > > already happened a discussion about how we want/like to stop exposing
>> >> > > bogomips info or rely on it for anything but in kernel delay loops?
>> >> >
>> >> > I meant that we could have a benchmark of that level of complexity,
>> >> > rather than those specific values.
>> >>
>> >> Or we could simply let user space use whatever benchmarks or hard-coded
>> >> values it wants and set the capacity via sysfs (during boot). By
>> >> default, the kernel would assume all CPUs equal.
>> >
>> > I assume that a userspace override would be available regardless of
>> > whatever mechanism the kernel uses to determine relative
>> > performance/effinciency.
>>
>> Don't you think that if we let a complete latitude to the userspace
>> to set whatever it wants, it will be used to abuse the kernel (and the
>> scheduler in particular ) and that this will finish in a real mess to
>> understand what is wrong when a task is not placed where it should be.
>
> I'm not sure I follow what you mean by "abuse" here. Userspace currently
> can force the scheduler to make sub-optimal decisions in a number of
> ways, e.g.
>
> * Hot-unplugging the preferred CPUs
> * Changing a task's affinity mask
> * Setting the nice value of a task
> * Using rlimits and/or cgroups
> * Using a cpufreq governor
> * Fork-bombing

All these are parameters have a meaning (except the last one). By
abusing i mean setting the capacity of the most powerful cpu to 1 for
no good reason except to abuse the scheduler so the latter will not
put that much tasks on it just  because the current running use case
is more efficient if the big core is not used.


>
> Practically all of these are prvileged operations. I would envisage the
> userspace interface for "capacity" management to be similar.
>
>> We can probably provide a debug mode to help soc manufacturer to
>> define their capacity value but IMHO we should not let complete
>> latitude in normal operation
>
> In normal operation userspace wouldn't mess with this, as with most of
> the cases above. Userspace can already shooti tself in the foot.
>
>> In normal operation we need to give some methods to tweak the value to
>> reflect a memory bounded or integer calculation work  or other kind of
>> work that currently runs on the cpu but not more
>
> You can already do that with the mechanisms above, to some extent. I'm
> not sure I follow.
>
> Mark.
