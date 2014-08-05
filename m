From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v5 1/5] ARM: EXYNOS: PM: replace EXYNOS_BOOT_VECTOR_* macros by
 static inlines
Date: Tue, 05 Aug 2014 15:34:22 +0200
Message-ID: <1407245666-20016-2-git-send-email-b.zolnierkie@samsung.com>
References: <1407245666-20016-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1407245666-20016-1-git-send-email-b.zolnierkie@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Sachin Kamat <sachin.kamat@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Replace EXYNOS_BOOT_VECTOR_ADDR and EXYNOS_BOOT_VECTOR_FLAG macros
by exynos_boot_vector_addr() and exynos_boot_vector_flag() static
inlines.

This patch shouldn't cause any functionality changes.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-exynos/pm.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 454c1cc..78e50ed 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -101,16 +101,23 @@ static int exynos_irq_set_wake(struct irq_data *data, unsigned int state)
 	return -ENOENT;
 }
 
-#define EXYNOS_BOOT_VECTOR_ADDR	(samsung_rev() == EXYNOS4210_REV_1_1 ? \
-			pmu_base_addr + S5P_INFORM7 : \
-			(samsung_rev() == EXYNOS4210_REV_1_0 ? \
-			(sysram_base_addr + 0x24) : \
-			pmu_base_addr + S5P_INFORM0))
-#define EXYNOS_BOOT_VECTOR_FLAG	(samsung_rev() == EXYNOS4210_REV_1_1 ? \
-			pmu_base_addr + S5P_INFORM6 : \
-			(samsung_rev() == EXYNOS4210_REV_1_0 ? \
-			(sysram_base_addr + 0x20) : \
-			pmu_base_addr + S5P_INFORM1))
+static inline void __iomem *exynos_boot_vector_addr(void)
+{
+	if (samsung_rev() == EXYNOS4210_REV_1_1)
+		return pmu_base_addr + S5P_INFORM7;
+	else if (samsung_rev() == EXYNOS4210_REV_1_0)
+		return sysram_base_addr + 0x24;
+	return pmu_base_addr + S5P_INFORM0;
+}
+
+static inline void __iomem *exynos_boot_vector_flag(void)
+{
+	if (samsung_rev() == EXYNOS4210_REV_1_1)
+		return pmu_base_addr + S5P_INFORM6;
+	else if (samsung_rev() == EXYNOS4210_REV_1_0)
+		return sysram_base_addr + 0x20;
+	return pmu_base_addr + S5P_INFORM1;
+}
 
 #define S5P_CHECK_AFTR  0xFCBA0D10
 #define S5P_CHECK_SLEEP 0x00000BAD
@@ -195,8 +202,9 @@ static void exynos_set_wakeupmask(long mask)
 
 static void exynos_cpu_set_boot_vector(long flags)
 {
-	__raw_writel(virt_to_phys(exynos_cpu_resume), EXYNOS_BOOT_VECTOR_ADDR);
-	__raw_writel(flags, EXYNOS_BOOT_VECTOR_FLAG);
+	__raw_writel(virt_to_phys(exynos_cpu_resume),
+		     exynos_boot_vector_addr());
+	__raw_writel(flags, exynos_boot_vector_flag());
 }
 
 static int exynos_aftr_finisher(unsigned long flags)
-- 
1.8.2.3
