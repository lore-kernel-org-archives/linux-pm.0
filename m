From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH RFC v3 2/3] Documentation: arm: add cache DT bindings
Date: Tue, 11 Feb 2014 14:17:52 +0000
Message-ID: <1392128273-8614-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1392128273-8614-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:33528 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbaBKORH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2014 09:17:07 -0500
In-Reply-To: <1392128273-8614-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Dave Martin <dave.martin@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Grant Likely <grant.likely@linaro.org>, Kumar Gala <galak@codeaurora.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King <linux@arm.linux.org.uk>, Mark Hambleton <mark.hambleton@broadcom.com>, Hanjun Guo <hanjun.guo@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Tomasz Figa <t.figa@samsung.com>, Kevin

On ARM systems the cache topology cannot be probed at runtime, in
particular, it is impossible to probe which CPUs share a given cache
level. Power management software requires this knowledge to implement
optimized power down sequences, hence this patch adds a document that
defines the DT cache bindings for ARM systems. The bindings supersede
cache bindings in the ePAPR (PowerPC bindings), because caches geometry for
architected caches is probeable on ARM systems. This patch also adds
properties that are specific to ARM architected caches to the existing ones
defined in the ePAPR v1.1, as bindings extensions.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 Documentation/devicetree/bindings/arm/cache.txt | 165 ++++++++++
 1 file changed, 165 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cache.txt b/Documentatio=
n/devicetree/bindings/arm/cache.txt
new file mode 100644
index 0000000..bd9f3d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/cache.txt
@@ -0,0 +1,165 @@
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ARM processors cache binding description
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Device tree bindings for cache nodes are already part of the ePAPR standar=
d
+v1.1 ([2]) for PowerPC platforms. This document defines the cache bindings
+for caches on ARM processor systems.
+
+On ARM based systems most of the cache properties related to cache geometr=
y
+are probeable in HW (please refer to the processor TRMs in [1] for registe=
r
+details), hence, unless otherwise stated, the properties defined in ePAPR =
for
+internal, multi-level and shared caches ([2], 3.7.3, 3.8) are to be consid=
ered
+superseded on ARM.
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
+=09Description: must be a direct child of the cpu node.
+=09=09     A system can contain multiple architected cache nodes
+=09=09     per cpu node, linked through the next-level-cache phandle.
+=09=09     The next-level-cache property in the cpu node points to
+=09=09     the first level of architected cache for the CPU.
+=09=09     The next-level-cache links ordering must represent the
+=09=09     system cache hierarchy in the system, with the upper
+=09=09     cache level represented by a cache node with a missing
+=09=09     next-level-cache property.
+
+=09ARM architected cache node defines the following properties:
+
+=09- compatible
+=09=09Usage: Required
+=09=09Value type: <string>
+=09=09Definition: value shall be "arm,arch-cache".
+
+=09- power-domain
+=09=09Usage: Optional
+=09=09Value type: phandle
+=09=09Definition: A phandle and power domain specifier as defined by
+=09=09=09    bindings of power domain specified by the
+=09=09=09    phandle [3].
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
+[1] ARM Architecture Reference Manuals
+    http://infocenter.arm.com/help/index.jsp
+[2] ePAPR standard
+    https://www.power.org/documentation/epapr-version-1-1/
+[3] Kernel documentation - power domain bindings
+    Documentation/devicetree/bindings/power/power_domain.txt
--=20
1.8.4


