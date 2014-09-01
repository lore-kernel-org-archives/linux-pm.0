From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v8 7/8] drivers: cpuidle: initialize big.LITTLE driver through DT
Date: Mon,  1 Sep 2014 16:28:43 +0100
Message-ID: <1409585324-3678-8-git-send-email-lorenzo.pieralisi@arm.com>
References: <1409585324-3678-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:60687 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753961AbaIAP3U (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Sep 2014 11:29:20 -0400
In-Reply-To: <1409585324-3678-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Chander Kashyap <k.chander@samsung.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie@kernel.org>, Paul Walmsley <paul@pwsan.com>, Geoff

With the introduction of DT based idle states, CPUidle drivers for ARM
can now initialize idle states data through properties in the device tree.

This patch adds code to the big.LITTLE CPUidle driver to dynamically
initialize idle states data through the updated device tree source file.

Cc: Chander Kashyap <k.chander@samsung.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts | 23 +++++++++++++++++++++++
 drivers/cpuidle/Kconfig.arm                |  1 +
 drivers/cpuidle/cpuidle-big_little.c       | 19 +++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts=
/vexpress-v2p-ca15_a7.dts
index a25c262..322fd15 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -38,6 +38,7 @@
 =09=09=09compatible =3D "arm,cortex-a15";
 =09=09=09reg =3D <0>;
 =09=09=09cci-control-port =3D <&cci_control1>;
+=09=09=09cpu-idle-states =3D <&CLUSTER_SLEEP_BIG>;
 =09=09};
=20
 =09=09cpu1: cpu@1 {
@@ -45,6 +46,7 @@
 =09=09=09compatible =3D "arm,cortex-a15";
 =09=09=09reg =3D <1>;
 =09=09=09cci-control-port =3D <&cci_control1>;
+=09=09=09cpu-idle-states =3D <&CLUSTER_SLEEP_BIG>;
 =09=09};
=20
 =09=09cpu2: cpu@2 {
@@ -52,6 +54,7 @@
 =09=09=09compatible =3D "arm,cortex-a7";
 =09=09=09reg =3D <0x100>;
 =09=09=09cci-control-port =3D <&cci_control2>;
+=09=09=09cpu-idle-states =3D <&CLUSTER_SLEEP_LITTLE>;
 =09=09};
=20
 =09=09cpu3: cpu@3 {
@@ -59,6 +62,7 @@
 =09=09=09compatible =3D "arm,cortex-a7";
 =09=09=09reg =3D <0x101>;
 =09=09=09cci-control-port =3D <&cci_control2>;
+=09=09=09cpu-idle-states =3D <&CLUSTER_SLEEP_LITTLE>;
 =09=09};
=20
 =09=09cpu4: cpu@4 {
@@ -66,6 +70,25 @@
 =09=09=09compatible =3D "arm,cortex-a7";
 =09=09=09reg =3D <0x102>;
 =09=09=09cci-control-port =3D <&cci_control2>;
+=09=09=09cpu-idle-states =3D <&CLUSTER_SLEEP_LITTLE>;
+=09=09};
+
+=09=09idle-states {
+=09=09=09CLUSTER_SLEEP_BIG: cluster-sleep-big {
+=09=09=09=09compatible =3D "arm,idle-state";
+=09=09=09=09local-timer-stop;
+=09=09=09=09entry-latency-us =3D <1000>;
+=09=09=09=09exit-latency-us =3D <700>;
+=09=09=09=09min-residency-us =3D <2000>;
+=09=09=09};
+
+=09=09=09CLUSTER_SLEEP_LITTLE: cluster-sleep-little {
+=09=09=09=09compatible =3D "arm,idle-state";
+=09=09=09=09local-timer-stop;
+=09=09=09=09entry-latency-us =3D <1000>;
+=09=09=09=09exit-latency-us =3D <500>;
+=09=09=09=09min-residency-us =3D <2500>;
+=09=09=09};
 =09=09};
 =09};
=20
diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 38cff69..e339c7f 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -7,6 +7,7 @@ config ARM_BIG_LITTLE_CPUIDLE
 =09depends on MCPM
 =09select ARM_CPU_SUSPEND
 =09select CPU_IDLE_MULTIPLE_DRIVERS
+=09select DT_IDLE_STATES
 =09help
 =09  Select this option to enable CPU idle driver for big.LITTLE based
 =09  ARM systems. Driver manages CPUs coordination through MCPM and
diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle=
-big_little.c
index ef94c3b..85d09bc 100644
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
@@ -73,6 +75,12 @@ static struct cpuidle_driver bl_idle_little_driver =3D {
 =09.state_count =3D 2,
 };
=20
+static const struct of_device_id bl_idle_state_match[] __initconst =3D {
+=09{ .compatible =3D "arm,idle-state",
+=09  .data =3D bl_enter_powerdown },
+=09{ },
+};
+
 static struct cpuidle_driver bl_idle_big_driver =3D {
 =09.name =3D "big_idle",
 =09.owner =3D THIS_MODULE,
@@ -190,6 +198,17 @@ static int __init bl_idle_init(void)
 =09if (ret)
 =09=09goto out_uninit_little;
=20
+=09/* Start at index 1, index 0 standard WFI */
+=09ret =3D dt_init_idle_driver(&bl_idle_big_driver, bl_idle_state_match, 1=
);
+=09if (ret < 0)
+=09=09goto out_uninit_big;
+
+=09/* Start at index 1, index 0 standard WFI */
+=09ret =3D dt_init_idle_driver(&bl_idle_little_driver,
+=09=09=09=09  bl_idle_state_match, 1);
+=09if (ret < 0)
+=09=09goto out_uninit_big;
+
 =09ret =3D cpuidle_register(&bl_idle_little_driver, NULL);
 =09if (ret)
 =09=09goto out_uninit_big;
--=20
1.9.1


