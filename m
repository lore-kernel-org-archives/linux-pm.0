From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH RFC v2 1/2] Documentation: arm: add cache DT bindings
Date: Tue, 21 Jan 2014 11:49:01 +0000
Message-ID: <20140121114845.GA2598@e103592.cambridge.arm.com>
References: <1390240079-6495-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1390240079-6495-2-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1390240079-6495-2-git-send-email-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Nicolas Pitre <nico@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Kumar Gala <galak@codeaurora.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Antti Miettinen <ananaza@iki.fi>, Mark Hambleton <mark.hambleton@broadcom.com>, linux-pm@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, linux-arm-kernel@lists.infradead.org, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 20, 2014 at 05:47:58PM +0000, Lorenzo Pieralisi wrote:
> On ARM systems the cache topology cannot be probed at runtime, in
> particular, it is impossible to probe which CPUs share a given cache
> level. Power management software requires this knowledge to implement
> optimized power down sequences, hence this patch adds a document that
> defines the DT cache bindings for ARM systems. The bindings are compliant
> with ePAPR (PowerPC bindings), even though most of the cache nodes
> properties requirements are overriden, because caches geometry for
> architected caches is probeable on ARM systems. This patch also adds
> properties that are specific to ARM architected caches to the existing ones
> defined in the ePAPR v1.1, as bindings extensions.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/cache.txt | 187 ++++++++++++++++++++++++
>  1 file changed, 187 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/cache.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/cache.txt b/Documentation/devicetree/bindings/arm/cache.txt
> new file mode 100644
> index 0000000..b27cedf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/cache.txt
> @@ -0,0 +1,187 @@
> +==========================================
> +ARM processors cache binding description
> +==========================================
> +
> +Device tree bindings for ARM processor caches adhere to the cache bindings
> +described in [3], in section 3.8 for multi-level and shared caches.
> +On ARM based systems most of the cache properties related to cache
> +geometry are probeable in HW, hence, unless otherwise stated, the properties
> +defined in ePAPR for multi-level and shared caches are to be considered
> +optional by default.

This point should be highlighted for discussion.

I do have a worry that because the kernel won't normally use this
information, by default it will get pasted between .dts files, won't get
tested and will be wrong rather often.  It also violates the DT principle
that probeable information should not be present in the DT -- ePAPR
obviously envisages systems where cache geometry information is not
probeable, but that's not the case for architected caches on ARM, except
in rare cases where the CLIDR is wrong.

But deviating needlessly from ePAPR is arguably a bad thing too.


There is one good argument in favour of making these properties
mandatory: it gives people a way to get (possibly wrong or unvalidated)
information about cache geometry and topology into userspace without the
kernel having to care.  This remains a contraversial issue though.


If we decide to allow or mandate these properties, the kernel should
validate them for consistency with the hardware and BUG() on boot if they
are inconsistent.  This is the correct approach until/unless the kernel
grows a proper mechanism for using this info from the DT.

> +
> +On ARM, caches are either architected (directly controlled by the processor
> +through coprocessor instructions and tightly coupled with the processor
> +implementation) or unarchitected (controlled through a memory mapped
> +interface, implemented as a stand-alone IP external to the processor
> +implementation).
> +
> +This document provides the device tree bindings for ARM architected caches.
> +
> +- ARM architected cache node
> +
> +	Description: must be a direct child of the cpu node. A system


For this paragraph as a whole:

Can we break this paragraph up, and move the background information (e.g.
description of the ARM Architecture) outside?

It's long and hard to read at present.

I think we only need the fundamental rules, which are basically that
the next-level-cache properties must be consistent with the hardware
cache topology.  We could try to be more precise, but ePAPR is pretty
vague too.

> +		     can contain multiple architected cache nodes per cpu node,
> +		     linked through the next-level-cache phandle. The
> +		     next-level-cache property in the cpu node points to
> +		     the first level of architected cache for the CPU.
> +		     The next-level-cache property in architected cache nodes
> +		     points to the respective next level of caching in the
> +		     hierarchy. An architected cache node with an empty or
> +		     missing next-level-cache property represents the last
> +		     architected cache level for the CPU.
> +		     On ARM v7 and v8 architectures, the order in which cache
> +		     nodes are linked through the next-level-cache phandle must
> +		     follow the ordering specified in the processors CLIDR (v7)

We shouldn't describe the ARM Architecture in the binding.  That's
background information that could move outside.

> +		     and CLIDR_EL1 (v8) registers, as described in [1][2],
> +		     implying that a cache node pointed at by a
> +		     next-level-cache phandle must correspond to a level
> +		     defined in CLIDR (v7) and CLIDR_EL1 (v8) greater than the
> +		     one the cache node containing the next-level-cache
> +		     phandle corresponds to.
> +
> +	Since on ARM most of the cache properties are probeable in HW the
> +	properties described in [3] - section 3.8 multi-level and shared
> +	caches - shall be considered optional, with the following properties
> +	updates, specific for the ARM architected cache node.
> +
> +	- compatible
> +		Usage: Required
> +		Value type: <string>
> +		Definition: value shall be "arm,arch-cache".
> +
> +	- interrupts
> +		Usage: Optional
> +		Value type: See definition
> +		Definition: standard device tree property [3] that defines
> +			    the interrupt line associated with the cache.
> +			    The property can be accompanied by an
> +			    interrupt-names property, as described in [4].

Do ARM Architectured caches ever have interrupts?  (Just my ignorance
here.)

> +
> +	- power-domain
> +		Usage: Optional
> +		Value type: phandle
> +		Definition: A phandle and power domain specifier as defined by
> +			    bindings of power controller specified by the
> +			    phandle [5].
> +
> +Example(dual-cluster big.LITTLE system 32-bit)
> +
> +	cpus {
> +		#size-cells = <0>;
> +		#address-cells = <1>;
> +
> +		cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a15";
> +			reg = <0x0>;
> +			next-level-cache = <&L1_0>;

ePAPR puts the L1 cache properties in the cpu node directly;
there's no "L1" node as such.  That geometry description is also
mandated by ePAPR.

The ARM Architecture does not force a CPU to have any non-shared
first level(s) of cache, and ePAPR does not permit next-level-cache
to point to a cpu node, so there are possible ARM Architecture
implementations that cannot be described without violating ePAPR.
However, for practical reasons, such systems are unlikely -- I don't
know if any exist today.

We should decide whether to deviate explicitly from ePAPR on this
point (your examples provide on way), or whether to follow ePAPR and
bodge things later for L1-less systems if they appear.

Cheers
---Dave
