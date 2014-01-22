From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH RFC v2 2/2] Documentation: arm: define DT C-states
 bindings
Date: Wed, 22 Jan 2014 19:20:42 +0000
Message-ID: <20140122192041.GA3709@e102568-lin.cambridge.arm.com>
References: <1390240079-6495-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1390240079-6495-3-git-send-email-lorenzo.pieralisi@arm.com>
 <CAKfTPtAbYXuis1bfyDLiHRaYwosre3RAG+iNQSz-y+cWfc3uQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:38165 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358AbaAVTUu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jan 2014 14:20:50 -0500
In-Reply-To: <CAKfTPtAbYXuis1bfyDLiHRaYwosre3RAG+iNQSz-y+cWfc3uQA@mail.gmail.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Kumar Gala <galak@codeaurora.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Mark Hambleton <mark.hambleton@broadcom.com>, Hanjun Guo <hanjun.guo@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Tomasz Figa <t.figa@samsung.com>, Kevin Hilman <khilman@linaro.org>

Hi Vincent,

On Tue, Jan 21, 2014 at 11:16:46AM +0000, Vincent Guittot wrote:
> Hi Lorenzo,
> 
> On 20 January 2014 18:47, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> > ARM based platforms implement a variety of power management schemes that
> > allow processors to enter at run-time low-power states, aka C-states
> > in ACPI jargon. The parameters defining these C-states vary on a per-platform
> > basis forcing the OS to hardcode the state parameters in platform
> > specific static tables whose size grows as the number of platforms supported
> > in the kernel increases and hampers device drivers standardization.
> >
> > Therefore, this patch aims at standardizing C-state device tree bindings for
> > ARM platforms. Bindings define C-state parameters inclusive of entry methods
> > and state latencies, to allow operating systems to retrieve the
> > configuration entries from the device tree and initialize the related
> > power management drivers, paving the way for common code in the kernel
> > to deal with power states and removing the need for static data in current
> > and previous kernel versions.
> >
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > ---
> >  Documentation/devicetree/bindings/arm/c-states.txt | 774 +++++++++++++++++++++
> >  Documentation/devicetree/bindings/arm/cpus.txt     |  10 +
> >  2 files changed, 784 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/c-states.txt
> >
> > diff --git a/Documentation/devicetree/bindings/arm/c-states.txt b/Documentation/devicetree/bindings/arm/c-states.txt
> > new file mode 100644
> > index 0000000..0b5617b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/c-states.txt
> > @@ -0,0 +1,774 @@
> > +==========================================
> > +ARM C-states binding description
> > +==========================================
> > +
> > +==========================================
> > +1 - Introduction
> > +==========================================
> > +
> > +ARM systems contain HW capable of managing power consumption dynamically,
> > +where cores can be put in different low-power states (ranging from simple
> > +wfi to power gating) according to OSPM policies. Borrowing concepts
> > +from the ACPI specification[1], the CPU states representing the range of
> > +dynamic states that a processor can enter at run-time, aka C-state, can be
> > +specified through device tree bindings representing the parameters required to
> > +enter/exit specific C-states on a given processor.
> > +
> > +The state an ARM CPU can be put into is loosely identified by one of the
> > +following operating modes:
> > +
> > +- Running:
> > +        # Processor core is executing instructions
> > +
> > +- Wait for Interrupt:
> > +       # An ARM processor enters wait for interrupt (WFI) low power
> > +         state by executing a wfi instruction. When a processor enters
> > +         wfi state it disables most of the clocks while keeping the processor
> > +         powered up. This state is standard on all ARM processors and it is
> > +         defined as C1 in the remainder of this document.
> > +
> 
> > +- Dormant:
> > +       # Dormant mode is entered by executing wfi instructions and by sending
> > +         platform specific commands to the platform power controller (coupled
> > +         with processor specific SW/HW control sequences).
> > +         In dormant mode, most of the processor control and debug logic is
> > +         powered up but cache RAM can be put in retention state, providing
> 
> Base on your description, it's not clear for me what is on, what is
> lost and what is power down ?
> My understand of the dormant mode that you described above is : the
> cache is preserved (and especially the cache RAM) but the processor
> state is lost (registers ...). Do I understand correctly ?
> 
> What about retention mode where the contents of processor and cache
> are preserved but the power consumption is reduced ? it can be seen as
> a special wfi mode which need specific SW/HW control sequences but i'm
> not sure to understand how to describe such state with your proposal.

I had an idea. To simplify things, I think that one possibility is to
add a parameter to the power domain specifier (platform specific, see
Tomasz bindings):

Documentation/devicetree/bindings/power/power_domain.txt

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-January/224928.html

to represent, when that state is entered the behavior of the power
controller (ie cache RAM retention or cache shutdown or in general any
substate within a power domain). Since it is platform specific, and since
we are able to link caches to the power domain, the power controller will
actually define what happens to the cache when that state is entered
(basically we use the power domain specifier additional parameter to define
a "substate" in that power domain e.g.:

Example:

foo_power_controller {
	[...]
	/*
	 * first cell is register index, second one is the state index
	 * that in turn implies the state behavior - eg cache lost or
	 * retained
	 */
	#power-domain-cells = <2>;
};

l1-cache {
	[...]
	/*
	 * syntax: power-domains = list of power domain specifiers
		<[&power_domain_phandle register-index state],[&power_domain_phandle register-index state]>;
		The syntax is defined by the power controller du jour
		as described by Tomasz bindings
	*/
	power-domains =<&foo_power_controller 0 0 &foo_power_controller 0 1>;

}:

and then

state0 {
	index = <2>;
	compatible = "arm,cpu-power-state";
	latency = <...>;
	/*
	 * This means that when the state is entered, the power
	 * controller should use register index 0 and state 0,
	 * whose meaning is power controller specific. Since we
	 * know all components affected (for every component
	 * we declare its power domain(s) and states so we
	 * know what components are affected by the state entry.
	 * Given the cache node above and this phandle, the state
	 * implies that the cache is retained, register index == 0 state == 0
	 /*
	power-domain =<&foo_power_controller 0 0>;
};

state1 {
	index = <3>;
	compatible = "arm,cpu-power-state";
	latency = <...>;
	/*
	 * This means that when the state is entered, the power
	 * controller should use register index 0 and state 1,
	 * whose meaning is power controller specific. Since we
	 * know all components affected (for every component
	 * we declare its power domain(s) and states so we
	 * know what components are affected by the state entry.
	 * Given the cache node above and this phandle, the state
	 * implies that the cache is lost, register index == 0 state == 1
	 /*
	power-domain =<&foo_power_controller 0 1>;
};

It is complex but it is probably the cleanest way. And it leaves complexity
to power controller implementations (if managed in the kernel....), which
actually makes sense because it is up to power controller to define the
behavior of certain states.

All in all it is just an idea, feel free to scotch it, it is complex but
we have to sort it out, one way or another.

Vincent, Tomasz, anyone, thoughts ?
Lorenzo

