From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH 2/8] Documentation: arm: define DT cpu capacity
 bindings
Date: Tue, 15 Dec 2015 16:41:45 +0000
Message-ID: <20151215164145.GA8012@leverpostej>
References: <20151214123616.GC3308@e106622-lin>
 <20151214165928.GV5727@sirena.org.uk>
 <20151215122238.GG16007@e106622-lin>
 <20151215133951.GY5727@sirena.org.uk>
 <20151215140135.GI31299@leverpostej>
 <20151215150813.GZ5727@sirena.org.uk>
 <20151215153218.GA7228@leverpostej>
 <20151215154651.GK16007@e106622-lin>
 <20151215155737.GB7619@leverpostej>
 <20151215162317.GB24286@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50370 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753994AbbLOQmI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 15 Dec 2015 11:42:08 -0500
Content-Disposition: inline
In-Reply-To: <20151215162317.GB24286@e104818-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Juri Lelli <juri.lelli@arm.com>, peterz@infradead.org, Linus Walleij <linus.walleij@linaro.org>, will.deacon@arm.com, morten.rasmussen@arm.com, lorenzo.pieralisi@arm.com, vincent.guittot@linaro.org, linux-pm@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Mark Brown <broonie@kernel.org>, Gregory CLEMENT <gregory.clement@free-electrons.com>, linux@arm.linux.org.uk, dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Paul Walmsley <paul@pwsan.com>, linux-kernel@vger.kernel.org, sudeep.holla@arm.com, Olof Johansson <olof@lixom.net>, Maxime Ripard <maxime.ripard@free-electrons.com>

On Tue, Dec 15, 2015 at 04:23:18PM +0000, Catalin Marinas wrote:
> On Tue, Dec 15, 2015 at 03:57:37PM +0000, Mark Rutland wrote:
> > On Tue, Dec 15, 2015 at 03:46:51PM +0000, Juri Lelli wrote:
> > > On 15/12/15 15:32, Mark Rutland wrote:
> > > > On Tue, Dec 15, 2015 at 03:08:13PM +0000, Mark Brown wrote:
> > > > > My expectation is that we just need good enough, not perfect, and that
> > > > > seems to match what Juri is saying about the expectation that most of
> > > > > the fine tuning is done via other knobs.
> > > > 
> > > > My expectation is that if a ballpark figure is good enough, it should be
> > > > possible to implement something trivial like bogomips / loop_per_jiffy
> > > > calculation.
> > > 
> > > I didn't really followed that, so I might be wrong here, but isn't
> > > already happened a discussion about how we want/like to stop exposing
> > > bogomips info or rely on it for anything but in kernel delay loops?
> > 
> > I meant that we could have a benchmark of that level of complexity,
> > rather than those specific values.
> 
> Or we could simply let user space use whatever benchmarks or hard-coded
> values it wants and set the capacity via sysfs (during boot). By
> default, the kernel would assume all CPUs equal.

I assume that a userspace override would be available regardless of
whatever mechanism the kernel uses to determine relative
performance/effinciency.

I am not opposed to that mechanism being "assume equal".

Mark.
