From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v4 1/6] Documentation: arm: define DT idle states bindings
Date: Wed, 18 Jun 2014 18:36:48 +0100
Message-ID: <20140618173648.GB31573@e102568-lin.cambridge.arm.com>
References: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1402503520-8611-2-git-send-email-lorenzo.pieralisi@arm.com>
 <alpine.LFD.2.11.1406111240010.25775@knanqh.ubzr>
 <20140613164954.GA16745@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.11.1406131306160.25775@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:41264 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753934AbaFRRgy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jun 2014 13:36:54 -0400
In-Reply-To: <alpine.LFD.2.11.1406131306160.25775@knanqh.ubzr>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Rob Herring <robh+dt@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie@ke>

On Fri, Jun 13, 2014 at 06:33:35PM +0100, Nicolas Pitre wrote:
> On Fri, 13 Jun 2014, Lorenzo Pieralisi wrote:
> 
> > On Wed, Jun 11, 2014 at 07:15:16PM +0100, Nicolas Pitre wrote:
> > > Let's illustrate the different periods on a time line to make it clearer
> > > (hmmm let's see how this can be managed on a braille display :-O ):
> > > 
> > > EXEC:	Normal CPU execution.
> > > 
> > > PREP:	Preparation phase before committing the hardware to idle mode
> > > 	like cache flushing. This is abortable on pending wake-up 
> > > 	event conditions. The abort latency is assumed to be negligible 
> > > 	(i.e. less than the ENTRY + EXIT duration). If aborted, we go 
> > > 	back to EXEC. This phase is optional. If not abortable, this 
> > > 	should be included in the ENTRY phase instead.
> > > 
> > > ENTRY:	The hardware is committed to idle mode. This period must run to
> > > 	completion up to IDLE before anything else can happen.
> > > 
> > > IDLE:	This is the actual power-saving idle period. This may last 
> > > 	between 0 and infinite time, until a wake-up event occurs.
> > > 
> > > EXIT:	Period during which the CPU is brought back to operational
> > > 	mode (EXEC).
> > > 
> > > ...__[EXEC]__|__[PREP]--|__[ENTRY]__|__[IDLE]__|___[EXIT]_--|__[EXEC]__...
> > >              |          |           |          |            |
> > > 
> > >              |<-- entry-latency --->|
> > > 
> > >                                                |<- exit-  ->|
> > >                                                |  latency   |
> > > 
> > >              |<-------------- min-residency --------------->|
> > > 
> > >                         |<----- worst_wakeup_latency ------>|
> > > 
> > > entry-latency: Worst case latency required to enter the idle state.  The 
> > > exit_latency may be guaranteed only after entry-latency has passed.
> > > 
> > > min-residency: Minimum period, including preparation, entry and exit, 
> > > for a given power mode to be worthwhile energy wise.  It must be at 
> > > least equal to entry_latency + exit_latency.

Ok, a minor tweak to the diagram above, min-residency should include
energy costs related to idle entry and exit, but not the exit-latency
itself, as long as the energy costs implied by exiting the state are
factored out in the min-residency-us property.

Hence, to sum it up, I attached below the updated bindings patch:

I think we are close to an agreement, if anyone disagrees please shout
as soon as possible so that we can still integrate changes.

Thanks,
Lorenzo

-- >8 --
Subject: [PATCH] Documentation: arm: define DT idle states bindings

ARM based platforms implement a variety of power management schemes that
allow processors to enter idle states at run-time.
The parameters defining these idle states vary on a per-platform basis forcing
the OS to hardcode the state parameters in platform specific static tables
whose size grows as the number of platforms supported in the kernel increases
and hampers device drivers standardization.

Therefore, this patch aims at standardizing idle state device tree bindings for
ARM platforms. Bindings define idle state parameters inclusive of entry methods
and state latencies, to allow operating systems to retrieve the configuration
entries from the device tree and initialize the related power management
drivers, paving the way for common code in the kernel to deal with idle
states and removing the need for static data in current and previous kernel
versions.

Reviewed-by: Sebastian Capella <sebcape@gmail.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 Documentation/devicetree/bindings/arm/cpus.txt     |   8 +
 .../devicetree/bindings/arm/idle-states.txt        | 561 +++++++++++++++++++++
 2 files changed, 569 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/idle-states.txt

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 1fe72a0..a44d4fd 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -215,6 +215,12 @@ nodes to be present and contain the properties described below.
 		Value type: <phandle>
 		Definition: Specifies the ACC[2] node associated with this CPU.
 
+	- cpu-idle-states
+		Usage: Optional
+		Value type: <prop-encoded-array>
+		Definition:
+			# List of phandles to idle state nodes supported
+			  by this cpu [3].
 
 Example 1 (dual-cluster big.LITTLE system 32-bit):
 
@@ -411,3 +417,5 @@ cpus {
 --
 [1] arm/msm/qcom,saw2.txt
 [2] arm/msm/qcom,kpss-acc.txt
+[3] ARM Linux kernel documentation - idle states bindings
+    Documentation/devicetree/bindings/arm/idle-states.txt
diff --git a/Documentation/devicetree/bindings/arm/idle-states.txt b/Documentation/devicetree/bindings/arm/idle-states.txt
new file mode 100644
index 0000000..c9e1ec6
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/idle-states.txt
@@ -0,0 +1,561 @@
+==========================================
+ARM idle states binding description
+==========================================
+
+==========================================
+1 - Introduction
+==========================================
+
+ARM systems contain HW capable of managing power consumption dynamically,
+where cores can be put in different low-power states (ranging from simple
+wfi to power gating) according to OSPM policies. The CPU states representing
+the range of dynamic idle states that a processor can enter at run-time, can be
+specified through device tree bindings representing the parameters required
+to enter/exit specific idle states on a given processor.
+
+According to the Server Base System Architecture document (SBSA, [3]), the
+power states an ARM CPU can be put into are identified by the following list:
+
+- Running
+- Idle_standby
+- Idle_retention
+- Sleep
+- Off
+
+The power states described in the SBSA document define the basic CPU states on
+top of which ARM platforms implement power management schemes that allow an OS
+PM implementation to put the processor in different idle states (which include
+states listed above; "off" state is not an idle state since it does not have
+wake-up capabilities, hence it is not considered in this document).
+
+Idle state parameters (eg entry latency) are platform specific and need to be
+characterized with bindings that provide the required information to OSPM
+code so that it can build the required tables and use them at runtime.
+
+The device tree binding definition for ARM idle states is the subject of this
+document.
+
+===========================================
+2 - idle-states node
+===========================================
+
+ARM processor idle states are defined within the idle-states node, which is
+a direct child of the cpus node [1] and provides a container where the
+processor idle states, defined as device tree nodes, are listed.
+
+- idle-states node
+
+	Usage: Optional - On ARM systems, is a container of processor idle
+			  states nodes. If the system does not provide CPU
+			  power management capabilities or the processor just
+			  supports idle_standby an idle-states node is not
+			  required.
+
+	Description: idle-states node is a container node, where its
+		     subnodes describe the CPU idle states.
+
+	Node name must be "idle-states".
+
+	The idle-states node's parent node must be the cpus node.
+
+	The idle-states node's child nodes can be:
+
+	- one or more state nodes
+
+	Any other configuration is considered invalid.
+
+	An idle-states node defines the following properties:
+
+	- entry-method
+		Usage: Required
+		Value type: <stringlist>
+		Definition: Describes the method by which a CPU enters the
+			    idle states. This property is required and must be
+			    one of:
+
+			    - "arm,psci"
+			      ARM PSCI firmware interface [2].
+
+			    - "[vendor],[method]"
+			      An implementation dependent string with
+			      format "vendor,method", where vendor is a string
+			      denoting the name of the manufacturer and
+			      method is a string specifying the mechanism
+			      used to enter the idle state.
+
+The nodes describing the idle states (state) can only be defined within the
+idle-states node, any other configuration is considered invalid and therefore
+must be ignored.
+
+===========================================
+3 - state node
+===========================================
+
+A state node represents an idle state description and must be defined as
+follows:
+
+- state node
+
+	Description: must be child of the idle-states node
+
+	The state node name shall follow standard device tree naming
+	rules ([5], 2.2.1 "Node names"), in particular state nodes which
+	are siblings within a single common parent must be given a unique name.
+
+	The idle state entered by executing the wfi instruction (idle_standby
+	SBSA,[3][4]) is considered standard on all ARM platforms and therefore
+	must not be listed.
+
+	To correctly specify idle states timing and energy related properties,
+	the following definitions identify the different execution phases
+	a CPU goes through to enter and exit idle states and the implied
+	energy metrics:
+
+	..__[EXEC]__|__[PREP]__|__[ENTRY]__|__[IDLE]__|__[EXIT]__|__[EXEC]__..
+		    |          |           |          |          |
+
+		    |<------ entry ------->|
+		    |       latency        |
+						      |<- exit ->|
+						      |  latency |
+		    |<-------- min-residency -------->|
+			       |<-------  wakeup-latency ------->|
+
+	EXEC:	Normal CPU execution.
+
+	PREP:	Preparation phase before committing the hardware to idle mode
+		like cache flushing. This is abortable on pending wake-up
+		event conditions. The abort latency is assumed to be negligible
+		(i.e. less than the ENTRY + EXIT duration). If aborted, CPU
+		goes back to EXEC. This phase is optional. If not abortable,
+		this should be included in the ENTRY phase instead.
+
+	ENTRY:	The hardware is committed to idle mode. This period must run
+		to completion up to IDLE before anything else can happen.
+
+	IDLE:	This is the actual energy-saving idle period. This may last
+		between 0 and infinite time, until a wake-up event occurs.
+
+	EXIT:	Period during which the CPU is brought back to operational
+		mode (EXEC).
+
+	With the definitions provided above, the following list represents
+	the valid properties for a state node:
+
+	- compatible
+		Usage: Required
+		Value type: <stringlist>
+		Definition: Must be "arm,idle-state".
+
+	- logic-state-retained
+		Usage: See definition
+		Value type: <none>
+		Definition: if present logic is retained on state entry,
+			    otherwise it is lost.
+
+	- cache-state-retained
+		Usage: See definition
+		Value type: <none>
+		Definition: if present cache memory is retained on state entry,
+			    otherwise it is lost.
+
+	- entry-method-param
+		Usage: See definition.
+		Value type: <u32>
+		Definition: Depends on the idle-states node entry-method
+			    property value. Refer to the entry-method bindings
+			    for this property value definition.
+
+	- entry-latency-us
+		Usage: Required
+		Value type: <prop-encoded-array>
+		Definition: u32 value representing worst case latency in
+			    microseconds required to enter the idle state.
+			    The exit-latency-us duration may be guaranteed
+			    only after entry-latency-us has passed.
+
+	- exit-latency-us
+		Usage: Required
+		Value type: <prop-encoded-array>
+		Definition: u32 value representing worst case latency
+			    in microseconds required to exit the idle state.
+
+	- min-residency-us
+		Usage: Required
+		Value type: <prop-encoded-array>
+		Definition: u32 value representing minimum residency duration
+			    in microseconds, inclusive of preparation and
+			    entry, for this idle state to be considered
+			    worthwhile energy wise.
+			    The residency time must take into account the
+			    energy consumed while entering and exiting the
+			    idle state and is therefore expected to be
+			    longer than entry-latency-us.
+
+	- wakeup-latency-us:
+		Usage: Optional
+		Value type: <prop-encoded-array>
+		Definition: u32 value representing maximum delay between the
+			    signaling of a wake-up event and the CPU being
+			    able to execute normal code again. If omitted,
+			    this is assumed to be equal to:
+				entry-latency-us + exit-latency-us
+
+===========================================
+4 - Examples
+===========================================
+
+Example 1 (ARM 64-bit, 16-cpu system):
+
+cpus {
+	#size-cells = <0>;
+	#address-cells = <2>;
+
+	idle-states {
+		entry-method = "arm,psci";
+
+		CPU_RETENTION_0_0: cpu-retention-0-0 {
+			compatible = "arm,idle-state";
+			cache-state-retained;
+			entry-method-param = <0x0010000>;
+			entry-latency-us = <20>;
+			exit-latency-us = <40>;
+			min-residency-us = <80>;
+		};
+
+		CLUSTER_RETENTION_0: cluster-retention-0 {
+			compatible = "arm,idle-state";
+			logic-state-retained;
+			cache-state-retained;
+			entry-method-param = <0x1010000>;
+			entry-latency-us = <50>;
+			exit-latency-us = <100>;
+			min-residency-us = <250>;
+		};
+
+		CPU_SLEEP_0_0: cpu-sleep-0-0 {
+			compatible = "arm,idle-state";
+			entry-method-param = <0x0010000>;
+			entry-latency-us = <250>;
+			exit-latency-us = <500>;
+			min-residency-us = <950>;
+		};
+
+		CLUSTER_SLEEP_0: cluster-sleep-0 {
+			compatible = "arm,idle-state";
+			entry-method-param = <0x1010000>;
+			entry-latency-us = <600>;
+			exit-latency-us = <1100>;
+			min-residency-us = <2700>;
+		};
+
+		CPU_RETENTION_1_0: cpu-retention-1-0 {
+			compatible = "arm,idle-state";
+			cache-state-retained;
+			entry-method-param = <0x0010000>;
+			entry-latency-us = <20>;
+			exit-latency-us = <40>;
+			min-residency-us = <90>;
+		};
+
+		CLUSTER_RETENTION_1: cluster-retention-1 {
+			compatible = "arm,idle-state";
+			logic-state-retained;
+			cache-state-retained;
+			entry-method-param = <0x1010000>;
+			entry-latency-us = <50>;
+			exit-latency-us = <100>;
+			min-residency-us = <270>;
+		};
+
+		CPU_SLEEP_1_0: cpu-sleep-1-0 {
+			compatible = "arm,idle-state";
+			entry-method-param = <0x0010000>;
+			entry-latency-us = <70>;
+			exit-latency-us = <100>;
+			min-residency-us = <300>;
+		};
+
+		CLUSTER_SLEEP_1: cluster-sleep-1 {
+			compatible = "arm,idle-state";
+			entry-method-param = <0x1010000>;
+			entry-latency-us = <500>;
+			exit-latency-us = <1200>;
+			min-residency-us = <3500>;
+		};
+	};
+
+	CPU0: cpu@0 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x0>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
+				   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+	};
+
+	CPU1: cpu@1 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x1>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
+				   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+	};
+
+	CPU2: cpu@100 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x100>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
+				   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+	};
+
+	CPU3: cpu@101 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x101>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
+				   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+	};
+
+	CPU4: cpu@10000 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x10000>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
+				   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+	};
+
+	CPU5: cpu@10001 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x10001>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
+				   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+	};
+
+	CPU6: cpu@10100 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x10100>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
+				   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+	};
+
+	CPU7: cpu@10101 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x10101>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
+				   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+	};
+
+	CPU8: cpu@100000000 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x0>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
+				   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+	};
+
+	CPU9: cpu@100000001 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x1>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
+				   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+	};
+
+	CPU10: cpu@100000100 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x100>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
+				   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+	};
+
+	CPU11: cpu@100000101 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x101>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
+				   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+	};
+
+	CPU12: cpu@100010000 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x10000>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
+				   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+	};
+
+	CPU13: cpu@100010001 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x10001>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
+				   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+	};
+
+	CPU14: cpu@100010100 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x10100>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
+				   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+	};
+
+	CPU15: cpu@100010101 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x10101>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
+				   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+	};
+};
+
+Example 2 (ARM 32-bit, 8-cpu system, two clusters):
+
+cpus {
+	#size-cells = <0>;
+	#address-cells = <1>;
+
+	idle-states {
+		entry-method = "arm,psci";
+
+		CPU_SLEEP_0_0: cpu-sleep-0-0 {
+			compatible = "arm,idle-state";
+			entry-method-param = <0x0010000>;
+			entry-latency-us = <200>;
+			exit-latency-us = <100>;
+			wakeup-latency-us = <250>;
+			min-residency-us = <400>;
+		};
+
+		CLUSTER_SLEEP_0: cluster-sleep-0 {
+			compatible = "arm,idle-state";
+			entry-method-param = <0x1010000>;
+			entry-latency-us = <500>;
+			exit-latency-us = <1500>;
+			wakeup-latency-us = <1700>;
+			min-residency-us = <2500>;
+		};
+
+		CPU_SLEEP_1_0: cpu-sleep-1-0 {
+			compatible = "arm,idle-state";
+			entry-method-param = <0x0010000>;
+			entry-latency-us = <300>;
+			exit-latency-us = <500>;
+			wakeup-latency-us = <600>;
+			min-residency-us = <900>;
+		};
+
+		CLUSTER_SLEEP_1: cluster-sleep-1 {
+			compatible = "arm,idle-state";
+			entry-method-param = <0x1010000>;
+			entry-latency-us = <800>;
+			exit-latency-us = <2000>;
+			wakeup-latency-us = <2300>;
+			min-residency-us = <6500>;
+		};
+	};
+
+	CPU0: cpu@0 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a15";
+		reg = <0x0>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_SLEEP_0_0 &CLUSTER_SLEEP_0>;
+	};
+
+	CPU1: cpu@1 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a15";
+		reg = <0x1>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_SLEEP_0_0 &CLUSTER_SLEEP_0>;
+	};
+
+	CPU2: cpu@2 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a15";
+		reg = <0x2>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_SLEEP_0_0 &CLUSTER_SLEEP_0>;
+	};
+
+	CPU3: cpu@3 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a15";
+		reg = <0x3>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_SLEEP_0_0 &CLUSTER_SLEEP_0>;
+	};
+
+	CPU4: cpu@100 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a7";
+		reg = <0x100>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_SLEEP_1_0 &CLUSTER_SLEEP_1>;
+	};
+
+	CPU5: cpu@101 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a7";
+		reg = <0x101>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_SLEEP_1_0 &CLUSTER_SLEEP_1>;
+	};
+
+	CPU6: cpu@102 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a7";
+		reg = <0x102>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_SLEEP_1_0 &CLUSTER_SLEEP_1>;
+	};
+
+	CPU7: cpu@103 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a7";
+		reg = <0x103>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_SLEEP_1_0 &CLUSTER_SLEEP_1>;
+	};
+};
+
+===========================================
+4 - References
+===========================================
+
+[1] ARM Linux Kernel documentation - CPUs bindings
+    Documentation/devicetree/bindings/arm/cpus.txt
+
+[2] ARM Linux Kernel documentation - PSCI bindings
+    Documentation/devicetree/bindings/arm/psci.txt
+
+[3] ARM Server Base System Architecture (SBSA)
+    http://infocenter.arm.com/help/index.jsp
+
+[4] ARM Architecture Reference Manuals
+    http://infocenter.arm.com/help/index.jsp
+
+[5] ePAPR standard
+    https://www.power.org/documentation/epapr-version-1-1/
-- 
1.9.1

