From: Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC 7/7] arm64: dts: imx8mq: Add cpu-sleep state with poke wake-up
 enabled
Date: Wed, 27 Mar 2019 13:21:18 +0000
Message-ID: <1553692845-20983-8-git-send-email-abel.vesa@nxp.com>
References: <1553692845-20983-1-git-send-email-abel.vesa@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553692845-20983-1-git-send-email-abel.vesa@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Fabio Estevam <fabio.estevam@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, Aisheng Dong <aisheng.dong@nxp.com>
Cc: dl-linux-imx <linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Abel Vesa <abel.vesa@nxp.com>
List-Id: linux-pm@vger.kernel.org

Add the idle state cpu-sleep to each core. This idle state
makes use of 'local-wakeup-poke' property which basically tells
the cpuidle-arm driver to enable the poking for this state.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mq.dtsi
index 230f198..8b7303d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -84,6 +84,22 @@
 		#address-cells =3D <1>;
 		#size-cells =3D <0>;
=20
+		idle-states {
+			entry-method =3D "psci";
+
+			CPU_SLEEP: cpu-sleep {
+				compatible =3D "arm,idle-state";
+				arm,psci-suspend-param =3D <0x0010033>;
+				local-timer-stop;
+				local-wakeup-poke;
+				entry-latency-us =3D <1000>;
+				exit-latency-us =3D <700>;
+				min-residency-us =3D <2700>;
+				wakeup-latency-us =3D <1500>;
+			};
+		};
+
+
 		A53_0: cpu@0 {
 			device_type =3D "cpu";
 			compatible =3D "arm,cortex-a53";
@@ -94,6 +110,7 @@
 			next-level-cache =3D <&A53_L2>;
 			operating-points-v2 =3D <&a53_opp_table>;
 			#cooling-cells =3D <2>;
+			cpu-idle-states =3D <&CPU_SLEEP>;
 		};
=20
 		A53_1: cpu@1 {
@@ -106,6 +123,7 @@
 			next-level-cache =3D <&A53_L2>;
 			operating-points-v2 =3D <&a53_opp_table>;
 			#cooling-cells =3D <2>;
+			cpu-idle-states =3D <&CPU_SLEEP>;
 		};
=20
 		A53_2: cpu@2 {
@@ -118,6 +136,7 @@
 			next-level-cache =3D <&A53_L2>;
 			operating-points-v2 =3D <&a53_opp_table>;
 			#cooling-cells =3D <2>;
+			cpu-idle-states =3D <&CPU_SLEEP>;
 		};
=20
 		A53_3: cpu@3 {
@@ -130,6 +149,7 @@
 			next-level-cache =3D <&A53_L2>;
 			operating-points-v2 =3D <&a53_opp_table>;
 			#cooling-cells =3D <2>;
+			cpu-idle-states =3D <&CPU_SLEEP>;
 		};
=20
 		A53_L2: l2-cache0 {
--=20
2.7.4
