From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFC PATCH 2/8] Documentation: arm: define DT cpu capacity
 bindings
Date: Thu, 10 Dec 2015 17:58:20 +0000
Message-ID: <20151210175820.GE14571@e106622-lin>
References: <1448288921-30307-1-git-send-email-juri.lelli@arm.com>
 <1448288921-30307-3-git-send-email-juri.lelli@arm.com>
 <20151124020631.GA15165@rob-hp-laptop>
 <20151210153004.GA26758@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56780 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751877AbbLJR5x (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 10 Dec 2015 12:57:53 -0500
Content-Disposition: inline
In-Reply-To: <20151210153004.GA26758@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Olof Johansson <olof@lixom.net>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Paul Walmsley <paul@pwsan.com>, Linus Walleij <linus.walleij@linaro.org>, Chen-Yu Tsai <wens@csie.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Hi Mark,

I certainly understand your (and Rob's) concerns, but let me try anyway
to argument a bit more around this approach :-).

On 10/12/15 15:30, Mark Brown wrote:
> On Mon, Nov 23, 2015 at 08:06:31PM -0600, Rob Herring wrote:
> 
> > I think you need something absolute and probably per MHz (like 
> > dynamic-power-coefficient property). Perhaps the IPC (instructions per 
> > clock) value?
> 
> > In other words, I want to see these numbers have a defined method 
> > of determining them and don't want to see random values from every 
> > vendor. ARM, Ltd. says core X has a value of Y would be good enough for 
> > me. Vendor X's A57 having a value of 2 and Vendor Y's A57 having a 
> > value of 1024 is not what I want to see. Of course things like cache 
> > sizes can vary the performance, but is a baseline value good enough? 
> 
> > However, no vendor will want to publish their values if these are 
> > absolute values relative to other vendors.
> 
> > If you expect these to need frequent tuning, then don't put them in DT.
> 
> I agree strongly.  Putting what are essentially tuning numbers for the
> system into the ABI is going to lead us into a mess long term since if
> we change anything related to the performance of the system the numbers
> may become invalid and we've no real way of recovering sensible
> information.
> 
> There is of course also the issue where people are getting the numbers
> from in the first place - were the numbers picked for some particular
> use case or to optimise some particular benchmark, what other conditions
> existed at the time (cpufreq setup for example), what tuning goals did
> the people picking the numbers have and do any of those things
> correspond to what a given user wants?  If detailed tuning the numbers
> for specific systems matters much will we get competing users patching
> the in kernel DTs over and over, and what do we do about ACPI systems?
> Having an absolute definition doesn't really help with this since the
> concrete effect DT authors see is that these are tuning numbers.
> 

I'm not entirely getting here why you consider capacity values to be
tunables. As part of the EAS effort, we are proposing ways in which users
should be able to fine tune their system as needed, when required
(don't know if you had a chance to have a look at the SchedTune posting
back in August for example [1]). This patch tries to only standardize
where do we get default values from and how we specify them. I'm not
seeing them changing much after an initial benchmarking phase has been
done. Tuning should happen using different methods, not by changing
these values, IMHO.

> It would be better to have the DT describe concrete physical properties
> of the system which we can then map onto numbers we like, that way if we
> get better information in future or just decide that completely
> different metrics are appropriate for tuning we can just do that without
> having to worry about translating the old metrics into new ones.  We can
> then expose the tuning knobs to userspace for override if that's needed.
> If doing system specific tuning on vertically integrated systems really
> is terribly important it's not going to matter too much where the tuning
> is but we also have to consider more general purpose systems.
> 

As replied to Rob, I'm not sure it is so easy to find any physical
property that expresses what we essentially need (without maybe relying
on a complex mix of hardware details and a model to extract numbers from
them). Instead, we propose to have reasonable, per SoC, default numbers;
and then let users fine tune their platform afterwards, without changing
those default values.

> We're not going to get out of having to pick numbers at some point,
> pushing them into DT doesn't get us out of that but it does make the
> situation harder to manage long term and makes the performance for the
> general user less relaible.  It's also just more work all round,
> everyone doing the DT for a SoC is going to have to do some combination
> of cargo culting or repeating the callibration.
> 

I'm most probably a bit naive here, but I see the calibration phase
happening only once, after the platform is stable. You get default
capacity values by running a pretty simple benchmark on a fixed
configuration; and you put them somewhere (DTs still seem to be a
sensible place to me). Then you'll be able to suit tuning needs using
different interfaces.

ABI changes have to be carefully considered, I know. But still, we need
to agree on a way to provide these default capacity values someway. So,
thanks for helping us carry on this discussion.

Best,

- Juri

> I remember Peter remarking at one of the LPC discussions of this idea
> that there had been some bad experiences with getting numbers from 
> firmware on other systems.

[1] https://lkml.org/lkml/2015/8/19/419
