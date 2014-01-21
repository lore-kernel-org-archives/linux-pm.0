From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH RFC v2 1/2] Documentation: arm: add cache DT bindings
Date: Tue, 21 Jan 2014 14:47:16 +0000
Message-ID: <20140121144715.GC28801@e102568-lin.cambridge.arm.com>
References: <1390240079-6495-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1390240079-6495-2-git-send-email-lorenzo.pieralisi@arm.com>
 <20140121114845.GA2598@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:43868 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754438AbaAUOrV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jan 2014 09:47:21 -0500
In-Reply-To: <20140121114845.GA2598@e103592.cambridge.arm.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dave Martin <Dave.Martin@arm.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Tomasz Figa <t.figa@samsung.com>, Mark Hambleton <mark.hambleton@broadcom.com>, Vincent Guittot <vincent.guittot@linaro.org>, Nicolas Pitre <nico@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Antti Miettinen <ananaza@iki.fi>, Peter De Schrijver <pdeschrijver@nvidia.com>, Stephen Boyd <sboyd@codeaurora.org>, Amit Kucheria <amit.kucheria@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Hanjun Guo <hanjun.guo@lina>

On Tue, Jan 21, 2014 at 11:49:01AM +0000, Dave Martin wrote:
> On Mon, Jan 20, 2014 at 05:47:58PM +0000, Lorenzo Pieralisi wrote:
> > On ARM systems the cache topology cannot be probed at runtime, in
> > particular, it is impossible to probe which CPUs share a given cache
> > level. Power management software requires this knowledge to implement
> > optimized power down sequences, hence this patch adds a document that
> > defines the DT cache bindings for ARM systems. The bindings are compliant
> > with ePAPR (PowerPC bindings), even though most of the cache nodes
> > properties requirements are overriden, because caches geometry for
> > architected caches is probeable on ARM systems. This patch also adds
> > properties that are specific to ARM architected caches to the existing ones
> > defined in the ePAPR v1.1, as bindings extensions.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > ---
> >  Documentation/devicetree/bindings/arm/cache.txt | 187 ++++++++++++++++++++++++
> >  1 file changed, 187 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/cache.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/cache.txt b/Documentation/devicetree/bindings/arm/cache.txt
> > new file mode 100644
> > index 0000000..b27cedf
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/cache.txt
> > @@ -0,0 +1,187 @@
> > +==========================================
> > +ARM processors cache binding description
> > +==========================================
> > +
> > +Device tree bindings for ARM processor caches adhere to the cache bindings
> > +described in [3], in section 3.8 for multi-level and shared caches.
> > +On ARM based systems most of the cache properties related to cache
> > +geometry are probeable in HW, hence, unless otherwise stated, the properties
> > +defined in ePAPR for multi-level and shared caches are to be considered
> > +optional by default.
> 
> This point should be highlighted for discussion.
> 
> I do have a worry that because the kernel won't normally use this
> information, by default it will get pasted between .dts files, won't get
> tested and will be wrong rather often.  It also violates the DT principle
> that probeable information should not be present in the DT -- ePAPR
> obviously envisages systems where cache geometry information is not
> probeable, but that's not the case for architected caches on ARM, except
> in rare cases where the CLIDR is wrong.
> 
> But deviating needlessly from ePAPR is arguably a bad thing too.
> 
> 
> There is one good argument in favour of making these properties
> mandatory: it gives people a way to get (possibly wrong or unvalidated)
> information about cache geometry and topology into userspace without the
> kernel having to care.  This remains a contraversial issue though.
>

I am not sure it is a good argument, and to be honest there are already
properties in the DT that we do not validate but still are exposed to
users (eg cpu nodes compatible strings). I'd rather forbid all cache
geometry DT properties on ARM.

> If we decide to allow or mandate these properties, the kernel should
> validate them for consistency with the hardware and BUG() on boot if they
> are inconsistent.  This is the correct approach until/unless the kernel
> grows a proper mechanism for using this info from the DT.

I think we should forbid them, so that, if people cut'n'paste those
properties into DT, those properties are to be considered outright junk.

A wrong CLIDR is a HW bug, and should be fixed as an errata, not through DT.

> > +On ARM, caches are either architected (directly controlled by the processor
> > +through coprocessor instructions and tightly coupled with the processor
> > +implementation) or unarchitected (controlled through a memory mapped
> > +interface, implemented as a stand-alone IP external to the processor
> > +implementation).
> > +
> > +This document provides the device tree bindings for ARM architected caches.
> > +
> > +- ARM architected cache node
> > +
> > +	Description: must be a direct child of the cpu node. A system
> 
> 
> For this paragraph as a whole:
> 
> Can we break this paragraph up, and move the background information (e.g.
> description of the ARM Architecture) outside?
> 
> It's long and hard to read at present.

Yes, I noticed too.

> I think we only need the fundamental rules, which are basically that
> the next-level-cache properties must be consistent with the hardware
> cache topology.  We could try to be more precise, but ePAPR is pretty
> vague too.

I agree.

> > +		     can contain multiple architected cache nodes per cpu node,
> > +		     linked through the next-level-cache phandle. The
> > +		     next-level-cache property in the cpu node points to
> > +		     the first level of architected cache for the CPU.
> > +		     The next-level-cache property in architected cache nodes
> > +		     points to the respective next level of caching in the
> > +		     hierarchy. An architected cache node with an empty or
> > +		     missing next-level-cache property represents the last
> > +		     architected cache level for the CPU.
> > +		     On ARM v7 and v8 architectures, the order in which cache
> > +		     nodes are linked through the next-level-cache phandle must
> > +		     follow the ordering specified in the processors CLIDR (v7)
> 
> We shouldn't describe the ARM Architecture in the binding.  That's
> background information that could move outside.

Ok, I will try to reword it.

> > +		     and CLIDR_EL1 (v8) registers, as described in [1][2],
> > +		     implying that a cache node pointed at by a
> > +		     next-level-cache phandle must correspond to a level
> > +		     defined in CLIDR (v7) and CLIDR_EL1 (v8) greater than the
> > +		     one the cache node containing the next-level-cache
> > +		     phandle corresponds to.
> > +
> > +	Since on ARM most of the cache properties are probeable in HW the
> > +	properties described in [3] - section 3.8 multi-level and shared
> > +	caches - shall be considered optional, with the following properties
> > +	updates, specific for the ARM architected cache node.
> > +
> > +	- compatible
> > +		Usage: Required
> > +		Value type: <string>
> > +		Definition: value shall be "arm,arch-cache".
> > +
> > +	- interrupts
> > +		Usage: Optional
> > +		Value type: See definition
> > +		Definition: standard device tree property [3] that defines
> > +			    the interrupt line associated with the cache.
> > +			    The property can be accompanied by an
> > +			    interrupt-names property, as described in [4].
> 
> Do ARM Architectured caches ever have interrupts?  (Just my ignorance
> here.)

I added the property in preparation for Stephen's bindings on krait, but
since those caches are not architected caches, I was a bit overzealous.

Certainly it is a bit of a shame to redefine another binding for caches
on krait that basically have the SAME properties, and just add interrupts.

Thoughts appreciated.

> > +	- power-domain
> > +		Usage: Optional
> > +		Value type: phandle
> > +		Definition: A phandle and power domain specifier as defined by
> > +			    bindings of power controller specified by the
> > +			    phandle [5].
> > +
> > +Example(dual-cluster big.LITTLE system 32-bit)
> > +
> > +	cpus {
> > +		#size-cells = <0>;
> > +		#address-cells = <1>;
> > +
> > +		cpu@0 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a15";
> > +			reg = <0x0>;
> > +			next-level-cache = <&L1_0>;
> 
> ePAPR puts the L1 cache properties in the cpu node directly;
> there's no "L1" node as such.  That geometry description is also
> mandated by ePAPR.

I mentioned that all cache properties from ePAPR should be considered
optional. Now I will probably forbid them :)

> The ARM Architecture does not force a CPU to have any non-shared
> first level(s) of cache, and ePAPR does not permit next-level-cache
> to point to a cpu node, so there are possible ARM Architecture
> implementations that cannot be described without violating ePAPR.
> However, for practical reasons, such systems are unlikely -- I don't
> know if any exist today.
> 
> We should decide whether to deviate explicitly from ePAPR on this
> point (your examples provide on way), or whether to follow ePAPR and
> bodge things later for L1-less systems if they appear.

I defined the way it is so that I can always distinguish between a CPU
and its L1, that for power domain reasons, through phandles.

I might want to define a L1 that is retained and a CPU that loses context, if
I lump them together I need to cook up something else to distinguish them.

I think the way I defined it is cleaner, opinions appreciated.

Thanks for the review,
Lorenzo

