From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH v5 1/8] Documentation: arm: define DT cpu
 capacity-dmips-mhz bindings
Date: Thu, 16 Jun 2016 09:20:42 +0100
Message-ID: <20160616082042.GI5981@e106622-lin>
References: <1465985877-18271-1-git-send-email-juri.lelli@arm.com>
 <1465985877-18271-2-git-send-email-juri.lelli@arm.com>
 <CAL_JsqJwQVsn3=6vQus4Q2OhnLUsJVN70j2+f3QoJejcb=p9YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqJwQVsn3=6vQus4Q2OhnLUsJVN70j2+f3QoJejcb=p9YA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, peterz@infradead.org, Vincent Guittot <vincent.guittot@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Mark Brown <broonie@kernel.org>, sgurrappadi@nvidia.com, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Olof
List-Id: linux-pm@vger.kernel.org

Hi,

On 15/06/16 17:11, Rob Herring wrote:
> On Wed, Jun 15, 2016 at 5:17 AM, Juri Lelli <juri.lelli@arm.com> wrote:

[...]

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
> > +CPU capacities are obtained by running a suitable benchmark. This binding makes
> > +no aspersions on the validity or suitability of any particular benchmark, the
> > +final capacity should, however, be:
> > +
> > +* A "single-threaded" or CPU affine benchmark
> > +* Divided by the running frequency of the CPU executing the benchmark
> > +* Not subject to dynamic frequency scaling of the CPU
> > +
> > +For the time being we however advise usage of the Dhrystone benchmark. What
> > +above thus becomes:
> > +
> > +CPU capacities are obtained by running the Dhrystone benchmark on each CPU at
> > +max frequency. The obtained DMIPS score is then divided by the frequency (in
> > +MHz) at which the benchmark has been run, so that DMIPS/MHz are obtained.
> > +Such values are then normalized w.r.t. the highest score obtained in the
> > +system.
> 
> So the property says it represents DMIPS/MHz, but we take that and
> "normalize" them back to a made up numbers?

The normalization step is required if one wants to prevent
cross-platform comparisons (I think that's what vendors generally want).
They are not made up, they still come from measured DMIPS/MHz values.

> Perhaps that step should
> be optional. Then paranoid Si vendors can put their fake numbers in
> and end users can update the dts files with real numbers.
> 

But, you can also decide to skip that step and put non normalized
numbers in. This documentation is advising people for what seems to be
be the most common way of coming up with values that, once in a DT,
won't be used to compare perf of different platforms.

Maybe we want to add a paragraph clearly stating this point?

> Is there any point in allowing people to pick their own scale? Why not
> just 100 (as in percent)?
> 

I think we agreed that not picking any particular scale is more flexible
and easier to use. For example, if there is a 2x factor between you cpus
you can simply put 1 and 2 there. But, if you need higher "resolution"
you can put whatever suits you better and we'll use the max as scale.

Thanks a lot for the review.

Best,

- Juri
