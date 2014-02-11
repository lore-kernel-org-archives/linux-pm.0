From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH RFC v3 3/3] Documentation: arm: define DT idle states bindings
Date: Tue, 11 Feb 2014 14:17:53 +0000
Message-ID: <1392128273-8614-4-git-send-email-lorenzo.pieralisi@arm.com>
References: <1392128273-8614-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:33729 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbaBKORK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2014 09:17:10 -0500
In-Reply-To: <1392128273-8614-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Dave Martin <dave.martin@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Grant Likely <grant.likely@linaro.org>, Kumar Gala <galak@codeaurora.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King <linux@arm.linux.org.uk>, Mark Hambleton <mark.hambleton@broadcom.com>, Hanjun Guo <hanjun.guo@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Tomasz Figa <t.figa@samsung.com>, Kevin

ARM based platforms implement a variety of power management schemes that
allow processors to enter idle states at run-time.
The parameters defining these idle states vary on a per-platform basis forc=
ing
the OS to hardcode the state parameters in platform specific static tables
whose size grows as the number of platforms supported in the kernel increas=
es
and hampers device drivers standardization.

Therefore, this patch aims at standardizing idle state device tree bindings=
 for
ARM platforms. Bindings define idle state parameters inclusive of entry met=
hods
and state latencies, to allow operating systems to retrieve the configurati=
on
entries from the device tree and initialize the related power management
drivers, paving the way for common code in the kernel to deal with idle
states and removing the need for static data in current and previous kernel
versions.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 Documentation/devicetree/bindings/arm/cpus.txt        |  10 +
 Documentation/devicetree/bindings/arm/idle-states.txt | 690 ++++++++++
 2 files changed, 700 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation=
/devicetree/bindings/arm/cpus.txt
index 9130435..fb7f008 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -191,6 +191,13 @@ nodes to be present and contain the properties describ=
ed below.
 =09=09=09  property identifying a 64-bit zero-initialised
 =09=09=09  memory location.
=20
+=09- cpu-idle-states
+=09=09Usage: Optional
+=09=09Value type: <prop-encoded-array>
+=09=09Definition:
+=09=09=09# List of phandles to cpu idle state nodes supported
+=09=09=09  by this cpu [1].
+
 Example 1 (dual-cluster big.LITTLE system 32-bit):
=20
 =09cpus {
@@ -382,3 +389,6 @@ cpus {
 =09=09cpu-release-addr =3D <0 0x20000000>;
 =09};
 };
+
+[1] ARM Linux kernel documentation - idle state bindings
+    Documentation/devicetree/bindings/arm/idle-states.txt
diff --git a/Documentation/devicetree/bindings/arm/idle-states.txt b/Docume=
ntation/devicetree/bindings/arm/idle-states.txt
new file mode 100644
index 0000000..f155e70
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/idle-states.txt
@@ -0,0 +1,690 @@
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ARM idle states binding description
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+1 - Introduction
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+ARM systems contain HW capable of managing power consumption dynamically,
+where cores can be put in different low-power states (ranging from simple
+wfi to power gating) according to OSPM policies. The CPU states representi=
ng
+the range of dynamic idle states that a processor can enter at run-time, c=
an be
+specified through device tree bindings representing the parameters require=
d
+to enter/exit specific idle states on a given processor.
+
+According to the Server Base System Architecture document (SBSA, [3]), the
+power states an ARM CPU can be put into are identified by the following li=
st:
+
+1 - Running
+2 - Idle_standby
+3 - Idle_retention
+4 - Sleep
+5 - Off
+
+ARM platforms implement the power states specified in the SBSA through pow=
er
+management schemes that allow an OS PM implementation to put the processor=
 in
+different idle states (which include states 1 to 4 above; "off" state is n=
ot
+an idle state since it does not have wake-up capabilities, hence it is not
+considered in this document).
+
+Idle state parameters (eg entry latency) are platform specific and need to=
 be
+characterized with bindings that provide the required information to OSPM
+code so that it can build the required tables and use them at runtime.
+
+The device tree binding definition for ARM idle states is the subject of t=
his
+document.
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+2 - cpu-idle-states node
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+ARM processor idle states are defined within the cpu-idle-states node, whi=
ch is
+a direct child of the cpus node and provides a container where the process=
or
+states, defined as device tree nodes, are listed.
+
+- cpu-idle-states node
+
+=09Usage: Optional - On ARM systems, is a container of processor idle
+=09=09=09  states nodes. If the system does not provide CPU
+=09=09=09  power management capabilities or the processor just
+=09=09=09  supports idle_standby a cpu-idle-states node is not
+=09=09=09  required.
+
+=09Description: cpu-idle-states node is a container node, where its
+=09=09     subnodes describe the CPU idle states.
+
+=09Node name must be "cpu-idle-states".
+
+=09The cpu-idle-states node's parent node must be the cpus node.
+
+=09The cpu-idle-states node's child nodes can be:
+
+=09- one or more state nodes
+
+=09Any other configuration is considered invalid.
+
+The nodes describing the idle states (state) can only be defined within th=
e
+cpu-idle-states node.
+
+Any other configuration is consider invalid and therefore must be ignored.
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+2 - state node
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+A state node represents an idle state description and must be defined as
+follows:
+
+- state node
+
+=09Description: must be child of either the cpu-idle-states node or
+=09=09     a state node.
+
+=09The state node name shall be "stateN", where N =3D {0, 1, ...} is
+=09the node number; state nodes which are siblings within a single common
+=09parent node must be given a unique and sequential N value, starting
+=09from 0.
+
+=09A state node can contain state child nodes. A state node with
+=09children represents a hierarchical state, which is a superset of
+=09the child states. Hierarchical states require all CPUs on which
+=09they are valid to request the state in order for it to be entered.
+
+=09A state node defines the following properties:
+
+=09- compatible
+=09=09Usage: Required
+=09=09Value type: <stringlist>
+=09=09Definition: Must be "arm,cpu-idle-state".
+
+=09- index
+=09=09Usage: Required
+=09=09Value type: <u32>
+=09=09Definition: It represents an idle state index, starting from 2.
+=09=09=09    Index 0 represents the processor state "running"
+=09=09=09    and index 1 represents processor mode
+=09=09=09    "idle_standby", entered by executing a wfi
+=09=09=09    instruction (SBSA,[3]); indexes 0 and 1 are
+=09=09=09    standard ARM states that need not be described.
+
+=09- entry-method
+=09=09Usage: Required
+=09=09Value type: <stringlist>
+=09=09Definition: Describes the method by which a CPU enters the
+=09=09=09    idle state. This property is required and must be
+=09=09=09    one of:
+
+=09=09=09    - "arm,psci-cpu-suspend"
+=09=09=09      ARM PSCI firmware interface, CPU suspend
+=09=09=09      method[2].
+
+=09=09=09    - "[vendor],[method]"
+=09=09=09      An implementation dependent string with
+=09=09=09      format "vendor,method", where vendor is a string
+=09=09=09      denoting the name of the manufacturer and
+=09=09=09      method is a string specifying the mechanism
+=09=09=09      used to enter the idle state.
+
+=09- power-state
+=09=09Usage: See definition.
+=09=09Value type: <u32>
+=09=09Definition: Depends on the entry-method property value.
+=09=09=09    If entry-method is "arm,psci-cpu-suspend":
+=09=09=09=09# Property is required and represents
+=09=09=09=09  psci-power-state parameter. Please refer to
+=09=09=09=09  [2] for PSCI bindings definition.
+
+=09- entry-latency
+=09=09Usage: Required
+=09=09Value type: <prop-encoded-array>
+=09=09Definition: u32 value representing worst case latency
+=09=09=09    in microseconds required to enter the idle state.
+
+=09- exit-latency
+=09=09Usage: Required
+=09=09Value type: <prop-encoded-array>
+=09=09Definition: u32 value representing worst case latency
+=09=09=09    in microseconds required to exit the idle state.
+
+=09- min-residency
+=09=09Usage: Required
+=09=09Value type: <prop-encoded-array>
+=09=09Definition: u32 value representing time in microseconds
+=09=09=09    required for the CPU to be in the idle state to
+=09=09=09    make up for the dynamic power consumed to
+=09=09=09    enter/exit the idle state in order to break even
+=09=09=09    in terms of power consumption compared to idle
+=09=09=09    state index 1 (idle_standby).
+
+=09- power-domains
+=09=09Usage: Optional
+=09=09Value type: <prop-encoded-array>
+=09=09Definition: List of power domain specifiers ([1]) describing
+=09=09=09    the power domains that are affected by the idle
+=09=09=09    state entry.
+
+=09- cache-state-retained
+=09=09Usage: See definition
+=09=09Value type: <none>
+=09=09Definition: if present cache memory is retained on power down,
+=09=09=09    otherwise it is lost.
+
+=09- processor-state-retained
+=09=09Usage: See definition
+=09=09Value type: <none>
+=09=09Definition: if present CPU processor logic is retained on
+=09=09=09    power down, otherwise it is lost.
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+3 - Examples
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Example 1 (ARM 64-bit, 16-cpu system):
+
+pd_clusters: power-domain-clusters@80002000 {
+=09compatible =3D "arm,power-controller";
+=09reg =3D <0x0 0x80002000 0x0 0x1000>;
+=09#power-domain-cells =3D <1>;
+=09#address-cells =3D <2>;
+=09#size-cells =3D <2>;
+
+=09pd_cores: power-domain-cores@80000000 {
+=09=09compatible =3D "arm,power-controller";
+=09=09reg =3D <0x0 0x80000000 0x0 0x1000>;
+=09=09#power-domain-cells =3D <1>;
+=09};
+};
+
+cpus {
+=09#size-cells =3D <0>;
+=09#address-cells =3D <2>;
+
+=09cpu-idle-states {
+
+=09=09STATE0: state0 {
+=09=09=09compatible =3D "arm,cpu-idle-state";
+=09=09=09index =3D <3>;
+=09=09=09entry-method =3D "arm,psci-cpu-suspend";
+=09=09=09psci-power-state =3D <0x1010000>;
+=09=09=09entry-latency =3D <500>;
+=09=09=09exit-latency =3D <1000>;
+=09=09=09min-residency =3D <2500>;
+=09=09=09power-domains =3D <&pd_clusters 0>;
+=09=09=09STATE0_1: state0 {
+=09=09=09=09compatible =3D "arm,cpu-idle-state";
+=09=09=09=09index =3D <2>;
+=09=09=09=09entry-method =3D "arm,psci-cpu-suspend";
+=09=09=09=09psci-power-state =3D <0x0010000>;
+=09=09=09=09entry-latency =3D <200>;
+=09=09=09=09exit-latency =3D <400>;
+=09=09=09=09min-residency =3D <300>;
+=09=09=09=09power-domains =3D <&pd_cores 0>,
+=09=09=09=09=09=09<&pd_cores 1>,
+=09=09=09=09=09=09<&pd_cores 2>,
+=09=09=09=09=09=09<&pd_cores 3>,
+=09=09=09=09=09=09<&pd_cores 4>,
+=09=09=09=09=09=09<&pd_cores 5>,
+=09=09=09=09=09=09<&pd_cores 6>,
+=09=09=09=09=09=09<&pd_cores 7>;
+=09=09=09};
+=09=09};
+
+=09=09STATE1: state1 {
+=09=09=09compatible =3D "arm,cpu-idle-state";
+=09=09=09index =3D <3>;
+=09=09=09entry-method =3D "arm,psci-cpu-suspend";
+=09=09=09psci-power-state =3D <0x1010000>;
+=09=09=09entry-latency =3D <1000>;
+=09=09=09exit-latency =3D <3000>;
+=09=09=09min-residency =3D <6500>;
+=09=09=09power-domains =3D <&pd_clusters 1>;
+=09=09=09STATE1_0: state0 {
+=09=09=09=09compatible =3D "arm,cpu-idle-state";
+=09=09=09=09index =3D <2>;
+=09=09=09=09entry-method =3D "arm,psci-cpu-suspend";
+=09=09=09=09psci-power-state =3D <0x0010000>;
+=09=09=09=09entry-latency =3D <200>;
+=09=09=09=09exit-latency =3D <400>;
+=09=09=09=09min-residency =3D <500>;
+=09=09=09=09power-domains =3D <&pd_cores 8>,
+=09=09=09=09=09=09<&pd_cores 9>,
+=09=09=09=09=09=09<&pd_cores 10>,
+=09=09=09=09=09=09<&pd_cores 11>,
+=09=09=09=09=09=09<&pd_cores 12>,
+=09=09=09=09=09=09<&pd_cores 13>,
+=09=09=09=09=09=09<&pd_cores 14>,
+=09=09=09=09=09=09<&pd_cores 15>;
+=09=09=09};
+=09=09};
+=09};
+
+=09CPU0: cpu@0 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a57";
+=09=09reg =3D <0x0 0x0>;
+=09=09enable-method =3D "psci";
+=09=09next-level-cache =3D <&L1_0>;
+=09=09cpu-idle-states =3D <&STATE0_1 &STATE0>;
+=09=09L1_0: l1-cache {
+=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09next-level-cache =3D <&L2_0>;
+=09=09=09power-domain =3D <&pd_cores 0>;
+=09=09};
+=09=09L2_0: l2-cache {
+=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09power-domain =3D <&pd_clusters 0>;
+=09=09};
+=09};
+
+=09CPU1: cpu@1 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a57";
+=09=09reg =3D <0x0 0x1>;
+=09=09enable-method =3D "psci";
+=09=09next-level-cache =3D <&L1_1>;
+=09=09cpu-idle-states =3D <&STATE0_1 &STATE0>;
+=09=09L1_1: l1-cache {
+=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09next-level-cache =3D <&L2_0>;
+=09=09=09power-domain =3D <&pd_cores 1>;
+=09=09};
+=09};
+
+=09CPU2: cpu@100 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a57";
+=09=09reg =3D <0x0 0x100>;
+=09=09enable-method =3D "psci";
+=09=09next-level-cache =3D <&L1_2>;
+=09=09cpu-idle-states =3D <&STATE0_1 &STATE0>;
+=09=09L1_2: l1-cache {
+=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09next-level-cache =3D <&L2_0>;
+=09=09=09power-domain =3D <&pd_cores 2>;
+=09=09};
+=09};
+
+=09CPU3: cpu@101 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a57";
+=09=09reg =3D <0x0 0x101>;
+=09=09enable-method =3D "psci";
+=09=09next-level-cache =3D <&L1_3>;
+=09=09cpu-idle-states =3D <&STATE0_1 &STATE0>;
+=09=09L1_3: l1-cache {
+=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09next-level-cache =3D <&L2_0>;
+=09=09=09power-domain =3D <&pd_cores 3>;
+=09=09};
+=09};
+
+=09CPU4: cpu@10000 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a57";
+=09=09reg =3D <0x0 0x10000>;
+=09=09enable-method =3D "psci";
+=09=09next-level-cache =3D <&L1_4>;
+=09=09cpu-idle-states =3D <&STATE0_1 &STATE0>;
+=09=09L1_4: l1-cache {
+=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09next-level-cache =3D <&L2_0>;
+=09=09=09power-domain =3D <&pd_cores 4>;
+=09=09};
+=09};
+
+=09CPU5: cpu@10001 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a57";
+=09=09reg =3D <0x0 0x10001>;
+=09=09enable-method =3D "psci";
+=09=09next-level-cache =3D <&L1_5>;
+=09=09cpu-idle-states =3D <&STATE0_1 &STATE0>;
+=09=09L1_5: l1-cache {
+=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09next-level-cache =3D <&L2_0>;
+=09=09=09power-domain =3D <&pd_cores 5>;
+=09=09};
+=09};
+
+=09CPU6: cpu@10100 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a57";
+=09=09reg =3D <0x0 0x10100>;
+=09=09enable-method =3D "psci";
+=09=09next-level-cache =3D <&L1_6>;
+=09=09cpu-idle-states =3D <&STATE0_1 &STATE0>;
+=09=09L1_6: l1-cache {
+=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09next-level-cache =3D <&L2_0>;
+=09=09=09power-domain =3D <&pd_cores 6>;
+=09=09};
+=09};
+
+=09CPU7: cpu@10101 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a57";
+=09=09reg =3D <0x0 0x10101>;
+=09=09enable-method =3D "psci";
+=09=09next-level-cache =3D <&L1_7>;
+=09=09cpu-idle-states =3D <&STATE0_1 &STATE0>;
+=09=09L1_7: l1-cache {
+=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09next-level-cache =3D <&L2_0>;
+=09=09=09power-domain =3D <&pd_cores 7>;
+=09=09};
+=09};
+
+=09CPU8: cpu@100000000 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a53";
+=09=09reg =3D <0x1 0x0>;
+=09=09enable-method =3D "psci";
+=09=09next-level-cache =3D <&L1_8>;
+=09=09cpu-idle-states =3D <&STATE1_0 &STATE1>;
+=09=09L1_8: l1-cache {
+=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09next-level-cache =3D <&L2_1>;
+=09=09=09power-domain =3D <&pd_cores 8>;
+=09=09};
+=09=09L2_1: l2-cache {
+=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09power-domain =3D <&pd_clusters 1>;
+=09=09};
+=09};
+
+=09CPU9: cpu@100000001 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a53";
+=09=09reg =3D <0x1 0x1>;
+=09=09enable-method =3D "psci";
+=09=09next-level-cache =3D <&L1_9>;
+=09=09cpu-idle-states =3D <&STATE1_0 &STATE1>;
+=09=09L1_9: l1-cache {
+=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09next-level-cache =3D <&L2_1>;
+=09=09=09power-domain =3D <&pd_cores 9>;
+=09=09};
+=09};
+
+=09CPU10: cpu@100000100 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a53";
+=09=09reg =3D <0x1 0x100>;
+=09=09enable-method =3D "psci";
+=09=09next-level-cache =3D <&L1_10>;
+=09=09cpu-idle-states =3D <&STATE1_0 &STATE1>;
+=09=09L1_10: l1-cache {
+=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09next-level-cache =3D <&L2_1>;
+=09=09=09power-domain =3D <&pd_cores 10>;
+=09=09};
+=09};
+
+=09CPU11: cpu@100000101 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a53";
+=09=09reg =3D <0x1 0x101>;
+=09=09enable-method =3D "psci";
+=09=09next-level-cache =3D <&L1_11>;
+=09=09cpu-idle-states =3D <&STATE1_0 &STATE1>;
+=09=09L1_11: l1-cache {
+=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09next-level-cache =3D <&L2_1>;
+=09=09=09power-domain =3D <&pd_cores 11>;
+=09=09};
+=09};
+
+=09CPU12: cpu@100010000 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a53";
+=09=09reg =3D <0x1 0x10000>;
+=09=09enable-method =3D "psci";
+=09=09next-level-cache =3D <&L1_12>;
+=09=09cpu-idle-states =3D <&STATE1_0 &STATE1>;
+=09=09L1_12: l1-cache {
+=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09next-level-cache =3D <&L2_1>;
+=09=09=09power-domain =3D <&pd_cores 12>;
+=09=09};
+=09};
+
+=09CPU13: cpu@100010001 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a53";
+=09=09reg =3D <0x1 0x10001>;
+=09=09enable-method =3D "psci";
+=09=09next-level-cache =3D <&L1_13>;
+=09=09cpu-idle-states =3D <&STATE1_0 &STATE1>;
+=09=09L1_13: l1-cache {
+=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09next-level-cache =3D <&L2_1>;
+=09=09=09power-domain =3D <&pd_cores 13>;
+=09=09};
+=09};
+
+=09CPU14: cpu@100010100 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a53";
+=09=09reg =3D <0x1 0x10100>;
+=09=09enable-method =3D "psci";
+=09=09next-level-cache =3D <&L1_14>;
+=09=09cpu-idle-states =3D <&STATE1_0 &STATE1>;
+=09=09L1_14: l1-cache {
+=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09next-level-cache =3D <&L2_1>;
+=09=09=09power-domain =3D <&pd_cores 14>;
+=09=09};
+=09};
+
+=09CPU15: cpu@100010101 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a53";
+=09=09reg =3D <0x1 0x10101>;
+=09=09enable-method =3D "psci";
+=09=09next-level-cache =3D <&L1_15>;
+=09=09cpu-idle-states =3D <&STATE1_0 &STATE1>;
+=09=09L1_15: l1-cache {
+=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09next-level-cache =3D <&L2_1>;
+=09=09=09power-domain =3D <&pd_cores 15>;
+=09=09};
+=09};
+};
+
+Example 2 (ARM 32-bit, 8-cpu system, two clusters):
+
+pd_clusters: power-domain-clusters@80002000 {
+=09compatible =3D "arm,power-controller";
+=09reg =3D <0x80002000 0x1000>;
+=09#power-domain-cells =3D <1>;
+=09#address-cells =3D <1>;
+=09#size-cells =3D <1>;
+
+=09pd_cores: power-domain-cores@80000000 {
+=09=09compatible =3D "arm,power-controller";
+=09=09reg =3D <0x80000000 0x1000>;
+=09=09#power-domain-cells =3D <1>;
+=09};
+};
+
+cpus {
+=09#size-cells =3D <0>;
+=09#address-cells =3D <1>;
+
+=09cpu-idle-states {
+
+=09=09STATE0: state0 {
+=09=09=09compatible =3D "arm,cpu-idle-state";
+=09=09=09index =3D <3>;
+=09=09=09entry-method =3D "psci";
+=09=09=09psci-power-state =3D <0x1010000>;
+=09=09=09entry-latency =3D <1000>;
+=09=09=09exit-latency =3D <1500>;
+=09=09=09min-residency =3D <1500>;
+=09=09=09power-domains =3D <&pd_clusters 0>;
+=09=09=09STATE0_1: state0 {
+=09=09=09=09compatible =3D "arm,cpu-idle-state";
+=09=09=09=09index =3D <2>;
+=09=09=09=09entry-method =3D "psci";
+=09=09=09=09psci-power-state =3D <0x0010000>;
+=09=09=09=09entry-latency =3D <400>;
+=09=09=09=09exit-latency =3D <500>;
+=09=09=09=09min-residency =3D <300>;
+=09=09=09=09power-domains =3D <&pd_cores 0>,
+=09=09=09=09=09=09<&pd_cores 1>,
+=09=09=09=09=09=09<&pd_cores 2>,
+=09=09=09=09=09=09<&pd_cores 3>;
+=09=09=09};
+=09=09};
+
+=09=09STATE1: state1 {
+=09=09=09compatible =3D "arm,cpu-idle-state";
+=09=09=09index =3D <3>;
+=09=09=09entry-method =3D "psci";
+=09=09=09psci-power-state =3D <0x1010000>;
+=09=09=09entry-latency =3D <800>;
+=09=09=09exit-latency =3D <2000>;
+=09=09=09min-residency =3D <6500>;
+=09=09=09power-domains =3D <&pd_clusters 1>;
+=09=09=09STATE1_0: state0 {
+=09=09=09=09compatible =3D "arm,cpu-idle-state";
+=09=09=09=09index =3D <2>;
+=09=09=09=09entry-method =3D "psci";
+=09=09=09=09psci-power-state =3D <0x0010000>;
+=09=09=09=09entry-latency =3D <300>;
+=09=09=09=09exit-latency =3D <500>;
+=09=09=09=09min-residency =3D <500>;
+=09=09=09=09power-domains =3D <&pd_cores 4>,
+=09=09=09=09=09=09<&pd_cores 5>,
+=09=09=09=09=09=09<&pd_cores 6>,
+=09=09=09=09=09=09<&pd_cores 7>;
+=09=09=09};
+=09=09};
+=09};
+
+=09CPU0: cpu@0 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a15";
+=09=09reg =3D <0x0>;
+=09=09next-level-cache =3D <&L1_0>;
+=09=09cpu-idle-states =3D <&STATE0_1 &STATE0>;
+=09=09L1_0: l1-cache {
+=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09next-level-cache =3D <&L2_0>;
+=09=09=09power-domain =3D <&pd_cores 0>;
+=09=09};
+=09=09L2_0: l2-cache {
+=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09power-domain =3D <&pd_clusters 0>;
+=09=09};
+=09};
+
+=09CPU1: cpu@1 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a15";
+=09=09reg =3D <0x1>;
+=09=09next-level-cache =3D <&L1_1>;
+=09=09cpu-idle-states =3D <&STATE0_1 &STATE0>;
+=09=09L1_1: l1-cache {
+=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09next-level-cache =3D <&L2_0>;
+=09=09=09power-domain =3D <&pd_cores 1>;
+=09=09};
+=09};
+
+=09CPU2: cpu@2 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a15";
+=09=09reg =3D <0x2>;
+=09=09next-level-cache =3D <&L1_2>;
+=09=09cpu-idle-states =3D <&STATE0_1 &STATE0>;
+=09=09L1_2: l1-cache {
+=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09next-level-cache =3D <&L2_0>;
+=09=09=09power-domain =3D <&pd_cores 2>;
+=09=09};
+=09};
+
+=09CPU3: cpu@3 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a15";
+=09=09reg =3D <0x3>;
+=09=09next-level-cache =3D <&L1_3>;
+=09=09cpu-idle-states =3D <&STATE0_1 &STATE0>;
+=09=09L1_3: l1-cache {
+=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09next-level-cache =3D <&L2_0>;
+=09=09=09power-domain =3D <&pd_cores 3>;
+=09=09};
+=09};
+
+=09CPU4: cpu@100 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a7";
+=09=09reg =3D <0x100>;
+=09=09next-level-cache =3D <&L1_4>;
+=09=09cpu-idle-states =3D <&STATE1_0 &STATE1>;
+=09=09L1_4: l1-cache {
+=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09next-level-cache =3D <&L2_1>;
+=09=09=09power-domain =3D <&pd_cores 4>;
+=09=09};
+=09=09L2_1: l2-cache {
+=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09power-domain =3D <&pd_clusters 1>;
+=09=09};
+=09};
+
+=09CPU5: cpu@101 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a7";
+=09=09reg =3D <0x101>;
+=09=09next-level-cache =3D <&L1_5>;
+=09=09cpu-idle-states =3D <&STATE1_0 &STATE1>;
+=09=09L1_5: l1-cache {
+=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09next-level-cache =3D <&L2_1>;
+=09=09=09power-domain =3D <&pd_cores 5>;
+=09=09};
+=09};
+
+=09CPU6: cpu@102 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a7";
+=09=09reg =3D <0x102>;
+=09=09next-level-cache =3D <&L1_6>;
+=09=09cpu-idle-states =3D <&STATE1_0 &STATE1>;
+=09=09L1_6: l1-cache {
+=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09next-level-cache =3D <&L2_1>;
+=09=09=09power-domain =3D <&pd_cores 6>;
+=09=09};
+=09};
+
+=09CPU7: cpu@103 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a7";
+=09=09reg =3D <0x103>;
+=09=09next-level-cache =3D <&L1_7>;
+=09=09cpu-idle-states =3D <&STATE1_0 &STATE1>;
+=09=09L1_7: l1-cache {
+=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09next-level-cache =3D <&L2_1>;
+=09=09=09power-domain =3D <&pd_cores 7>;
+=09=09};
+=09};
+};
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+4 - References
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+[1] ARM Linux Kernel documentation - power domain bindings
+    Documentation/devicetree/bindings/power/power_domain.txt
+
+[2] ARM Linux Kernel documentation - PSCI bindings
+    Documentation/devicetree/bindings/arm/psci.txt
+
+[3] ARM Server Base System Architecture (SBSA)
+    http://infocenter.arm.com/help/index.jsp
--=20
1.8.4


