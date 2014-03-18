From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH RFC v5 3/3] Documentation: arm: define DT idle states bindings
Date: Tue, 18 Mar 2014 11:28:52 +0000
Message-ID: <1395142132-20788-4-git-send-email-lorenzo.pieralisi@arm.com>
References: <1395142132-20788-1-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1395142132-20788-1-git-send-email-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: devicetree@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Mike Turquette <mturquette@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Mark Hambleton <mark.hambleton@broadcom.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Russell King <linux@arm.linux.org.uk>, Sebastian Capella <sebastian.capella@linaro.org>, Nicolas Pitre <nico@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@linaro.org>, Dave Martin <dave.martin@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Kevin Hilman <khilman@linaro.org>, linux-pm@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Peter De Schrijver <pdeschrijver@nvidia.com>, Stephen Boyd <sboyd@codeaurora.org>, Amit Kucheria <amit.kucheria@linaro.org>Mark
List-Id: linux-pm@vger.kernel.org

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

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 Documentation/devicetree/bindings/arm/cpus.txt     |  18 +
 .../devicetree/bindings/arm/idle-states.txt        | 771 +++++++++++++++++++++
 2 files changed, 789 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/idle-states.txt

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 9130435..79a1d9b 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -191,6 +191,19 @@ nodes to be present and contain the properties described below.
 			  property identifying a 64-bit zero-initialised
 			  memory location.
 
+	- cpu-idle-states
+		Usage: Optional
+		Value type: <prop-encoded-array>
+		Definition:
+			# List of phandles to idle state nodes supported
+			  by this cpu [1].
+
+	- power-domain
+		Usage: Optional
+		Value type: <prop-encoded-array>
+		Definition: A phandle and power domain specifier as defined by
+			    bindings of power domain specified by [2].
+
 Example 1 (dual-cluster big.LITTLE system 32-bit):
 
 	cpus {
@@ -382,3 +395,8 @@ cpus {
 		cpu-release-addr = <0 0x20000000>;
 	};
 };
+
+[1] ARM Linux kernel documentation - idle states bindings
+    Documentation/devicetree/bindings/arm/idle-states.txt
+[2] Kernel documentation - power domain bindings
+    Documentation/devicetree/bindings/power/power_domain.txt
diff --git a/Documentation/devicetree/bindings/arm/idle-states.txt b/Documentation/devicetree/bindings/arm/idle-states.txt
new file mode 100644
index 0000000..fee176d
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/idle-states.txt
@@ -0,0 +1,771 @@
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
+According to the Server Base System Architecture document (SBSA, [4]), the
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
+a direct child of the cpus node and provides a container where the processor
+idle states, defined as device tree nodes, are listed.
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
+			      ARM PSCI firmware interface [3].
+
+			    - "[vendor],[method]"
+			      An implementation dependent string with
+			      format "vendor,method", where vendor is a string
+			      denoting the name of the manufacturer and
+			      method is a string specifying the mechanism
+			      used to enter the idle state.
+
+The nodes describing the idle states (state) can only be defined within the
+idle-states node.
+
+Any other configuration is consider invalid and therefore must be ignored.
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
+	Description: must be child of either the idle-states node or
+		     a state node.
+
+	The state node name shall follow standard device tree naming
+	rules ([6], 2.2.1 "Node names"), in particular state nodes which
+	are siblings within a single common parent must be given a unique name.
+
+	The idle state entered by executing the wfi instruction (idle_standby
+	SBSA,[4][5]) is considered standard on all ARM platforms and therefore
+	must not be listed.
+
+	A state node can contain state child nodes. A state node with
+	children represents a hierarchical state, which is a superset of
+	the child states.
+
+	A state node defines the following properties:
+
+	- compatible
+		Usage: Required
+		Value type: <stringlist>
+		Definition: Must be "arm,idle-state".
+
+	- index
+		Usage: Required
+		Value type: <u32>
+		Definition: It represents the idle state index.
+			    The index must be given an increasing
+			    value = {0, 1, ....}, starting from 0, with higher
+			    values implying less power consumption.
+			    Indices must be unique as seen from a cpu
+			    perspective, ie phandles in the cpu nodes [1]
+			    cpu-idle-states array property are not allowed to
+			    point at idle state nodes having the same index
+			    value.
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
+		Definition: u32 value representing worst case latency
+			    in microseconds required to enter the idle state.
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
+		Definition: u32 value representing time in microseconds
+			    required for the CPU to be in the idle state to
+			    guarantee power savings maximization.
+
+	- power-domains
+		Usage: Optional
+		Value type: <prop-encoded-array>
+		Definition: List of phandle and power domain specifiers ([2])
+			    describing the power domains that are affected by
+			    the idle state entry. All devices whose
+			    power-domains property contains entries referring
+			    to one of the power domains listed in this
+			    property are affected by the idle state entry.
+
+===========================================
+4 - Examples
+===========================================
+
+Example 1 (ARM 64-bit, 16-cpu system):
+
+pd_clusters: power-domain-clusters@80002000 {
+	compatible = "arm,power-controller";
+	reg = <0x0 0x80002000 0x0 0x1000>;
+	#power-domain-cells = <1>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	pd_cores: power-domain-cores@80000000 {
+		compatible = "arm,power-controller";
+		reg = <0x0 0x80000000 0x0 0x1000>;
+		#power-domain-cells = <1>;
+	};
+};
+
+cpus {
+	#size-cells = <0>;
+	#address-cells = <2>;
+
+	idle-states {
+		entry-method = "arm,psci-cpu-suspend";
+
+		CLUSTER_RETENTION_0: cluster-retention-0 {
+			compatible = "arm,idle-state";
+			index = <2>;
+			logic-state-retained;
+			cache-state-retained;
+			entry-method-param = <0x1010000>;
+			entry-latency-us = <50>;
+			exit-latency-us = <100>;
+			min-residency-us = <250>;
+			power-domains = <&pd_clusters 0>;
+			CPU_RETENTION_0_0: cpu-retention-0 {
+				compatible = "arm,idle-state";
+				index = <0>;
+				cache-state-retained;
+				entry-method-param = <0x0010000>;
+				entry-latency-us = <20>;
+				exit-latency-us = <40>;
+				min-residency-us = <30>;
+				power-domains = <&pd_cores 0>,
+						<&pd_cores 1>,
+						<&pd_cores 2>,
+						<&pd_cores 3>,
+						<&pd_cores 4>,
+						<&pd_cores 5>,
+						<&pd_cores 6>,
+						<&pd_cores 7>;
+			};
+		};
+
+		CLUSTER_SLEEP_0: cluster-sleep-0 {
+			compatible = "arm,idle-state";
+			index = <3>;
+			entry-method-param = <0x1010000>;
+			entry-latency-us = <600>;
+			exit-latency-us = <1100>;
+			min-residency-us = <2700>;
+			power-domains = <&pd_clusters 0>;
+			CPU_SLEEP_0_0: cpu-sleep-0 {
+				/* cpu sleep */
+				compatible = "arm,idle-state";
+				index = <1>;
+				entry-method-param = <0x0010000>;
+				entry-latency-us = <250>;
+				exit-latency-us = <500>;
+				min-residency-us = <350>;
+				power-domains = <&pd_cores 0>,
+						<&pd_cores 1>,
+						<&pd_cores 2>,
+						<&pd_cores 3>,
+						<&pd_cores 4>,
+						<&pd_cores 5>,
+						<&pd_cores 6>,
+						<&pd_cores 7>;
+			};
+		};
+		CLUSTER_RETENTION_1: cluster-retention-1 {
+			compatible = "arm,idle-state";
+			index = <2>;
+			logic-state-retained;
+			cache-state-retained;
+			entry-method-param = <0x1010000>;
+			entry-latency-us = <50>;
+			exit-latency-us = <100>;
+			min-residency-us = <270>;
+			power-domains = <&pd_clusters 1>;
+			CPU_RETENTION_1_0: cpu-retention-0 {
+				compatible = "arm,idle-state";
+				index = <0>;
+				cache-state-retained;
+				entry-method-param = <0x0010000>;
+				entry-latency-us = <20>;
+				exit-latency-us = <40>;
+				min-residency-us = <30>;
+				power-domains = <&pd_cores 8>,
+						<&pd_cores 9>,
+						<&pd_cores 10>,
+						<&pd_cores 11>,
+						<&pd_cores 12>,
+						<&pd_cores 13>,
+						<&pd_cores 14>,
+						<&pd_cores 15>;
+			};
+		};
+
+		CLUSTER_SLEEP_1: cluster-sleep-1 {
+			compatible = "arm,idle-state";
+			index = <3>;
+			entry-method-param = <0x1010000>;
+			entry-latency-us = <500>;
+			exit-latency-us = <1200>;
+			min-residency-us = <3500>;
+			power-domains = <&pd_clusters 1>;
+			CPU_SLEEP_1_0: cpu-sleep-0 {
+				compatible = "arm,idle-state";
+				index = <1>;
+				entry-method-param = <0x0010000>;
+				entry-latency-us = <70>;
+				exit-latency-us = <100>;
+				min-residency-us = <100>;
+				power-domains = <&pd_cores 8>,
+						<&pd_cores 9>,
+						<&pd_cores 10>,
+						<&pd_cores 11>,
+						<&pd_cores 12>,
+						<&pd_cores 13>,
+						<&pd_cores 14>,
+						<&pd_cores 15>;
+			};
+		};
+	};
+
+	CPU0: cpu@0 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x0>;
+		enable-method = "psci";
+		next-level-cache = <&L1_0>;
+		cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
+				   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+		L1_0: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_0>;
+			power-domain = <&pd_cores 0>;
+		};
+		L2_0: l2-cache {
+			compatible = "arm,arch-cache";
+			power-domain = <&pd_clusters 0>;
+		};
+	};
+
+	CPU1: cpu@1 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x1>;
+		enable-method = "psci";
+		next-level-cache = <&L1_1>;
+		cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
+				   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+		L1_1: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_0>;
+			power-domain = <&pd_cores 1>;
+		};
+	};
+
+	CPU2: cpu@100 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x100>;
+		enable-method = "psci";
+		next-level-cache = <&L1_2>;
+		cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
+				   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+		L1_2: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_0>;
+			power-domain = <&pd_cores 2>;
+		};
+	};
+
+	CPU3: cpu@101 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x101>;
+		enable-method = "psci";
+		next-level-cache = <&L1_3>;
+		cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
+				   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+		L1_3: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_0>;
+			power-domain = <&pd_cores 3>;
+		};
+	};
+
+	CPU4: cpu@10000 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x10000>;
+		enable-method = "psci";
+		next-level-cache = <&L1_4>;
+		cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
+				   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+		L1_4: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_0>;
+			power-domain = <&pd_cores 4>;
+		};
+	};
+
+	CPU5: cpu@10001 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x10001>;
+		enable-method = "psci";
+		next-level-cache = <&L1_5>;
+		cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
+				   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+		L1_5: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_0>;
+			power-domain = <&pd_cores 5>;
+		};
+	};
+
+	CPU6: cpu@10100 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x10100>;
+		enable-method = "psci";
+		next-level-cache = <&L1_6>;
+		cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
+				   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+		L1_6: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_0>;
+			power-domain = <&pd_cores 6>;
+		};
+	};
+
+	CPU7: cpu@10101 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x0 0x10101>;
+		enable-method = "psci";
+		next-level-cache = <&L1_7>;
+		cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
+				   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+		L1_7: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_0>;
+			power-domain = <&pd_cores 7>;
+		};
+	};
+
+	CPU8: cpu@100000000 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x0>;
+		enable-method = "psci";
+		next-level-cache = <&L1_8>;
+		cpu-idle-states = <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
+				   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+		L1_8: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_1>;
+			power-domain = <&pd_cores 8>;
+		};
+		L2_1: l2-cache {
+			compatible = "arm,arch-cache";
+			power-domain = <&pd_clusters 1>;
+		};
+	};
+
+	CPU9: cpu@100000001 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x1>;
+		enable-method = "psci";
+		next-level-cache = <&L1_9>;
+		cpu-idle-states = <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
+				   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+		L1_9: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_1>;
+			power-domain = <&pd_cores 9>;
+		};
+	};
+
+	CPU10: cpu@100000100 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x100>;
+		enable-method = "psci";
+		next-level-cache = <&L1_10>;
+		cpu-idle-states = <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
+				   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+		L1_10: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_1>;
+			power-domain = <&pd_cores 10>;
+		};
+	};
+
+	CPU11: cpu@100000101 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x101>;
+		enable-method = "psci";
+		next-level-cache = <&L1_11>;
+		cpu-idle-states = <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
+				   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+		L1_11: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_1>;
+			power-domain = <&pd_cores 11>;
+		};
+	};
+
+	CPU12: cpu@100010000 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x10000>;
+		enable-method = "psci";
+		next-level-cache = <&L1_12>;
+		cpu-idle-states = <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
+				   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+		L1_12: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_1>;
+			power-domain = <&pd_cores 12>;
+		};
+	};
+
+	CPU13: cpu@100010001 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x10001>;
+		enable-method = "psci";
+		next-level-cache = <&L1_13>;
+		cpu-idle-states = <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
+				   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+		L1_13: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_1>;
+			power-domain = <&pd_cores 13>;
+		};
+	};
+
+	CPU14: cpu@100010100 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x10100>;
+		enable-method = "psci";
+		next-level-cache = <&L1_14>;
+		cpu-idle-states = <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
+				   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+		L1_14: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_1>;
+			power-domain = <&pd_cores 14>;
+		};
+	};
+
+	CPU15: cpu@100010101 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x1 0x10101>;
+		enable-method = "psci";
+		next-level-cache = <&L1_15>;
+		cpu-idle-states = <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
+				   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+		L1_15: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_1>;
+			power-domain = <&pd_cores 15>;
+		};
+	};
+};
+
+Example 2 (ARM 32-bit, 8-cpu system, two clusters):
+
+pd_clusters: power-domain-clusters@80002000 {
+	compatible = "arm,power-controller";
+	reg = <0x80002000 0x1000>;
+	#power-domain-cells = <1>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	pd_cores: power-domain-cores@80000000 {
+		compatible = "arm,power-controller";
+		reg = <0x80000000 0x1000>;
+		#power-domain-cells = <1>;
+	};
+};
+
+cpus {
+	#size-cells = <0>;
+	#address-cells = <1>;
+
+	idle-states {
+		entry-method = "arm,psci-cpu-suspend";
+
+		CLUSTER_SLEEP_0: cluster-sleep-0 {
+			compatible = "arm,idle-state";
+			index = <1>;
+			entry-method-param = <0x1010000>;
+			entry-latency-us = <1000>;
+			exit-latency-us = <1500>;
+			min-residency-us = <1500>;
+			power-domains = <&pd_clusters 0>;
+			CPU_SLEEP_0_0: cpu-sleep-0 {
+				compatible = "arm,idle-state";
+				index = <0>;
+				entry-method-param = <0x0010000>;
+				entry-latency-us = <400>;
+				exit-latency-us = <500>;
+				min-residency-us = <300>;
+				power-domains = <&pd_cores 0>,
+						<&pd_cores 1>,
+						<&pd_cores 2>,
+						<&pd_cores 3>;
+			};
+		};
+
+		CLUSTER_SLEEP_1: cluster-sleep-1 {
+			compatible = "arm,idle-state";
+			index = <1>;
+			entry-method-param = <0x1010000>;
+			entry-latency-us = <800>;
+			exit-latency-us = <2000>;
+			min-residency-us = <6500>;
+			power-domains = <&pd_clusters 1>;
+			CPU_SLEEP_1_0: cpu-sleep-0 {
+				compatible = "arm,idle-state";
+				index = <0>;
+				entry-method-param = <0x0010000>;
+				entry-latency-us = <300>;
+				exit-latency-us = <500>;
+				min-residency-us = <500>;
+				power-domains = <&pd_cores 4>,
+						<&pd_cores 5>,
+						<&pd_cores 6>,
+						<&pd_cores 7>;
+			};
+		};
+	};
+
+	CPU0: cpu@0 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a15";
+		reg = <0x0>;
+		next-level-cache = <&L1_0>;
+		cpu-idle-states = <&CPU_SLEEP_0_0 &CLUSTER_SLEEP_0>;
+		L1_0: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_0>;
+			power-domain = <&pd_cores 0>;
+		};
+		L2_0: l2-cache {
+			compatible = "arm,arch-cache";
+			power-domain = <&pd_clusters 0>;
+		};
+	};
+
+	CPU1: cpu@1 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a15";
+		reg = <0x1>;
+		next-level-cache = <&L1_1>;
+		cpu-idle-states = <&CPU_SLEEP_0_0 &CLUSTER_SLEEP_0>;
+		L1_1: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_0>;
+			power-domain = <&pd_cores 1>;
+		};
+	};
+
+	CPU2: cpu@2 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a15";
+		reg = <0x2>;
+		next-level-cache = <&L1_2>;
+		cpu-idle-states = <&CPU_SLEEP_0_0 &CLUSTER_SLEEP_0>;
+		L1_2: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_0>;
+			power-domain = <&pd_cores 2>;
+		};
+	};
+
+	CPU3: cpu@3 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a15";
+		reg = <0x3>;
+		next-level-cache = <&L1_3>;
+		cpu-idle-states = <&CPU_SLEEP_0_0 &CLUSTER_SLEEP_0>;
+		L1_3: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_0>;
+			power-domain = <&pd_cores 3>;
+		};
+	};
+
+	CPU4: cpu@100 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a7";
+		reg = <0x100>;
+		next-level-cache = <&L1_4>;
+		cpu-idle-states = <&CPU_SLEEP_1_0 &CLUSTER_SLEEP_1>;
+		L1_4: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_1>;
+			power-domain = <&pd_cores 4>;
+		};
+		L2_1: l2-cache {
+			compatible = "arm,arch-cache";
+			power-domain = <&pd_clusters 1>;
+		};
+	};
+
+	CPU5: cpu@101 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a7";
+		reg = <0x101>;
+		next-level-cache = <&L1_5>;
+		cpu-idle-states = <&CPU_SLEEP_1_0 &CLUSTER_SLEEP_1>;
+		L1_5: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_1>;
+			power-domain = <&pd_cores 5>;
+		};
+	};
+
+	CPU6: cpu@102 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a7";
+		reg = <0x102>;
+		next-level-cache = <&L1_6>;
+		cpu-idle-states = <&CPU_SLEEP_1_0 &CLUSTER_SLEEP_1>;
+		L1_6: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_1>;
+			power-domain = <&pd_cores 6>;
+		};
+	};
+
+	CPU7: cpu@103 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a7";
+		reg = <0x103>;
+		next-level-cache = <&L1_7>;
+		cpu-idle-states = <&CPU_SLEEP_1_0 &CLUSTER_SLEEP_1>;
+		L1_7: l1-cache {
+			compatible = "arm,arch-cache";
+			next-level-cache = <&L2_1>;
+			power-domain = <&pd_cores 7>;
+		};
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
+[2] ARM Linux Kernel documentation - power domain bindings
+    Documentation/devicetree/bindings/power/power_domain.txt
+
+[3] ARM Linux Kernel documentation - PSCI bindings
+    Documentation/devicetree/bindings/arm/psci.txt
+
+[4] ARM Server Base System Architecture (SBSA)
+    http://infocenter.arm.com/help/index.jsp
+
+[5] ARM Architecture Reference Manuals
+    http://infocenter.arm.com/help/index.jsp
+
+[6] ePAPR standard
+    https://www.power.org/documentation/epapr-version-1-1/
-- 
1.8.4
