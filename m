From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: [PATCH v6 6/6] mcpm: exynos: populate suspend and powered_up callbacks
Date: Fri, 16 May 2014 13:33:58 +0530
Message-ID: <1400227438-27155-7-git-send-email-chander.kashyap@linaro.org>
References: <CANuQgHGSA+R__raSa_tzrgpceqLD2SZw+s0XQUHGF4wscgh6Kg@mail.gmail.com>
 <1400227438-27155-1-git-send-email-chander.kashyap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1400227438-27155-1-git-send-email-chander.kashyap@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Chander Kashyap <k.chander@samsung.com>, lorenzo.pieralisi@arm.com, daniel.lezcano@linaro.org, rjw@rjwysocki.net, tomasz.figa@gmail.com, Chander Kashyap <chander.kashyap@linaro.org>, kgene.kim@samsung.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

In order to support cpuidle through mcpm, suspend and powered-up
callbacks are required in mcpm platform code.
Hence populate the same callbacks.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
Signed-off-by: Chander Kashyap <k.chander@samsung.com>
---
Changes in v6: None
Changes in v5:
	1. Add comment to address cache access while c-bit is cleared in SCLTR
	2. Make exynos_powered_up static
Changes in v4: None
Changes in v3:
	1. Removed coherency enablement after suspend failure.
	2. Use generic function to poweron cpu.
changes in v2:
	1. Fixed typo: enynos_pmu_cpunr to exynos_pmu_cpunr
 arch/arm/mach-exynos/mcpm-exynos.c |   36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
index c6bb3a4..623dfa7 100644
--- a/arch/arm/mach-exynos/mcpm-exynos.c
+++ b/arch/arm/mach-exynos/mcpm-exynos.c
@@ -253,10 +253,46 @@ static int exynos_power_down_finish(unsigned int cpu, unsigned int cluster)
 	return -ETIMEDOUT; /* timeout */
 }
 
+static void exynos_powered_up(void)
+{
+	unsigned int mpidr, cpu, cluster;
+
+	mpidr = read_cpuid_mpidr();
+	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+
+	arch_spin_lock(&exynos_mcpm_lock);
+	if (cpu_use_count[cpu][cluster] == 0)
+		cpu_use_count[cpu][cluster] = 1;
+	arch_spin_unlock(&exynos_mcpm_lock);
+}
+
+static void exynos_suspend(u64 residency)
+{
+	unsigned int mpidr, cpunr;
+
+	exynos_power_down();
+
+	/*
+	 * Execution reaches here only if cpu did not power down.
+	 * Hence roll back the changes done in exynos_power_down function.
+	 *
+	 * CAUTION: "This function requires the stack data to be visible through
+	 * power down and can only be executed on processors like A15 and A7
+	 * that hit the cache with the C bit clear in the SCTLR register."
+	*/
+	mpidr = read_cpuid_mpidr();
+	cpunr = exynos_pmu_cpunr(mpidr);
+
+	exynos_cpu_power_up(cpunr);
+}
+
 static const struct mcpm_platform_ops exynos_power_ops = {
 	.power_up		= exynos_power_up,
 	.power_down		= exynos_power_down,
 	.power_down_finish	= exynos_power_down_finish,
+	.suspend		= exynos_suspend,
+	.powered_up		= exynos_powered_up,
 };
 
 static void __init exynos_mcpm_usage_count_init(void)
-- 
1.7.9.5
