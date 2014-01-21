From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH RFC v2 2/2] Documentation: arm: define DT C-states bindings
Date: Tue, 21 Jan 2014 12:16:46 +0100
Message-ID: <CAKfTPtAbYXuis1bfyDLiHRaYwosre3RAG+iNQSz-y+cWfc3uQA@mail.gmail.com>
References: <1390240079-6495-1-git-send-email-lorenzo.pieralisi@arm.com> <1390240079-6495-3-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:49528 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754139AbaAULRH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jan 2014 06:17:07 -0500
Received: by mail-oa0-f53.google.com with SMTP id m1so7740026oag.40
        for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2014 03:17:07 -0800 (PST)
In-Reply-To: <1390240079-6495-3-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dave Martin <dave.martin@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Grant Likely <grant.likely@linaro.org>, Kumar Gala <galak@codeaurora.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Mark Hambleton <mark.hambleton@broadcom.com>, Hanjun Guo <hanjun.guo@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Tomasz Figa <t.figa@samsung.com>, Kevin Hilman <khilman@linaro.org>

Hi Lorenzo,

On 20 January 2014 18:47, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
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

Base on your description, it's not clear for me what is on, what is
lost and what is power down ?
My understand of the dormant mode that you described above is : the
cache is preserved (and especially the cache RAM) but the processor
state is lost (registers ...). Do I understand correctly ?

What about retention mode where the contents of processor and cache
are preserved but the power consumption is reduced ? it can be seen as
a special wfi mode which need specific SW/HW control sequences but i'm
not sure to understand how to describe such state with your proposal.

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
> +management schemes that allow an OS PM implementation to put the processor in
> +different CPU states (C-states). C-states parameters (eg latency) are
> +platform specific and need to be characterized with bindings that provide the
> +required information to OSPM code so that it can build the required tables and
> +use them at runtime.
> +
> +The device tree binding definition for ARM C-states is the subject of this
> +document.
> +

[snip]

> +
> +       - psci-power-state
> +               Usage: Required if entry-method property value is set to
> +                      "psci".
> +               Value type: <u32>
> +               Definition: power_state parameter to pass to the PSCI
> +                           suspend call to enter the C-state.

Why psci has got a dedicated field and not vendor methods ? can't you
make that more generic ?

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
> +

[snip]

Thanks
Vincent
