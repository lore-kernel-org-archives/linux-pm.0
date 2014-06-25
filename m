From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v5 7/8] drivers: cpuidle: initialize Exynos driver through DT
Date: Wed, 25 Jun 2014 15:10:20 +0100
Message-ID: <1403705421-17597-8-git-send-email-lorenzo.pieralisi@arm.com>
References: <1403705421-17597-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:48740 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757364AbaFYOKf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jun 2014 10:10:35 -0400
In-Reply-To: <1403705421-17597-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Mark Brown <broonie@kernel.org>, Paul Walmsley <paul@pwsan.com>, Chander Kashyap <chander.kashyap@linaro.org>

With the introduction of DT based idle states, CPUidle drivers for
ARM can now initialize idle states data through properties in the device
tree.

This patch adds code to the Exynos CPUidle driver to dynamically
initialize idle states data through the updated device tree source
files.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
Compile tested, I am not sure I patched the right dts files, please check.

 .../devicetree/bindings/arm/exynos/idle-states.txt | 27 ++++++++++++++++++=
++
 arch/arm/boot/dts/exynos3250.dtsi                  | 16 ++++++++++++
 arch/arm/boot/dts/exynos5250.dtsi                  | 15 +++++++++++
 arch/arm/boot/dts/exynos5410.dtsi                  | 17 +++++++++++++
 drivers/cpuidle/Kconfig.arm                        |  1 +
 drivers/cpuidle/cpuidle-exynos.c                   | 29 +++++++++++++-----=
----
 6 files changed, 93 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/exynos/idle-state=
s.txt

diff --git a/Documentation/devicetree/bindings/arm/exynos/idle-states.txt b=
/Documentation/devicetree/bindings/arm/exynos/idle-states.txt
new file mode 100644
index 0000000..342ecb4
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/exynos/idle-states.txt
@@ -0,0 +1,27 @@
+idle-states node
+----------------
+
+On Exynos platforms with power management capabilities, the device
+tree source file must contain the idle-states node[1]. As defined in [1] t=
he
+idle-states node must contain an entry-method property that for Exynos
+platforms can be one of:
+
+=09- "samsung,exynos"
+
+Exynos idle-states nodes example:
+
+=09idle-states {
+=09=09entry-method =3D "samsung,exynos";
+
+=09=09CLUSTER_SLEEP_0: cluster-sleep-0 {
+=09=09=09compatible =3D "arm,idle-state";
+=09=09=09timer-state-retained;
+=09=09=09power-rank =3D <0>;
+=09=09=09entry-latency-us =3D <1000>;
+=09=09=09exit-latency-us =3D <300>;
+=09=09=09min-residency-us =3D <100000>;
+=09=09};
+=09};
+
+[1] ARM Linux Kernel documentation - Idle states bindings
+    Documentation/devicetree/bindings/arm/idle-states.txt
diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos32=
50.dtsi
index 3e678fa..b0ccfca 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -45,11 +45,26 @@
 =09=09#address-cells =3D <1>;
 =09=09#size-cells =3D <0>;
=20
+=09=09idle-states {
+=09=09=09entry-method =3D "samsung,exynos";
+
+=09=09=09CLUSTER_SLEEP_0: cluster-sleep-0 {
+=09=09=09=09compatible =3D "arm,idle-state";
+=09=09=09=09timer-state-retained;
+=09=09=09=09power-rank =3D <0>;
+=09=09=09=09entry-latency-us =3D <1000>;
+=09=09=09=09exit-latency-us =3D <300>;
+=09=09=09=09min-residency-us =3D <100000>;
+=09=09=09};
+
+=09=09};
+
 =09=09cpu0: cpu@0 {
 =09=09=09device_type =3D "cpu";
 =09=09=09compatible =3D "arm,cortex-a7";
 =09=09=09reg =3D <0>;
 =09=09=09clock-frequency =3D <1000000000>;
+=09=09=09cpu-idle-states =3D <&CLUSTER_SLEEP_0>;
 =09=09};
=20
 =09=09cpu1: cpu@1 {
@@ -57,6 +72,7 @@
 =09=09=09compatible =3D "arm,cortex-a7";
 =09=09=09reg =3D <1>;
 =09=09=09clock-frequency =3D <1000000000>;
+=09=09=09cpu-idle-states =3D <&CLUSTER_SLEEP_0>;
 =09=09};
 =09};
=20
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos52=
50.dtsi
index 834fb5a..b806653 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -58,17 +58,32 @@
 =09=09#address-cells =3D <1>;
 =09=09#size-cells =3D <0>;
=20
+=09=09idle-states {
+=09=09=09entry-method =3D "samsung,exynos";
+
+=09=09=09CLUSTER_SLEEP_0: cluster-sleep-0 {
+=09=09=09=09compatible =3D "arm,idle-state";
+=09=09=09=09timer-state-retained;
+=09=09=09=09power-rank =3D <0>;
+=09=09=09=09entry-latency-us =3D <1000>;
+=09=09=09=09exit-latency-us =3D <300>;
+=09=09=09=09min-residency-us =3D <100000>;
+=09=09=09};
+=09=09};
+
 =09=09cpu@0 {
 =09=09=09device_type =3D "cpu";
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
 =09=09};
 =09};
=20
diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos54=
10.dtsi
index 3839c26..82e4b7b 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -24,28 +24,45 @@
 =09=09#address-cells =3D <1>;
 =09=09#size-cells =3D <0>;
=20
+=09=09idle-states {
+=09=09=09entry-method =3D "samsung,exynos";
+
+=09=09=09CLUSTER_SLEEP_0: cluster-sleep-0 {
+=09=09=09=09compatible =3D "arm,idle-state";
+=09=09=09=09timer-state-retained;
+=09=09=09=09power-rank =3D <0>;
+=09=09=09=09entry-latency-us =3D <1000>;
+=09=09=09=09exit-latency-us =3D <300>;
+=09=09=09=09min-residency-us =3D <100000>;
+=09=09=09};
+=09=09};
+
 =09=09CPU0: cpu@0 {
 =09=09=09device_type =3D "cpu";
 =09=09=09compatible =3D "arm,cortex-a15";
 =09=09=09reg =3D <0x0>;
+=09=09=09cpu-idle-states =3D <&CLUSTER_SLEEP_0>;
 =09=09};
=20
 =09=09CPU1: cpu@1 {
 =09=09=09device_type =3D "cpu";
 =09=09=09compatible =3D "arm,cortex-a15";
 =09=09=09reg =3D <0x1>;
+=09=09=09cpu-idle-states =3D <&CLUSTER_SLEEP_0>;
 =09=09};
=20
 =09=09CPU2: cpu@2 {
 =09=09=09device_type =3D "cpu";
 =09=09=09compatible =3D "arm,cortex-a15";
 =09=09=09reg =3D <0x2>;
+=09=09=09cpu-idle-states =3D <&CLUSTER_SLEEP_0>;
 =09=09};
=20
 =09=09CPU3: cpu@3 {
 =09=09=09device_type =3D "cpu";
 =09=09=09compatible =3D "arm,cortex-a15";
 =09=09=09reg =3D <0x3>;
+=09=09=09cpu-idle-states =3D <&CLUSTER_SLEEP_0>;
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
index 7c01512..d76af54 100644
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
 static int idle_finisher(unsigned long flags)
@@ -60,26 +62,29 @@ static struct cpuidle_driver exynos_idle_driver =3D {
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
+=09drv->cpumask =3D (struct cpumask *) cpu_possible_mask;
+
+=09/* Start at index 1, index 0 standard WFI */
+=09ret =3D dt_init_idle_driver(drv, NULL, 1, false);
+=09if (ret) {
+=09=09dev_err(&pdev->dev, "failed to initialize idle states\n");
+=09=09return ret;
+=09}
+
+=09for (i =3D 1; i < drv->state_count; i++)
+=09=09drv->states[i].enter =3D exynos_enter_lowpower;
+
+=09ret =3D cpuidle_register(drv, NULL);
 =09if (ret) {
 =09=09dev_err(&pdev->dev, "failed to register cpuidle driver\n");
 =09=09return ret;
--=20
1.9.1


