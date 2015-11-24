From: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 2/8] Documentation: arm: define DT cpu capacity
 bindings
Date: Tue, 24 Nov 2015 10:54:23 +0000
Message-ID: <20151124105423.GM26372@e106622-lin>
References: <1448288921-30307-1-git-send-email-juri.lelli@arm.com>
 <1448288921-30307-3-git-send-email-juri.lelli@arm.com>
 <20151124020631.GA15165@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151124020631.GA15165@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, morten.rasmussen-5wv7dgnIgG8@public.gmane.org, dietmar.eggemann-5wv7dgnIgG8@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On 23/11/15 20:06, Rob Herring wrote:
> On Mon, Nov 23, 2015 at 02:28:35PM +0000, Juri Lelli wrote:
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
> > Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
> > Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
> > Cc: Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
> > Cc: Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> > Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > Cc: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
> > Cc: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
> > Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> > Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Signed-off-by: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
> > ---
> >  .../devicetree/bindings/arm/cpu-capacity.txt       | 227 +++++++++++++++++++++
> >  Documentation/devicetree/bindings/arm/cpus.txt     |  17 ++
> >  2 files changed, 244 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/cpu-capacity.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/cpu-capacity.txt b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> > new file mode 100644
> > index 0000000..2a00af0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> > @@ -0,0 +1,227 @@
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
> > +CPU user space benchmark (e.g, sysbench, dhrystone, etc.) on each CPU at
> > +maximum frequency and then normalize values w.r.t.  the best performing CPU.
> > +One can also do a statistically significant study of a wide collection of
> > +benchmarks, but pros of such an approach are not really evident at the time of
> > +writing.
> > +
> > +==========================================
> > +3 - capacity-scale
> > +==========================================
> > +
> > +CPUs capacities are defined with respect to capacity-scale property in the cpus
> > +node [1]. The property is optional; if not defined a 1024 capacity-scale is
> > +assumed. This property defines both the highest CPU capacity present in the
> > +system and granularity of CPU capacity values.
> 
> I don't really see the point of this vs. having an absolute scale.
> 

IMHO, we need this for several reasons, one being to address one of your
concerns below: vendors are free to choose their scale without being
forced to publish absolute data. Another reason is that it might make
life easier in certain cases; for example, someone could implement a
system with a few clusters of, say, A57s, but some run at half the clock
of the others (e.g., you have a 1.2GHz cluster and a 600MHz cluster); in
this case I think it is just easier to define capacity-scale as 1200 and
capacities as 1200 and 600. Last reason that I can think of right now is
that we don't probably want to bound ourself to some particular range
from the beginning, as that range might be enough now, but it could
change in the future (as in, right now [1-1024] looks fine for
scheduling purposes, but that might change).

> > +
> > +==========================================
> > +4 - capacity
> > +==========================================
> > +
> > +capacity is an optional cpu node [1] property: u32 value representing CPU
> > +capacity, relative to capacity-scale. It is required and enforced that capacity
> > +<= capacity-scale.
> 
> I think you need something absolute and probably per MHz (like 
> dynamic-power-coefficient property). Perhaps the IPC (instructions per 
> clock) value?
> 
> In other words, I want to see these numbers have a defined method 
> of determining them and don't want to see random values from every 
> vendor. ARM, Ltd. says core X has a value of Y would be good enough for 
> me. Vendor X's A57 having a value of 2 and Vendor Y's A57 having a 
> value of 1024 is not what I want to see. Of course things like cache 
> sizes can vary the performance, but is a baseline value good enough? 
> 

A standard reference baseline is what we advocate with this set, but
making this baseline work for every vendor's implementation is hardly
achievable, IMHO. I don't think we can come up with any number that
applies to each and every implementation; you can have different
revisions of the same core and vendors might make implementation choices
that end up with different peak performance. 

> However, no vendor will want to publish their values if these are 
> absolute values relative to other vendors.
> 

Right. That is why I think we need to abstract numbers, as we do with
capacity-scale.

> If you expect these to need frequent tuning, then don't put them in DT.
> 

I expect that it is possible to come up with a sensible baseline number
for a specific platform implementation, so there is value in
standardizing how we specify this value and how it is then consumed.
Finer grained tuning might then happen both offline (with changes to the
mainline DT) and online (using the sysfs interface), but that should
only apply to a narrow set of use cases.

Thanks,

- Juri
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
