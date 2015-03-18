From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 3/5] ARM: EXYNOS: add exynos_set_boot_addr() helper
Date: Wed, 18 Mar 2015 14:09:55 +0100
Message-ID: <1426684197-22281-4-git-send-email-b.zolnierkie@samsung.com>
References: <1426684197-22281-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1426684197-22281-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Colin Cross <ccross@google.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Add exynos_set_boot_addr() helper and covert existing code
(exynos_boot_secondary() and exynos_smp_prepare_cpus()) to
use it.

There should be no functional changes caused by this patch.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/platsmp.c | 53 +++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 6f7a1c7..b7cfcdc 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -247,6 +247,31 @@ static void exynos_secondary_init(unsigned int cpu)
 	spin_unlock(&boot_lock);
 }
 
+static int exynos_set_boot_addr(u32 core_id, unsigned long boot_addr)
+{
+	int ret;
+
+	/*
+	 * Try to set boot address using firmware first
+	 * and fall back to boot register if it fails.
+	 */
+	ret = call_firmware_op(set_cpu_boot_addr, core_id, boot_addr);
+	if (ret && ret != -ENOSYS)
+		goto fail;
+	if (ret == -ENOSYS) {
+		void __iomem *boot_reg = cpu_boot_reg(core_id);
+
+		if (IS_ERR(boot_reg)) {
+			ret = PTR_ERR(boot_reg);
+			goto fail;
+		}
+		__raw_writel(boot_addr, boot_reg);
+		ret = 0;
+	}
+fail:
+	return ret;
+}
+
 static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	unsigned long timeout;
@@ -306,22 +331,9 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 		boot_addr = virt_to_phys(exynos4_secondary_startup);
 
-		/*
-		 * Try to set boot address using firmware first
-		 * and fall back to boot register if it fails.
-		 */
-		ret = call_firmware_op(set_cpu_boot_addr, core_id, boot_addr);
-		if (ret && ret != -ENOSYS)
+		ret = exynos_set_boot_addr(core_id, boot_addr);
+		if (ret)
 			goto fail;
-		if (ret == -ENOSYS) {
-			void __iomem *boot_reg = cpu_boot_reg(core_id);
-
-			if (IS_ERR(boot_reg)) {
-				ret = PTR_ERR(boot_reg);
-				goto fail;
-			}
-			__raw_writel(boot_addr, boot_reg);
-		}
 
 		call_firmware_op(cpu_boot, core_id);
 
@@ -409,16 +421,9 @@ static void __init exynos_smp_prepare_cpus(unsigned int max_cpus)
 		core_id = MPIDR_AFFINITY_LEVEL(mpidr, 0);
 		boot_addr = virt_to_phys(exynos4_secondary_startup);
 
-		ret = call_firmware_op(set_cpu_boot_addr, core_id, boot_addr);
-		if (ret && ret != -ENOSYS)
+		ret = exynos_set_boot_addr(core_id, boot_addr);
+		if (ret)
 			break;
-		if (ret == -ENOSYS) {
-			void __iomem *boot_reg = cpu_boot_reg(core_id);
-
-			if (IS_ERR(boot_reg))
-				break;
-			__raw_writel(boot_addr, boot_reg);
-		}
 	}
 }
 
-- 
1.8.2.3
