From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH RFC v3 1/6] Documentation: arm: define DT idle states
 bindings
Date: Thu, 8 May 2014 09:57:43 +0100
Message-ID: <20140508085743.GA12860@e102568-lin.cambridge.arm.com>
References: <1399399483-17112-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1399399483-17112-2-git-send-email-lorenzo.pieralisi@arm.com>
 <536ac4ef.6ae7440a.511a.ffffdef8@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:48981 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752762AbaEHI5u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 May 2014 04:57:50 -0400
In-Reply-To: <536ac4ef.6ae7440a.511a.ffffdef8@mx.google.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Capella <sebastian.capella@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Sebastian Capella <capellas@>

On Thu, May 08, 2014 at 12:43:04AM +0100, Sebastian Capella wrote:
> Quoting Lorenzo Pieralisi (2014-05-06 11:04:38)
> > diff --git a/Documentation/devicetree/bindings/arm/idle-states.txt b/Documentation/devicetree/bindings/arm/idle-states.txt
> > new file mode 100644
> > index 0000000..196ef52
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/idle-states.txt
> > @@ -0,0 +1,508 @@
> ...
> > +===========================================
> > +2 - idle-states node
> > +===========================================
> > +
> > +ARM processor idle states are defined within the idle-states node, which is
> > +a direct child of the cpus node [1] and provides a container where the
> > +processor idle states, defined as device tree nodes, are listed.
> > +
> > +- idle-states node
> > +
> > +       Usage: Optional - On ARM systems, is a container of processor idle
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
> > +idle-states node.
> > +
> > +Any other configuration is consider invalid and therefore must be ignored.
> 
> consider -> considered
> must be -> shall?
> 
> Is the reference to "any other configuration" referring to state nodes
> not in the idle states node?  If so, maybe this sentence should go
> together with that one.

Yes, it makes sense.

> > +===========================================
> > +4 - Examples
> > +===========================================
> > +
> > +Example 1 (ARM 64-bit, 16-cpu system):
> > +
> > +cpus {
> > +       #size-cells = <0>;
> > +       #address-cells = <2>;
> > +
> > +       idle-states {
> > +               entry-method = "arm,psci";
> > +
> > +               CPU_RETENTION_0_0: cpu-retention-0-0 {
> > +                       compatible = "arm,idle-state";
> > +                       cache-state-retained;
> > +                       entry-method-param = <0x0010000>;
> > +                       entry-latency-us = <20>;
> > +                       exit-latency-us = <40>;
> > +                       min-residency-us = <30>;
> > +               };
> > +
> > +               CLUSTER_RETENTION_0: cluster-retention-0 {
> > +                       compatible = "arm,idle-state";
> > +                       logic-state-retained;
> > +                       cache-state-retained;
> > +                       entry-method-param = <0x1010000>;
> > +                       entry-latency-us = <50>;
> > +                       exit-latency-us = <100>;
> > +                       min-residency-us = <250>;
> > +               };
>                   ...
> > +       };
> > +
> > +       CPU0: cpu@0 {
> > +               device_type = "cpu";
> > +               compatible = "arm,cortex-a57";
> > +               reg = <0x0 0x0>;
> > +               enable-method = "psci";
> > +               cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
> > +                                  &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
> > +       };
> > +
> > +       CPU1: cpu@1 {
> > +               device_type = "cpu";
> > +               compatible = "arm,cortex-a57";
> > +               reg = <0x0 0x1>;
> > +               enable-method = "psci";
> > +               cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
> > +                                  &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
> > +       };
> 
> How can we specify what states are entered together vs. those that
> are independent (since they also share the entry-method-param)?
> CPU_SLEEP_0_0 is used for both CPU0 and CPU1, yet each cpu can enter
> it without waiting for the other.  Whereas CLUSTER_RETENTION_0 should
> not be entered until all CPUs sharing it enter.

We do not specify that. That can be solved with power-domains but I
removed them from the bindings since I want to merge bindings that are
required by current code, and PSCI does not need this information, since
the power state parameter to PSCI suspend call (and the related SMC
implementation) caters for it.

When I see implementations requiring these bits of info, we will add
them to the bindings.

> Is the idea to define separate CPU_SLEEP/CPU_RETENTION nodes for each cpu?

On big.LITTLE systems you might want to have different states (eg CPU
core gatng) for big and little CPUs, and that's doable with the current
bindings since each CPU can point at idle states in its cpu node.

Thanks for having a look,
Lorenzo

