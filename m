From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFC PATCH 05/10] ARM: vexpress: Add CPU clock-frequencies to TC2 device-tree
Date: Tue,  2 Dec 2014 14:06:27 +0000
Message-ID: <1417529192-11579-6-git-send-email-morten.rasmussen@arm.com>
References: <1417529192-11579-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1417529192-11579-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com
Cc: dietmar.eggemann@arm.com, vincent.guittot@linaro.org, pjt@google.com, bsegall@google.com, mturquette@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Jon Medhurst <tixy@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

To enable the parsing of clock frequency and cpu efficiency values inside
parse_dt_topology [arch/arm/kernel/topology.c] to scale the relative
capacity of the cpus, this property has to be provided within the cpu
nodes of the dts file.

The patch is a copy of 'ARM: vexpress: Add CPU clock-frequencies to TC2
device-tree' (commit 8f15973ef8c3) taken from Linaro Stable Kernel (LSK)
massaged into mainline.

Cc: Jon Medhurst <tixy@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts=
/vexpress-v2p-ca15_a7.dts
index 322fd15..62f89e2 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -39,6 +39,7 @@
 =09=09=09reg =3D <0>;
 =09=09=09cci-control-port =3D <&cci_control1>;
 =09=09=09cpu-idle-states =3D <&CLUSTER_SLEEP_BIG>;
+=09=09=09clock-frequency =3D <1000000000>;
 =09=09};
=20
 =09=09cpu1: cpu@1 {
@@ -47,6 +48,7 @@
 =09=09=09reg =3D <1>;
 =09=09=09cci-control-port =3D <&cci_control1>;
 =09=09=09cpu-idle-states =3D <&CLUSTER_SLEEP_BIG>;
+=09=09=09clock-frequency =3D <1000000000>;
 =09=09};
=20
 =09=09cpu2: cpu@2 {
@@ -55,6 +57,7 @@
 =09=09=09reg =3D <0x100>;
 =09=09=09cci-control-port =3D <&cci_control2>;
 =09=09=09cpu-idle-states =3D <&CLUSTER_SLEEP_LITTLE>;
+=09=09=09clock-frequency =3D <800000000>;
 =09=09};
=20
 =09=09cpu3: cpu@3 {
@@ -63,6 +66,7 @@
 =09=09=09reg =3D <0x101>;
 =09=09=09cci-control-port =3D <&cci_control2>;
 =09=09=09cpu-idle-states =3D <&CLUSTER_SLEEP_LITTLE>;
+=09=09=09clock-frequency =3D <800000000>;
 =09=09};
=20
 =09=09cpu4: cpu@4 {
@@ -71,6 +75,7 @@
 =09=09=09reg =3D <0x102>;
 =09=09=09cci-control-port =3D <&cci_control2>;
 =09=09=09cpu-idle-states =3D <&CLUSTER_SLEEP_LITTLE>;
+=09=09=09clock-frequency =3D <800000000>;
 =09=09};
=20
 =09=09idle-states {
--=20
1.9.1
