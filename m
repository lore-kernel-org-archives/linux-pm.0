From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH RFC v2 2/2] Documentation: arm: define DT C-states
 bindings
Date: Tue, 21 Jan 2014 15:23:59 +0000
Message-ID: <20140121152358.GD28801@e102568-lin.cambridge.arm.com>
References: <1390240079-6495-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1390240079-6495-3-git-send-email-lorenzo.pieralisi@arm.com>
 <CAKfTPtAbYXuis1bfyDLiHRaYwosre3RAG+iNQSz-y+cWfc3uQA@mail.gmail.com>
 <20140121133148.GB28801@e102568-lin.cambridge.arm.com>
 <CAP245DXdFS5FEkrDvSw07aDDuZDqFPZXF=CoBLPrBB4JuYE8cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:40306 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265AbaAUPYE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jan 2014 10:24:04 -0500
In-Reply-To: <CAP245DXdFS5FEkrDvSw07aDDuZDqFPZXF=CoBLPrBB4JuYE8cQ@mail.gmail.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Lists LAKML <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Kumar Gala <galak@codeaurora.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Mark Hambleton <mark.hambleton@broadcom.com>, Hanjun Guo <hanjun.guo@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Tomasz Figa <t.figa@samsung.com>, Kevin Hilman <khilman@linaro.org>

Hi Amit,

On Tue, Jan 21, 2014 at 02:35:11PM +0000, Amit Kucheria wrote:
> Hi Lorenzo,
> 
> On Mon, Jan 20, 2014 at 11:17 PM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
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
> 
> s/c-states/idle-states?
> 
> While C-states are widely used when talking about idle-states as
> you've noted, idle-states are still the correct generic term for them.

C-states on ACPI are processor power states, I think we can keep the
same nomenclature. I do not mind changing it though, more comments
below.

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
> > +- Dormant:
> > +       # Dormant mode is entered by executing wfi instructions and by sending
> > +         platform specific commands to the platform power controller (coupled
> > +         with processor specific SW/HW control sequences).
> > +         In dormant mode, most of the processor control and debug logic is
> > +         powered up but cache RAM can be put in retention state, providing
> > +         additional power savings.
> > +
> > +- Sleep:
> > +       # Sleep mode is entered by executing the wfi instruction and by sending
> > +         platform specific commands to the platform power controller (coupled
> > +         with processor specific SW/HW control sequences). In sleep mode, a
> > +         processor and its caches are shutdown, the entire processor state is
> > +         lost.
> > +
> > +Building on top of the previous processor modes, ARM platforms implement power
> 
> Nitpick: s/previous/above

Ok.

> > +management schemes that allow an OS PM implementation to put the processor in
> > +different CPU states (C-states). C-states parameters (eg latency) are
> > +platform specific and need to be characterized with bindings that provide the
> > +required information to OSPM code so that it can build the required tables and
> > +use them at runtime.
> > +
> > +The device tree binding definition for ARM C-states is the subject of this
> > +document.
> > +
> > +===========================================
> > +2 - cpu-power-states node
> > +===========================================
> > +
> > +ARM processor C-states are defined within the cpu-power-states node, which is
> > +a direct child of the cpus node and provides a container where the processor
> > +states, defined as device tree nodes, are listed.
> > +
> > +- cpu-power-states node
> 
> What do you think of s/cpu-power-states/cpu-idle-states?
> 
> CPU Power management is more than just idle. Unless you have plans to
> add more properties to the cpu-power-states node later.

Ok, if by saying that CPU power management is more than just idle you
also mean managing power while processor is running (ie DVFS) I think
you have a point. Again, I do not mind changing it, keeping in mind that
names stick so if we think we require more info from these bindings,
and that's probably the case, we'd better stick to the current naming
scheme.

[...]

> > +       - latency
> > +               Usage: Required
> > +               Value type: <prop-encoded-array>
> > +               Definition: List of u32 values representing worst case latency
> > +                           in microseconds required to enter and exit the
> > +                           C-state, one value per OPP [2]. The list should
> > +                           be specified in the same order as the operating
> > +                           points property list of the cpu this state is
> > +                           valid on.
> > +                           If no OPP bindings are present, the latency value
> > +                           is associated with the current OPP of CPUs in the
> > +                           system.
> 
> DT-newbie here. What would happen if a vendor does not characterise
> the latency at each OPP? IOW, the table only contains latency values
> for a subset of the OPPs.

The bindings are explicit, so the kernel will barf. Adding a LUT to map
latencies to OPPs make me cringe, so I would not change the current
bindings.

> > +       - min-residency
> > +               Usage: Required
> > +               Value type: <prop-encoded-array>
> > +               Definition: List of u32 values representing time in
> > +                           microseconds required for the CPU to be in
> > +                           the C-state to make up for the dynamic power
> > +                           consumed to enter/exit the C-state in order to
> > +                           break even in terms of power consumption compared
> > +                           to C1 state (wfi), one value per-OPP [2].
> > +                           This parameter depends on the operating conditions
> > +                           (HW state) and must assume worst case scenario.
> > +                           The list should be specified in the same order as
> > +                           the operating points property list of the cpu this
> > +                           state is valid on.
> > +                           If no OPP bindings are present the min-residency
> > +                           value is associated with the current OPP of CPUs
> > +                           in the system.
> 
> Same question as latency above.

Same opinion, I am not keen on adding further complexity, after all if
some operating points are not characterized either they should be
disabled or people do not care, hence they can add estimated values just
as well to the respective latencies in the DT.

> > +
> > +===========================================
> > +3 - Examples
> > +===========================================
> > +
> > +Example 1 (ARM 64-bit, 16-cpu system, two clusters of clusters):
> 
> 
>      ^^^^^^^^^^^^^
>                                                          clusters of cpus?

Well I took it from an example where topology was clusters of clusters
but I removed the topology node and honestly it does not add anything to
the discussion so I will reword it.

Thanks for having a look,
Lorenzo

