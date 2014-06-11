From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v4 1/6] Documentation: arm: define DT idle states bindings
Date: Wed, 11 Jun 2014 17:18:35 +0100
Message-ID: <1402503520-8611-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:55243 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755761AbaFKQSj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Jun 2014 12:18:39 -0400
In-Reply-To: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie@kernel.org>, Paul Walmsley <paul@pwsan.com>, Chander Kashyap <chander.kashyap@linaro.org>

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

Reviewed-by: Sebastian Capella <sebcape@gmail.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 Documentation/devicetree/bindings/arm/cpus.txt     |   8 +
 .../devicetree/bindings/arm/idle-states.txt        | 507 +++++++++++++++++=
++++
 2 files changed, 515 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/idle-states.txt

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation=
/devicetree/bindings/arm/cpus.txt
index 1fe72a0..a44d4fd 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -215,6 +215,12 @@ nodes to be present and contain the properties describ=
ed below.
 =09=09Value type: <phandle>
 =09=09Definition: Specifies the ACC[2] node associated with this CPU.
=20
+=09- cpu-idle-states
+=09=09Usage: Optional
+=09=09Value type: <prop-encoded-array>
+=09=09Definition:
+=09=09=09# List of phandles to idle state nodes supported
+=09=09=09  by this cpu [3].
=20
 Example 1 (dual-cluster big.LITTLE system 32-bit):
=20
@@ -411,3 +417,5 @@ cpus {
 --
 [1] arm/msm/qcom,saw2.txt
 [2] arm/msm/qcom,kpss-acc.txt
+[3] ARM Linux kernel documentation - idle states bindings
+    Documentation/devicetree/bindings/arm/idle-states.txt
diff --git a/Documentation/devicetree/bindings/arm/idle-states.txt b/Docume=
ntation/devicetree/bindings/arm/idle-states.txt
new file mode 100644
index 0000000..223c425
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/idle-states.txt
@@ -0,0 +1,507 @@
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
+- Running
+- Idle_standby
+- Idle_retention
+- Sleep
+- Off
+
+The power states described in the SBSA document define the basic CPU state=
s on
+top of which ARM platforms implement power management schemes that allow a=
n OS
+PM implementation to put the processor in different idle states (which inc=
lude
+states listed above; "off" state is not an idle state since it does not ha=
ve
+wake-up capabilities, hence it is not considered in this document).
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
+2 - idle-states node
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+ARM processor idle states are defined within the idle-states node, which i=
s
+a direct child of the cpus node [1] and provides a container where the
+processor idle states, defined as device tree nodes, are listed.
+
+- idle-states node
+
+=09Usage: Optional - On ARM systems, is a container of processor idle
+=09=09=09  states nodes. If the system does not provide CPU
+=09=09=09  power management capabilities or the processor just
+=09=09=09  supports idle_standby an idle-states node is not
+=09=09=09  required.
+
+=09Description: idle-states node is a container node, where its
+=09=09     subnodes describe the CPU idle states.
+
+=09Node name must be "idle-states".
+
+=09The idle-states node's parent node must be the cpus node.
+
+=09The idle-states node's child nodes can be:
+
+=09- one or more state nodes
+
+=09Any other configuration is considered invalid.
+
+=09An idle-states node defines the following properties:
+
+=09- entry-method
+=09=09Usage: Required
+=09=09Value type: <stringlist>
+=09=09Definition: Describes the method by which a CPU enters the
+=09=09=09    idle states. This property is required and must be
+=09=09=09    one of:
+
+=09=09=09    - "arm,psci"
+=09=09=09      ARM PSCI firmware interface [2].
+
+=09=09=09    - "[vendor],[method]"
+=09=09=09      An implementation dependent string with
+=09=09=09      format "vendor,method", where vendor is a string
+=09=09=09      denoting the name of the manufacturer and
+=09=09=09      method is a string specifying the mechanism
+=09=09=09      used to enter the idle state.
+
+The nodes describing the idle states (state) can only be defined within th=
e
+idle-states node, any other configuration is considered invalid and theref=
ore
+must be ignored.
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+3 - state node
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+A state node represents an idle state description and must be defined as
+follows:
+
+- state node
+
+=09Description: must be child of the idle-states node
+
+=09The state node name shall follow standard device tree naming
+=09rules ([5], 2.2.1 "Node names"), in particular state nodes which
+=09are siblings within a single common parent must be given a unique name.
+
+=09The idle state entered by executing the wfi instruction (idle_standby
+=09SBSA,[3][4]) is considered standard on all ARM platforms and therefore
+=09must not be listed.
+
+=09A state node defines the following properties:
+
+=09- compatible
+=09=09Usage: Required
+=09=09Value type: <stringlist>
+=09=09Definition: Must be "arm,idle-state".
+
+=09- logic-state-retained
+=09=09Usage: See definition
+=09=09Value type: <none>
+=09=09Definition: if present logic is retained on state entry,
+=09=09=09    otherwise it is lost.
+
+=09- cache-state-retained
+=09=09Usage: See definition
+=09=09Value type: <none>
+=09=09Definition: if present cache memory is retained on state entry,
+=09=09=09    otherwise it is lost.
+
+=09- entry-method-param
+=09=09Usage: See definition.
+=09=09Value type: <u32>
+=09=09Definition: Depends on the idle-states node entry-method
+=09=09=09    property value. Refer to the entry-method bindings
+=09=09=09    for this property value definition.
+
+=09- entry-latency-us
+=09=09Usage: Required
+=09=09Value type: <prop-encoded-array>
+=09=09Definition: u32 value representing worst case latency
+=09=09=09    in microseconds required to enter the idle state.
+
+=09- exit-latency-us
+=09=09Usage: Required
+=09=09Value type: <prop-encoded-array>
+=09=09Definition: u32 value representing worst case latency
+=09=09=09    in microseconds required to exit the idle state.
+
+=09- min-residency-us
+=09=09Usage: Required
+=09=09Value type: <prop-encoded-array>
+=09=09Definition: u32 value representing duration in microseconds
+=09=09=09    after which this state becomes more energy
+=09=09=09    efficient than any shallower states.
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+4 - Examples
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Example 1 (ARM 64-bit, 16-cpu system):
+
+cpus {
+=09#size-cells =3D <0>;
+=09#address-cells =3D <2>;
+
+=09idle-states {
+=09=09entry-method =3D "arm,psci";
+
+=09=09CPU_RETENTION_0_0: cpu-retention-0-0 {
+=09=09=09compatible =3D "arm,idle-state";
+=09=09=09cache-state-retained;
+=09=09=09entry-method-param =3D <0x0010000>;
+=09=09=09entry-latency-us =3D <20>;
+=09=09=09exit-latency-us =3D <40>;
+=09=09=09min-residency-us =3D <30>;
+=09=09};
+
+=09=09CLUSTER_RETENTION_0: cluster-retention-0 {
+=09=09=09compatible =3D "arm,idle-state";
+=09=09=09logic-state-retained;
+=09=09=09cache-state-retained;
+=09=09=09entry-method-param =3D <0x1010000>;
+=09=09=09entry-latency-us =3D <50>;
+=09=09=09exit-latency-us =3D <100>;
+=09=09=09min-residency-us =3D <250>;
+=09=09};
+
+=09=09CPU_SLEEP_0_0: cpu-sleep-0-0 {
+=09=09=09compatible =3D "arm,idle-state";
+=09=09=09entry-method-param =3D <0x0010000>;
+=09=09=09entry-latency-us =3D <250>;
+=09=09=09exit-latency-us =3D <500>;
+=09=09=09min-residency-us =3D <350>;
+=09=09};
+
+=09=09CLUSTER_SLEEP_0: cluster-sleep-0 {
+=09=09=09compatible =3D "arm,idle-state";
+=09=09=09entry-method-param =3D <0x1010000>;
+=09=09=09entry-latency-us =3D <600>;
+=09=09=09exit-latency-us =3D <1100>;
+=09=09=09min-residency-us =3D <2700>;
+=09=09};
+
+=09=09CPU_RETENTION_1_0: cpu-retention-1-0 {
+=09=09=09compatible =3D "arm,idle-state";
+=09=09=09cache-state-retained;
+=09=09=09entry-method-param =3D <0x0010000>;
+=09=09=09entry-latency-us =3D <20>;
+=09=09=09exit-latency-us =3D <40>;
+=09=09=09min-residency-us =3D <30>;
+=09=09};
+
+=09=09CLUSTER_RETENTION_1: cluster-retention-1 {
+=09=09=09compatible =3D "arm,idle-state";
+=09=09=09logic-state-retained;
+=09=09=09cache-state-retained;
+=09=09=09entry-method-param =3D <0x1010000>;
+=09=09=09entry-latency-us =3D <50>;
+=09=09=09exit-latency-us =3D <100>;
+=09=09=09min-residency-us =3D <270>;
+=09=09};
+
+=09=09CPU_SLEEP_1_0: cpu-sleep-1-0 {
+=09=09=09compatible =3D "arm,idle-state";
+=09=09=09entry-method-param =3D <0x0010000>;
+=09=09=09entry-latency-us =3D <70>;
+=09=09=09exit-latency-us =3D <100>;
+=09=09=09min-residency-us =3D <100>;
+=09=09};
+
+=09=09CLUSTER_SLEEP_1: cluster-sleep-1 {
+=09=09=09compatible =3D "arm,idle-state";
+=09=09=09entry-method-param =3D <0x1010000>;
+=09=09=09entry-latency-us =3D <500>;
+=09=09=09exit-latency-us =3D <1200>;
+=09=09=09min-residency-us =3D <3500>;
+=09=09};
+=09};
+
+=09CPU0: cpu@0 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a57";
+=09=09reg =3D <0x0 0x0>;
+=09=09enable-method =3D "psci";
+=09=09cpu-idle-states =3D <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
+=09=09=09=09   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+=09};
+
+=09CPU1: cpu@1 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a57";
+=09=09reg =3D <0x0 0x1>;
+=09=09enable-method =3D "psci";
+=09=09cpu-idle-states =3D <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
+=09=09=09=09   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+=09};
+
+=09CPU2: cpu@100 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a57";
+=09=09reg =3D <0x0 0x100>;
+=09=09enable-method =3D "psci";
+=09=09cpu-idle-states =3D <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
+=09=09=09=09   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+=09};
+
+=09CPU3: cpu@101 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a57";
+=09=09reg =3D <0x0 0x101>;
+=09=09enable-method =3D "psci";
+=09=09cpu-idle-states =3D <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
+=09=09=09=09   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+=09};
+
+=09CPU4: cpu@10000 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a57";
+=09=09reg =3D <0x0 0x10000>;
+=09=09enable-method =3D "psci";
+=09=09cpu-idle-states =3D <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
+=09=09=09=09   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+=09};
+
+=09CPU5: cpu@10001 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a57";
+=09=09reg =3D <0x0 0x10001>;
+=09=09enable-method =3D "psci";
+=09=09cpu-idle-states =3D <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
+=09=09=09=09   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+=09};
+
+=09CPU6: cpu@10100 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a57";
+=09=09reg =3D <0x0 0x10100>;
+=09=09enable-method =3D "psci";
+=09=09cpu-idle-states =3D <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
+=09=09=09=09   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+=09};
+
+=09CPU7: cpu@10101 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a57";
+=09=09reg =3D <0x0 0x10101>;
+=09=09enable-method =3D "psci";
+=09=09cpu-idle-states =3D <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
+=09=09=09=09   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+=09};
+
+=09CPU8: cpu@100000000 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a53";
+=09=09reg =3D <0x1 0x0>;
+=09=09enable-method =3D "psci";
+=09=09cpu-idle-states =3D <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
+=09=09=09=09   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+=09};
+
+=09CPU9: cpu@100000001 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a53";
+=09=09reg =3D <0x1 0x1>;
+=09=09enable-method =3D "psci";
+=09=09cpu-idle-states =3D <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
+=09=09=09=09   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+=09};
+
+=09CPU10: cpu@100000100 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a53";
+=09=09reg =3D <0x1 0x100>;
+=09=09enable-method =3D "psci";
+=09=09cpu-idle-states =3D <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
+=09=09=09=09   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+=09};
+
+=09CPU11: cpu@100000101 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a53";
+=09=09reg =3D <0x1 0x101>;
+=09=09enable-method =3D "psci";
+=09=09cpu-idle-states =3D <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
+=09=09=09=09   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+=09};
+
+=09CPU12: cpu@100010000 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a53";
+=09=09reg =3D <0x1 0x10000>;
+=09=09enable-method =3D "psci";
+=09=09cpu-idle-states =3D <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
+=09=09=09=09   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+=09};
+
+=09CPU13: cpu@100010001 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a53";
+=09=09reg =3D <0x1 0x10001>;
+=09=09enable-method =3D "psci";
+=09=09cpu-idle-states =3D <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
+=09=09=09=09   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+=09};
+
+=09CPU14: cpu@100010100 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a53";
+=09=09reg =3D <0x1 0x10100>;
+=09=09enable-method =3D "psci";
+=09=09cpu-idle-states =3D <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
+=09=09=09=09   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+=09};
+
+=09CPU15: cpu@100010101 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a53";
+=09=09reg =3D <0x1 0x10101>;
+=09=09enable-method =3D "psci";
+=09=09cpu-idle-states =3D <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
+=09=09=09=09   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+=09};
+};
+
+Example 2 (ARM 32-bit, 8-cpu system, two clusters):
+
+cpus {
+=09#size-cells =3D <0>;
+=09#address-cells =3D <1>;
+
+=09idle-states {
+=09=09entry-method =3D "arm,psci";
+
+=09=09CPU_SLEEP_0_0: cpu-sleep-0-0 {
+=09=09=09compatible =3D "arm,idle-state";
+=09=09=09entry-method-param =3D <0x0010000>;
+=09=09=09entry-latency-us =3D <400>;
+=09=09=09exit-latency-us =3D <500>;
+=09=09=09min-residency-us =3D <300>;
+=09=09};
+
+=09=09CLUSTER_SLEEP_0: cluster-sleep-0 {
+=09=09=09compatible =3D "arm,idle-state";
+=09=09=09entry-method-param =3D <0x1010000>;
+=09=09=09entry-latency-us =3D <1000>;
+=09=09=09exit-latency-us =3D <1500>;
+=09=09=09min-residency-us =3D <1500>;
+=09=09};
+
+=09=09CPU_SLEEP_1_0: cpu-sleep-1-0 {
+=09=09=09compatible =3D "arm,idle-state";
+=09=09=09entry-method-param =3D <0x0010000>;
+=09=09=09entry-latency-us =3D <300>;
+=09=09=09exit-latency-us =3D <500>;
+=09=09=09min-residency-us =3D <500>;
+=09=09};
+
+=09=09CLUSTER_SLEEP_1: cluster-sleep-1 {
+=09=09=09compatible =3D "arm,idle-state";
+=09=09=09entry-method-param =3D <0x1010000>;
+=09=09=09entry-latency-us =3D <800>;
+=09=09=09exit-latency-us =3D <2000>;
+=09=09=09min-residency-us =3D <6500>;
+=09=09};
+=09};
+
+=09CPU0: cpu@0 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a15";
+=09=09reg =3D <0x0>;
+=09=09enable-method =3D "psci";
+=09=09cpu-idle-states =3D <&CPU_SLEEP_0_0 &CLUSTER_SLEEP_0>;
+=09};
+
+=09CPU1: cpu@1 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a15";
+=09=09reg =3D <0x1>;
+=09=09enable-method =3D "psci";
+=09=09cpu-idle-states =3D <&CPU_SLEEP_0_0 &CLUSTER_SLEEP_0>;
+=09};
+
+=09CPU2: cpu@2 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a15";
+=09=09reg =3D <0x2>;
+=09=09enable-method =3D "psci";
+=09=09cpu-idle-states =3D <&CPU_SLEEP_0_0 &CLUSTER_SLEEP_0>;
+=09};
+
+=09CPU3: cpu@3 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a15";
+=09=09reg =3D <0x3>;
+=09=09enable-method =3D "psci";
+=09=09cpu-idle-states =3D <&CPU_SLEEP_0_0 &CLUSTER_SLEEP_0>;
+=09};
+
+=09CPU4: cpu@100 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a7";
+=09=09reg =3D <0x100>;
+=09=09enable-method =3D "psci";
+=09=09cpu-idle-states =3D <&CPU_SLEEP_1_0 &CLUSTER_SLEEP_1>;
+=09};
+
+=09CPU5: cpu@101 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a7";
+=09=09reg =3D <0x101>;
+=09=09enable-method =3D "psci";
+=09=09cpu-idle-states =3D <&CPU_SLEEP_1_0 &CLUSTER_SLEEP_1>;
+=09};
+
+=09CPU6: cpu@102 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a7";
+=09=09reg =3D <0x102>;
+=09=09enable-method =3D "psci";
+=09=09cpu-idle-states =3D <&CPU_SLEEP_1_0 &CLUSTER_SLEEP_1>;
+=09};
+
+=09CPU7: cpu@103 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a7";
+=09=09reg =3D <0x103>;
+=09=09enable-method =3D "psci";
+=09=09cpu-idle-states =3D <&CPU_SLEEP_1_0 &CLUSTER_SLEEP_1>;
+=09};
+};
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+4 - References
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
--=20
1.8.4


