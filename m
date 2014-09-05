From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v9 7/8] drivers: cpuidle: initialize big.LITTLE driver through DT
Date: Fri,  5 Sep 2014 18:34:56 +0100
Message-ID: <1409938498-17984-8-git-send-email-lorenzo.pieralisi@arm.com>
References: <1409938498-17984-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1409938498-17984-1-git-send-email-lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Chander Kashyap <k.chander-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Charles Garcia Tobin <Charles.Garcia-Tobin-5wv7dgnIgG8@public.gmane.org>, Nicolas Pitre <nico-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Amit Kucheria <amit.kucheria-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Antti Miettinen <ananaza-X3B1VOXEql0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Capella <sebcape-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Geoff
List-Id: linux-pm@vger.kernel.org

With the introduction of DT based idle states, CPUidle drivers for ARM
can now initialize idle states data through properties in the device tree.

This patch adds code to the big.LITTLE CPUidle driver to dynamically
initialize idle states data through the updated device tree source file.

Cc: Chander Kashyap <k.chander-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Acked-by: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Acked-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
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


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
