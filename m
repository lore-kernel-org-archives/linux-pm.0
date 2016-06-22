From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 1/2] cpufreq: exynos: use relaxed IO accesors
Date: Wed, 22 Jun 2016 10:33:03 +0100
Message-ID: <1466587984-14105-1-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@lists.codethink.co.uk
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ben Dooks <ben.dooks@codethink.co.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The use of __raw IO accesors is not endian safe and should be used
sparingly. The relaxed variants should be as lightweight and also
are endian safe.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/cpufreq/exynos5440-cpufreq.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
index c0f3373..7a5707f 100644
--- a/drivers/cpufreq/exynos5440-cpufreq.c
+++ b/drivers/cpufreq/exynos5440-cpufreq.c
@@ -155,7 +155,7 @@ static int init_div_table(void)
 		tmp = (clk_div | ema_div | (volt_id << P0_7_VDD_SHIFT)
 			| ((freq / FREQ_UNIT) << P0_7_FREQ_SHIFT));
 
-		__raw_writel(tmp, dvfs_info->base + XMU_PMU_P0_7 + 4 *
+		writel_relaxed(tmp, dvfs_info->base + XMU_PMU_P0_7 + 4 *
 						(pos - freq_tbl));
 	}
 
@@ -169,17 +169,17 @@ static void exynos_enable_dvfs(unsigned int cur_frequency)
 	struct cpufreq_frequency_table *freq_table = dvfs_info->freq_table;
 	struct cpufreq_frequency_table *pos;
 	/* Disable DVFS */
-	__raw_writel(0,	dvfs_info->base + XMU_DVFS_CTRL);
+	writel_relaxed(0,	dvfs_info->base + XMU_DVFS_CTRL);
 
 	/* Enable PSTATE Change Event */
-	tmp = __raw_readl(dvfs_info->base + XMU_PMUEVTEN);
+	tmp = readl_relaxed(dvfs_info->base + XMU_PMUEVTEN);
 	tmp |= (1 << PSTATE_CHANGED_EVTEN_SHIFT);
-	 __raw_writel(tmp, dvfs_info->base + XMU_PMUEVTEN);
+	 writel_relaxed(tmp, dvfs_info->base + XMU_PMUEVTEN);
 
 	/* Enable PSTATE Change IRQ */
-	tmp = __raw_readl(dvfs_info->base + XMU_PMUIRQEN);
+	tmp = readl_relaxed(dvfs_info->base + XMU_PMUIRQEN);
 	tmp |= (1 << PSTATE_CHANGED_IRQEN_SHIFT);
-	 __raw_writel(tmp, dvfs_info->base + XMU_PMUIRQEN);
+	 writel_relaxed(tmp, dvfs_info->base + XMU_PMUIRQEN);
 
 	/* Set initial performance index */
 	cpufreq_for_each_entry(pos, freq_table)
@@ -197,14 +197,14 @@ static void exynos_enable_dvfs(unsigned int cur_frequency)
 						cur_frequency);
 
 	for (cpu = 0; cpu < CONFIG_NR_CPUS; cpu++) {
-		tmp = __raw_readl(dvfs_info->base + XMU_C0_3_PSTATE + cpu * 4);
+		tmp = readl_relaxed(dvfs_info->base + XMU_C0_3_PSTATE + cpu * 4);
 		tmp &= ~(P_VALUE_MASK << C0_3_PSTATE_NEW_SHIFT);
 		tmp |= ((pos - freq_table) << C0_3_PSTATE_NEW_SHIFT);
-		__raw_writel(tmp, dvfs_info->base + XMU_C0_3_PSTATE + cpu * 4);
+		writel_relaxed(tmp, dvfs_info->base + XMU_C0_3_PSTATE + cpu * 4);
 	}
 
 	/* Enable DVFS */
-	__raw_writel(1 << XMU_DVFS_CTRL_EN_SHIFT,
+	writel_relaxed(1 << XMU_DVFS_CTRL_EN_SHIFT,
 				dvfs_info->base + XMU_DVFS_CTRL);
 }
 
@@ -223,11 +223,11 @@ static int exynos_target(struct cpufreq_policy *policy, unsigned int index)
 
 	/* Set the target frequency in all C0_3_PSTATE register */
 	for_each_cpu(i, policy->cpus) {
-		tmp = __raw_readl(dvfs_info->base + XMU_C0_3_PSTATE + i * 4);
+		tmp = readl_relaxed(dvfs_info->base + XMU_C0_3_PSTATE + i * 4);
 		tmp &= ~(P_VALUE_MASK << C0_3_PSTATE_NEW_SHIFT);
 		tmp |= (index << C0_3_PSTATE_NEW_SHIFT);
 
-		__raw_writel(tmp, dvfs_info->base + XMU_C0_3_PSTATE + i * 4);
+		writel_relaxed(tmp, dvfs_info->base + XMU_C0_3_PSTATE + i * 4);
 	}
 	mutex_unlock(&cpufreq_lock);
 	return 0;
@@ -246,7 +246,7 @@ static void exynos_cpufreq_work(struct work_struct *work)
 	mutex_lock(&cpufreq_lock);
 	freqs.old = policy->cur;
 
-	cur_pstate = __raw_readl(dvfs_info->base + XMU_P_STATUS);
+	cur_pstate = readl_relaxed(dvfs_info->base + XMU_P_STATUS);
 	if (cur_pstate >> C0_3_PSTATE_VALID_SHIFT & 0x1)
 		index = (cur_pstate >> C0_3_PSTATE_CURR_SHIFT) & P_VALUE_MASK;
 	else
@@ -270,9 +270,9 @@ static irqreturn_t exynos_cpufreq_irq(int irq, void *id)
 {
 	unsigned int tmp;
 
-	tmp = __raw_readl(dvfs_info->base + XMU_PMUIRQ);
+	tmp = readl_relaxed(dvfs_info->base + XMU_PMUIRQ);
 	if (tmp >> PSTATE_CHANGED_SHIFT & 0x1) {
-		__raw_writel(tmp, dvfs_info->base + XMU_PMUIRQ);
+		writel_relaxed(tmp, dvfs_info->base + XMU_PMUIRQ);
 		disable_irq_nosync(irq);
 		schedule_work(&dvfs_info->irq_work);
 	}
-- 
2.8.1
