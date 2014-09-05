From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v9 8/8] drivers: cpuidle: initialize Exynos driver through DT
Date: Fri,  5 Sep 2014 18:34:57 +0100
Message-ID: <1409938498-17984-9-git-send-email-lorenzo.pieralisi@arm.com>
References: <1409938498-17984-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:54982 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754746AbaIERfC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Sep 2014 13:35:02 -0400
In-Reply-To: <1409938498-17984-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Chander Kashyap <k.chander@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Mark Brown <broonie@kernel.org>, Paul

With the introduction of DT based idle states, CPUidle drivers for
ARM can now initialize idle states data through properties in the device
tree.

This patch adds code to the Exynos CPUidle driver to dynamically
initialize idle states data through the updated device tree source
files.

Cc: Chander Kashyap <k.chander@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/boot/dts/exynos4210.dtsi | 11 +++++++++++
 arch/arm/boot/dts/exynos5250.dtsi | 11 +++++++++++
 drivers/cpuidle/Kconfig.arm       |  1 +
 drivers/cpuidle/cpuidle-exynos.c  | 18 +++++++++++++++++-
 4 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos42=
10.dtsi
index eab7c7b..69fd1a0 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -48,12 +48,23 @@
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
index 492e1ef..3a758ff 100644
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
index e339c7f..04cc229 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -55,6 +55,7 @@ config ARM_AT91_CPUIDLE
 config ARM_EXYNOS_CPUIDLE
 =09bool "Cpu Idle Driver for the Exynos processors"
 =09depends on ARCH_EXYNOS
+=09select DT_IDLE_STATES
 =09help
 =09  Select this to enable cpuidle for Exynos processors
=20
diff --git a/drivers/cpuidle/cpuidle-exynos.c b/drivers/cpuidle/cpuidle-exy=
nos.c
index ba9b34b..e66a426 100644
--- a/drivers/cpuidle/cpuidle-exynos.c
+++ b/drivers/cpuidle/cpuidle-exynos.c
@@ -18,6 +18,8 @@
 #include <asm/suspend.h>
 #include <asm/cpuidle.h>
=20
+#include "dt_idle_states.h"
+
 static void (*exynos_enter_aftr)(void);
=20
 static int exynos_enter_lowpower(struct cpuidle_device *dev,
@@ -56,13 +58,27 @@ static struct cpuidle_driver exynos_idle_driver =3D {
 =09.safe_state_index =3D 0,
 };
=20
+static const struct of_device_id exynos_idle_state_match[] __initconst =3D=
 {
+=09{ .compatible =3D "arm,idle-state",
+=09  .data =3D exynos_enter_lowpower },
+=09{ },
+};
+
 static int exynos_cpuidle_probe(struct platform_device *pdev)
 {
 =09int ret;
+=09struct cpuidle_driver *drv =3D &exynos_idle_driver;
=20
 =09exynos_enter_aftr =3D (void *)(pdev->dev.platform_data);
=20
-=09ret =3D cpuidle_register(&exynos_idle_driver, NULL);
+=09/* Start at index 1, index 0 standard WFI */
+=09ret =3D dt_init_idle_driver(drv, exynos_idle_state_match, 1);
+=09if (ret < 0) {
+=09=09dev_err(&pdev->dev, "failed to initialize idle states\n");
+=09=09return ret;
+=09}
+
+=09ret =3D cpuidle_register(drv, NULL);
 =09if (ret) {
 =09=09dev_err(&pdev->dev, "failed to register cpuidle driver\n");
 =09=09return ret;
--=20
1.9.1


