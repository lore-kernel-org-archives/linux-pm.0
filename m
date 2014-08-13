From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v7 8/8] drivers: cpuidle: initialize Exynos driver through DT
Date: Wed, 13 Aug 2014 16:52:07 +0100
Message-ID: <1407945127-27554-9-git-send-email-lorenzo.pieralisi@arm.com>
References: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Tomasz Figa <t.figa@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Lina Iyer <lina.iyer@linaro.org>, Chander Kashyap <k.chander@samsung.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Nicolas Pitre <nico@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Grant Likely <grant.likely@linaro.org>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, devicetree@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sebastian Capella <sebcape@gmail.com>, Mark Brown <broonie@kernel.org>, Antti Miettinen <ananaza@iki.fi>, Paul Walmsley <paul@pwsan.com>, Geoff Levand <geoff@infradead.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Stephen Boyd <sboyd@codeaurora.org>, Amit Kucheria <amit>
List-Id: linux-pm@vger.kernel.org

With the introduction of DT based idle states, CPUidle drivers for
ARM can now initialize idle states data through properties in the device
tree.

This patch adds code to the Exynos CPUidle driver to dynamically
initialize idle states data through the updated device tree source
files.

Cc: Chander Kashyap <k.chander@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/boot/dts/exynos4210.dtsi | 11 +++++++++++
 arch/arm/boot/dts/exynos5250.dtsi | 11 +++++++++++
 drivers/cpuidle/Kconfig.arm       |  1 +
 drivers/cpuidle/cpuidle-exynos.c  | 27 ++++++++++++++++++++++++---
 4 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index eab7c7b..69fd1a0 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -48,12 +48,23 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0x900>;
+			cpu-idle-states = <&CLUSTER_SLEEP_0>;
 		};
 
 		cpu@901 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0x901>;
+			cpu-idle-states = <&CLUSTER_SLEEP_0>;
+		};
+
+		idle-states {
+			CLUSTER_SLEEP_0: cluster-sleep-0 {
+				compatible = "arm,idle-state";
+				entry-latency-us = <1000>;
+				exit-latency-us = <300>;
+				min-residency-us = <100000>;
+			};
 		};
 	};
 
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 492e1ef..3a758ff 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -63,12 +63,23 @@
 			compatible = "arm,cortex-a15";
 			reg = <0>;
 			clock-frequency = <1700000000>;
+			cpu-idle-states = <&CLUSTER_SLEEP_0>;
 		};
 		cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <1>;
 			clock-frequency = <1700000000>;
+			cpu-idle-states = <&CLUSTER_SLEEP_0>;
+		};
+
+		idle-states {
+			CLUSTER_SLEEP_0: cluster-sleep-0 {
+				compatible = "arm,idle-state";
+				entry-latency-us = <1000>;
+				exit-latency-us = <300>;
+				min-residency-us = <100000>;
+			};
 		};
 	};
 
diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index e339c7f..04cc229 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -55,6 +55,7 @@ config ARM_AT91_CPUIDLE
 config ARM_EXYNOS_CPUIDLE
 	bool "Cpu Idle Driver for the Exynos processors"
 	depends on ARCH_EXYNOS
+	select DT_IDLE_STATES
 	help
 	  Select this to enable cpuidle for Exynos processors
 
diff --git a/drivers/cpuidle/cpuidle-exynos.c b/drivers/cpuidle/cpuidle-exynos.c
index ba9b34b..6dff982 100644
--- a/drivers/cpuidle/cpuidle-exynos.c
+++ b/drivers/cpuidle/cpuidle-exynos.c
@@ -13,11 +13,14 @@
 #include <linux/export.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 
 #include <asm/proc-fns.h>
 #include <asm/suspend.h>
 #include <asm/cpuidle.h>
 
+#include "dt_idle_states.h"
+
 static void (*exynos_enter_aftr)(void);
 
 static int exynos_enter_lowpower(struct cpuidle_device *dev,
@@ -58,17 +61,35 @@ static struct cpuidle_driver exynos_idle_driver = {
 
 static int exynos_cpuidle_probe(struct platform_device *pdev)
 {
-	int ret;
+	int ret, i;
+	struct cpuidle_driver *drv = &exynos_idle_driver;
 
 	exynos_enter_aftr = (void *)(pdev->dev.platform_data);
 
-	ret = cpuidle_register(&exynos_idle_driver, NULL);
+	drv->cpumask = kzalloc(cpumask_size(), GFP_KERNEL);
+	if (!drv->cpumask)
+		return -ENOMEM;
+
+	/* Start at index 1, index 0 standard WFI */
+	ret = dt_init_idle_driver(drv, 1);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to initialize idle states\n");
+		goto free_mem;
+	}
+
+	for (i = 1; i < drv->state_count; i++)
+		drv->states[i].enter = exynos_enter_lowpower;
+
+	ret = cpuidle_register(drv, NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register cpuidle driver\n");
-		return ret;
+		goto free_mem;
 	}
 
 	return 0;
+free_mem:
+	kfree(drv->cpumask);
+	return ret;
 }
 
 static struct platform_driver exynos_cpuidle_driver = {
-- 
1.9.1
