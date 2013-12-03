From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH RFC 2/2] Documentation: arm: define DT C-states bindings
Date: Tue, 3 Dec 2013 10:40:06 +0000
Message-ID: <20131203104004.GA5694@e102568-lin.cambridge.arm.com>
References: <1386001205-11978-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1386001205-11978-3-git-send-email-lorenzo.pieralisi@arm.com>
 <3AA6B169-C4C8-474B-B110-B912510B834E@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:54461 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836Ab3LCKkR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Dec 2013 05:40:17 -0500
In-Reply-To: <3AA6B169-C4C8-474B-B110-B912510B834E@codeaurora.org>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>
Cc: devicetree <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Mark Hambleton <mark.hambleton@broadcom.com>, Hanjun Guo <hanjun.guo@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>

On Mon, Dec 02, 2013 at 06:08:16PM +0000, Kumar Gala wrote:
> 
> On Dec 2, 2013, at 10:20 AM, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> 
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
> 
> Where is this spec'd today in the kernel?

How can it be in the kernel given that these bindings have just been posted ?
I started coding the layer managing the C-states in the kernel, even
though I would avoid writing it and then restart from scratch if these
bindings are scrapped. Bindings should not depend on kernel code, it
is the other way around, right ?

[...]

> > +===========================================
> > +2 - state node
> > +===========================================
> > +
> > +A state node represents a C-state description and must be defined as follows:
> > +
> > +- state node
> > +
> > +     Description: must be child of the cpu-power-states node.
> > +
> > +     The state node name must be "state", with unit address provided by the
> > +     "reg" property following standard DT requirements[4].
> > +
> > +     A state node defines the following properties:
> > +
> > +     - reg
> > +             Usage: Required
> > +             Value type: <u32>
> > +             Definition: Standard device tree property [4] used for
> > +                         enumeration purposes.
> 
> I'm not sure what purpose reg is really serving here.

Enumeration, that's it.

> > +
> > +     - index
> > +             Usage: Required
> > +             Value type: <u32>
> > +             Definition: It represents C-state index, starting from 2 (index
> > +                         0 represents the processor state "running" and
> > +                         index 1 represents processor mode "WFI"; indexes 0
> > +                         and 1 are standard ARM states that need not be
> > +                         described).
> 
> any reason not to call it c-state-index"

Well, they are called "state" nodes, so I called it "index".

I really do not care, can change it if we think we should call states
c-states.

> > +
> > +     - entry-method
> > +             Value type: <stringlist>
> > +             Usage: Required
> > +             Definition: Describes the method by which a CPU enters the
> > +                         C-state. This property is required and must be one
> > +                         of:
> > +
> > +                         - "psci"
> > +                           ARM Standard firmware interface
> > +
> > +                         - "[vendor],[method]"
> > +                           An implementation dependent string with
> > +                           format "vendor,method", where vendor is a string
> > +                           denoting the name of the manufacturer and
> > +                           method is a string specifying the mechanism
> > +                           used to enter the C-state.
> > +
> > +     - psci-power-state
> > +             Usage: Required if entry-method property value is set to
> > +                    "psci".
> > +             Value type: <u32>
> > +             Definition: power_state parameter to pass to the PSCI
> > +                         suspend call to enter the C-state.
> > +
> > +     - latency
> > +             Usage: Required
> > +             Value type: <u32>
> > +             Definition: Worst case latency in microseconds required to
> > +                         enter and exit the C-state.
> > +
> > +     - min-residency
> > +             Usage: Required
> > +             Value type: <u32>
> > +             Definition: Time in microseconds required for the CPU to be in
> > +                         the C-state to make up for the dynamic power
> > +                         consumed to enter/exit the C-state in order to
> > +                         break even in terms of power consumption compared
> > +                         to C1 state (wfi).
> > +                         This parameter depends on the operating conditions
> > +                         (operating point, cache state) and must assume
> > +                         worst case scenario.
> > +
> > +     - cpus
> > +             Usage: Optional
> > +             Value type: <phandle>
> > +             Definition: If defined, the phandle points to a node in the
> > +                         cpu-map[2] representing all CPUs on which C-state
> > +                         is valid. If not present or system is UP, the
> > +                         C-state has to be considered valid for all CPUs in
> > +                         the system.
> > +
> > +     - affinity
> > +             Usage: Optional
> > +             Value type: <phandle>
> > +             Definition: If defined, phandle points to a node in the
> > +                         cpu-map[2] that represents all CPUs that are
> > +                         affected (ie share) by the C-state and have to
> > +                         be coordinated on C-state entry/exit. If not
> > +                         present or system is UP, the C-state is local to
> > +                         a CPU and need no coordination (ie it is a CPU
> > +                         state, that does not require coordination with
> > +                         other CPUs). If present, the affinity property
> > +                         must contain a phandle to a cpu-map node that
> > +                         represents a subset, possibly inclusive of the
> > +                         CPUs described through the cpus property.
> > +
> > +     - power-depth
> > +             Usage: Required
> > +             Value type: <u32>
> > +             Definition: Integer value, starting from 2 (value 0 meaning
> > +                         running and value 1 representing power depth of
> > +                         wfi (C1)), that defines the level of depth of a
> > +                         power state.
> > +                         The system denotes power states with different
> > +                         depths, an increasing value meaning less power
> > +                         consumption and might involve powering down more
> > +                         components.  Devices that are affected by
> > +                         C-states entry must define the maximum power
> > +                         depth supported in their respective device tree
> > +                         bindings so that OSPM can take decision on how
> > +                         to handle the device in question when the C-state
> > +                         is entered. All devices (per-CPU or external) with
> > +                         a power depth lower than the one defined in the
> > +                         C-state entry stop operating when the C-state
> > +                         is entered and action is required by OSPM to
> > +                         guarantee their logic and memory content is saved
> > +                         restored to guarantee proper functioning.
> 
> How is this different from the c-state index?

The idea, not sure it is worthwhile, is to represent a unique value in
the system. There can be multiple eg C2 states (two clusters in two
different power domains) with same index and different power depths.

Devices attached to power domains can check the power depth to detect if
the CPU must be prevented from entering the C-state or not, and on the
other hand, power depth allows to understand if a device state must be
saved and restored.

I should have added an example but there is already lots of stuff to
discuss for bindings as they are IMHO.

Lorenzo

