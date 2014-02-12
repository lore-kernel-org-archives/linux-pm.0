From: Amit Kachhap <amit.kachhap@gmail.com>
Subject: Re: [PATCH RFC v3 3/3] Documentation: arm: define DT idle states bindings
Date: Wed, 12 Feb 2014 17:09:28 +0530
Message-ID: <CADGdYn6O6Vpye8knxXdpGzVQNy9p6mM1Sf-bBs7aQtQv6ReoHQ@mail.gmail.com>
References: <1392128273-8614-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1392128273-8614-4-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yh0-f49.google.com ([209.85.213.49]:57376 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbaBLLj3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2014 06:39:29 -0500
In-Reply-To: <1392128273-8614-4-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Dave Martin <dave.martin@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Grant Likely <grant.likely@linaro.org>, Kumar Gala <galak@codeaurora.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King <linux@arm.linux.org.uk>, Mark Hambleton <mark.hambleton@broadcom.com>, Hanjun Guo <hanjun.guo@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Tomasz Figa <t.figa@samsung.com>, Kevin Hilman <khilman@linaro.o>

Hi Lorenzo,

This patch series looks nice and explains the ARM C state DT bindings clearly.
Couples of thoughts below.

On 2/11/14, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> ARM based platforms implement a variety of power management schemes that
> allow processors to enter idle states at run-time.
> The parameters defining these idle states vary on a per-platform basis
> forcing
> the OS to hardcode the state parameters in platform specific static tables
> whose size grows as the number of platforms supported in the kernel
> increases
> and hampers device drivers standardization.
>
> Therefore, this patch aims at standardizing idle state device tree bindings
> for
> ARM platforms. Bindings define idle state parameters inclusive of entry
> methods
> and state latencies, to allow operating systems to retrieve the
> configuration
> entries from the device tree and initialize the related power management
> drivers, paving the way for common code in the kernel to deal with idle
> states and removing the need for static data in current and previous kernel
> versions.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.txt        |  10 +
>  Documentation/devicetree/bindings/arm/idle-states.txt | 690 ++++++++++
>  2 files changed, 700 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt
> b/Documentation/devicetree/bindings/arm/cpus.txt
> index 9130435..fb7f008 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.txt
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -191,6 +191,13 @@ nodes to be present and contain the properties
> described below.
>  			  property identifying a 64-bit zero-initialised
>  			  memory location.
>
> +	- cpu-idle-states
> +		Usage: Optional
> +		Value type: <prop-encoded-array>
> +		Definition:
> +			# List of phandles to cpu idle state nodes supported
> +			  by this cpu [1].
> +
>  Example 1 (dual-cluster big.LITTLE system 32-bit):
>
>  	cpus {
> @@ -382,3 +389,6 @@ cpus {
>  		cpu-release-addr = <0 0x20000000>;
>  	};
>  };
> +
> +[1] ARM Linux kernel documentation - idle state bindings
> +    Documentation/devicetree/bindings/arm/idle-states.txt
> diff --git a/Documentation/devicetree/bindings/arm/idle-states.txt
> b/Documentation/devicetree/bindings/arm/idle-states.txt
> new file mode 100644
> index 0000000..f155e70
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/idle-states.txt
> @@ -0,0 +1,690 @@
> +==========================================
> +ARM idle states binding description
> +==========================================
> +
> +==========================================
> +1 - Introduction
> +==========================================
> +
> +ARM systems contain HW capable of managing power consumption dynamically,
> +where cores can be put in different low-power states (ranging from simple
> +wfi to power gating) according to OSPM policies. The CPU states
> representing
> +the range of dynamic idle states that a processor can enter at run-time,
> can be
> +specified through device tree bindings representing the parameters
> required
> +to enter/exit specific idle states on a given processor.
> +
> +According to the Server Base System Architecture document (SBSA, [3]), the
> +power states an ARM CPU can be put into are identified by the following
> list:
> +
> +1 - Running
> +2 - Idle_standby
> +3 - Idle_retention
> +4 - Sleep
> +5 - Off
> +
> +ARM platforms implement the power states specified in the SBSA through
> power
> +management schemes that allow an OS PM implementation to put the processor
> in
> +different idle states (which include states 1 to 4 above; "off" state is
> not
> +an idle state since it does not have wake-up capabilities, hence it is not
> +considered in this document).
> +
> +Idle state parameters (eg entry latency) are platform specific and need to
> be
> +characterized with bindings that provide the required information to OSPM
> +code so that it can build the required tables and use them at runtime.
> +
> +The device tree binding definition for ARM idle states is the subject of
> this
> +document.
> +
> +===========================================
> +2 - cpu-idle-states node
> +===========================================
> +
> +ARM processor idle states are defined within the cpu-idle-states node,
> which is
> +a direct child of the cpus node and provides a container where the
> processor
> +states, defined as device tree nodes, are listed.
> +
> +- cpu-idle-states node
> +
> +	Usage: Optional - On ARM systems, is a container of processor idle
> +			  states nodes. If the system does not provide CPU
> +			  power management capabilities or the processor just
> +			  supports idle_standby a cpu-idle-states node is not
> +			  required.
> +
> +	Description: cpu-idle-states node is a container node, where its
> +		     subnodes describe the CPU idle states.
> +
> +	Node name must be "cpu-idle-states".
> +
> +	The cpu-idle-states node's parent node must be the cpus node.
> +
> +	The cpu-idle-states node's child nodes can be:
> +
> +	- one or more state nodes
> +
> +	Any other configuration is considered invalid.
> +
> +The nodes describing the idle states (state) can only be defined within
> the
> +cpu-idle-states node.
> +
> +Any other configuration is consider invalid and therefore must be ignored.
> +
> +===========================================
> +2 - state node
> +===========================================
> +
> +A state node represents an idle state description and must be defined as
> +follows:
> +
> +- state node
> +
> +	Description: must be child of either the cpu-idle-states node or
> +		     a state node.
> +
> +	The state node name shall be "stateN", where N = {0, 1, ...} is
> +	the node number; state nodes which are siblings within a single common
> +	parent node must be given a unique and sequential N value, starting
> +	from 0.
> +
> +	A state node can contain state child nodes. A state node with
> +	children represents a hierarchical state, which is a superset of
> +	the child states. Hierarchical states require all CPUs on which
> +	they are valid to request the state in order for it to be entered.
> +
> +	A state node defines the following properties:
> +
> +	- compatible
> +		Usage: Required
> +		Value type: <stringlist>
> +		Definition: Must be "arm,cpu-idle-state".
> +
> +	- index
> +		Usage: Required
> +		Value type: <u32>
> +		Definition: It represents an idle state index, starting from 2.
> +			    Index 0 represents the processor state "running"
> +			    and index 1 represents processor mode
> +			    "idle_standby", entered by executing a wfi
> +			    instruction (SBSA,[3]); indexes 0 and 1 are
> +			    standard ARM states that need not be described.
> +
> +	- entry-method
> +		Usage: Required
> +		Value type: <stringlist>
> +		Definition: Describes the method by which a CPU enters the
> +			    idle state. This property is required and must be
> +			    one of:
> +
> +			    - "arm,psci-cpu-suspend"
> +			      ARM PSCI firmware interface, CPU suspend
> +			      method[2].
> +
> +			    - "[vendor],[method]"
> +			      An implementation dependent string with
> +			      format "vendor,method", where vendor is a string
> +			      denoting the name of the manufacturer and
> +			      method is a string specifying the mechanism
> +			      used to enter the idle state.
> +
> +	- power-state
> +		Usage: See definition.
> +		Value type: <u32>
> +		Definition: Depends on the entry-method property value.
> +			    If entry-method is "arm,psci-cpu-suspend":
> +				# Property is required and represents
> +				  psci-power-state parameter. Please refer to
> +				  [2] for PSCI bindings definition.
> +
> +	- entry-latency
> +		Usage: Required
> +		Value type: <prop-encoded-array>
> +		Definition: u32 value representing worst case latency
> +			    in microseconds required to enter the idle state.
I liked your V2 version of OPP based latency more. However in this way
also latency supplied can correspond to max OPP and based on the
current OPP, the cpuidle driver can compute the new latency
proportionately. In case of frequency this can be linear but may not
be linear for residency.
> +
> +	- exit-latency
> +		Usage: Required
> +		Value type: <prop-encoded-array>
> +		Definition: u32 value representing worst case latency
> +			    in microseconds required to exit the idle state.
> +
> +	- min-residency
> +		Usage: Required
> +		Value type: <prop-encoded-array>
> +		Definition: u32 value representing time in microseconds
> +			    required for the CPU to be in the idle state to
> +			    make up for the dynamic power consumed to
> +			    enter/exit the idle state in order to break even
> +			    in terms of power consumption compared to idle
> +			    state index 1 (idle_standby).
> +
> +	- power-domains
> +		Usage: Optional
> +		Value type: <prop-encoded-array>
> +		Definition: List of power domain specifiers ([1]) describing
> +			    the power domains that are affected by the idle
> +			    state entry.
I can see power-domains used in 2 places. First in C state definitions
and second in cpu node cache descriptions. I am not sure but if
possible than this can be put in one place.
> +
> +	- cache-state-retained
> +		Usage: See definition
> +		Value type: <none>
> +		Definition: if present cache memory is retained on power down,
> +			    otherwise it is lost.
Can the DT bindings support both retained and non-retained with
different C states? The example shown does not use the retained flag.
I guess than many combinations are possible.
Processor retained, cache non-retained = C state 2
Processor non retained , cache retained = C state 3
Processor non retained, cache non retained = C state 4
> +
> +	- processor-state-retained
> +		Usage: See definition
> +		Value type: <none>
> +		Definition: if present CPU processor logic is retained on
> +			    power down, otherwise it is lost.
> +
> +===========================================
> +3 - Examples
> +===========================================
> +
> +Example 1 (ARM 64-bit, 16-cpu system):
> +
> +pd_clusters: power-domain-clusters@80002000 {
> +	compatible = "arm,power-controller";
> +	reg = <0x0 0x80002000 0x0 0x1000>;
> +	#power-domain-cells = <1>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	pd_cores: power-domain-cores@80000000 {
> +		compatible = "arm,power-controller";
> +		reg = <0x0 0x80000000 0x0 0x1000>;
> +		#power-domain-cells = <1>;
> +	};
> +};
> +
> +cpus {
> +	#size-cells = <0>;
> +	#address-cells = <2>;
> +
> +	cpu-idle-states {
> +
> +		STATE0: state0 {
> +			compatible = "arm,cpu-idle-state";
> +			index = <3>;
> +			entry-method = "arm,psci-cpu-suspend";
> +			psci-power-state = <0x1010000>;
> +			entry-latency = <500>;
> +			exit-latency = <1000>;
> +			min-residency = <2500>;
> +			power-domains = <&pd_clusters 0>;
> +			STATE0_1: state0 {
> +				compatible = "arm,cpu-idle-state";
> +				index = <2>;
> +				entry-method = "arm,psci-cpu-suspend";
> +				psci-power-state = <0x0010000>;
> +				entry-latency = <200>;
> +				exit-latency = <400>;
> +				min-residency = <300>;
> +				power-domains = <&pd_cores 0>,
> +						<&pd_cores 1>,
> +						<&pd_cores 2>,
> +						<&pd_cores 3>,
> +						<&pd_cores 4>,
> +						<&pd_cores 5>,
> +						<&pd_cores 6>,
> +						<&pd_cores 7>;
> +			};
> +		};
> +
> +		STATE1: state1 {
> +			compatible = "arm,cpu-idle-state";
> +			index = <3>;
> +			entry-method = "arm,psci-cpu-suspend";
> +			psci-power-state = <0x1010000>;
> +			entry-latency = <1000>;
> +			exit-latency = <3000>;
> +			min-residency = <6500>;
> +			power-domains = <&pd_clusters 1>;
> +			STATE1_0: state0 {
> +				compatible = "arm,cpu-idle-state";
> +				index = <2>;
> +				entry-method = "arm,psci-cpu-suspend";
> +				psci-power-state = <0x0010000>;
> +				entry-latency = <200>;
> +				exit-latency = <400>;
> +				min-residency = <500>;
> +				power-domains = <&pd_cores 8>,
> +						<&pd_cores 9>,
> +						<&pd_cores 10>,
> +						<&pd_cores 11>,
> +						<&pd_cores 12>,
> +						<&pd_cores 13>,
> +						<&pd_cores 14>,
> +						<&pd_cores 15>;
> +			};
> +		};
> +	};
> +
> +	CPU0: cpu@0 {
> +		device_type = "cpu";
> +		compatible = "arm,cortex-a57";
> +		reg = <0x0 0x0>;
> +		enable-method = "psci";
> +		next-level-cache = <&L1_0>;
> +		cpu-idle-states = <&STATE0_1 &STATE0>;
> +		L1_0: l1-cache {
> +			compatible = "arm,arch-cache";
> +			next-level-cache = <&L2_0>;
> +			power-domain = <&pd_cores 0>;
> +		};
> +		L2_0: l2-cache {
> +			compatible = "arm,arch-cache";
> +			power-domain = <&pd_clusters 0>;
> +		};
> +	};
> +
> +	CPU1: cpu@1 {
> +		device_type = "cpu";
> +		compatible = "arm,cortex-a57";
> +		reg = <0x0 0x1>;
> +		enable-method = "psci";
> +		next-level-cache = <&L1_1>;
> +		cpu-idle-states = <&STATE0_1 &STATE0>;
> +		L1_1: l1-cache {
> +			compatible = "arm,arch-cache";
> +			next-level-cache = <&L2_0>;
> +			power-domain = <&pd_cores 1>;
> +		};
> +	};
> +
> +	CPU2: cpu@100 {
> +		device_type = "cpu";
> +		compatible = "arm,cortex-a57";
> +		reg = <0x0 0x100>;
> +		enable-method = "psci";
> +		next-level-cache = <&L1_2>;
> +		cpu-idle-states = <&STATE0_1 &STATE0>;
> +		L1_2: l1-cache {
> +			compatible = "arm,arch-cache";
> +			next-level-cache = <&L2_0>;
> +			power-domain = <&pd_cores 2>;
> +		};
> +	};
> +
> +	CPU3: cpu@101 {
> +		device_type = "cpu";
> +		compatible = "arm,cortex-a57";
> +		reg = <0x0 0x101>;
> +		enable-method = "psci";
> +		next-level-cache = <&L1_3>;
> +		cpu-idle-states = <&STATE0_1 &STATE0>;
> +		L1_3: l1-cache {
> +			compatible = "arm,arch-cache";
> +			next-level-cache = <&L2_0>;
> +			power-domain = <&pd_cores 3>;
> +		};
> +	};
> +
> +	CPU4: cpu@10000 {
> +		device_type = "cpu";
> +		compatible = "arm,cortex-a57";
> +		reg = <0x0 0x10000>;
> +		enable-method = "psci";
> +		next-level-cache = <&L1_4>;
> +		cpu-idle-states = <&STATE0_1 &STATE0>;
> +		L1_4: l1-cache {
> +			compatible = "arm,arch-cache";
> +			next-level-cache = <&L2_0>;
> +			power-domain = <&pd_cores 4>;
> +		};
> +	};
> +
> +	CPU5: cpu@10001 {
> +		device_type = "cpu";
> +		compatible = "arm,cortex-a57";
> +		reg = <0x0 0x10001>;
> +		enable-method = "psci";
> +		next-level-cache = <&L1_5>;
> +		cpu-idle-states = <&STATE0_1 &STATE0>;
> +		L1_5: l1-cache {
> +			compatible = "arm,arch-cache";
> +			next-level-cache = <&L2_0>;
> +			power-domain = <&pd_cores 5>;
> +		};
> +	};
> +
> +	CPU6: cpu@10100 {
> +		device_type = "cpu";
> +		compatible = "arm,cortex-a57";
> +		reg = <0x0 0x10100>;
> +		enable-method = "psci";
> +		next-level-cache = <&L1_6>;
> +		cpu-idle-states = <&STATE0_1 &STATE0>;
> +		L1_6: l1-cache {
> +			compatible = "arm,arch-cache";
> +			next-level-cache = <&L2_0>;
> +			power-domain = <&pd_cores 6>;
> +		};
> +	};
> +
> +	CPU7: cpu@10101 {
> +		device_type = "cpu";
> +		compatible = "arm,cortex-a57";
> +		reg = <0x0 0x10101>;
> +		enable-method = "psci";
> +		next-level-cache = <&L1_7>;
> +		cpu-idle-states = <&STATE0_1 &STATE0>;
> +		L1_7: l1-cache {
> +			compatible = "arm,arch-cache";
> +			next-level-cache = <&L2_0>;
> +			power-domain = <&pd_cores 7>;
> +		};
> +	};
> +
> +	CPU8: cpu@100000000 {
> +		device_type = "cpu";
> +		compatible = "arm,cortex-a53";
> +		reg = <0x1 0x0>;
> +		enable-method = "psci";
> +		next-level-cache = <&L1_8>;
> +		cpu-idle-states = <&STATE1_0 &STATE1>;
> +		L1_8: l1-cache {
> +			compatible = "arm,arch-cache";
> +			next-level-cache = <&L2_1>;
> +			power-domain = <&pd_cores 8>;
> +		};
> +		L2_1: l2-cache {
> +			compatible = "arm,arch-cache";
> +			power-domain = <&pd_clusters 1>;
> +		};
> +	};
> +
> +	CPU9: cpu@100000001 {
> +		device_type = "cpu";
> +		compatible = "arm,cortex-a53";
> +		reg = <0x1 0x1>;
> +		enable-method = "psci";
> +		next-level-cache = <&L1_9>;
> +		cpu-idle-states = <&STATE1_0 &STATE1>;
> +		L1_9: l1-cache {
> +			compatible = "arm,arch-cache";
> +			next-level-cache = <&L2_1>;
> +			power-domain = <&pd_cores 9>;
> +		};
> +	};
> +
> +	CPU10: cpu@100000100 {
> +		device_type = "cpu";
> +		compatible = "arm,cortex-a53";
> +		reg = <0x1 0x100>;
> +		enable-method = "psci";
> +		next-level-cache = <&L1_10>;
> +		cpu-idle-states = <&STATE1_0 &STATE1>;
> +		L1_10: l1-cache {
> +			compatible = "arm,arch-cache";
> +			next-level-cache = <&L2_1>;
> +			power-domain = <&pd_cores 10>;
> +		};
> +	};
> +
> +	CPU11: cpu@100000101 {
> +		device_type = "cpu";
> +		compatible = "arm,cortex-a53";
> +		reg = <0x1 0x101>;
> +		enable-method = "psci";
> +		next-level-cache = <&L1_11>;
> +		cpu-idle-states = <&STATE1_0 &STATE1>;
> +		L1_11: l1-cache {
> +			compatible = "arm,arch-cache";
> +			next-level-cache = <&L2_1>;
> +			power-domain = <&pd_cores 11>;
> +		};
> +	};
> +
> +	CPU12: cpu@100010000 {
> +		device_type = "cpu";
> +		compatible = "arm,cortex-a53";
> +		reg = <0x1 0x10000>;
> +		enable-method = "psci";
> +		next-level-cache = <&L1_12>;
> +		cpu-idle-states = <&STATE1_0 &STATE1>;
> +		L1_12: l1-cache {
> +			compatible = "arm,arch-cache";
> +			next-level-cache = <&L2_1>;
> +			power-domain = <&pd_cores 12>;
> +		};
> +	};
> +
> +	CPU13: cpu@100010001 {
> +		device_type = "cpu";
> +		compatible = "arm,cortex-a53";
> +		reg = <0x1 0x10001>;
> +		enable-method = "psci";
> +		next-level-cache = <&L1_13>;
> +		cpu-idle-states = <&STATE1_0 &STATE1>;
> +		L1_13: l1-cache {
> +			compatible = "arm,arch-cache";
> +			next-level-cache = <&L2_1>;
> +			power-domain = <&pd_cores 13>;
> +		};
> +	};
> +
> +	CPU14: cpu@100010100 {
> +		device_type = "cpu";
> +		compatible = "arm,cortex-a53";
> +		reg = <0x1 0x10100>;
> +		enable-method = "psci";
> +		next-level-cache = <&L1_14>;
> +		cpu-idle-states = <&STATE1_0 &STATE1>;
> +		L1_14: l1-cache {
> +			compatible = "arm,arch-cache";
> +			next-level-cache = <&L2_1>;
> +			power-domain = <&pd_cores 14>;
> +		};
> +	};
> +
> +	CPU15: cpu@100010101 {
> +		device_type = "cpu";
> +		compatible = "arm,cortex-a53";
> +		reg = <0x1 0x10101>;
> +		enable-method = "psci";
> +		next-level-cache = <&L1_15>;
> +		cpu-idle-states = <&STATE1_0 &STATE1>;
> +		L1_15: l1-cache {
> +			compatible = "arm,arch-cache";
> +			next-level-cache = <&L2_1>;
> +			power-domain = <&pd_cores 15>;
> +		};
> +	};
> +};
> +
> +Example 2 (ARM 32-bit, 8-cpu system, two clusters):
> +
> +pd_clusters: power-domain-clusters@80002000 {
> +	compatible = "arm,power-controller";
> +	reg = <0x80002000 0x1000>;
> +	#power-domain-cells = <1>;
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	pd_cores: power-domain-cores@80000000 {
> +		compatible = "arm,power-controller";
> +		reg = <0x80000000 0x1000>;
> +		#power-domain-cells = <1>;
> +	};
> +};
> +
> +cpus {
> +	#size-cells = <0>;
> +	#address-cells = <1>;
> +
> +	cpu-idle-states {
> +
> +		STATE0: state0 {
> +			compatible = "arm,cpu-idle-state";
> +			index = <3>;
> +			entry-method = "psci";
> +			psci-power-state = <0x1010000>;
> +			entry-latency = <1000>;
> +			exit-latency = <1500>;
> +			min-residency = <1500>;
> +			power-domains = <&pd_clusters 0>;
> +			STATE0_1: state0 {
> +				compatible = "arm,cpu-idle-state";
> +				index = <2>;
> +				entry-method = "psci";
> +				psci-power-state = <0x0010000>;
> +				entry-latency = <400>;
> +				exit-latency = <500>;
> +				min-residency = <300>;
> +				power-domains = <&pd_cores 0>,
> +						<&pd_cores 1>,
> +						<&pd_cores 2>,
> +						<&pd_cores 3>;
> +			};
> +		};
> +
> +		STATE1: state1 {
> +			compatible = "arm,cpu-idle-state";
> +			index = <3>;
> +			entry-method = "psci";
> +			psci-power-state = <0x1010000>;
> +			entry-latency = <800>;
> +			exit-latency = <2000>;
> +			min-residency = <6500>;
> +			power-domains = <&pd_clusters 1>;
> +			STATE1_0: state0 {
> +				compatible = "arm,cpu-idle-state";
> +				index = <2>;
> +				entry-method = "psci";
> +				psci-power-state = <0x0010000>;
> +				entry-latency = <300>;
> +				exit-latency = <500>;
> +				min-residency = <500>;
> +				power-domains = <&pd_cores 4>,
> +						<&pd_cores 5>,
> +						<&pd_cores 6>,
> +						<&pd_cores 7>;
> +			};
> +		};
> +	};
> +
> +	CPU0: cpu@0 {
> +		device_type = "cpu";
> +		compatible = "arm,cortex-a15";
> +		reg = <0x0>;
> +		next-level-cache = <&L1_0>;
> +		cpu-idle-states = <&STATE0_1 &STATE0>;
> +		L1_0: l1-cache {
> +			compatible = "arm,arch-cache";
> +			next-level-cache = <&L2_0>;
> +			power-domain = <&pd_cores 0>;
> +		};
> +		L2_0: l2-cache {
> +			compatible = "arm,arch-cache";
> +			power-domain = <&pd_clusters 0>;
> +		};
> +	};
> +
> +	CPU1: cpu@1 {
> +		device_type = "cpu";
> +		compatible = "arm,cortex-a15";
> +		reg = <0x1>;
> +		next-level-cache = <&L1_1>;
> +		cpu-idle-states = <&STATE0_1 &STATE0>;
> +		L1_1: l1-cache {
> +			compatible = "arm,arch-cache";
> +			next-level-cache = <&L2_0>;
> +			power-domain = <&pd_cores 1>;
> +		};
> +	};
> +
> +	CPU2: cpu@2 {
> +		device_type = "cpu";
> +		compatible = "arm,cortex-a15";
> +		reg = <0x2>;
> +		next-level-cache = <&L1_2>;
> +		cpu-idle-states = <&STATE0_1 &STATE0>;
> +		L1_2: l1-cache {
> +			compatible = "arm,arch-cache";
> +			next-level-cache = <&L2_0>;
> +			power-domain = <&pd_cores 2>;
> +		};
> +	};
> +
> +	CPU3: cpu@3 {
> +		device_type = "cpu";
> +		compatible = "arm,cortex-a15";
> +		reg = <0x3>;
> +		next-level-cache = <&L1_3>;
> +		cpu-idle-states = <&STATE0_1 &STATE0>;
> +		L1_3: l1-cache {
> +			compatible = "arm,arch-cache";
> +			next-level-cache = <&L2_0>;
> +			power-domain = <&pd_cores 3>;
> +		};
> +	};
> +
> +	CPU4: cpu@100 {
> +		device_type = "cpu";
> +		compatible = "arm,cortex-a7";
> +		reg = <0x100>;
> +		next-level-cache = <&L1_4>;
> +		cpu-idle-states = <&STATE1_0 &STATE1>;
> +		L1_4: l1-cache {
> +			compatible = "arm,arch-cache";
> +			next-level-cache = <&L2_1>;
> +			power-domain = <&pd_cores 4>;
> +		};
> +		L2_1: l2-cache {
> +			compatible = "arm,arch-cache";
> +			power-domain = <&pd_clusters 1>;
> +		};
> +	};
> +
> +	CPU5: cpu@101 {
> +		device_type = "cpu";
> +		compatible = "arm,cortex-a7";
> +		reg = <0x101>;
> +		next-level-cache = <&L1_5>;
> +		cpu-idle-states = <&STATE1_0 &STATE1>;
> +		L1_5: l1-cache {
> +			compatible = "arm,arch-cache";
> +			next-level-cache = <&L2_1>;
> +			power-domain = <&pd_cores 5>;
> +		};
> +	};
> +
> +	CPU6: cpu@102 {
> +		device_type = "cpu";
> +		compatible = "arm,cortex-a7";
> +		reg = <0x102>;
> +		next-level-cache = <&L1_6>;
> +		cpu-idle-states = <&STATE1_0 &STATE1>;
> +		L1_6: l1-cache {
> +			compatible = "arm,arch-cache";
> +			next-level-cache = <&L2_1>;
> +			power-domain = <&pd_cores 6>;
> +		};
> +	};
> +
> +	CPU7: cpu@103 {
> +		device_type = "cpu";
> +		compatible = "arm,cortex-a7";
> +		reg = <0x103>;
> +		next-level-cache = <&L1_7>;
> +		cpu-idle-states = <&STATE1_0 &STATE1>;
> +		L1_7: l1-cache {
> +			compatible = "arm,arch-cache";
> +			next-level-cache = <&L2_1>;
> +			power-domain = <&pd_cores 7>;
> +		};
> +	};
> +};
> +
> +===========================================
> +4 - References
> +===========================================
> +
> +[1] ARM Linux Kernel documentation - power domain bindings
> +    Documentation/devicetree/bindings/power/power_domain.txt
> +
> +[2] ARM Linux Kernel documentation - PSCI bindings
> +    Documentation/devicetree/bindings/arm/psci.txt
> +
> +[3] ARM Server Base System Architecture (SBSA)
> +    http://infocenter.arm.com/help/index.jsp
> --
> 1.8.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
