From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH v4 2/8] Documentation: arm: define DT cpu capacity
 bindings
Date: Mon, 21 Mar 2016 11:39:38 +0000
Message-ID: <20160321113938.GC12319@e106622-lin>
References: <1458311054-13524-1-git-send-email-juri.lelli@arm.com>
 <1458311054-13524-3-git-send-email-juri.lelli@arm.com>
 <20160320011517.GA17705@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34764 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754554AbcCULiX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 21 Mar 2016 07:38:23 -0400
Content-Disposition: inline
In-Reply-To: <20160320011517.GA17705@rob-hp-laptop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, broonie@kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Olof Johansson <olof@lixom.net>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Paul Walmsley <paul@pwsan.com>, Linus Walleij <linus.walleij@linaro.org>, Chen-Yu Tsai <wens@csie.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

On 19/03/16 20:15, Rob Herring wrote:
> On Fri, Mar 18, 2016 at 02:24:08PM +0000, Juri Lelli wrote:
> > ARM systems may be configured to have cpus with different power/performance
> > characteristics within the same chip. In this case, additional information
> > has to be made available to the kernel (the scheduler in particular) for it
> > to be aware of such differences and take decisions accordingly.
> > 
> > Therefore, this patch aims at standardizing cpu capacities device tree
> > bindings for ARM platforms. Bindings define cpu capacity parameter, to
> > allow operating systems to retrieve such information from the device tree
> > and initialize related kernel structures, paving the way for common code in
> > the kernel to deal with heterogeneity.
> > 
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Pawel Moll <pawel.moll@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> > Cc: Kumar Gala <galak@codeaurora.org>
> > Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> > Cc: Olof Johansson <olof@lixom.net>
> > Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Chen-Yu Tsai <wens@csie.org>
> > Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> > ---
> > 
> > Changes from v1:
> >  - removed section regarding capacity-scale
> >  - added information regarding normalization
> > ---
> >  .../devicetree/bindings/arm/cpu-capacity.txt       | 222 +++++++++++++++++++++
> >  Documentation/devicetree/bindings/arm/cpus.txt     |   9 +
> >  2 files changed, 231 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/cpu-capacity.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/cpu-capacity.txt b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> > new file mode 100644
> > index 0000000..fdfc453
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> > @@ -0,0 +1,222 @@
> > +==========================================
> > +ARM CPUs capacity bindings
> > +==========================================
> > +
> > +==========================================
> > +1 - Introduction
> > +==========================================
> > +
> > +ARM systems may be configured to have cpus with different power/performance
> > +characteristics within the same chip. In this case, additional information
> > +has to be made available to the kernel (the scheduler in particular) for
> > +it to be aware of such differences and take decisions accordingly.
> > +
> > +==========================================
> > +2 - CPU capacity definition
> > +==========================================
> > +
> > +CPU capacity is a number that provides the scheduler information about CPUs
> > +heterogeneity. Such heterogeneity can come from micro-architectural differences
> > +(e.g., ARM big.LITTLE systems) or maximum frequency at which CPUs can run
> > +(e.g., SMP systems with multiple frequency domains). Heterogeneity in this
> > +context is about differing performance characteristics; this binding tries to
> > +capture a first-order approximation of the relative performance of CPUs.
> > +
> > +One simple way to estimate CPU capacities is to iteratively run a well-known
> > +CPU user space benchmark (e.g, sysbench) on each CPU at maximum frequency and
> > +then normalize values w.r.t.  the best performing CPU.  One can also do a
> > +statistically significant study of a wide collection of benchmarks, but pros
> > +of such an approach are not really evident at the time of writing.
> 
> I'll say again what I did previously. I don't have a problem this being 
> in DT, but I want to see a defined method for determining the value. The 
> above is a pretty vague statement. That can be run X to generate the 
> value on the cpu. Or ARM providing the "golden" value for each core. As 
> you said, it is only a 1st order approximation, so vendor to vendor 
> implementation variations should not matter. 
> 

OK, sorry if I didn't get it. :-)

What we usually do to come up with these numbers for a new platform is
really something as simple as:

 - set every CPUs to performance governor
 - run the following on first CPU of each cluster
   # taskset '<CPUmask>' sysbench --test=cpu --num-threads=1 --max-time=10 \
     run | grep "events:" | awk '{print $5}'
 - normalize numbers w.r.t. highest value obtained by running the former

I'm not sure we can put something like this in the definition above, but
I wont raise any objections if we actually can. :-)

The "golden" value solution I don't think is feasible. Different
implementations of the same CPU, and different configurations of caches
etc., will end up giving different numbers. This values has to be a per
platform thing, IMHO. Also, being it a per platform and relative number,
it will be "confined" to a certain platform only (comparing capacities
across different DTs has no meaning).

> I also worry about what happens in more complex cases with lots of 
> possible OPPs such as Qualcomm chips. This single value may not be 
> sufficient.
> 

Having many OPPs are not a problem. This value only tells about
micro-arch differences and it is used to obtain CPU scale invariance
component.  We then have a frequency invariant component to handle clock
frequency differences (there is also an on-going discussion about this
[1]). The capacity values are to be obtained running at max freq.

Thanks,

- Juri

[1] https://lkml.org/lkml/2016/3/14/64
