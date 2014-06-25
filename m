From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v5 8/8] arm64: boot: dts: update rtsm aemv8 dts with PSCI and idle states
Date: Wed, 25 Jun 2014 15:10:21 +0100
Message-ID: <1403705421-17597-9-git-send-email-lorenzo.pieralisi@arm.com>
References: <1403705421-17597-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:48821 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757219AbaFYOKh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jun 2014 10:10:37 -0400
In-Reply-To: <1403705421-17597-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie@kernel.org>, Paul Walmsley <paul@pwsan.com>, Chander Kashyap <chander.kashyap@linaro.org>

This patch updates the RTSM dts file with PSCI bindings and nodes
describing the AEMv8 model idle states parameters.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/boot/dts/rtsm_ve-aemv8a.dts | 44 +++++++++++++++++++++++++++---=
----
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts b/arch/arm64/boot/dts/r=
tsm_ve-aemv8a.dts
index d79de9c..4051ffb 100644
--- a/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
+++ b/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
@@ -27,37 +27,65 @@
 =09=09serial3 =3D &v2m_serial3;
 =09};
=20
+=09psci {
+=09=09compatible =3D "arm,psci-0.2";
+=09=09method =3D "smc";
+=09=09cpu_suspend =3D <0xc4000001>;
+=09=09cpu_off =3D <0x84000002>;
+=09=09cpu_on =3D <0xc4000003>;
+=09};
+
 =09cpus {
 =09=09#address-cells =3D <2>;
 =09=09#size-cells =3D <0>;
=20
+=09=09idle-states {
+=09=09=09entry-method =3D "arm,psci";
+
+=09=09=09CPU_SLEEP_0: cpu-sleep-0 {
+=09=09=09=09compatible =3D "arm,idle-state";
+=09=09=09=09entry-method-param =3D <0x0010000>;
+=09=09=09=09entry-latency-us =3D <40>;
+=09=09=09=09exit-latency-us =3D <100>;
+=09=09=09=09min-residency-us =3D <150>;
+=09=09=09};
+
+=09=09=09CLUSTER_SLEEP_0: cluster-sleep-0 {
+=09=09=09=09compatible =3D "arm,idle-state";
+=09=09=09=09entry-method-param =3D <0x1010000>;
+=09=09=09=09entry-latency-us =3D <500>;
+=09=09=09=09exit-latency-us =3D <1000>;
+=09=09=09=09min-residency-us =3D <2500>;
+=09=09=09};
+=09=09};
+
 =09=09cpu@0 {
 =09=09=09device_type =3D "cpu";
 =09=09=09compatible =3D "arm,armv8";
 =09=09=09reg =3D <0x0 0x0>;
-=09=09=09enable-method =3D "spin-table";
-=09=09=09cpu-release-addr =3D <0x0 0x8000fff8>;
+=09=09=09enable-method =3D "psci";
+=09=09=09cpu-idle-states =3D <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 =09=09};
 =09=09cpu@1 {
 =09=09=09device_type =3D "cpu";
 =09=09=09compatible =3D "arm,armv8";
 =09=09=09reg =3D <0x0 0x1>;
-=09=09=09enable-method =3D "spin-table";
-=09=09=09cpu-release-addr =3D <0x0 0x8000fff8>;
+=09=09=09enable-method =3D "psci";
+=09=09=09cpu-idle-states =3D <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 =09=09};
 =09=09cpu@2 {
 =09=09=09device_type =3D "cpu";
 =09=09=09compatible =3D "arm,armv8";
 =09=09=09reg =3D <0x0 0x2>;
-=09=09=09enable-method =3D "spin-table";
-=09=09=09cpu-release-addr =3D <0x0 0x8000fff8>;
+=09=09=09enable-method =3D "psci";
+=09=09=09cpu-idle-states =3D <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 =09=09};
 =09=09cpu@3 {
 =09=09=09device_type =3D "cpu";
 =09=09=09compatible =3D "arm,armv8";
 =09=09=09reg =3D <0x0 0x3>;
-=09=09=09enable-method =3D "spin-table";
-=09=09=09cpu-release-addr =3D <0x0 0x8000fff8>;
+=09=09=09enable-method =3D "psci";
+=09=09=09cpu-idle-states =3D <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 =09=09};
 =09};
=20
--=20
1.9.1


