From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFC PATCH 2/8] Documentation: arm: define DT cpu capacity
 bindings
Date: Tue, 15 Dec 2015 14:24:58 +0000
Message-ID: <20151215142458.GI16007@e106622-lin>
References: <1448288921-30307-3-git-send-email-juri.lelli@arm.com>
 <20151124020631.GA15165@rob-hp-laptop>
 <20151210153004.GA26758@sirena.org.uk>
 <20151210175820.GE14571@e106622-lin>
 <20151211174940.GQ5727@sirena.org.uk>
 <20151214123616.GC3308@e106622-lin>
 <20151214165928.GV5727@sirena.org.uk>
 <20151215122238.GG16007@e106622-lin>
 <20151215133951.GY5727@sirena.org.uk>
 <20151215140135.GI31299@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151215140135.GI31299@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Olof Johansson <olof@lixom.net>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Paul Walmsley <paul@pwsan.com>, Linus Walleij <linus.walleij@linaro.org>, Chen-Yu Tsai <wens@csie.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
List-Id: linux-pm@vger.kernel.org

Hi Mark,

On 15/12/15 14:01, Mark Rutland wrote:
> On Tue, Dec 15, 2015 at 01:39:51PM +0000, Mark Brown wrote:
> > On Tue, Dec 15, 2015 at 12:22:38PM +0000, Juri Lelli wrote:
> > > > So then why isn't it adequate to just have things like the core types in
> > > > there and work from there?  Are we really expecting the tuning to be so
> > > > much better than it's possible to come up with something that's so much
> > > > better on the scale that we're expecting this to be accurate that it's
> > > > worth just jumping straight to magic numbers?
> > 
> > > I take your point here that having fine grained values might not really
> > > give us appreciable differences (that is also why I proposed the
> > > capacity-scale in the first instance), but I'm not sure I'm getting what
> > > you are proposing here.
> > 
> > Something like the existing solution for arm32.
> > 
> > >  static const struct cpu_efficiency table_efficiency[] = {
> > >  	{"arm,cortex-a15", 3891},
> > >  	{"arm,cortex-a7",  2048},
> > >  	{NULL, },
> > >  };
> > 
> > > When clock-frequency property is defined in DT, we try to find a match
> > > for the compatibility string in the table above and then use the
> > > associate number to compute the capacity. Are you proposing to have
> > > something like this for arm64 as well?
> > 
> > > BTW, the only info I could find about those numbers is from this thread
> > 
> > It was discussed in some other thread when I was sending the equivalent
> > stuff for arm64 (I never got round to finishing it off due to issues
> > with Catalin and Will being concerned about the specific numbers).
> > Vincent confirmed that the numbers came from the (IIRC) DMIPS/MHz
> > numbers that ARM publish for the cores.  I'd independently done the same
> > thing for arm64.  It would probably help to put comments in there with
> > the base numbers before scaling, or just redo the table in terms of the
> > raw numbers.
> > 
> > This is, of course, an example of my concerns about magic number
> > configuration.
> > 
> > > If I understand how that table was created, how do we think we will
> > > extend it in the future to allow newer core types (say we replicate this
> > > solution for arm64)?  It seems that we have to change it, rescaling
> > > values, each time we have a new core on the market. How can we come up
> > > with relative numbers, in the future, comparing newer cores to old ones
> > > (that might be already out of the market by that time)?
> > 
> > It doesn't seem particularly challenging to add new numbers to the table
> > (and add additional properties to select on) TBH.  We can either rescale
> > by hand in the table when adding entries, script it as part of the
> > kernel build or do it at runtime (as the arm32 code already does to an
> > extent based on the particular set of cores we find).  What difficulties
> > do you see with this?
> > 
> > This is something that seems like an advantage to me - we can just
> > replace everything at any point, we're not tied to trusting the golden
> > benchmark someone did (or tweaked) if we come up with a better
> > methodology later on.
> 
> I really don't want to see a table of magic numbers in the kernel.
> 

Doesn't seem to be a clean and scalable solution to me either. It is not
easy to reconfigure when new core types come around, as I don't think
relative data is always present or easy to derive, and it exposes some
sort of centralized global information where everyone is compared
against everyone. Where the DT solution is inherently per platform: no
need to expose absolute values and no problems with knowing data
regarding old core types.

> The relative performance and efficiency of cores will vary depending on
> uArch-specific configuration (e.g. sizing of L1/L2 caches) in addition
> to general uArch differences, and integration too (e.g. if the memory
> system gives priority to one cluster over another for whatever reason).
> I've heard of pseudo-heterogeneous platforms with different
> configuration of the same uArch across clusters.
> 
> We also don't necessarily have the CPU clock frequencies, or the ability
> to scale them. Maybe we simply give up in that case, though.
> 
> If we cannot rely on external information, and want this information to
> be derived by the kernel, then we need to perform some dynamic
> benchmark. That would work for future CPUs the kernel knows nothing
> about yet, and would cater for the pseudo-heterogeneous cases too.
> 

I've actually experimented a bit with this approch already, but I wasn't
convinced of its viability. It is true that we remove the burden of
coming up with default values from user/integrator, but I'm pretty sure
we will end up discussing endlessly about which particular benchmark to
pick and the fact that it impacts on boot time and such.

Best,

- Juri
