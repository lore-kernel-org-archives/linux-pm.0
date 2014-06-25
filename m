From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v5 6/8] drivers: cpuidle: initialize big.LITTLE driver through DT
Date: Wed, 25 Jun 2014 15:10:19 +0100
Message-ID: <1403705421-17597-7-git-send-email-lorenzo.pieralisi@arm.com>
References: <1403705421-17597-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:48644 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757357AbaFYOKe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jun 2014 10:10:34 -0400
In-Reply-To: <1403705421-17597-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Chander Kashyap <chander.kashyap@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie@kernel.org>, Paul Walmsley <paul@pwsan.com>

With the introduction of DT based idle states, CPUidle drivers for ARM
can now initialize idle states data through properties in the device tree.

This patch adds code to the big.LITTLE CPUidle driver to dynamically
initialize idle states data through the updated device tree source file.

Cc: Chander Kashyap <chander.kashyap@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 Documentation/devicetree/bindings/arm/vexpress.txt | 25 +++++++++++++
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts         | 25 +++++++++++++
 drivers/cpuidle/Kconfig.arm                        |  1 +
 drivers/cpuidle/cpuidle-big_little.c               | 43 +++++++++++-------=
----
 4 files changed, 73 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/vexpress.txt b/Documenta=
tion/devicetree/bindings/arm/vexpress.txt
index 39844cd..7f52ac8 100644
--- a/Documentation/devicetree/bindings/arm/vexpress.txt
+++ b/Documentation/devicetree/bindings/arm/vexpress.txt
@@ -67,6 +67,28 @@ with device_type =3D "cpu" property for every available =
core, eg.:
 =09=09};
 =09};
=20
+idle-states node
+----------------
+
+On Versatile Express platforms with power management capabilities, the dev=
ice
+tree source file must contain the idle-states node[1]. As defined in [1] t=
he
+idle-states node must contain an entry-method property that for Versatile
+Express platforms can be one of:
+
+=09- "arm,vexpress-v2p-ca15_a7"
+
+Versatile Express idle-states nodes example:
+
+=09idle-states {
+=09=09entry-method =3D "arm,vexpress-v2p-ca15_a7";
+
+=09=09cluster-sleep-0 {
+=09=09=09compatible =3D "arm,idle-state";
+=09=09=09entry-latency-us =3D <1000>;
+=09=09=09exit-latency-us =3D <700>;
+=09=09=09min-residency-us =3D <3500>;
+=09=09};
+=09};
=20
 Configuration infrastructure
 ----------------------------
@@ -227,3 +249,6 @@ Example of a VE tile description (simplified)
 =09};
 };
=20
+
+[1] ARM Linux Kernel documentation - Idle states bindings
+    Documentation/devicetree/bindings/arm/idle-states.txt
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts=
/vexpress-v2p-ca15_a7.dts
index a25c262..ad28242 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -33,11 +33,32 @@
 =09=09#address-cells =3D <1>;
 =09=09#size-cells =3D <0>;
=20
+=09=09idle-states {
+=09=09=09entry-method =3D "arm,vexpress-v2p-ca15_a7";
+
+=09=09=09CLUSTER_SLEEP_BIG: cluster-sleep-big {
+=09=09=09=09compatible =3D "arm,idle-state";
+=09=09=09=09power-rank =3D <0>;
+=09=09=09=09entry-latency-us =3D <1000>;
+=09=09=09=09exit-latency-us =3D <700>;
+=09=09=09=09min-residency-us =3D <3500>;
+=09=09=09};
+
+=09=09=09CLUSTER_SLEEP_LITTLE: cluster-sleep-little {
+=09=09=09=09compatible =3D "arm,idle-state";
+=09=09=09=09power-rank =3D <0>;
+=09=09=09=09entry-latency-us =3D <1000>;
+=09=09=09=09exit-latency-us =3D <500>;
+=09=09=09=09min-residency-us =3D <3000>;
+=09=09=09};
+=09=09};
+
 =09=09cpu0: cpu@0 {
 =09=09=09device_type =3D "cpu";
 =09=09=09compatible =3D "arm,cortex-a15";
 =09=09=09reg =3D <0>;
 =09=09=09cci-control-port =3D <&cci_control1>;
+=09=09=09cpu-idle-states =3D <&CLUSTER_SLEEP_BIG>;
 =09=09};
=20
 =09=09cpu1: cpu@1 {
@@ -45,6 +66,7 @@
 =09=09=09compatible =3D "arm,cortex-a15";
 =09=09=09reg =3D <1>;
 =09=09=09cci-control-port =3D <&cci_control1>;
+=09=09=09cpu-idle-states =3D <&CLUSTER_SLEEP_BIG>;
 =09=09};
=20
 =09=09cpu2: cpu@2 {
@@ -52,6 +74,7 @@
 =09=09=09compatible =3D "arm,cortex-a7";
 =09=09=09reg =3D <0x100>;
 =09=09=09cci-control-port =3D <&cci_control2>;
+=09=09=09cpu-idle-states =3D <&CLUSTER_SLEEP_LITTLE>;
 =09=09};
=20
 =09=09cpu3: cpu@3 {
@@ -59,6 +82,7 @@
 =09=09=09compatible =3D "arm,cortex-a7";
 =09=09=09reg =3D <0x101>;
 =09=09=09cci-control-port =3D <&cci_control2>;
+=09=09=09cpu-idle-states =3D <&CLUSTER_SLEEP_LITTLE>;
 =09=09};
=20
 =09=09cpu4: cpu@4 {
@@ -66,6 +90,7 @@
 =09=09=09compatible =3D "arm,cortex-a7";
 =09=09=09reg =3D <0x102>;
 =09=09=09cci-control-port =3D <&cci_control2>;
+=09=09=09cpu-idle-states =3D <&CLUSTER_SLEEP_LITTLE>;
 =09=09};
 =09};
=20
diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index b6d69e8..a9b089c 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -12,6 +12,7 @@ config ARM_BIG_LITTLE_CPUIDLE
 =09depends on ARCH_VEXPRESS_TC2_PM
 =09select ARM_CPU_SUSPEND
 =09select CPU_IDLE_MULTIPLE_DRIVERS
+=09select DT_IDLE_STATES
 =09help
 =09  Select this option to enable CPU idle driver for big.LITTLE based
 =09  ARM systems. Driver manages CPUs coordination through MCPM and
diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle=
-big_little.c
index b45fc62..6712441 100644
--- a/drivers/cpuidle/cpuidle-big_little.c
+++ b/drivers/cpuidle/cpuidle-big_little.c
@@ -24,6 +24,8 @@
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
=20
+#include "dt_idle_states.h"
+
 static int bl_enter_powerdown(struct cpuidle_device *dev,
 =09=09=09      struct cpuidle_driver *drv, int idx);
=20
@@ -61,32 +63,12 @@ static struct cpuidle_driver bl_idle_little_driver =3D =
{
 =09.name =3D "little_idle",
 =09.owner =3D THIS_MODULE,
 =09.states[0] =3D ARM_CPUIDLE_WFI_STATE,
-=09.states[1] =3D {
-=09=09.enter=09=09=09=3D bl_enter_powerdown,
-=09=09.exit_latency=09=09=3D 700,
-=09=09.target_residency=09=3D 2500,
-=09=09.flags=09=09=09=3D CPUIDLE_FLAG_TIME_VALID |
-=09=09=09=09=09  CPUIDLE_FLAG_TIMER_STOP,
-=09=09.name=09=09=09=3D "C1",
-=09=09.desc=09=09=09=3D "ARM little-cluster power down",
-=09},
-=09.state_count =3D 2,
 };
=20
 static struct cpuidle_driver bl_idle_big_driver =3D {
 =09.name =3D "big_idle",
 =09.owner =3D THIS_MODULE,
 =09.states[0] =3D ARM_CPUIDLE_WFI_STATE,
-=09.states[1] =3D {
-=09=09.enter=09=09=09=3D bl_enter_powerdown,
-=09=09.exit_latency=09=09=3D 500,
-=09=09.target_residency=09=3D 2000,
-=09=09.flags=09=09=09=3D CPUIDLE_FLAG_TIME_VALID |
-=09=09=09=09=09  CPUIDLE_FLAG_TIMER_STOP,
-=09=09.name=09=09=09=3D "C1",
-=09=09.desc=09=09=09=3D "ARM big-cluster power down",
-=09},
-=09.state_count =3D 2,
 };
=20
 /*
@@ -165,7 +147,8 @@ static int __init bl_idle_driver_init(struct cpuidle_dr=
iver *drv, int cpu_id)
=20
 static int __init bl_idle_init(void)
 {
-=09int ret;
+=09int ret, i;
+=09struct cpuidle_driver *drv;
=20
 =09/*
 =09 * Initialize the driver just for a compliant set of machines
@@ -187,6 +170,24 @@ static int __init bl_idle_init(void)
 =09if (ret)
 =09=09goto out_uninit_little;
=20
+=09 /* Start at index 1, index 0 standard WFI */
+=09ret =3D dt_init_idle_driver(&bl_idle_big_driver, NULL, 1, false);
+=09if (ret)
+=09=09goto out_uninit_big;
+
+=09 /* Start at index 1, index 0 standard WFI */
+=09ret =3D dt_init_idle_driver(&bl_idle_little_driver, NULL, 1, false);
+=09if (ret)
+=09=09goto out_uninit_big;
+
+=09drv =3D &bl_idle_big_driver;
+=09for (i =3D 1; i < drv->state_count; i++)
+=09=09drv->states[i].enter =3D bl_enter_powerdown;
+
+=09drv =3D &bl_idle_little_driver;
+=09for (i =3D 1; i < drv->state_count; i++)
+=09=09drv->states[i].enter =3D bl_enter_powerdown;
+
 =09ret =3D cpuidle_register(&bl_idle_little_driver, NULL);
 =09if (ret)
 =09=09goto out_uninit_big;
--=20
1.9.1


