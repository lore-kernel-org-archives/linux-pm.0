From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v5 1/8] Documentation: arm: define DT idle states bindings
Date: Wed, 25 Jun 2014 18:37:46 +0100
Message-ID: <20140625173745.GC15050@e102568-lin.cambridge.arm.com>
References: <1403705421-17597-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1403705421-17597-2-git-send-email-lorenzo.pieralisi@arm.com>
 <20140625145849.GC15240@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:44628 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757671AbaFYRhx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jun 2014 13:37:53 -0400
In-Reply-To: <20140625145849.GC15240@leverpostej>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie@kernel>

On Wed, Jun 25, 2014 at 03:58:49PM +0100, Mark Rutland wrote:
> Hi Lorenzo,
> 
> On Wed, Jun 25, 2014 at 03:10:14PM +0100, Lorenzo Pieralisi wrote:
> > ARM based platforms implement a variety of power management schemes that
> > allow processors to enter idle states at run-time.
> > The parameters defining these idle states vary on a per-platform basis forcing
> > the OS to hardcode the state parameters in platform specific static tables
> > whose size grows as the number of platforms supported in the kernel increases
> > and hampers device drivers standardization.
> >
> > Therefore, this patch aims at standardizing idle state device tree bindings for
> > ARM platforms. Bindings define idle state parameters inclusive of entry methods
> > and state latencies, to allow operating systems to retrieve the configuration
> > entries from the device tree and initialize the related power management
> > drivers, paving the way for common code in the kernel to deal with idle
> > states and removing the need for static data in current and previous kernel
> > versions.
> >
> > Reviewed-by: Sebastian Capella <sebcape@gmail.com>
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > ---
> >  Documentation/devicetree/bindings/arm/cpus.txt     |   8 +
> >  .../devicetree/bindings/arm/idle-states.txt        | 733 +++++++++++++++++++++
> >  2 files changed, 741 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/idle-states.txt
> 
> [...]
> 
> > +===========================================
> > +3 - idle-states node
> > +===========================================
> > +
> > +ARM processor idle states are defined within the idle-states node, which is
> > +a direct child of the cpus node [1] and provides a container where the
> > +processor idle states, defined as device tree nodes, are listed.
> > +
> > +- idle-states node
> > +
> > +       Usage: Optional - On ARM systems, it is a container of processor idle
> > +                         states nodes. If the system does not provide CPU
> > +                         power management capabilities or the processor just
> > +                         supports idle_standby an idle-states node is not
> > +                         required.
> > +
> > +       Description: idle-states node is a container node, where its
> > +                    subnodes describe the CPU idle states.
> > +
> > +       Node name must be "idle-states".
> > +
> > +       The idle-states node's parent node must be the cpus node.
> > +
> > +       The idle-states node's child nodes can be:
> > +
> > +       - one or more state nodes
> > +
> > +       Any other configuration is considered invalid.
> > +
> > +       An idle-states node defines the following properties:
> > +
> > +       - entry-method
> > +               Usage: Required
> > +               Value type: <stringlist>
> > +               Definition: Describes the method by which a CPU enters the
> > +                           idle states. This property is required and must be
> > +                           one of:
> > +
> > +                           - "arm,psci"
> > +                             ARM PSCI firmware interface [2].
> > +
> > +                           - "[vendor],[method]"
> > +                             An implementation dependent string with
> > +                             format "vendor,method", where vendor is a string
> > +                             denoting the name of the manufacturer and
> > +                             method is a string specifying the mechanism
> > +                             used to enter the idle state.
> > +
> > +The nodes describing the idle states (state) can only be defined within the
> > +idle-states node, any other configuration is considered invalid and therefore
> > +must be ignored.
> > +
> > +===========================================
> > +4 - state node
> > +===========================================
> > +
> > +A state node represents an idle state description and must be defined as
> > +follows:
> > +
> > +- state node
> > +
> > +       Description: must be child of the idle-states node
> > +
> > +       The state node name shall follow standard device tree naming
> > +       rules ([5], 2.2.1 "Node names"), in particular state nodes which
> > +       are siblings within a single common parent must be given a unique name.
> > +
> > +       The idle state entered by executing the wfi instruction (idle_standby
> > +       SBSA,[3][4]) is considered standard on all ARM platforms and therefore
> > +       must not be listed.
> > +
> > +       With the definitions provided above, the following list represents
> > +       the valid properties for a state node:
> > +
> > +       - compatible
> > +               Usage: Required
> > +               Value type: <stringlist>
> > +               Definition: Must be "arm,idle-state".
> > +
> > +       - logic-state-retained
> > +               Usage: See definition
> > +               Value type: <none>
> > +               Definition: if present logic is retained on state entry,
> > +                           otherwise it is lost.
> 
> What logic state is retained? All system registers?
> 
> > +       - cache-state-retained
> > +               Usage: See definition
> > +               Value type: <none>
> > +               Definition: if present cache memory is retained on state entry,
> > +                           otherwise it is lost.
> 
> Likewise, how much of the cache hierarchy is affected? Any of it? All of
> it?

Well, to be honest these properties are shortcuts. If we wanted to do
things properly, I should have added power domains into the picture
(actually I did in the earlier versions of the bindings and later
streamlined them) so that every device inclusive of CPUs and caches
can be linked to a power domain, and from that linkage we could detect
what's lost when an idle state is entered.

PSCI does not need the two properties above (but that's no valid reason
to remove them, or to avoid adding power domains).

In case power domains are added, we need to know if the caches are lost
or retained and this flag specifies that. I can add these properties
when they are needed ie not in the current bindings.

> > +       - timer-state-retained
> > +               Usage: See definition
> > +               Value type: <none>
> > +               Definition: if present the timer control logic is retained on
> > +                            state entry, otherwise it is lost.
> 
> The architected generic timers? Any CPU-local timers? Or any timers
> whatsoever?

See above. Without power domains (and even with power domains attaching
a tick device to a power domain is far from being a simple job) it is
impossible to know if the tick device (what timer lies behind it is
unknown to the idle driver) is lost on idle state entry.

PowerPC guys got around that by adding a flag to DT which is a Linux specific
thing, this property is also a Linux specific property, but I think it
is a problem present in other OS too (and that ACPI solves the same way I
did).

On x86, the idle state index defines what states lose the local timer so
this stuff is not needed at all.

My question is, and that's a very important one: is it worth going the
whole nine yards, implementing bindings with power domains and parse
all this stuff in the kernel to set a flag for some CPUidle states ?

Complexity behind this is significant, but using the power domains is the
proper way to do it.

The only alternative lies in always setting the CPUIDLE_FLAG_TIMER_STOP
on all idle states (which turns out as a nop if the tick device does not have
C3STOP in its features).

Or maybe we can get away with adding the compatible string of the timer that
is lost on idle state entry if any ? That's horrible but that's another
possibility.

I know I am talking DT with kernel code in mind, but in this specific
case it is pretty hard to do otherwise.

Comments very welcome and encouraged because that's a blocking point.

> > +       - power-rank
> > +               Usage: Required
> > +               Value type: <u32>
> > +               Definition: It represents the idle state power-rank.
> > +                           An increasing value implies less power
> > +                           consumption. It must be given a sequential
> > +                           value = {0, 1, ....}, starting from 0.
> > +                           Phandles in the cpu nodes [1] cpu-idle-states
> > +                           array property are not allowed to point at idle
> > +                           state nodes having the same power-rank value.
> 
> Why can't this be implicit in the order of the cpu-idle-states list?
> That way it's impossible to violate the ordering requirement.

You mean the phandles list in the cpu nodes ? Maybe, but this would
require the list to be the same order for all cpu nodes on which the
idle states are valid, or just take one and use that.

It can be viable, as long as everyone agrees, every time I post this
code someone comes up with a new idea on how to sort the states and
honestly I would like to be done with that.

> 
> > +       - entry-method-param
> > +               Usage: See definition.
> > +               Value type: <u32>
> > +               Definition: Depends on the idle-states node entry-method
> > +                           property value. Refer to the entry-method bindings
> > +                           for this property value definition.
> 
> Should this not be left up to the particular mechanism to describe?
> e.g. for PSCI we could have a arm,psci-suspend-param property.

It was like that in early postings, and probably was better than the
current definition. I need to think about that but I am almost convinced
you are right.

> Are we sure a single u32 value is going to be sufficient?

Well, it is for PSCI, so see above, adding generality when it is not
present is a risky business, hoping that a u32 parameter will work
for other entry methods is an unsafe bet, you are right.

Thanks,
Lorenzo

