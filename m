From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH RFC v2 1/2] Documentation: arm: add cache DT bindings
Date: Mon, 20 Jan 2014 17:47:58 +0000
Message-ID: <1390240079-6495-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1390240079-6495-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:50525 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750AbaATRrW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jan 2014 12:47:22 -0500
In-Reply-To: <1390240079-6495-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Dave Martin <dave.martin@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Grant Likely <grant.likely@linaro.org>, Kumar Gala <galak@codeaurora.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Mark Hambleton <mark.hambleton@broadcom.com>, Hanjun Guo <hanjun.guo@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Tomasz Figa <t.figa@samsung.com>, Kevin Hilman <khilman@linaro.org>

On ARM systems the cache topology cannot be probed at runtime, in
particular, it is impossible to probe which CPUs share a given cache
level. Power management software requires this knowledge to implement
optimized power down sequences, hence this patch adds a document that
defines the DT cache bindings for ARM systems. The bindings are compliant
with ePAPR (PowerPC bindings), even though most of the cache nodes
properties requirements are overriden, because caches geometry for
architected caches is probeable on ARM systems. This patch also adds
properties that are specific to ARM architected caches to the existing ones
defined in the ePAPR v1.1, as bindings extensions.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 Documentation/devicetree/bindings/arm/cache.txt | 187 ++++++++++++++++++++=
++++
 1 file changed, 187 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/cache.txt

diff --git a/Documentation/devicetree/bindings/arm/cache.txt b/Documentatio=
n/devicetree/bindings/arm/cache.txt
new file mode 100644
index 0000000..b27cedf
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/cache.txt
@@ -0,0 +1,187 @@
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ARM processors cache binding description
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Device tree bindings for ARM processor caches adhere to the cache bindings
+described in [3], in section 3.8 for multi-level and shared caches.
+On ARM based systems most of the cache properties related to cache
+geometry are probeable in HW, hence, unless otherwise stated, the properti=
es
+defined in ePAPR for multi-level and shared caches are to be considered
+optional by default.
+
+On ARM, caches are either architected (directly controlled by the processo=
r
+through coprocessor instructions and tightly coupled with the processor
+implementation) or unarchitected (controlled through a memory mapped
+interface, implemented as a stand-alone IP external to the processor
+implementation).
+
+This document provides the device tree bindings for ARM architected caches=
.
+
+- ARM architected cache node
+
+=09Description: must be a direct child of the cpu node. A system
+=09=09     can contain multiple architected cache nodes per cpu node,
+=09=09     linked through the next-level-cache phandle. The
+=09=09     next-level-cache property in the cpu node points to
+=09=09     the first level of architected cache for the CPU.
+=09=09     The next-level-cache property in architected cache nodes
+=09=09     points to the respective next level of caching in the
+=09=09     hierarchy. An architected cache node with an empty or
+=09=09     missing next-level-cache property represents the last
+=09=09     architected cache level for the CPU.
+=09=09     On ARM v7 and v8 architectures, the order in which cache
+=09=09     nodes are linked through the next-level-cache phandle must
+=09=09     follow the ordering specified in the processors CLIDR (v7)
+=09=09     and CLIDR_EL1 (v8) registers, as described in [1][2],
+=09=09     implying that a cache node pointed at by a
+=09=09     next-level-cache phandle must correspond to a level
+=09=09     defined in CLIDR (v7) and CLIDR_EL1 (v8) greater than the
+=09=09     one the cache node containing the next-level-cache
+=09=09     phandle corresponds to.
+
+=09Since on ARM most of the cache properties are probeable in HW the
+=09properties described in [3] - section 3.8 multi-level and shared
+=09caches - shall be considered optional, with the following properties
+=09updates, specific for the ARM architected cache node.
+
+=09- compatible
+=09=09Usage: Required
+=09=09Value type: <string>
+=09=09Definition: value shall be "arm,arch-cache".
+
+=09- interrupts
+=09=09Usage: Optional
+=09=09Value type: See definition
+=09=09Definition: standard device tree property [3] that defines
+=09=09=09    the interrupt line associated with the cache.
+=09=09=09    The property can be accompanied by an
+=09=09=09    interrupt-names property, as described in [4].
+
+=09- power-domain
+=09=09Usage: Optional
+=09=09Value type: phandle
+=09=09Definition: A phandle and power domain specifier as defined by
+=09=09=09    bindings of power controller specified by the
+=09=09=09    phandle [5].
+
+Example(dual-cluster big.LITTLE system 32-bit)
+
+=09cpus {
+=09=09#size-cells =3D <0>;
+=09=09#address-cells =3D <1>;
+
+=09=09cpu@0 {
+=09=09=09device_type =3D "cpu";
+=09=09=09compatible =3D "arm,cortex-a15";
+=09=09=09reg =3D <0x0>;
+=09=09=09next-level-cache =3D <&L1_0>;
+
+=09=09=09L1_0: l1-cache {
+=09=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09=09next-level-cache =3D <&L2_0>;
+=09=09=09};
+
+=09=09=09L2_0: l2-cache {
+=09=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09};
+=09=09};
+
+=09=09cpu@1 {
+=09=09=09device_type =3D "cpu";
+=09=09=09compatible =3D "arm,cortex-a15";
+=09=09=09reg =3D <0x1>;
+=09=09=09next-level-cache =3D <&L1_1>;
+
+=09=09=09L1_1: l1-cache {
+=09=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09=09next-level-cache =3D <&L2_0>;
+=09=09=09};
+=09=09};
+
+=09=09cpu@2 {
+=09=09=09device_type =3D "cpu";
+=09=09=09compatible =3D "arm,cortex-a15";
+=09=09=09reg =3D <0x2>;
+=09=09=09next-level-cache =3D <&L1_2>;
+
+=09=09=09L1_2: l1-cache {
+=09=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09=09next-level-cache =3D <&L2_0>;
+=09=09=09};
+=09=09};
+
+=09=09cpu@3 {
+=09=09=09device_type =3D "cpu";
+=09=09=09compatible =3D "arm,cortex-a15";
+=09=09=09reg =3D <0x3>;
+=09=09=09next-level-cache =3D <&L1_3>;
+
+=09=09=09L1_3: l1-cache {
+=09=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09=09next-level-cache =3D <&L2_0>;
+=09=09=09};
+=09=09};
+
+=09=09cpu@100 {
+=09=09=09device_type =3D "cpu";
+=09=09=09compatible =3D "arm,cortex-a7";
+=09=09=09reg =3D <0x100>;
+=09=09=09next-level-cache =3D <&L1_4>;
+
+=09=09=09L1_4: l1-cache {
+=09=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09=09next-level-cache =3D <&L2_1>;
+=09=09=09};
+
+=09=09=09L2_1: l2-cache {
+=09=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09};
+=09=09};
+
+=09=09cpu@101 {
+=09=09=09device_type =3D "cpu";
+=09=09=09compatible =3D "arm,cortex-a7";
+=09=09=09reg =3D <0x101>;
+=09=09=09next-level-cache =3D <&L1_5>;
+
+=09=09=09L1_5: l1-cache {
+=09=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09=09next-level-cache =3D <&L2_1>;
+=09=09=09};
+=09=09};
+
+=09=09cpu@102 {
+=09=09=09device_type =3D "cpu";
+=09=09=09compatible =3D "arm,cortex-a7";
+=09=09=09reg =3D <0x102>;
+=09=09=09next-level-cache =3D <&L1_6>;
+
+=09=09=09L1_6: l1-cache {
+=09=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09=09next-level-cache =3D <&L2_1>;
+=09=09=09};
+=09=09};
+
+=09=09cpu@103 {
+=09=09=09device_type =3D "cpu";
+=09=09=09compatible =3D "arm,cortex-a7";
+=09=09=09reg =3D <0x103>;
+=09=09=09next-level-cache =3D <&L1_7>;
+
+=09=09=09L1_7: l1-cache {
+=09=09=09=09compatible =3D "arm,arch-cache";
+=09=09=09=09next-level-cache =3D <&L2_1>;
+=09=09=09};
+=09=09};
+=09};
+
+[1] ARMv7-AR Reference Manual
+    http://infocenter.arm.com/help/index.jsp
+[2] ARMv8-A Reference Manual
+    http://infocenter.arm.com/help/index.jsp
+[3] ePAPR standard
+    https://www.power.org/documentation/epapr-version-1-1/
+[4] Kernel documentation - resource property bindings
+    Documentation/devicetree/bindings/resource-names.txt
+[5] Kernel documentation - power domain bindings
+    Documentation/devicetree/bindings/power/power_domain.txt
--=20
1.8.4


