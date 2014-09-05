From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v9 1/8] Documentation: arm: define DT idle states bindings
Date: Fri,  5 Sep 2014 18:34:50 +0100
Message-ID: <1409938498-17984-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1409938498-17984-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:54376 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754213AbaIERex (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Sep 2014 13:34:53 -0400
In-Reply-To: <1409938498-17984-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Mark Brown <broonie@kernel.org>, Paul Walmsley <paul@pwsan.com>, Chander Kashyap <k.chander@samsung.com>, Geoff

ARM based platforms implement a variety of power management schemes that
allow processors to enter idle states at run-time.
The parameters defining these idle states vary on a per-platform basis forc=
ing
the OS to hardcode the state parameters in platform specific static tables
whose size grows as the number of platforms supported in the kernel increas=
es
and hampers device drivers standardization.

Therefore, this patch aims at standardizing idle state device tree bindings
for ARM platforms. Bindings define idle state parameters inclusive of entry
methods and state latencies, to allow operating systems to retrieve the
configuration entries from the device tree and initialize the related power
management drivers, paving the way for common code in the kernel to deal wi=
th
idle states and removing the need for static data in current and previous
kernel versions.

ARM64 platforms require the DT to define an entry-method property
for idle states.

On system implementing PSCI as an enable-method to enter low-power
states the PSCI CPU suspend method requires the power_state parameter to
be passed to the PSCI CPU suspend function.

This parameter is specific to a power state and platform specific,
therefore must be provided by firmware to the OS in order to enable
proper call sequence.

Thus, this patch also adds a property in the PSCI bindings that
describes how the PSCI CPU suspend power_state parameter should be
defined in DT in all device nodes that rely on PSCI CPU suspend method usag=
e.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Nicolas Pitre <nico@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Sebastian Capella <sebcape@gmail.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 Documentation/devicetree/bindings/arm/cpus.txt     |   8 +
 .../devicetree/bindings/arm/idle-states.txt        | 679 +++++++++++++++++=
++++
 Documentation/devicetree/bindings/arm/psci.txt     |  14 +-
 3 files changed, 700 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/idle-states.txt

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation=
/devicetree/bindings/arm/cpus.txt
index 298e2f6..6fd0f15 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -219,6 +219,12 @@ nodes to be present and contain the properties describ=
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
@@ -415,3 +421,5 @@ cpus {
 --
 [1] arm/msm/qcom,saw2.txt
 [2] arm/msm/qcom,kpss-acc.txt
+[3] ARM Linux kernel documentation - idle states bindings
+    Documentation/devicetree/bindings/arm/idle-states.txt
diff --git a/Documentation/devicetree/bindings/arm/idle-states.txt b/Docume=
ntation/devicetree/bindings/arm/idle-states.txt
new file mode 100644
index 0000000..37375c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/idle-states.txt
@@ -0,0 +1,679 @@
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
+wfi to power gating) according to OS PM policies. The CPU states represent=
ing
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
+characterized with bindings that provide the required information to OS PM
+code so that it can build the required tables and use them at runtime.
+
+The device tree binding definition for ARM idle states is the subject of t=
his
+document.
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+2 - idle-states definitions
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Idle states are characterized for a specific system through a set of
+timing and energy related properties, that underline the HW behaviour
+triggered upon idle states entry and exit.
+
+The following diagram depicts the CPU execution phases and related timing
+properties required to enter and exit an idle state:
+
+..__[EXEC]__|__[PREP]__|__[ENTRY]__|__[IDLE]__|__[EXIT]__|__[EXEC]__..
+=09    |          |           |          |          |
+
+=09    |<------ entry ------->|
+=09    |       latency        |
+=09=09=09=09=09      |<- exit ->|
+=09=09=09=09=09      |  latency |
+=09    |<-------- min-residency -------->|
+=09=09       |<-------  wakeup-latency ------->|
+
+=09=09Diagram 1: CPU idle state execution phases
+
+EXEC:=09Normal CPU execution.
+
+PREP:=09Preparation phase before committing the hardware to idle mode
+=09like cache flushing. This is abortable on pending wake-up
+=09event conditions. The abort latency is assumed to be negligible
+=09(i.e. less than the ENTRY + EXIT duration). If aborted, CPU
+=09goes back to EXEC. This phase is optional. If not abortable,
+=09this should be included in the ENTRY phase instead.
+
+ENTRY:=09The hardware is committed to idle mode. This period must run
+=09to completion up to IDLE before anything else can happen.
+
+IDLE:=09This is the actual energy-saving idle period. This may last
+=09between 0 and infinite time, until a wake-up event occurs.
+
+EXIT:=09Period during which the CPU is brought back to operational
+=09mode (EXEC).
+
+entry-latency: Worst case latency required to enter the idle state. The
+exit-latency may be guaranteed only after entry-latency has passed.
+
+min-residency: Minimum period, including preparation and entry, for a give=
n
+idle state to be worthwhile energywise.
+
+wakeup-latency: Maximum delay between the signaling of a wake-up event and=
 the
+CPU being able to execute normal code again. If not specified, this is ass=
umed
+to be entry-latency + exit-latency.
+
+These timing parameters can be used by an OS in different circumstances.
+
+An idle CPU requires the expected min-residency time to select the most
+appropriate idle state based on the expected expiry time of the next IRQ
+(ie wake-up) that causes the CPU to return to the EXEC phase.
+
+An operating system scheduler may need to compute the shortest wake-up del=
ay
+for CPUs in the system by detecting how long will it take to get a CPU out
+of an idle state, eg:
+
+wakeup-delay =3D exit-latency + max(entry-latency - (now - entry-timestamp=
), 0)
+
+In other words, the scheduler can make its scheduling decision by selectin=
g
+(eg waking-up) the CPU with the shortest wake-up latency.
+The wake-up latency must take into account the entry latency if that perio=
d
+has not expired. The abortable nature of the PREP period can be ignored
+if it cannot be relied upon (e.g. the PREP deadline may occur much sooner =
than
+the worst case since it depends on the CPU operating conditions, ie caches
+state).
+
+An OS has to reliably probe the wakeup-latency since some devices can enfo=
rce
+latency constraints guarantees to work properly, so the OS has to detect t=
he
+worst case wake-up latency it can incur if a CPU is allowed to enter an
+idle state, and possibly to prevent that to guarantee reliable device
+functioning.
+
+The min-residency time parameter deserves further explanation since it is
+expressed in time units but must factor in energy consumption coefficients=
.
+
+The energy consumption of a cpu when it enters a power state can be roughl=
y
+characterised by the following graph:
+
+               |
+               |
+               |
+           e   |
+           n   |                                      /---
+           e   |                               /------
+           r   |                        /------
+           g   |                  /-----
+           y   |           /------
+               |       ----
+               |      /|
+               |     / |
+               |    /  |
+               |   /   |
+               |  /    |
+               | /     |
+               |/      |
+          -----|-------+----------------------------------
+              0|       1                              time(ms)
+
+=09=09Graph 1: Energy vs time example
+
+The graph is split in two parts delimited by time 1ms on the X-axis.
+The graph curve with X-axis values =3D { x | 0 < x < 1ms } has a steep slo=
pe
+and denotes the energy costs incurred whilst entering and leaving the idle
+state.
+The graph curve in the area delimited by X-axis values =3D {x | x > 1ms } =
has
+shallower slope and essentially represents the energy consumption of the i=
dle
+state.
+
+min-residency is defined for a given idle state as the minimum expected
+residency time for a state (inclusive of preparation and entry) after
+which choosing that state become the most energy efficient option. A good
+way to visualise this, is by taking the same graph above and comparing som=
e
+states energy consumptions plots.
+
+For sake of simplicity, let's consider a system with two idle states IDLE1=
,
+and IDLE2:
+
+          |
+          |
+          |
+          |                                                  /-- IDLE1
+       e  |                                              /---
+       n  |                                         /----
+       e  |                                     /---
+       r  |                                /-----/--------- IDLE2
+       g  |                    /-------/---------
+       y  |        ------------    /---|
+          |       /           /----    |
+          |      /        /---         |
+          |     /    /----             |
+          |    / /---                  |
+          |   ---                      |
+          |  /                         |
+          | /                          |
+          |/                           |                  time
+       ---/----------------------------+------------------------
+          |IDLE1-energy < IDLE2-energy | IDLE2-energy < IDLE1-energy
+                                       |
+                                IDLE2-min-residency
+
+=09=09Graph 2: idle states min-residency example
+
+In graph 2 above, that takes into account idle states entry/exit energy
+costs, it is clear that if the idle state residency time (ie time till nex=
t
+wake-up IRQ) is less than IDLE2-min-residency, IDLE1 is the better idle st=
ate
+choice energywise.
+
+This is mainly down to the fact that IDLE1 entry/exit energy costs are low=
er
+than IDLE2.
+
+However, the lower power consumption (ie shallower energy curve slope) of =
idle
+state IDLE2 implies that after a suitable time, IDLE2 becomes more energy
+efficient.
+
+The time at which IDLE2 becomes more energy efficient than IDLE1 (and othe=
r
+shallower states in a system with multiple idle states) is defined
+IDLE2-min-residency and corresponds to the time when energy consumption of
+IDLE1 and IDLE2 states breaks even.
+
+The definitions provided in this section underpin the idle states
+properties specification that is the subject of the following sections.
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+3 - idle-states node
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
+=09Usage: Optional - On ARM systems, it is a container of processor idle
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
+=09=09Value type: <stringlist>
+=09=09Usage and definition depend on ARM architecture version.
+=09=09=09# On ARM v8 64-bit this property is required and must
+=09=09=09  be one of:
+=09=09=09   - "psci" (see bindings in [2])
+=09=09=09# On ARM 32-bit systems this property is optional
+
+The nodes describing the idle states (state) can only be defined within th=
e
+idle-states node, any other configuration is considered invalid and theref=
ore
+must be ignored.
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+4 - state node
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
+=09With the definitions provided above, the following list represents
+=09the valid properties for a state node:
+
+=09- compatible
+=09=09Usage: Required
+=09=09Value type: <stringlist>
+=09=09Definition: Must be "arm,idle-state".
+
+=09- local-timer-stop
+=09=09Usage: See definition
+=09=09Value type: <none>
+=09=09Definition: if present the CPU local timer control logic is
+=09=09=09    lost on state entry, otherwise it is retained.
+
+=09- entry-latency-us
+=09=09Usage: Required
+=09=09Value type: <prop-encoded-array>
+=09=09Definition: u32 value representing worst case latency in
+=09=09=09    microseconds required to enter the idle state.
+=09=09=09    The exit-latency-us duration may be guaranteed
+=09=09=09    only after entry-latency-us has passed.
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
+=09=09Definition: u32 value representing minimum residency duration
+=09=09=09    in microseconds, inclusive of preparation and
+=09=09=09    entry, for this idle state to be considered
+=09=09=09    worthwhile energy wise (refer to section 2 of
+=09=09=09    this document for a complete description).
+
+=09- wakeup-latency-us:
+=09=09Usage: Optional
+=09=09Value type: <prop-encoded-array>
+=09=09Definition: u32 value representing maximum delay between the
+=09=09=09    signaling of a wake-up event and the CPU being
+=09=09=09    able to execute normal code again. If omitted,
+=09=09=09    this is assumed to be equal to:
+
+=09=09=09=09entry-latency-us + exit-latency-us
+
+=09=09=09    It is important to supply this value on systems
+=09=09=09    where the duration of PREP phase (see diagram 1,
+=09=09=09    section 2) is non-neglibigle.
+=09=09=09    In such systems entry-latency-us + exit-latency-us
+=09=09=09    will exceed wakeup-latency-us by this duration.
+
+=09In addition to the properties listed above, a state node may require
+=09additional properties specifics to the entry-method defined in the
+=09idle-states node, please refer to the entry-method bindings
+=09documentation for properties definitions.
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+4 - Examples
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Example 1 (ARM 64-bit, 16-cpu system, PSCI enable-method):
+
+cpus {
+=09#size-cells =3D <0>;
+=09#address-cells =3D <2>;
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
+
+=09idle-states {
+=09=09entry-method =3D "arm,psci";
+
+=09=09CPU_RETENTION_0_0: cpu-retention-0-0 {
+=09=09=09compatible =3D "arm,idle-state";
+=09=09=09arm,psci-suspend-param =3D <0x0010000>;
+=09=09=09entry-latency-us =3D <20>;
+=09=09=09exit-latency-us =3D <40>;
+=09=09=09min-residency-us =3D <80>;
+=09=09};
+
+=09=09CLUSTER_RETENTION_0: cluster-retention-0 {
+=09=09=09compatible =3D "arm,idle-state";
+=09=09=09local-timer-stop;
+=09=09=09arm,psci-suspend-param =3D <0x1010000>;
+=09=09=09entry-latency-us =3D <50>;
+=09=09=09exit-latency-us =3D <100>;
+=09=09=09min-residency-us =3D <250>;
+=09=09=09wakeup-latency-us =3D <130>;
+=09=09};
+
+=09=09CPU_SLEEP_0_0: cpu-sleep-0-0 {
+=09=09=09compatible =3D "arm,idle-state";
+=09=09=09local-timer-stop;
+=09=09=09arm,psci-suspend-param =3D <0x0010000>;
+=09=09=09entry-latency-us =3D <250>;
+=09=09=09exit-latency-us =3D <500>;
+=09=09=09min-residency-us =3D <950>;
+=09=09};
+
+=09=09CLUSTER_SLEEP_0: cluster-sleep-0 {
+=09=09=09compatible =3D "arm,idle-state";
+=09=09=09local-timer-stop;
+=09=09=09arm,psci-suspend-param =3D <0x1010000>;
+=09=09=09entry-latency-us =3D <600>;
+=09=09=09exit-latency-us =3D <1100>;
+=09=09=09min-residency-us =3D <2700>;
+=09=09=09wakeup-latency-us =3D <1500>;
+=09=09};
+
+=09=09CPU_RETENTION_1_0: cpu-retention-1-0 {
+=09=09=09compatible =3D "arm,idle-state";
+=09=09=09arm,psci-suspend-param =3D <0x0010000>;
+=09=09=09entry-latency-us =3D <20>;
+=09=09=09exit-latency-us =3D <40>;
+=09=09=09min-residency-us =3D <90>;
+=09=09};
+
+=09=09CLUSTER_RETENTION_1: cluster-retention-1 {
+=09=09=09compatible =3D "arm,idle-state";
+=09=09=09local-timer-stop;
+=09=09=09arm,psci-suspend-param =3D <0x1010000>;
+=09=09=09entry-latency-us =3D <50>;
+=09=09=09exit-latency-us =3D <100>;
+=09=09=09min-residency-us =3D <270>;
+=09=09=09wakeup-latency-us =3D <100>;
+=09=09};
+
+=09=09CPU_SLEEP_1_0: cpu-sleep-1-0 {
+=09=09=09compatible =3D "arm,idle-state";
+=09=09=09local-timer-stop;
+=09=09=09arm,psci-suspend-param =3D <0x0010000>;
+=09=09=09entry-latency-us =3D <70>;
+=09=09=09exit-latency-us =3D <100>;
+=09=09=09min-residency-us =3D <300>;
+=09=09=09wakeup-latency-us =3D <150>;
+=09=09};
+
+=09=09CLUSTER_SLEEP_1: cluster-sleep-1 {
+=09=09=09compatible =3D "arm,idle-state";
+=09=09=09local-timer-stop;
+=09=09=09arm,psci-suspend-param =3D <0x1010000>;
+=09=09=09entry-latency-us =3D <500>;
+=09=09=09exit-latency-us =3D <1200>;
+=09=09=09min-residency-us =3D <3500>;
+=09=09=09wakeup-latency-us =3D <1300>;
+=09=09};
+=09};
+
+};
+
+Example 2 (ARM 32-bit, 8-cpu system, two clusters):
+
+cpus {
+=09#size-cells =3D <0>;
+=09#address-cells =3D <1>;
+
+=09CPU0: cpu@0 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a15";
+=09=09reg =3D <0x0>;
+=09=09cpu-idle-states =3D <&CPU_SLEEP_0_0 &CLUSTER_SLEEP_0>;
+=09};
+
+=09CPU1: cpu@1 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a15";
+=09=09reg =3D <0x1>;
+=09=09cpu-idle-states =3D <&CPU_SLEEP_0_0 &CLUSTER_SLEEP_0>;
+=09};
+
+=09CPU2: cpu@2 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a15";
+=09=09reg =3D <0x2>;
+=09=09cpu-idle-states =3D <&CPU_SLEEP_0_0 &CLUSTER_SLEEP_0>;
+=09};
+
+=09CPU3: cpu@3 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a15";
+=09=09reg =3D <0x3>;
+=09=09cpu-idle-states =3D <&CPU_SLEEP_0_0 &CLUSTER_SLEEP_0>;
+=09};
+
+=09CPU4: cpu@100 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a7";
+=09=09reg =3D <0x100>;
+=09=09cpu-idle-states =3D <&CPU_SLEEP_1_0 &CLUSTER_SLEEP_1>;
+=09};
+
+=09CPU5: cpu@101 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a7";
+=09=09reg =3D <0x101>;
+=09=09cpu-idle-states =3D <&CPU_SLEEP_1_0 &CLUSTER_SLEEP_1>;
+=09};
+
+=09CPU6: cpu@102 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a7";
+=09=09reg =3D <0x102>;
+=09=09cpu-idle-states =3D <&CPU_SLEEP_1_0 &CLUSTER_SLEEP_1>;
+=09};
+
+=09CPU7: cpu@103 {
+=09=09device_type =3D "cpu";
+=09=09compatible =3D "arm,cortex-a7";
+=09=09reg =3D <0x103>;
+=09=09cpu-idle-states =3D <&CPU_SLEEP_1_0 &CLUSTER_SLEEP_1>;
+=09};
+
+=09idle-states {
+=09=09CPU_SLEEP_0_0: cpu-sleep-0-0 {
+=09=09=09compatible =3D "arm,idle-state";
+=09=09=09local-timer-stop;
+=09=09=09entry-latency-us =3D <200>;
+=09=09=09exit-latency-us =3D <100>;
+=09=09=09min-residency-us =3D <400>;
+=09=09=09wakeup-latency-us =3D <250>;
+=09=09};
+
+=09=09CLUSTER_SLEEP_0: cluster-sleep-0 {
+=09=09=09compatible =3D "arm,idle-state";
+=09=09=09local-timer-stop;
+=09=09=09entry-latency-us =3D <500>;
+=09=09=09exit-latency-us =3D <1500>;
+=09=09=09min-residency-us =3D <2500>;
+=09=09=09wakeup-latency-us =3D <1700>;
+=09=09};
+
+=09=09CPU_SLEEP_1_0: cpu-sleep-1-0 {
+=09=09=09compatible =3D "arm,idle-state";
+=09=09=09local-timer-stop;
+=09=09=09entry-latency-us =3D <300>;
+=09=09=09exit-latency-us =3D <500>;
+=09=09=09min-residency-us =3D <900>;
+=09=09=09wakeup-latency-us =3D <600>;
+=09=09};
+
+=09=09CLUSTER_SLEEP_1: cluster-sleep-1 {
+=09=09=09compatible =3D "arm,idle-state";
+=09=09=09local-timer-stop;
+=09=09=09entry-latency-us =3D <800>;
+=09=09=09exit-latency-us =3D <2000>;
+=09=09=09min-residency-us =3D <6500>;
+=09=09=09wakeup-latency-us =3D <2300>;
+=09=09};
+=09};
+
+};
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+5 - References
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
diff --git a/Documentation/devicetree/bindings/arm/psci.txt b/Documentation=
/devicetree/bindings/arm/psci.txt
index b4a58f3..5aa40ed 100644
--- a/Documentation/devicetree/bindings/arm/psci.txt
+++ b/Documentation/devicetree/bindings/arm/psci.txt
@@ -50,6 +50,16 @@ Main node optional properties:
=20
  - migrate       : Function ID for MIGRATE operation
=20
+Device tree nodes that require usage of PSCI CPU_SUSPEND function (ie idle
+state nodes, as per bindings in [1]) must specify the following properties=
:
+
+- arm,psci-suspend-param
+=09=09Usage: Required for state nodes[1] if the corresponding
+                       idle-states node entry-method property is set
+                       to "psci".
+=09=09Value type: <u32>
+=09=09Definition: power_state parameter to pass to the PSCI
+=09=09=09    suspend call.
=20
 Example:
=20
@@ -64,7 +74,6 @@ Case 1: PSCI v0.1 only.
 =09=09migrate=09=09=3D <0x95c10003>;
 =09};
=20
-
 Case 2: PSCI v0.2 only
=20
 =09psci {
@@ -88,3 +97,6 @@ Case 3: PSCI v0.2 and PSCI v0.1.
=20
 =09=09...
 =09};
+
+[1] Kernel documentation - ARM idle states bindings
+    Documentation/devicetree/bindings/arm/idle-states.txt
--=20
1.9.1


