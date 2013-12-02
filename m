From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH RFC 2/2] Documentation: arm: define DT C-states bindings
Date: Mon,  2 Dec 2013 16:20:05 +0000
Message-ID: <1386001205-11978-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1386001205-11978-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:53938 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804Ab3LBQUI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Dec 2013 11:20:08 -0500
In-Reply-To: <1386001205-11978-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Dave Martin <dave.martin@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Grant Likely <grant.likely@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Mark Hambleton <mark.hambleton@broadcom.com>, Hanjun Guo <hanjun.guo@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>

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
 Documentation/devicetree/bindings/arm/c-states.txt | 830 +++++++++++++++++=
++++
 1 file changed, 830 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/c-states.txt

diff --git a/Documentation/devicetree/bindings/arm/c-states.txt b/Documenta=
tion/devicetree/bindings/arm/c-states.txt
new file mode 100644
index 0000000..f568417
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/c-states.txt
@@ -0,0 +1,830 @@
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
+=09The cpu-power-states node must contain the following properties:
+
+=09- compatible
+=09=09Value type: <stringlist>
+=09=09Usage: Required
+=09=09Definition: Must be "arm,cpu-power-states".
+
+=09- #address-cells
+=09=09Usage: Required
+=09=09Value type: <u32>
+=09=09Definition: must be set to 1.
+
+=09- #size-cells
+=09=09Usage: Required
+=09=09Value type: <u32>
+=09=09Definition: must be set to 0.
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
+=09Description: must be child of the cpu-power-states node.
+
+=09The state node name must be "state", with unit address provided by the
+=09"reg" property following standard DT requirements[4].
+
+=09A state node defines the following properties:
+
+=09- reg
+=09=09Usage: Required
+=09=09Value type: <u32>
+=09=09Definition: Standard device tree property [4] used for
+=09=09=09    enumeration purposes.
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
+=09- entry-method
+=09=09Value type: <stringlist>
+=09=09Usage: Required
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
+=09=09Value type: <u32>
+=09=09Definition: Worst case latency in microseconds required to
+=09=09=09    enter and exit the C-state.
+
+=09- min-residency
+=09=09Usage: Required
+=09=09Value type: <u32>
+=09=09Definition: Time in microseconds required for the CPU to be in
+=09=09=09    the C-state to make up for the dynamic power
+=09=09=09    consumed to enter/exit the C-state in order to
+=09=09=09    break even in terms of power consumption compared
+=09=09=09    to C1 state (wfi).
+=09=09=09    This parameter depends on the operating conditions
+=09=09=09    (operating point, cache state) and must assume
+=09=09=09    worst case scenario.
+
+=09- cpus
+=09=09Usage: Optional
+=09=09Value type: <phandle>
+=09=09Definition: If defined, the phandle points to a node in the
+=09=09=09    cpu-map[2] representing all CPUs on which C-state
+=09=09=09    is valid. If not present or system is UP, the
+=09=09=09    C-state has to be considered valid for all CPUs in
+=09=09=09    the system.
+
+=09- affinity
+=09=09Usage: Optional
+=09=09Value type: <phandle>
+=09=09Definition: If defined, phandle points to a node in the
+=09=09=09    cpu-map[2] that represents all CPUs that are
+=09=09=09    affected (ie share) by the C-state and have to
+=09=09=09    be coordinated on C-state entry/exit. If not
+=09=09=09    present or system is UP, the C-state is local to
+=09=09=09    a CPU and need no coordination (ie it is a CPU
+=09=09=09    state, that does not require coordination with
+=09=09=09    other CPUs). If present, the affinity property
+=09=09=09    must contain a phandle to a cpu-map node that
+=09=09=09    represents a subset, possibly inclusive of the
+=09=09=09    CPUs described through the cpus property.
+
+=09- power-depth
+=09=09Usage: Required
+=09=09Value type: <u32>
+=09=09Definition: Integer value, starting from 2 (value 0 meaning
+=09=09=09    running and value 1 representing power depth of
+=09=09=09    wfi (C1)), that defines the level of depth of a
+=09=09=09    power state.
+=09=09=09    The system denotes power states with different
+=09=09=09    depths, an increasing value meaning less power
+=09=09=09    consumption and might involve powering down more
+=09=09=09    components.  Devices that are affected by
+=09=09=09    C-states entry must define the maximum power
+=09=09=09    depth supported in their respective device tree
+=09=09=09    bindings so that OSPM can take decision on how
+=09=09=09    to handle the device in question when the C-state
+=09=09=09    is entered. All devices (per-CPU or external) with
+=09=09=09    a power depth lower than the one defined in the
+=09=09=09    C-state entry stop operating when the C-state
+=09=09=09    is entered and action is required by OSPM to
+=09=09=09    guarantee their logic and memory content is saved
+=09=09=09    restored to guarantee proper functioning.
+
+=09- cache-level-lost:
+=09=09Usage: Required if "entry-method" differs from "psci".
+=09=09Value type: <u32>
+=09=09Definition: An integer value representing the uppermost cache
+=09=09=09    level (inclusive) that is lost upon state entry.
+=09=09=09    This property requires the definition of cache
+=09=09=09    nodes as specified in [3]. Cache levels that are
+=09=09=09    shared between processors, according to [3], should
+=09=09=09    coordinate cache cleaning and invalidation to
+=09=09=09    maximize performance (ie a shared cache level
+=09=09=09    must be cleaned only if all CPUs sharing the
+=09=09=09    cache entered the state). If missing, cache
+=09=09=09    state has to be considered retained.
+
+=09- processor-state-retained:
+=09=09Usage: See definition
+=09=09Value type: <none>
+=09=09Definition: if present CPU processor logic is retained on
+=09=09=09    power down, otherwise it is lost.
+
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+3 - Examples
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Example 1 (ARM 64-bit, 16-cpu system, two clusters of clusters):
+
+cpus {
+=09#size-cells =3D <0>;
+=09#address-cells =3D <2>;
+
+=09cpu-map {
+=09=09CLUSTER0: cluster0 {
+=09=09=09CLUSTER2: cluster0 {
+=09=09=09=09core0 {
+=09=09=09=09=09thread0 {
+=09=09=09=09=09=09cpu =3D <&CPU0>;
+=09=09=09=09=09};
+=09=09=09=09=09thread1 {
+=09=09=09=09=09=09cpu =3D <&CPU1>;
+=09=09=09=09=09};
+=09=09=09=09};
+
+=09=09=09=09core1 {
+=09=09=09=09=09thread0 {
+=09=09=09=09=09=09cpu =3D <&CPU2>;
+=09=09=09=09=09};
+=09=09=09=09=09thread1 {
+=09=09=09=09=09=09cpu =3D <&CPU3>;
+=09=09=09=09=09};
+=09=09=09=09};
+=09=09=09};
+
+=09=09=09CLUSTER3: cluster1 {
+=09=09=09=09core0 {
+=09=09=09=09=09thread0 {
+=09=09=09=09=09=09cpu =3D <&CPU4>;
+=09=09=09=09=09};
+=09=09=09=09=09thread1 {
+=09=09=09=09=09=09cpu =3D <&CPU5>;
+=09=09=09=09=09};
+=09=09=09=09};
+
+=09=09=09=09core1 {
+=09=09=09=09=09thread0 {
+=09=09=09=09=09=09cpu =3D <&CPU6>;
+=09=09=09=09=09};
+=09=09=09=09=09thread1 {
+=09=09=09=09=09=09cpu =3D <&CPU7>;
+=09=09=09=09=09};
+=09=09=09=09};
+=09=09=09};
+=09=09};
+
+=09=09CLUSTER1: cluster1 {
+=09=09=09CLUSTER4: cluster0 {
+=09=09=09=09core0 {
+=09=09=09=09=09thread0 {
+=09=09=09=09=09=09cpu =3D <&CPU8>;
+=09=09=09=09=09};
+=09=09=09=09=09thread1 {
+=09=09=09=09=09=09cpu =3D <&CPU9>;
+=09=09=09=09=09};
+=09=09=09=09};
+=09=09=09=09core1 {
+=09=09=09=09=09thread0 {
+=09=09=09=09=09=09cpu =3D <&CPU10>;
+=09=09=09=09=09};
+=09=09=09=09=09thread1 {
+=09=09=09=09=09=09cpu =3D <&CPU11>;
+=09=09=09=09=09};
+=09=09=09=09};
+=09=09=09};
+
+=09=09=09CLUSTER5: cluster1 {
+=09=09=09=09core0 {
+=09=09=09=09=09thread0 {
+=09=09=09=09=09=09cpu =3D <&CPU12>;
+=09=09=09=09=09};
+=09=09=09=09=09thread1 {
+=09=09=09=09=09=09cpu =3D <&CPU13>;
+=09=09=09=09=09};
+=09=09=09=09};
+=09=09=09=09core1 {
+=09=09=09=09=09thread0 {
+=09=09=09=09=09=09cpu =3D <&CPU14>;
+=09=09=09=09=09};
+=09=09=09=09=09thread1 {
+=09=09=09=09=09=09cpu =3D <&CPU15>;
+=09=09=09=09=09};
+=09=09=09=09};
+=09=09=09};
+=09=09};
+=09};
+
+=09cpu-power-states {
+=09=09compatible =3D "arm,cpu-power-states";
+=09=09#size-cells =3D <0>;
+=09=09#address-cells =3D <1>;
+
+=09=09state@0 {
+=09=09=09reg =3D <0>;
+=09=09=09index =3D <2>;
+=09=09=09entry-method =3D "psci";
+=09=09=09psci-power-state =3D <0x1010000>;
+=09=09=09latency =3D <400>;
+=09=09=09min-residency =3D <300>;
+=09=09=09power-depth =3D <2>;
+=09=09=09cache-level-lost =3D <1>;
+=09=09=09cpus =3D <&CLUSTER0>;
+=09=09};
+
+=09=09state@1 {
+=09=09=09reg =3D <1>;
+=09=09=09index =3D <2>;
+=09=09=09entry-method =3D "psci";
+=09=09=09psci-power-state =3D <0x1010000>;
+=09=09=09latency =3D <400>;
+=09=09=09min-residency =3D <500>;
+=09=09=09power-depth =3D <2>;
+=09=09=09cache-level-lost =3D <1>;
+=09=09=09cpus =3D <&CLUSTER1>;
+=09=09};
+
+=09=09state@2 {
+=09=09=09reg =3D <2>;
+=09=09=09index =3D <3>;
+=09=09=09entry-method =3D "psci";
+=09=09=09psci-power-state =3D <0x3010000>;
+=09=09=09latency =3D <1000>;
+=09=09=09power-depth =3D <4>;
+=09=09=09cache-level-lost =3D <2>;
+=09=09=09cpus =3D <&CLUSTER0>;
+=09=09=09affinity =3D <&CLUSTER0>;
+=09=09};
+
+=09=09state@3 {
+=09=09=09reg =3D <3>;
+=09=09=09index =3D <3>;
+=09=09=09entry-method =3D "psci";
+=09=09=09latency =3D <4500>;
+=09=09=09min-residency =3D <6500>;
+=09=09=09psci-power-state =3D <0x3010000>;
+=09=09=09power-depth =3D <4>;
+=09=09=09cache-level-lost =3D <2>;
+=09=09=09cpus =3D <&CLUSTER1>;
+=09=09=09affinity =3D <&CLUSTER1>;
+=09=09};
+=09};
+
+=09CPU0: cpu@0 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a57";
+=09=09reg =3D <0x0 0x0>;
+=09=09enable-method =3D "psci";
+=09=09next-cache-level =3D <&L1_0>;
+=09=09L1_0: l1-cache {
+=09=09=09compatible =3D "cache";
+=09=09=09cache-level =3D <1>;
+=09=09=09next-cache-level =3D <&L2_0>;
+=09=09};
+=09=09L2_0: l2-cache {
+=09=09=09compatible =3D "cache";
+=09=09=09cache-level =3D <2>;
+=09=09};
+=09};
+
+=09CPU1: cpu@1 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a57";
+=09=09reg =3D <0x0 0x1>;
+=09=09enable-method =3D "psci";
+=09=09next-cache-level =3D <&L1_1>;
+=09=09L1_1: l1-cache {
+=09=09=09compatible =3D "cache";
+=09=09=09cache-level =3D <1>;
+=09=09=09next-cache-level =3D <&L2_0>;
+=09=09};
+=09};
+
+=09CPU2: cpu@100 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a57";
+=09=09reg =3D <0x0 0x100>;
+=09=09enable-method =3D "psci";
+=09=09next-cache-level =3D <&L1_2>;
+=09=09L1_2: l1-cache {
+=09=09=09compatible =3D "cache";
+=09=09=09cache-level =3D <1>;
+=09=09=09next-cache-level =3D <&L2_0>;
+=09=09};
+=09};
+
+=09CPU3: cpu@101 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a57";
+=09=09reg =3D <0x0 0x101>;
+=09=09enable-method =3D "psci";
+=09=09next-cache-level =3D <&L1_3>;
+=09=09L1_3: l1-cache {
+=09=09=09compatible =3D "cache";
+=09=09=09cache-level =3D <1>;
+=09=09=09next-cache-level =3D <&L2_0>;
+=09=09};
+=09};
+
+=09CPU4: cpu@10000 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a57";
+=09=09reg =3D <0x0 0x10000>;
+=09=09enable-method =3D "psci";
+=09=09next-cache-level =3D <&L1_4>;
+=09=09L1_4: l1-cache {
+=09=09=09compatible =3D "cache";
+=09=09=09cache-level =3D <1>;
+=09=09=09next-cache-level =3D <&L2_0>;
+=09=09};
+=09};
+
+=09CPU5: cpu@10001 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a57";
+=09=09reg =3D <0x0 0x10001>;
+=09=09enable-method =3D "psci";
+=09=09next-cache-level =3D <&L1_5>;
+=09=09L1_5: l1-cache {
+=09=09=09compatible =3D "cache";
+=09=09=09cache-level =3D <1>;
+=09=09=09next-cache-level =3D <&L2_0>;
+=09=09};
+=09};
+
+=09CPU6: cpu@10100 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a57";
+=09=09reg =3D <0x0 0x10100>;
+=09=09enable-method =3D "psci";
+=09=09next-cache-level =3D <&L1_6>;
+=09=09L1_6: l1-cache {
+=09=09=09compatible =3D "cache";
+=09=09=09cache-level =3D <1>;
+=09=09=09next-cache-level =3D <&L2_0>;
+=09=09};
+=09};
+
+=09CPU7: cpu@10101 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a57";
+=09=09reg =3D <0x0 0x10101>;
+=09=09enable-method =3D "psci";
+=09=09next-cache-level =3D <&L1_7>;
+=09=09L1_7: l1-cache {
+=09=09=09compatible =3D "cache";
+=09=09=09cache-level =3D <1>;
+=09=09=09next-cache-level =3D <&L2_0>;
+=09=09};
+=09};
+
+=09CPU8: cpu@100000000 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a53";
+=09=09reg =3D <0x1 0x0>;
+=09=09enable-method =3D "psci";
+=09=09next-cache-level =3D <&L1_8>;
+=09=09L1_8: l1-cache {
+=09=09=09compatible =3D "cache";
+=09=09=09cache-level =3D <1>;
+=09=09=09next-cache-level =3D <&L2_1>;
+=09=09};
+=09=09L2_1: l2-cache {
+=09=09=09compatible =3D "cache";
+=09=09=09cache-level =3D <2>;
+=09=09};
+=09};
+
+=09CPU9: cpu@100000001 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a53";
+=09=09reg =3D <0x1 0x1>;
+=09=09enable-method =3D "psci";
+=09=09next-cache-level =3D <&L1_9>;
+=09=09L1_9: l1-cache {
+=09=09=09compatible =3D "cache";
+=09=09=09cache-level =3D <1>;
+=09=09=09next-cache-level =3D <&L2_1>;
+=09=09};
+=09};
+
+=09CPU10: cpu@100000100 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a53";
+=09=09reg =3D <0x1 0x100>;
+=09=09enable-method =3D "psci";
+=09=09next-cache-level =3D <&L1_10>;
+=09=09L1_10: l1-cache {
+=09=09=09compatible =3D "cache";
+=09=09=09cache-level =3D <1>;
+=09=09=09next-cache-level =3D <&L2_1>;
+=09=09};
+=09};
+
+=09CPU11: cpu@100000101 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a53";
+=09=09reg =3D <0x1 0x101>;
+=09=09enable-method =3D "psci";
+=09=09next-cache-level =3D <&L1_11>;
+=09=09L1_11: l1-cache {
+=09=09=09compatible =3D "cache";
+=09=09=09cache-level =3D <1>;
+=09=09=09next-cache-level =3D <&L2_1>;
+=09=09};
+=09};
+
+=09CPU12: cpu@100010000 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a53";
+=09=09reg =3D <0x1 0x10000>;
+=09=09enable-method =3D "psci";
+=09=09next-cache-level =3D <&L1_12>;
+=09=09L1_12: l1-cache {
+=09=09=09compatible =3D "cache";
+=09=09=09cache-level =3D <1>;
+=09=09=09next-cache-level =3D <&L2_1>;
+=09=09};
+=09};
+
+=09CPU13: cpu@100010001 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a53";
+=09=09reg =3D <0x1 0x10001>;
+=09=09enable-method =3D "psci";
+=09=09next-cache-level =3D <&L1_13>;
+=09=09L1_13: l1-cache {
+=09=09=09compatible =3D "cache";
+=09=09=09cache-level =3D <1>;
+=09=09=09next-cache-level =3D <&L2_1>;
+=09=09};
+=09};
+
+=09CPU14: cpu@100010100 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a53";
+=09=09reg =3D <0x1 0x10100>;
+=09=09enable-method =3D "psci";
+=09=09next-cache-level =3D <&L1_14>;
+=09=09L1_14: l1-cache {
+=09=09=09compatible =3D "cache";
+=09=09=09cache-level =3D <1>;
+=09=09=09next-cache-level =3D <&L2_1>;
+=09=09};
+=09};
+
+=09CPU15: cpu@100010101 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a53";
+=09=09reg =3D <0x1 0x10101>;
+=09=09enable-method =3D "psci";
+=09=09next-cache-level =3D <&L1_15>;
+=09=09L1_15: l1-cache {
+=09=09=09compatible =3D "cache";
+=09=09=09cache-level =3D <1>;
+=09=09=09next-cache-level =3D <&L2_1>;
+=09=09};
+=09};
+};
+
+Example 2 (ARM 32-bit, 8-cpu system, two clusters):
+
+cpus {
+=09#size-cells =3D <0>;
+=09#address-cells =3D <1>;
+
+=09cpu-map {
+=09=09CLUSTER0: cluster0 {
+=09=09=09core0 {
+=09=09=09=09thread0 {
+=09=09=09=09=09cpu =3D <&CPU0>;
+=09=09=09=09};
+=09=09=09=09thread1 {
+=09=09=09=09=09cpu =3D <&CPU1>;
+=09=09=09=09};
+=09=09=09};
+
+=09=09=09core1 {
+=09=09=09=09thread0 {
+=09=09=09=09=09cpu =3D <&CPU2>;
+=09=09=09=09};
+=09=09=09=09thread1 {
+=09=09=09=09=09cpu =3D <&CPU3>;
+=09=09=09=09};
+=09=09=09};
+=09=09};
+
+=09=09CLUSTER1: cluster1 {
+=09=09=09core0 {
+=09=09=09=09thread0 {
+=09=09=09=09=09cpu =3D <&CPU4>;
+=09=09=09=09};
+=09=09=09=09thread1 {
+=09=09=09=09=09cpu =3D <&CPU5>;
+=09=09=09=09};
+=09=09=09};
+
+=09=09=09core1 {
+=09=09=09=09thread0 {
+=09=09=09=09=09cpu =3D <&CPU6>;
+=09=09=09=09};
+=09=09=09=09thread1 {
+=09=09=09=09=09cpu =3D <&CPU7>;
+=09=09=09=09};
+=09=09=09};
+=09=09};
+=09};
+
+=09cpu-power-states {
+=09=09compatible =3D "arm,cpu-power-states";
+=09=09#size-cells =3D <0>;
+=09=09#address-cells =3D <1>;
+
+=09=09state@0 {
+=09=09=09reg =3D <0>;
+=09=09=09index =3D <2>;
+=09=09=09entry-method =3D "psci";
+=09=09=09psci-power-state =3D <0x1010000>;
+=09=09=09latency =3D <400>;
+=09=09=09min-residency =3D <300>;
+=09=09=09power-depth =3D <2>;
+=09=09=09cpus =3D <&CLUSTER0>;
+=09=09};
+
+=09=09state@1 {
+=09=09=09reg =3D <1>;
+=09=09=09index =3D <2>;
+=09=09=09entry-method =3D "psci";
+=09=09=09psci-power-state =3D <0x1010000>;
+=09=09=09latency =3D <400>;
+=09=09=09min-residency =3D <500>;
+=09=09=09power-depth =3D <2>;
+=09=09=09cpus =3D <&CLUSTER1>;
+=09=09};
+
+=09=09state@2 {
+=09=09=09reg =3D <2>;
+=09=09=09index =3D <3>;
+=09=09=09entry-method =3D "psci";
+=09=09=09psci-power-state =3D <0x2010000>;
+=09=09=09latency =3D <3000>;
+=09=09=09min-residency =3D <3000>;
+=09=09=09cache-level-lost =3D <2>;
+=09=09=09power-depth =3D <3>;
+=09=09=09cpus =3D <&CLUSTER0>;
+=09=09=09affinity =3D <&CLUSTER0>;
+=09=09};
+
+=09=09state@3 {
+=09=09=09reg =3D <3>;
+=09=09=09index =3D <3>;
+=09=09=09entry-method =3D "psci";
+=09=09=09psci-power-state =3D <0x2010000>;
+=09=09=09latency =3D <4000>;
+=09=09=09min-residency =3D <5000>;
+=09=09=09cache-level-lost =3D <2>;
+=09=09=09power-depth =3D <3>;
+=09=09=09cpus =3D <&CLUSTER1>;
+=09=09=09affinity =3D <&CLUSTER1>;
+=09=09};
+=09};
+
+=09CPU0: cpu@0 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a15";
+=09=09reg =3D <0x0>;
+=09=09next-cache-level =3D <&L1_0>;
+=09=09L1_0: l1-cache {
+=09=09=09compatible =3D "cache";
+=09=09=09cache-level =3D <1>;
+=09=09};
+=09=09L2_0: l2-cache {
+=09=09=09compatible =3D "cache";
+=09=09=09cache-level =3D <2>;
+=09=09};
+=09};
+
+=09CPU1: cpu@1 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a15";
+=09=09reg =3D <0x1>;
+=09=09next-cache-level =3D <&L1_1>;
+=09=09L1_1: l1-cache {
+=09=09=09compatible =3D "cache";
+=09=09=09cache-level =3D <1>;
+=09=09=09next-cache-level =3D <&L2_0>;
+=09=09};
+=09};
+
+=09CPU2: cpu@2 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a15";
+=09=09reg =3D <0x2>;
+=09=09next-cache-level =3D <&L1_2>;
+=09=09L1_2: l1-cache {
+=09=09=09compatible =3D "cache";
+=09=09=09cache-level =3D <1>;
+=09=09=09next-cache-level =3D <&L2_0>;
+=09=09};
+=09};
+
+=09CPU3: cpu@3 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a15";
+=09=09reg =3D <0x3>;
+=09=09next-cache-level =3D <&L1_3>;
+=09=09L1_3: l1-cache {
+=09=09=09compatible =3D "cache";
+=09=09=09cache-level =3D <1>;
+=09=09=09next-cache-level =3D <&L2_0>;
+=09=09};
+=09};
+
+=09CPU4: cpu@100 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a7";
+=09=09reg =3D <0x100>;
+=09=09next-cache-level =3D <&L1_4>;
+=09=09L1_4: l1-cache {
+=09=09=09compatible =3D "cache";
+=09=09=09cache-level =3D <1>;
+=09=09};
+=09=09L2_1: l2-cache {
+=09=09=09compatible =3D "cache";
+=09=09=09cache-level =3D <2>;
+=09=09};
+=09};
+
+=09CPU5: cpu@101 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a7";
+=09=09reg =3D <0x101>;
+=09=09next-cache-level =3D <&L1_5>;
+=09=09L1_5: l1-cache {
+=09=09=09compatible =3D "cache";
+=09=09=09cache-level =3D <1>;
+=09=09=09next-cache-level =3D <&L2_1>;
+=09=09};
+=09};
+
+=09CPU6: cpu@102 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a7";
+=09=09reg =3D <0x102>;
+=09=09next-cache-level =3D <&L1_6>;
+=09=09L1_6: l1-cache {
+=09=09=09compatible =3D "cache";
+=09=09=09cache-level =3D <1>;
+=09=09=09next-cache-level =3D <&L2_1>;
+=09=09};
+=09};
+
+=09CPU7: cpu@103 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a7";
+=09=09reg =3D <0x103>;
+=09=09next-cache-level =3D <&L1_7>;
+=09=09L1_7: l1-cache {
+=09=09=09compatible =3D "cache";
+=09=09=09cache-level =3D <1>;
+=09=09=09next-cache-level =3D <&L2_1>;
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
+[2] ARM Linux kernel documentation - topology bindings
+    Documentation/devicetree/bindings/arm/topology.txt
+
+[3] ARM Linux kernel documentation - cache bindings
+    Documentation/devicetree/bindings/arm/cache.txt
+
+[4] ePAPR standard
+    https://www.power.org/documentation/epapr-version-1-1/
--=20
1.8.4


