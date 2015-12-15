From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH 2/8] Documentation: arm: define DT cpu capacity
 bindings
Date: Tue, 15 Dec 2015 15:57:37 +0000
Message-ID: <20151215155737.GB7619@leverpostej>
References: <20151210175820.GE14571@e106622-lin>
 <20151211174940.GQ5727@sirena.org.uk>
 <20151214123616.GC3308@e106622-lin>
 <20151214165928.GV5727@sirena.org.uk>
 <20151215122238.GG16007@e106622-lin>
 <20151215133951.GY5727@sirena.org.uk>
 <20151215140135.GI31299@leverpostej>
 <20151215150813.GZ5727@sirena.org.uk>
 <20151215153218.GA7228@leverpostej>
 <20151215154651.GK16007@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151215154651.GK16007@e106622-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Olof Johansson <olof@lixom.net>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Paul Walmsley <paul@pwsan.com>, Linus Walleij <linus.walleij@linaro.org>, Chen-Yu Tsai <wens@csie.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 15, 2015 at 03:46:51PM +0000, Juri Lelli wrote:
> On 15/12/15 15:32, Mark Rutland wrote:
> > On Tue, Dec 15, 2015 at 03:08:13PM +0000, Mark Brown wrote:
> > > My expectation is that we just need good enough, not perfect, and that
> > > seems to match what Juri is saying about the expectation that most of
> > > the fine tuning is done via other knobs.
> > 
> > My expectation is that if a ballpark figure is good enough, it should be
> > possible to implement something trivial like bogomips / loop_per_jiffy
> > calculation.
> > 
> 
> I didn't really followed that, so I might be wrong here, but isn't
> already happened a discussion about how we want/like to stop exposing
> bogomips info or rely on it for anything but in kernel delay loops?

I meant that we could have a benchmark of that level of complexity,
rather than those specific values.

Mark.
