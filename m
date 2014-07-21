From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v6 7/7] drivers: cpuidle: initialize Exynos driver through DT
Date: Mon, 21 Jul 2014 17:06:26 +0100
Message-ID: <1405958786-17243-8-git-send-email-lorenzo.pieralisi@arm.com>
References: <1405958786-17243-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:42271 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932793AbaGUQGt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jul 2014 12:06:49 -0400
In-Reply-To: <1405958786-17243-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Chander Kashyap <chander.kashyap@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Mark Brown <broonie@kernel.org>, Paul

With the introduction of DT based idle states, CPUidle drivers for
ARM can now initialize idle states data through properties in the device
tree.

This patch adds code to the Exynos CPUidle driver to dynamically
initialize idle states data through the updated device tree source
files.

Cc: Chander Kashyap <chander.kashyap@linaro.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/boot/dts/exynos4210.dtsi | 11 +++++++++++
 arch/arm/boot/dts/exynos5250.dtsi | 11 +++++++++++
 drivers/cpuidle/Kconfig.arm       |  1 +
 drivers/cpuidle/cpuidle-exynos.c  | 37 ++++++++++++++++++++++++-----------=
--
 4 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos42=
10.dtsi
index bc2b444..0270100 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -39,12 +39,23 @@
 =09=09=09device_type =3D "cpu";
 =09=09=09compatible =3D "arm,cortex-a9";
 =09=09=09reg =3D <0x900>;
+=09=09=09cpu-idle-states =3D <&CLUSTER_SLEEP_0>;
 =09=09};
=20
 =09=09cpu@901 {
 =09=09=09device_type =3D "cpu";
 =09=09=09compatible =3D "arm,cortex-a9";
 =09=09=09reg =3D <0x901>;
+=09=09=09cpu-idle-states =3D <&CLUSTER_SLEEP_0>;
+=09=09};
+
+=09=09idle-states {
+=09=09=09CLUSTER_SLEEP_0: cluster-sleep-0 {
+=09=09=09=09compatible =3D "arm,idle-state";
+=09=09=09=09entry-latency-us =3D <1000>;
+=09=09=09=09exit-latency-us =3D <300>;
+=09=09=09=09min-residency-us =3D <100000>;
+=09=09=09};
 =09=09};
 =09};
=20
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos52=
50.dtsi
index 834fb5a..631906e 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -63,12 +63,23 @@
 =09=09=09compatible =3D "arm,cortex-a15";
 =09=09=09reg =3D <0>;
 =09=09=09clock-frequency =3D <1700000000>;
+=09=09=09cpu-idle-states =3D <&CLUSTER_SLEEP_0>;
 =09=09};
 =09=09cpu@1 {
 =09=09=09device_type =3D "cpu";
 =09=09=09compatible =3D "arm,cortex-a15";
 =09=09=09reg =3D <1>;
 =09=09=09clock-frequency =3D <1700000000>;
+=09=09=09cpu-idle-states =3D <&CLUSTER_SLEEP_0>;
+=09=09};
+
+=09=09idle-states {
+=09=09=09CLUSTER_SLEEP_0: cluster-sleep-0 {
+=09=09=09=09compatible =3D "arm,idle-state";
+=09=09=09=09entry-latency-us =3D <1000>;
+=09=09=09=09exit-latency-us =3D <300>;
+=09=09=09=09min-residency-us =3D <100000>;
+=09=09=09};
 =09=09};
 =09};
=20
diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index a9b089c..d8a9cd2 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -60,5 +60,6 @@ config ARM_AT91_CPUIDLE
 config ARM_EXYNOS_CPUIDLE
 =09bool "Cpu Idle Driver for the Exynos processors"
 =09depends on ARCH_EXYNOS
+=09select DT_IDLE_STATES
 =09help
 =09  Select this to enable cpuidle for Exynos processors
diff --git a/drivers/cpuidle/cpuidle-exynos.c b/drivers/cpuidle/cpuidle-exy=
nos.c
index 7c01512..097c21d 100644
--- a/drivers/cpuidle/cpuidle-exynos.c
+++ b/drivers/cpuidle/cpuidle-exynos.c
@@ -13,11 +13,14 @@
 #include <linux/export.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
=20
 #include <asm/proc-fns.h>
 #include <asm/suspend.h>
 #include <asm/cpuidle.h>
=20
+#include "dt_idle_states.h"
+
 static void (*exynos_enter_aftr)(void);
=20
 static int idle_finisher(unsigned long flags)
@@ -60,32 +63,40 @@ static struct cpuidle_driver exynos_idle_driver =3D {
 =09.owner=09=09=09=3D THIS_MODULE,
 =09.states =3D {
 =09=09[0] =3D ARM_CPUIDLE_WFI_STATE,
-=09=09[1] =3D {
-=09=09=09.enter=09=09=09=3D exynos_enter_lowpower,
-=09=09=09.exit_latency=09=09=3D 300,
-=09=09=09.target_residency=09=3D 100000,
-=09=09=09.flags=09=09=09=3D CPUIDLE_FLAG_TIME_VALID,
-=09=09=09.name=09=09=09=3D "C1",
-=09=09=09.desc=09=09=09=3D "ARM power down",
-=09=09},
 =09},
-=09.state_count =3D 2,
-=09.safe_state_index =3D 0,
 };
=20
 static int exynos_cpuidle_probe(struct platform_device *pdev)
 {
-=09int ret;
+=09int ret, i;
+=09struct cpuidle_driver *drv =3D &exynos_idle_driver;
=20
 =09exynos_enter_aftr =3D (void *)(pdev->dev.platform_data);
=20
-=09ret =3D cpuidle_register(&exynos_idle_driver, NULL);
+=09drv->cpumask =3D kzalloc(cpumask_size(), GFP_KERNEL);
+=09if (!drv->cpumask)
+=09=09return -ENOMEM;
+
+=09/* Start at index 1, index 0 standard WFI */
+=09ret =3D dt_init_idle_driver(drv, 1);
+=09if (ret) {
+=09=09dev_err(&pdev->dev, "failed to initialize idle states\n");
+=09=09goto free_mem;
+=09}
+
+=09for (i =3D 1; i < drv->state_count; i++)
+=09=09drv->states[i].enter =3D exynos_enter_lowpower;
+
+=09ret =3D cpuidle_register(drv, NULL);
 =09if (ret) {
 =09=09dev_err(&pdev->dev, "failed to register cpuidle driver\n");
-=09=09return ret;
+=09=09goto free_mem;
 =09}
=20
 =09return 0;
+free_mem:
+=09kfree(drv->cpumask);
+=09return ret;
 }
=20
 static struct platform_driver exynos_cpuidle_driver =3D {
--=20
1.9.1


