From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH RFC v2 2/2] Documentation: arm: define DT C-states bindings
Date: Mon, 20 Jan 2014 17:47:59 +0000
Message-ID: <1390240079-6495-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1390240079-6495-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:50579 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765AbaATRrX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jan 2014 12:47:23 -0500
In-Reply-To: <1390240079-6495-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Dave Martin <dave.martin@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Grant Likely <grant.likely@linaro.org>, Kumar Gala <galak@codeaurora.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Mark Hambleton <mark.hambleton@broadcom.com>, Hanjun Guo <hanjun.guo@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Tomasz Figa <t.figa@samsung.com>, Kevin Hilman <khilman@linaro.org>

ARM based platforms implement a variety of power management schemes that
allow processors to enter at run-time low-power states, aka C-states
in ACPI jargon. The parameters defining these C-states vary on a per-platfo=
rm
basis forcing the OS to hardcode the state parameters in platform
specific static tables whose size grows as the number of platforms supporte=
d
in the kernel increases and hampers device drivers standardization.

Therefore, this patch aims at standardizing C-state device tree bindings fo=
r
ARM platforms. Bindings define C-state parameters inclusive of entry method=
s
and state latencies, to allow operating systems to retrieve the
configuration entries from the device tree and initialize the related
power management drivers, paving the way for common code in the kernel
to deal with power states and removing the need for static data in current
and previous kernel versions.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 Documentation/devicetree/bindings/arm/c-states.txt | 774 +++++++++++++++++=
++++
 Documentation/devicetree/bindings/arm/cpus.txt     |  10 +
 2 files changed, 784 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/c-states.txt

diff --git a/Documentation/devicetree/bindings/arm/c-states.txt b/Documenta=
tion/devicetree/bindings/arm/c-states.txt
new file mode 100644
index 0000000..0b5617b
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/c-states.txt
@@ -0,0 +1,774 @@
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ARM C-states binding description
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
+wfi to power gating) according to OSPM policies. Borrowing concepts
+from the ACPI specification[1], the CPU states representing the range of
+dynamic states that a processor can enter at run-time, aka C-state, can be
+specified through device tree bindings representing the parameters require=
d to
+enter/exit specific C-states on a given processor.
+
+The state an ARM CPU can be put into is loosely identified by one of the
+following operating modes:
+
+- Running:
+=09 # Processor core is executing instructions
+
+- Wait for Interrupt:
+=09# An ARM processor enters wait for interrupt (WFI) low power
+=09  state by executing a wfi instruction. When a processor enters
+=09  wfi state it disables most of the clocks while keeping the processor
+=09  powered up. This state is standard on all ARM processors and it is
+=09  defined as C1 in the remainder of this document.
+
+- Dormant:
+=09# Dormant mode is entered by executing wfi instructions and by sending
+=09  platform specific commands to the platform power controller (coupled
+=09  with processor specific SW/HW control sequences).
+=09  In dormant mode, most of the processor control and debug logic is
+=09  powered up but cache RAM can be put in retention state, providing
+=09  additional power savings.
+
+- Sleep:
+=09# Sleep mode is entered by executing the wfi instruction and by sending
+=09  platform specific commands to the platform power controller (coupled
+=09  with processor specific SW/HW control sequences). In sleep mode, a
+=09  processor and its caches are shutdown, the entire processor state is
+=09  lost.
+
+Building on top of the previous processor modes, ARM platforms implement p=
ower
+management schemes that allow an OS PM implementation to put the processor=
 in
+different CPU states (C-states). C-states parameters (eg latency) are
+platform specific and need to be characterized with bindings that provide =
the
+required information to OSPM code so that it can build the required tables=
 and
+use them at runtime.
+
+The device tree binding definition for ARM C-states is the subject of this
+document.
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+2 - cpu-power-states node
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+ARM processor C-states are defined within the cpu-power-states node, which=
 is
+a direct child of the cpus node and provides a container where the process=
or
+states, defined as device tree nodes, are listed.
+
+- cpu-power-states node
+
+=09Usage: Optional - On ARM systems, is a container of processor C-state
+=09=09=09  nodes. If the system does not provide CPU power
+=09=09=09  management capabilities or the processor just
+=09=09=09  supports WFI (C1 state) a cpu-power-states node is
+=09=09=09  not required.
+
+=09Description: cpu-power-states node is a container node, where its
+=09=09     subnodes describe the CPU low-power C-states.
+
+=09Node name must be "cpu-power-states".
+
+=09The cpu-power-states node's parent node must be cpus node.
+
+=09The cpu-power-states node's child nodes can be:
+
+=09- one or more state nodes
+
+=09Any other configuration is considered invalid.
+
+The nodes describing the C-states (state) can only be defined within the
+cpu-power-states node.
+
+Any other configuration is consider invalid and therefore must be ignored.
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+2 - state node
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+A state node represents a C-state description and must be defined as follo=
ws:
+
+- state node
+
+=09Description: must be child of either the cpu-power-states node or
+=09=09     a state node.
+
+=09The state node name shall be "stateN", where N =3D {0, 1, ...} is
+=09the node number; state nodes which are siblings within a single common
+=09parent node must be given a unique and sequential N value, starting
+=09from 0.
+
+=09A state node can contain state child nodes. Child nodes inherit
+=09properties from the parent state nodes that work as state
+=09properties aggregators (ie contain properties valid on all state
+=09nodes children).
+
+=09A state node defines the following properties (either explicitly
+=09or by inheriting them from a parent node):
+
+=09- compatible
+=09=09Usage: Required
+=09=09Value type: <stringlist>
+=09=09Definition: Must be "arm,cpu-power-state".
+
+=09- index
+=09=09Usage: Required
+=09=09Value type: <u32>
+=09=09Definition: It represents C-state index, starting from 2 (index
+=09=09=09    0 represents the processor state "running" and
+=09=09=09    index 1 represents processor mode "WFI"; indexes 0
+=09=09=09    and 1 are standard ARM states that need not be
+=09=09=09    described).
+
+=09- power-domain
+=09=09Usage: Required
+=09=09Value type: <prop-encoded-array>
+=09=09Definition: List of phandle and power domain specifiers
+=09=09=09    as defined by bindings of power controller
+=09=09=09    specified by the phandle [3]. It represents the
+=09=09=09    power domains associated with the C-state. The
+=09=09=09    power domains list can be used by OSPM to
+=09=09=09    retrieve the devices belonging to the power
+=09=09=09    domains and carry out corresponding actions to
+=09=09=09    preserve functionality across power cycles
+=09=09=09    (ie context save/restore, cache flushing).
+
+=09- entry-method
+=09=09Usage: Required
+=09=09Value type: <stringlist>
+=09=09Definition: Describes the method by which a CPU enters the
+=09=09=09    C-state. This property is required and must be one
+=09=09=09    of:
+
+=09=09=09    - "psci"
+=09=09=09      ARM Standard firmware interface
+
+=09=09=09    - "[vendor],[method]"
+=09=09=09      An implementation dependent string with
+=09=09=09      format "vendor,method", where vendor is a string
+=09=09=09      denoting the name of the manufacturer and
+=09=09=09      method is a string specifying the mechanism
+=09=09=09      used to enter the C-state.
+
+=09- psci-power-state
+=09=09Usage: Required if entry-method property value is set to
+=09=09       "psci".
+=09=09Value type: <u32>
+=09=09Definition: power_state parameter to pass to the PSCI
+=09=09=09    suspend call to enter the C-state.
+
+=09- latency
+=09=09Usage: Required
+=09=09Value type: <prop-encoded-array>
+=09=09Definition: List of u32 values representing worst case latency
+=09=09=09    in microseconds required to enter and exit the
+=09=09=09    C-state, one value per OPP [2]. The list should
+=09=09=09    be specified in the same order as the operating
+=09=09=09    points property list of the cpu this state is
+=09=09=09    valid on.
+=09=09=09    If no OPP bindings are present, the latency value
+=09=09=09    is associated with the current OPP of CPUs in the
+=09=09=09    system.
+
+=09- min-residency
+=09=09Usage: Required
+=09=09Value type: <prop-encoded-array>
+=09=09Definition: List of u32 values representing time in
+=09=09=09    microseconds required for the CPU to be in
+=09=09=09    the C-state to make up for the dynamic power
+=09=09=09    consumed to enter/exit the C-state in order to
+=09=09=09    break even in terms of power consumption compared
+=09=09=09    to C1 state (wfi), one value per-OPP [2].
+=09=09=09    This parameter depends on the operating conditions
+=09=09=09    (HW state) and must assume worst case scenario.
+=09=09=09    The list should be specified in the same order as
+=09=09=09    the operating points property list of the cpu this
+=09=09=09    state is valid on.
+=09=09=09    If no OPP bindings are present the min-residency
+=09=09=09    value is associated with the current OPP of CPUs
+=09=09=09    in the system.
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+3 - Examples
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Example 1 (ARM 64-bit, 16-cpu system, two clusters of clusters):
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
+=09cpu-power-states {
+
+=09=09state0 {
+=09=09=09compatible =3D "arm,cpu-power-state";
+=09=09=09index =3D <2>;
+=09=09=09entry-method =3D "psci";
+=09=09=09psci-power-state =3D <0x1010000>;
+=09=09=09latency =3D <400>;
+=09=09=09min-residency =3D <300>;
+=09=09=09STATE0_0: state0 {
+=09=09=09=09compatible =3D "arm,cpu-power-state";
+=09=09=09=09power-domain =3D <&pd_cores 0>;
+=09=09=09};
+=09=09=09STATE0_1: state1 {
+=09=09=09=09compatible =3D "arm,cpu-power-state";
+=09=09=09=09power-domain =3D <&pd_cores 1>;
+=09=09=09};
+=09=09=09STATE0_2: state2 {
+=09=09=09=09compatible =3D "arm,cpu-power-state";
+=09=09=09=09power-domain =3D <&pd_cores 2>;
+=09=09=09};
+=09=09=09STATE0_3: state3 {
+=09=09=09=09compatible =3D "arm,cpu-power-state";
+=09=09=09=09power-domain =3D <&pd_cores 3>;
+=09=09=09};
+=09=09=09STATE0_4: state4 {
+=09=09=09=09compatible =3D "arm,cpu-power-state";
+=09=09=09=09power-domain =3D <&pd_cores 4>;
+=09=09=09};
+=09=09=09STATE0_5: state5 {
+=09=09=09=09compatible =3D "arm,cpu-power-state";
+=09=09=09=09power-domain =3D <&pd_cores 5>;
+=09=09=09};
+=09=09=09STATE0_6: state6 {
+=09=09=09=09compatible =3D "arm,cpu-power-state";
+=09=09=09=09power-domain =3D <&pd_cores 6>;
+=09=09=09};
+=09=09=09STATE0_7: state7 {
+=09=09=09=09compatible =3D "arm,cpu-power-state";
+=09=09=09=09power-domain =3D <&pd_cores 7>;
+=09=09=09};
+=09=09};
+
+=09=09state1 {
+=09=09=09compatible =3D "arm,cpu-power-state";
+=09=09=09index =3D <2>;
+=09=09=09entry-method =3D "psci";
+=09=09=09psci-power-state =3D <0x1010000>;
+=09=09=09latency =3D <400>;
+=09=09=09min-residency =3D <500>;
+=09=09=09STATE1_0: state0 {
+=09=09=09=09compatible =3D "arm,cpu-power-state";
+=09=09=09=09power-domain =3D <&pd_cores 8>;
+=09=09=09};
+=09=09=09STATE1_1: state1 {
+=09=09=09=09compatible =3D "arm,cpu-power-state";
+=09=09=09=09power-domain =3D <&pd_cores 9>;
+=09=09=09};
+=09=09=09STATE1_2: state2 {
+=09=09=09=09compatible =3D "arm,cpu-power-state";
+=09=09=09=09power-domain =3D <&pd_cores 10>;
+=09=09=09};
+=09=09=09STATE1_3: state3 {
+=09=09=09=09compatible =3D "arm,cpu-power-state";
+=09=09=09=09power-domain =3D <&pd_cores 11>;
+=09=09=09};
+=09=09=09STATE1_4: state4 {
+=09=09=09=09compatible =3D "arm,cpu-power-state";
+=09=09=09=09power-domain =3D <&pd_cores 12>;
+=09=09=09};
+=09=09=09STATE1_5: state5 {
+=09=09=09=09compatible =3D "arm,cpu-power-state";
+=09=09=09=09power-domain =3D <&pd_cores 13>;
+=09=09=09};
+=09=09=09STATE1_6: state6 {
+=09=09=09=09compatible =3D "arm,cpu-power-state";
+=09=09=09=09power-domain =3D <&pd_cores 14>;
+=09=09=09};
+=09=09=09STATE1_7: state7 {
+=09=09=09=09compatible =3D "arm,cpu-power-state";
+=09=09=09=09power-domain =3D <&pd_cores 15>;
+=09=09=09};
+=09=09};
+
+=09=09STATE2: state2 {
+=09=09=09compatible =3D "arm,cpu-power-state";
+=09=09=09index =3D <3>;
+=09=09=09entry-method =3D "psci";
+=09=09=09psci-power-state =3D <0x3010000>;
+=09=09=09latency =3D <1000>;
+=09=09=09min-residency =3D <2500>;
+=09=09=09power-domain =3D <&pd_clusters 0>;
+=09=09};
+
+=09=09STATE3: state3 {
+=09=09=09compatible =3D "arm,cpu-power-state";
+=09=09=09index =3D <3>;
+=09=09=09entry-method =3D "psci";
+=09=09=09psci-power-state =3D <0x3010000>;
+=09=09=09latency =3D <4500>;
+=09=09=09min-residency =3D <6500>;
+=09=09=09power-domain =3D <&pd_clusters 1>;
+=09=09};
+=09};
+
+=09CPU0: cpu@0 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a57";
+=09=09reg =3D <0x0 0x0>;
+=09=09enable-method =3D "psci";
+=09=09next-level-cache =3D <&L1_0>;
+=09=09cpu-power-states =3D <&STATE0_0 &STATE2>;
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
+=09=09cpu-power-states =3D <&STATE0_1 &STATE2>;
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
+=09=09cpu-power-states =3D <&STATE0_2 &STATE2>;
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
+=09=09cpu-power-states =3D <&STATE0_3 &STATE2>;
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
+=09=09cpu-power-states =3D <&STATE0_4 &STATE2>;
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
+=09=09cpu-power-states =3D <&STATE0_5 &STATE2>;
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
+=09=09cpu-power-states =3D <&STATE0_6 &STATE2>;
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
+=09=09cpu-power-states =3D <&STATE0_7 &STATE2>;
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
+=09=09cpu-power-states =3D <&STATE1_0 &STATE3>;
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
+=09=09cpu-power-states =3D <&STATE1_1 &STATE3>;
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
+=09=09cpu-power-states =3D <&STATE1_2 &STATE3>;
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
+=09=09cpu-power-states =3D <&STATE1_3 &STATE3>;
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
+=09=09cpu-power-states =3D <&STATE1_4 &STATE3>;
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
+=09=09cpu-power-states =3D <&STATE1_5 &STATE3>;
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
+=09=09cpu-power-states =3D <&STATE1_6 &STATE3>;
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
+=09=09cpu-power-states =3D <&STATE1_7 &STATE3>;
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
+=09cpu-power-states {
+
+=09=09state0 {
+=09=09=09compatible =3D "arm,cpu-power-state";
+=09=09=09index =3D <2>;
+=09=09=09entry-method =3D "psci";
+=09=09=09psci-power-state =3D <0x1010000>;
+=09=09=09latency =3D <400>;
+=09=09=09min-residency =3D <300>;
+=09=09=09STATE0_0: state0 {
+=09=09=09=09compatible =3D "arm,cpu-power-state";
+=09=09=09=09power-domain =3D <&pd_cores 0>;
+=09=09=09};
+=09=09=09STATE0_1: state1 {
+=09=09=09=09compatible =3D "arm,cpu-power-state";
+=09=09=09=09power-domain =3D <&pd_cores 1>;
+=09=09=09};
+=09=09=09STATE0_2: state2 {
+=09=09=09=09compatible =3D "arm,cpu-power-state";
+=09=09=09=09power-domain =3D <&pd_cores 2>;
+=09=09=09};
+=09=09=09STATE0_3: state3 {
+=09=09=09=09compatible =3D "arm,cpu-power-state";
+=09=09=09=09power-domain =3D <&pd_cores 3>;
+=09=09=09};
+=09=09};
+
+=09=09state1 {
+=09=09=09compatible =3D "arm,cpu-power-state";
+=09=09=09index =3D <2>;
+=09=09=09entry-method =3D "psci";
+=09=09=09psci-power-state =3D <0x1010000>;
+=09=09=09latency =3D <400>;
+=09=09=09min-residency =3D <500>;
+=09=09=09STATE1_0: state0 {
+=09=09=09=09compatible =3D "arm,cpu-power-state";
+=09=09=09=09power-domain =3D <&pd_cores 4>;
+=09=09=09};
+=09=09=09STATE1_1: state1 {
+=09=09=09=09compatible =3D "arm,cpu-power-state";
+=09=09=09=09power-domain =3D <&pd_cores 5>;
+=09=09=09};
+=09=09=09STATE1_2: state2 {
+=09=09=09=09compatible =3D "arm,cpu-power-state";
+=09=09=09=09power-domain =3D <&pd_cores 6>;
+=09=09=09};
+=09=09=09STATE1_3: state3 {
+=09=09=09=09compatible =3D "arm,cpu-power-state";
+=09=09=09=09power-domain =3D <&pd_cores 7>;
+=09=09=09};
+=09=09};
+
+=09=09STATE2: state2 {
+=09=09=09compatible =3D "arm,cpu-power-state";
+=09=09=09index =3D <3>;
+=09=09=09entry-method =3D "psci";
+=09=09=09psci-power-state =3D <0x3010000>;
+=09=09=09latency =3D <1000>;
+=09=09=09min-residency =3D <1500>;
+=09=09=09power-domain =3D <&pd_clusters 0>;
+=09=09};
+
+=09=09STATE3: state3 {
+=09=09=09compatible =3D "arm,cpu-power-state";
+=09=09=09index =3D <3>;
+=09=09=09entry-method =3D "psci";
+=09=09=09psci-power-state =3D <0x3010000>;
+=09=09=09latency =3D <4500>;
+=09=09=09min-residency =3D <6500>;
+=09=09=09power-domain =3D <&pd_clusters 1>;
+=09=09};
+=09};
+
+=09CPU0: cpu@0 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a15";
+=09=09reg =3D <0x0>;
+=09=09next-level-cache =3D <&L1_0>;
+=09=09cpu-power-states =3D <&STATE0_0 &STATE2>;
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
+=09=09cpu-power-states =3D <&STATE0_1 &STATE2>;
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
+=09=09cpu-power-states =3D <&STATE0_2 &STATE2>;
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
+=09=09cpu-power-states =3D <&STATE0_3 &STATE2>;
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
+=09=09cpu-power-states =3D <&STATE1_0 &STATE3>;
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
+=09=09cpu-power-states =3D <&STATE1_1 &STATE3>;
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
+=09=09cpu-power-states =3D <&STATE1_2 &STATE3>;
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
+=09=09cpu-power-states =3D <&STATE1_3 &STATE3>;
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
+[1] ACPI v5.0 specification
+    http://www.acpi.info/spec50.htm
+
+[2] ARM Linux kernel documentation - OPP bindings
+    Documentation/devicetree/bindings/power/opp.txt
+
+[3] ARM Linux Kernel documentation - power domain bindings
+    Documentation/devicetree/bindings/power/power_domain.txt
diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation=
/devicetree/bindings/arm/cpus.txt
index 9130435..a3c9193 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -191,6 +191,13 @@ nodes to be present and contain the properties describ=
ed below.
 =09=09=09  property identifying a 64-bit zero-initialised
 =09=09=09  memory location.
=20
+=09- cpu-power-states
+=09=09Usage: Optional
+=09=09Value type: <prop-encoded-array>
+=09=09Definition:
+=09=09=09# List of phandles to cpu power state nodes supported
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
+[1] ARM Linux kernel documentation - C-state bindings
+    Documentation/devicetree/bindings/arm/c-states.txt
--=20
1.8.4


