From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH RFC v2 2/2] Documentation: arm: define DT C-states bindings
Date: Tue, 21 Jan 2014 20:05:11 +0530
Message-ID: <CAP245DXdFS5FEkrDvSw07aDDuZDqFPZXF=CoBLPrBB4JuYE8cQ@mail.gmail.com>
References: <1390240079-6495-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1390240079-6495-3-git-send-email-lorenzo.pieralisi@arm.com>
	<CAKfTPtAbYXuis1bfyDLiHRaYwosre3RAG+iNQSz-y+cWfc3uQA@mail.gmail.com>
	<20140121133148.GB28801@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:51607 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754274AbaAUOfN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jan 2014 09:35:13 -0500
Received: by mail-qa0-f43.google.com with SMTP id o15so6602154qap.2
        for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2014 06:35:11 -0800 (PST)
In-Reply-To: <20140121133148.GB28801@e102568-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: devicetree@vger.kernel.org, Lists LAKML <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, Dave Martin <dave.martin@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Grant Likely <grant.likely@linaro.org>, Kumar Gala <galak@codeaurora.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Mark Hambleton <mark.hambleton@broadcom.com>, Hanjun Guo <hanjun.guo@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Tomasz Figa <t.figa@samsung.com>, Kevin Hilman <khilman@linaro.org>

Hi Lorenzo,

On Mon, Jan 20, 2014 at 11:17 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> ARM based platforms implement a variety of power management schemes that
> allow processors to enter at run-time low-power states, aka C-states
> in ACPI jargon. The parameters defining these C-states vary on a per-platform
> basis forcing the OS to hardcode the state parameters in platform
> specific static tables whose size grows as the number of platforms supported
> in the kernel increases and hampers device drivers standardization.
>
> Therefore, this patch aims at standardizing C-state device tree bindings for
> ARM platforms. Bindings define C-state parameters inclusive of entry methods
> and state latencies, to allow operating systems to retrieve the
> configuration entries from the device tree and initialize the related
> power management drivers, paving the way for common code in the kernel
> to deal with power states and removing the need for static data in current
> and previous kernel versions.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/c-states.txt | 774 +++++++++++++++++++++
>  Documentation/devicetree/bindings/arm/cpus.txt     |  10 +
>  2 files changed, 784 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/c-states.txt
>
> diff --git a/Documentation/devicetree/bindings/arm/c-states.txt b/Documentation/devicetree/bindings/arm/c-states.txt

s/c-states/idle-states?

While C-states are widely used when talking about idle-states as
you've noted, idle-states are still the correct generic term for them.

> new file mode 100644
> index 0000000..0b5617b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/c-states.txt
> @@ -0,0 +1,774 @@
> +==========================================
> +ARM C-states binding description
> +==========================================
> +
> +==========================================
> +1 - Introduction
> +==========================================
> +
> +ARM systems contain HW capable of managing power consumption dynamically,
> +where cores can be put in different low-power states (ranging from simple
> +wfi to power gating) according to OSPM policies. Borrowing concepts
> +from the ACPI specification[1], the CPU states representing the range of
> +dynamic states that a processor can enter at run-time, aka C-state, can be
> +specified through device tree bindings representing the parameters required to
> +enter/exit specific C-states on a given processor.
> +
> +The state an ARM CPU can be put into is loosely identified by one of the
> +following operating modes:
> +
> +- Running:
> +        # Processor core is executing instructions
> +
> +- Wait for Interrupt:
> +       # An ARM processor enters wait for interrupt (WFI) low power
> +         state by executing a wfi instruction. When a processor enters
> +         wfi state it disables most of the clocks while keeping the processor
> +         powered up. This state is standard on all ARM processors and it is
> +         defined as C1 in the remainder of this document.
> +
> +- Dormant:
> +       # Dormant mode is entered by executing wfi instructions and by sending
> +         platform specific commands to the platform power controller (coupled
> +         with processor specific SW/HW control sequences).
> +         In dormant mode, most of the processor control and debug logic is
> +         powered up but cache RAM can be put in retention state, providing
> +         additional power savings.
> +
> +- Sleep:
> +       # Sleep mode is entered by executing the wfi instruction and by sending
> +         platform specific commands to the platform power controller (coupled
> +         with processor specific SW/HW control sequences). In sleep mode, a
> +         processor and its caches are shutdown, the entire processor state is
> +         lost.
> +
> +Building on top of the previous processor modes, ARM platforms implement power

Nitpick: s/previous/above

> +management schemes that allow an OS PM implementation to put the processor in
> +different CPU states (C-states). C-states parameters (eg latency) are
> +platform specific and need to be characterized with bindings that provide the
> +required information to OSPM code so that it can build the required tables and
> +use them at runtime.
> +
> +The device tree binding definition for ARM C-states is the subject of this
> +document.
> +
> +===========================================
> +2 - cpu-power-states node
> +===========================================
> +
> +ARM processor C-states are defined within the cpu-power-states node, which is
> +a direct child of the cpus node and provides a container where the processor
> +states, defined as device tree nodes, are listed.
> +
> +- cpu-power-states node

What do you think of s/cpu-power-states/cpu-idle-states?

CPU Power management is more than just idle. Unless you have plans to
add more properties to the cpu-power-states node later.

> +
> +       Usage: Optional - On ARM systems, is a container of processor C-state
> +                         nodes. If the system does not provide CPU power
> +                         management capabilities or the processor just
> +                         supports WFI (C1 state) a cpu-power-states node is
> +                         not required.
> +
> +       Description: cpu-power-states node is a container node, where its
> +                    subnodes describe the CPU low-power C-states.
> +
> +       Node name must be "cpu-power-states".
> +
> +       The cpu-power-states node's parent node must be cpus node.
> +
> +       The cpu-power-states node's child nodes can be:
> +
> +       - one or more state nodes
> +
> +       Any other configuration is considered invalid.
> +
> +The nodes describing the C-states (state) can only be defined within the
> +cpu-power-states node.
> +
> +Any other configuration is consider invalid and therefore must be ignored.
> +
> +===========================================
> +2 - state node
> +===========================================
> +
> +A state node represents a C-state description and must be defined as follows:
> +
> +- state node
> +
> +       Description: must be child of either the cpu-power-states node or
> +                    a state node.
> +
> +       The state node name shall be "stateN", where N = {0, 1, ...} is
> +       the node number; state nodes which are siblings within a single common
> +       parent node must be given a unique and sequential N value, starting
> +       from 0.
> +
> +       A state node can contain state child nodes. Child nodes inherit
> +       properties from the parent state nodes that work as state
> +       properties aggregators (ie contain properties valid on all state
> +       nodes children).
> +
> +       A state node defines the following properties (either explicitly
> +       or by inheriting them from a parent node):
> +
> +       - compatible
> +               Usage: Required
> +               Value type: <stringlist>
> +               Definition: Must be "arm,cpu-power-state".
> +
> +       - index
> +               Usage: Required
> +               Value type: <u32>
> +               Definition: It represents C-state index, starting from 2 (index
> +                           0 represents the processor state "running" and
> +                           index 1 represents processor mode "WFI"; indexes 0
> +                           and 1 are standard ARM states that need not be
> +                           described).
> +
> +       - power-domain
> +               Usage: Required
> +               Value type: <prop-encoded-array>
> +               Definition: List of phandle and power domain specifiers
> +                           as defined by bindings of power controller
> +                           specified by the phandle [3]. It represents the
> +                           power domains associated with the C-state. The
> +                           power domains list can be used by OSPM to
> +                           retrieve the devices belonging to the power
> +                           domains and carry out corresponding actions to
> +                           preserve functionality across power cycles
> +                           (ie context save/restore, cache flushing).
> +
> +       - entry-method
> +               Usage: Required
> +               Value type: <stringlist>
> +               Definition: Describes the method by which a CPU enters the
> +                           C-state. This property is required and must be one
> +                           of:
> +
> +                           - "psci"
> +                             ARM Standard firmware interface
> +
> +                           - "[vendor],[method]"
> +                             An implementation dependent string with
> +                             format "vendor,method", where vendor is a string
> +                             denoting the name of the manufacturer and
> +                             method is a string specifying the mechanism
> +                             used to enter the C-state.
> +
> +       - psci-power-state
> +               Usage: Required if entry-method property value is set to
> +                      "psci".
> +               Value type: <u32>
> +               Definition: power_state parameter to pass to the PSCI
> +                           suspend call to enter the C-state.
> +
> +       - latency
> +               Usage: Required
> +               Value type: <prop-encoded-array>
> +               Definition: List of u32 values representing worst case latency
> +                           in microseconds required to enter and exit the
> +                           C-state, one value per OPP [2]. The list should
> +                           be specified in the same order as the operating
> +                           points property list of the cpu this state is
> +                           valid on.
> +                           If no OPP bindings are present, the latency value
> +                           is associated with the current OPP of CPUs in the
> +                           system.

DT-newbie here. What would happen if a vendor does not characterise
the latency at each OPP? IOW, the table only contains latency values
for a subset of the OPPs.

> +
> +       - min-residency
> +               Usage: Required
> +               Value type: <prop-encoded-array>
> +               Definition: List of u32 values representing time in
> +                           microseconds required for the CPU to be in
> +                           the C-state to make up for the dynamic power
> +                           consumed to enter/exit the C-state in order to
> +                           break even in terms of power consumption compared
> +                           to C1 state (wfi), one value per-OPP [2].
> +                           This parameter depends on the operating conditions
> +                           (HW state) and must assume worst case scenario.
> +                           The list should be specified in the same order as
> +                           the operating points property list of the cpu this
> +                           state is valid on.
> +                           If no OPP bindings are present the min-residency
> +                           value is associated with the current OPP of CPUs
> +                           in the system.

Same question as latency above.

> +
> +===========================================
> +3 - Examples
> +===========================================
> +
> +Example 1 (ARM 64-bit, 16-cpu system, two clusters of clusters):


     ^^^^^^^^^^^^^
                                                         clusters of cpus?
> +
> +pd_clusters: power-domain-clusters@80002000 {
> +       compatible = "arm,power-controller";
> +       reg = <0x0 0x80002000 0x0 0x1000>;
> +       #power-domain-cells = <1>;
> +       #address-cells = <2>;
> +       #size-cells = <2>;
> +
> +       pd_cores: power-domain-cores@80000000 {
> +               compatible = "arm,power-controller";
> +               reg = <0x0 0x80000000 0x0 0x1000>;
> +               #power-domain-cells = <1>;
> +       };
> +};
> +

<snip>
