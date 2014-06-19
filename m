From: "Charles Garcia-Tobin" <charles.garcia-tobin@arm.com>
Subject: RE: [PATCH v4 1/6] Documentation: arm: define DT idle states bindings
Date: Thu, 19 Jun 2014 08:33:55 +0100
Message-ID: <000001cf8b90$d6a6f090$83f4d1b0$@arm.com>
References: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com> <1402503520-8611-2-git-send-email-lorenzo.pieralisi@arm.com> <alpine.LFD.2.11.1406111240010.25775@knanqh.ubzr> <20140613164954.GA16745@e102568-lin.cambridge.arm.com> <alpine.LFD.2.11.1406131306160.25775@knanqh.ubzr> <20140618173648.GB31573@e102568-lin.cambridge.arm.com> <53A1E818.6030400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.austin.arm.com ([217.140.110.23]:14718 "EHLO
	collaborate-mta1.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755362AbaFSHeT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Jun 2014 03:34:19 -0400
In-Reply-To: <53A1E818.6030400@ti.com>
Content-Language: en-gb
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Santosh Shilimkar' <santosh.shilimkar@ti.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <Mark.Rutland@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Rob Herring <robh+dt@kernel.org>, grant.likely@linaro.org, Peter De Schrijver <pdeschrijver@nvidia.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie@kernel.org>, Paul Walmsley <paul@pwsan.com>, Chander Kashyap <chander.kashyap@linaro.org>



> -----Original Message-----
> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
> Sent: 18 June 2014 20:27
> To: Lorenzo Pieralisi; Nicolas Pitre
> Cc: linux-arm-kernel@lists.infradead.org; linux-pm@vger.kernel.org;
> devicetree@vger.kernel.org; Mark Rutland; Sudeep Holla; Catalin
> Marinas; Charles Garcia-Tobin; Rob Herring; grant.likely@linaro.org;
> Peter De Schrijver; Daniel Lezcano; Amit Kucheria; Vincent Guittot;
> Antti Miettinen; Stephen Boyd; Kevin Hilman; Sebastian Capella; Tomasz
> Figa; Mark Brown; Paul Walmsley; Chander Kashyap
> Subject: Re: [PATCH v4 1/6] Documentation: arm: define DT idle states
> bindings
> 
> On Wednesday 18 June 2014 01:36 PM, Lorenzo Pieralisi wrote:
> > On Fri, Jun 13, 2014 at 06:33:35PM +0100, Nicolas Pitre wrote:
> 
> [..]
> > Ok, a minor tweak to the diagram above, min-residency should include
> > energy costs related to idle entry and exit, but not the exit-latency
> > itself, as long as the energy costs implied by exiting the state are
> > factored out in the min-residency-us property.
> >
> > Hence, to sum it up, I attached below the updated bindings patch:
> >
> > I think we are close to an agreement, if anyone disagrees please
> shout
> > as soon as possible so that we can still integrate changes.
> >
> 
> [..]
> 
> >
> > -- >8 --
> > Subject: [PATCH] Documentation: arm: define DT idle states bindings
> >
> > ARM based platforms implement a variety of power management schemes
> that
> > allow processors to enter idle states at run-time.
> > The parameters defining these idle states vary on a per-platform
> basis forcing
> > the OS to hardcode the state parameters in platform specific static
> tables
> > whose size grows as the number of platforms supported in the kernel
> increases
> > and hampers device drivers standardization.
> >
> > Therefore, this patch aims at standardizing idle state device tree
> bindings for
> > ARM platforms. Bindings define idle state parameters inclusive of
> entry methods
> > and state latencies, to allow operating systems to retrieve the
> configuration
> > entries from the device tree and initialize the related power
> management
> > drivers, paving the way for common code in the kernel to deal with
> idle
> > states and removing the need for static data in current and previous
> kernel
> > versions.
> >
> > Reviewed-by: Sebastian Capella <sebcape@gmail.com>
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > ---
> Nice work Lorenzo !!
> I have few comments/questions.
> 
> >  Documentation/devicetree/bindings/arm/cpus.txt     |   8 +
> >  .../devicetree/bindings/arm/idle-states.txt        | 561
> +++++++++++++++++++++
> >  2 files changed, 569 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/idle-
> states.txt
> >
> > diff --git a/Documentation/devicetree/bindings/arm/cpus.txt
> b/Documentation/devicetree/bindings/arm/cpus.txt
> > index 1fe72a0..a44d4fd 100644
> > --- a/Documentation/devicetree/bindings/arm/cpus.txt
> > +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> > @@ -215,6 +215,12 @@ nodes to be present and contain the properties
> described below.
> >  		Value type: <phandle>
> >  		Definition: Specifies the ACC[2] node associated with this
> CPU.
> >
> > +	- cpu-idle-states
> > +		Usage: Optional
> > +		Value type: <prop-encoded-array>
> > +		Definition:
> > +			# List of phandles to idle state nodes supported
> > +			  by this cpu [3].
> >
> >  Example 1 (dual-cluster big.LITTLE system 32-bit):
> >
> > @@ -411,3 +417,5 @@ cpus {
> >  --
> >  [1] arm/msm/qcom,saw2.txt
> >  [2] arm/msm/qcom,kpss-acc.txt
> > +[3] ARM Linux kernel documentation - idle states bindings
> > +    Documentation/devicetree/bindings/arm/idle-states.txt
> > diff --git a/Documentation/devicetree/bindings/arm/idle-states.txt
> b/Documentation/devicetree/bindings/arm/idle-states.txt
> > new file mode 100644
> > index 0000000..c9e1ec6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/idle-states.txt
> > @@ -0,0 +1,561 @@
> > +==========================================
> > +ARM idle states binding description
> > +==========================================
> > +
> > +==========================================
> > +1 - Introduction
> > +==========================================
> > +
> > +ARM systems contain HW capable of managing power consumption
> dynamically,
> > +where cores can be put in different low-power states (ranging from
> simple
> > +wfi to power gating) according to OSPM policies. The CPU states
> representing
> s/OSPM/OS PM ?
> > +the range of dynamic idle states that a processor can enter at run-
> time, can be
> > +specified through device tree bindings representing the parameters
> required
> > +to enter/exit specific idle states on a given processor.
> > +
> > +According to the Server Base System Architecture document (SBSA,
> [3]), the
> > +power states an ARM CPU can be put into are identified by the
> following list:
> > +
> > +- Running
> > +- Idle_standby
> > +- Idle_retention
> > +- Sleep
> > +- Off
> > +
> > +The power states described in the SBSA document define the basic CPU
> states on
> > +top of which ARM platforms implement power management schemes that
> allow an OS
> > +PM implementation to put the processor in different idle states
> (which include
> > +states listed above; "off" state is not an idle state since it does
> not have
> > +wake-up capabilities, hence it is not considered in this document).
> > +
> > +Idle state parameters (eg entry latency) are platform specific and
> need to be
> > +characterized with bindings that provide the required information to
> OSPM
> Ditto
> > +code so that it can build the required tables and use them at
> runtime.
> > +
> > +The device tree binding definition for ARM idle states is the
> subject of this
> > +document.
> > +
> > +===========================================
> > +2 - idle-states node
> > +===========================================
> > +
> > +ARM processor idle states are defined within the idle-states node,
> which is
> > +a direct child of the cpus node [1] and provides a container where
> the
> > +processor idle states, defined as device tree nodes, are listed.
> > +
> > +- idle-states node
> > +
> > +	Usage: Optional - On ARM systems, is a container of processor idle
> s/is/it is ?
> > +			  states nodes. If the system does not provide CPU
> > +			  power management capabilities or the processor
just
> > +			  supports idle_standby an idle-states node is not
> > +			  required.
> > +
> > +	Description: idle-states node is a container node, where its
> > +		     subnodes describe the CPU idle states.
> > +
> > +	Node name must be "idle-states".
> > +
> > +	The idle-states node's parent node must be the cpus node.
> > +
> > +	The idle-states node's child nodes can be:
> s/idle-states/idle-state
> > +
> > +	- one or more state nodes
> > +
> > +	Any other configuration is considered invalid.
> > +
> > +	An idle-states node defines the following properties:
> > +
> > +	- entry-method
> > +		Usage: Required
> > +		Value type: <stringlist>
> > +		Definition: Describes the method by which a CPU enters the
> > +			    idle states. This property is required and must
be
> > +			    one of:
> > +
> > +			    - "arm,psci"
> > +			      ARM PSCI firmware interface [2].
> > +
> > +			    - "[vendor],[method]"
> > +			      An implementation dependent string with
> > +			      format "vendor,method", where vendor is a
string
> > +			      denoting the name of the manufacturer and
> > +			      method is a string specifying the mechanism
> > +			      used to enter the idle state.
> > +
> > +The nodes describing the idle states (state) can only be defined
> within the
> > +idle-states node, any other configuration is considered invalid and
> therefore
> > +must be ignored.
> > +
> > +===========================================
> > +3 - state node
> > +===========================================
> > +
> > +A state node represents an idle state description and must be
> defined as
> > +follows:
> > +
> > +- state node
> > +
> > +	Description: must be child of the idle-states node
> > +
> > +	The state node name shall follow standard device tree naming
> > +	rules ([5], 2.2.1 "Node names"), in particular state nodes which
> > +	are siblings within a single common parent must be given a unique
> name.
> > +
> > +	The idle state entered by executing the wfi instruction
> (idle_standby
> > +	SBSA,[3][4]) is considered standard on all ARM platforms and
> therefore
> > +	must not be listed.
> > +
> > +	To correctly specify idle states timing and energy related
> properties,
> > +	the following definitions identify the different execution phases
> > +	a CPU goes through to enter and exit idle states and the implied
> > +	energy metrics:
> > +
> > +
> 	..__[EXEC]__|__[PREP]__|__[ENTRY]__|__[IDLE]__|__[EXIT]__|__[EXEC]
> __..
> > +		    |          |           |          |          |
> > +
> > +		    |<------ entry ------->|
> > +		    |       latency        |
> > +						      |<- exit ->|
> > +						      |  latency |
> > +		    |<-------- min-residency -------->|
> > +			       |<-------  wakeup-latency ------->|
> > +
> I don't know the wakeup latency makes much sense and also correct.
> Hardware wakeup latency is actually exit latency. Is it for failed
> or abort-able ilde case ? We are adding this as a new parameter
> at least from idle states perspective. I think we should just
> avoid it.
> 

Hi Santosh, 

To me wake up latency makes up a lot of sense. It is not always the same as
exit latency, it will depend on your system, and just how smart it is. In
some cases the [ENTRY] period may not be negligible in which case exit
latency will be less than the wake up latency. 
In addition, it will generally always be shorter than entry+exit which is
the default value if omitted, this assumes the PREP time is not abortable,
but this is the safer assumption to make.
Wake up latency is really the number that folk have in their head for what
you'd stick into the pm_qos to veto entry into states when you are latency
constrained. 
The one thing that really is an optimisation here is having a separate exit
latency, which is being proposed for use in core selection for the
scheduler.
So if anything was going to be made optional pending new scheduler patches
should that not be entry/exit latency? 
 
Cheers

Charles



> > +	EXEC:	Normal CPU execution.
> > +
> > +	PREP:	Preparation phase before committing the hardware to idle
mode
> > +		like cache flushing. This is abortable on pending wake-up
> > +		event conditions. The abort latency is assumed to be
> negligible
> > +		(i.e. less than the ENTRY + EXIT duration). If aborted, CPU
> > +		goes back to EXEC. This phase is optional. If not abortable,
> > +		this should be included in the ENTRY phase instead.
> > +
> > +	ENTRY:	The hardware is committed to idle mode. This period must
> run
> > +		to completion up to IDLE before anything else can happen.
> > +
> > +	IDLE:	This is the actual energy-saving idle period. This may last
> > +		between 0 and infinite time, until a wake-up event occurs.
> > +
> > +	EXIT:	Period during which the CPU is brought back to operational
> > +		mode (EXEC).
> > +
> > +	With the definitions provided above, the following list represents
> > +	the valid properties for a state node:
> > +
> > +	- compatible
> > +		Usage: Required
> > +		Value type: <stringlist>
> > +		Definition: Must be "arm,idle-state".
> > +
> > +	- logic-state-retained
> > +		Usage: See definition
> > +		Value type: <none>
> > +		Definition: if present logic is retained on state entry,
> > +			    otherwise it is lost.
> > +
> > +	- cache-state-retained
> > +		Usage: See definition
> > +		Value type: <none>
> > +		Definition: if present cache memory is retained on state
> entry,
> > +			    otherwise it is lost.
> > +
> > +	- entry-method-param
> > +		Usage: See definition.
> > +		Value type: <u32>
> > +		Definition: Depends on the idle-states node entry-method
> > +			    property value. Refer to the entry-method
bindings
> > +			    for this property value definition.
> > +
> > +	- entry-latency-us
> > +		Usage: Required
> > +		Value type: <prop-encoded-array>
> > +		Definition: u32 value representing worst case latency in
> > +			    microseconds required to enter the idle state.
> > +			    The exit-latency-us duration may be guaranteed
> > +			    only after entry-latency-us has passed.
> > +
> > +	- exit-latency-us
> > +		Usage: Required
> > +		Value type: <prop-encoded-array>
> > +		Definition: u32 value representing worst case latency
> > +			    in microseconds required to exit the idle state.
> > +
> > +	- min-residency-us
> > +		Usage: Required
> > +		Value type: <prop-encoded-array>
> > +		Definition: u32 value representing minimum residency
duration
> > +			    in microseconds, inclusive of preparation and
> > +			    entry, for this idle state to be considered
> > +			    worthwhile energy wise.
> > +			    The residency time must take into account the
> > +			    energy consumed while entering and exiting the
> > +			    idle state and is therefore expected to be
> > +			    longer than entry-latency-us.
> > +
> > +	- wakeup-latency-us:
> > +		Usage: Optional
> > +		Value type: <prop-encoded-array>
> > +		Definition: u32 value representing maximum delay between the
> > +			    signaling of a wake-up event and the CPU being
> > +			    able to execute normal code again. If omitted,
> > +			    this is assumed to be equal to:
> > +				entry-latency-us + exit-latency-us
> > +
> Rest of the patch looks fine by to me.
> 
> regards,
> Santosh
> 


