From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 1/2] cpufreq: s5pv210: use relaxed IO accesors
Date: Wed, 22 Jun 2016 10:36:37 +0100
Message-ID: <1466588198-27445-2-git-send-email-ben.dooks@codethink.co.uk>
References: <1466588198-27445-1-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1466588198-27445-1-git-send-email-ben.dooks@codethink.co.uk>
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
 drivers/cpufreq/s5pv210-cpufreq.c | 68 +++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index 4f4e9df..6bab65b 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -220,7 +220,7 @@ static void s5pv210_set_refresh(enum s5pv210_dmc_port ch, unsigned long freq)
 
 	tmp1 /= tmp;
 
-	__raw_writel(tmp1, reg);
+	writel_relaxed(tmp1, reg);
 }
 
 static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
@@ -297,29 +297,29 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
 		 * 1. Temporary Change divider for MFC and G3D
 		 * SCLKA2M(200/1=200)->(200/4=50)Mhz
 		 */
-		reg = __raw_readl(S5P_CLK_DIV2);
+		reg = readl_relaxed(S5P_CLK_DIV2);
 		reg &= ~(S5P_CLKDIV2_G3D_MASK | S5P_CLKDIV2_MFC_MASK);
 		reg |= (3 << S5P_CLKDIV2_G3D_SHIFT) |
 			(3 << S5P_CLKDIV2_MFC_SHIFT);
-		__raw_writel(reg, S5P_CLK_DIV2);
+		writel_relaxed(reg, S5P_CLK_DIV2);
 
 		/* For MFC, G3D dividing */
 		do {
-			reg = __raw_readl(S5P_CLKDIV_STAT0);
+			reg = readl_relaxed(S5P_CLKDIV_STAT0);
 		} while (reg & ((1 << 16) | (1 << 17)));
 
 		/*
 		 * 2. Change SCLKA2M(200Mhz)to SCLKMPLL in MFC_MUX, G3D MUX
 		 * (200/4=50)->(667/4=166)Mhz
 		 */
-		reg = __raw_readl(S5P_CLK_SRC2);
+		reg = readl_relaxed(S5P_CLK_SRC2);
 		reg &= ~(S5P_CLKSRC2_G3D_MASK | S5P_CLKSRC2_MFC_MASK);
 		reg |= (1 << S5P_CLKSRC2_G3D_SHIFT) |
 			(1 << S5P_CLKSRC2_MFC_SHIFT);
-		__raw_writel(reg, S5P_CLK_SRC2);
+		writel_relaxed(reg, S5P_CLK_SRC2);
 
 		do {
-			reg = __raw_readl(S5P_CLKMUX_STAT1);
+			reg = readl_relaxed(S5P_CLKMUX_STAT1);
 		} while (reg & ((1 << 7) | (1 << 3)));
 
 		/*
@@ -331,19 +331,19 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
 			s5pv210_set_refresh(DMC1, 133000);
 
 		/* 4. SCLKAPLL -> SCLKMPLL */
-		reg = __raw_readl(S5P_CLK_SRC0);
+		reg = readl_relaxed(S5P_CLK_SRC0);
 		reg &= ~(S5P_CLKSRC0_MUX200_MASK);
 		reg |= (0x1 << S5P_CLKSRC0_MUX200_SHIFT);
-		__raw_writel(reg, S5P_CLK_SRC0);
+		writel_relaxed(reg, S5P_CLK_SRC0);
 
 		do {
-			reg = __raw_readl(S5P_CLKMUX_STAT0);
+			reg = readl_relaxed(S5P_CLKMUX_STAT0);
 		} while (reg & (0x1 << 18));
 
 	}
 
 	/* Change divider */
-	reg = __raw_readl(S5P_CLK_DIV0);
+	reg = readl_relaxed(S5P_CLK_DIV0);
 
 	reg &= ~(S5P_CLKDIV0_APLL_MASK | S5P_CLKDIV0_A2M_MASK |
 		S5P_CLKDIV0_HCLK200_MASK | S5P_CLKDIV0_PCLK100_MASK |
@@ -359,25 +359,25 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
 		(clkdiv_val[index][6] << S5P_CLKDIV0_HCLK133_SHIFT) |
 		(clkdiv_val[index][7] << S5P_CLKDIV0_PCLK66_SHIFT));
 
-	__raw_writel(reg, S5P_CLK_DIV0);
+	writel_relaxed(reg, S5P_CLK_DIV0);
 
 	do {
-		reg = __raw_readl(S5P_CLKDIV_STAT0);
+		reg = readl_relaxed(S5P_CLKDIV_STAT0);
 	} while (reg & 0xff);
 
 	/* ARM MCS value changed */
-	reg = __raw_readl(S5P_ARM_MCS_CON);
+	reg = readl_relaxed(S5P_ARM_MCS_CON);
 	reg &= ~0x3;
 	if (index >= L3)
 		reg |= 0x3;
 	else
 		reg |= 0x1;
 
-	__raw_writel(reg, S5P_ARM_MCS_CON);
+	writel_relaxed(reg, S5P_ARM_MCS_CON);
 
 	if (pll_changing) {
 		/* 5. Set Lock time = 30us*24Mhz = 0x2cf */
-		__raw_writel(0x2cf, S5P_APLL_LOCK);
+		writel_relaxed(0x2cf, S5P_APLL_LOCK);
 
 		/*
 		 * 6. Turn on APLL
@@ -385,12 +385,12 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
 		 * 6-2. Wait untile the PLL is locked
 		 */
 		if (index == L0)
-			__raw_writel(APLL_VAL_1000, S5P_APLL_CON);
+			writel_relaxed(APLL_VAL_1000, S5P_APLL_CON);
 		else
-			__raw_writel(APLL_VAL_800, S5P_APLL_CON);
+			writel_relaxed(APLL_VAL_800, S5P_APLL_CON);
 
 		do {
-			reg = __raw_readl(S5P_APLL_CON);
+			reg = readl_relaxed(S5P_APLL_CON);
 		} while (!(reg & (0x1 << 29)));
 
 		/*
@@ -398,39 +398,39 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
 		 * to SCLKA2M(200Mhz) in MFC_MUX and G3D MUX
 		 * (667/4=166)->(200/4=50)Mhz
 		 */
-		reg = __raw_readl(S5P_CLK_SRC2);
+		reg = readl_relaxed(S5P_CLK_SRC2);
 		reg &= ~(S5P_CLKSRC2_G3D_MASK | S5P_CLKSRC2_MFC_MASK);
 		reg |= (0 << S5P_CLKSRC2_G3D_SHIFT) |
 			(0 << S5P_CLKSRC2_MFC_SHIFT);
-		__raw_writel(reg, S5P_CLK_SRC2);
+		writel_relaxed(reg, S5P_CLK_SRC2);
 
 		do {
-			reg = __raw_readl(S5P_CLKMUX_STAT1);
+			reg = readl_relaxed(S5P_CLKMUX_STAT1);
 		} while (reg & ((1 << 7) | (1 << 3)));
 
 		/*
 		 * 8. Change divider for MFC and G3D
 		 * (200/4=50)->(200/1=200)Mhz
 		 */
-		reg = __raw_readl(S5P_CLK_DIV2);
+		reg = readl_relaxed(S5P_CLK_DIV2);
 		reg &= ~(S5P_CLKDIV2_G3D_MASK | S5P_CLKDIV2_MFC_MASK);
 		reg |= (clkdiv_val[index][10] << S5P_CLKDIV2_G3D_SHIFT) |
 			(clkdiv_val[index][9] << S5P_CLKDIV2_MFC_SHIFT);
-		__raw_writel(reg, S5P_CLK_DIV2);
+		writel_relaxed(reg, S5P_CLK_DIV2);
 
 		/* For MFC, G3D dividing */
 		do {
-			reg = __raw_readl(S5P_CLKDIV_STAT0);
+			reg = readl_relaxed(S5P_CLKDIV_STAT0);
 		} while (reg & ((1 << 16) | (1 << 17)));
 
 		/* 9. Change MPLL to APLL in MSYS_MUX */
-		reg = __raw_readl(S5P_CLK_SRC0);
+		reg = readl_relaxed(S5P_CLK_SRC0);
 		reg &= ~(S5P_CLKSRC0_MUX200_MASK);
 		reg |= (0x0 << S5P_CLKSRC0_MUX200_SHIFT);
-		__raw_writel(reg, S5P_CLK_SRC0);
+		writel_relaxed(reg, S5P_CLK_SRC0);
 
 		do {
-			reg = __raw_readl(S5P_CLKMUX_STAT0);
+			reg = readl_relaxed(S5P_CLKMUX_STAT0);
 		} while (reg & (0x1 << 18));
 
 		/*
@@ -447,13 +447,13 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
 	 * and memory refresh parameter should be changed
 	 */
 	if (bus_speed_changing) {
-		reg = __raw_readl(S5P_CLK_DIV6);
+		reg = readl_relaxed(S5P_CLK_DIV6);
 		reg &= ~S5P_CLKDIV6_ONEDRAM_MASK;
 		reg |= (clkdiv_val[index][8] << S5P_CLKDIV6_ONEDRAM_SHIFT);
-		__raw_writel(reg, S5P_CLK_DIV6);
+		writel_relaxed(reg, S5P_CLK_DIV6);
 
 		do {
-			reg = __raw_readl(S5P_CLKDIV_STAT1);
+			reg = readl_relaxed(S5P_CLKDIV_STAT1);
 		} while (reg & (1 << 15));
 
 		/* Reconfigure DRAM refresh counter value */
@@ -493,7 +493,7 @@ static int check_mem_type(void __iomem *dmc_reg)
 {
 	unsigned long val;
 
-	val = __raw_readl(dmc_reg + 0x4);
+	val = readl_relaxed(dmc_reg + 0x4);
 	val = (val & (0xf << 8));
 
 	return val >> 8;
@@ -538,10 +538,10 @@ static int s5pv210_cpu_init(struct cpufreq_policy *policy)
 	}
 
 	/* Find current refresh counter and frequency each DMC */
-	s5pv210_dram_conf[0].refresh = (__raw_readl(dmc_base[0] + 0x30) * 1000);
+	s5pv210_dram_conf[0].refresh = (readl_relaxed(dmc_base[0] + 0x30) * 1000);
 	s5pv210_dram_conf[0].freq = clk_get_rate(dmc0_clk);
 
-	s5pv210_dram_conf[1].refresh = (__raw_readl(dmc_base[1] + 0x30) * 1000);
+	s5pv210_dram_conf[1].refresh = (readl_relaxed(dmc_base[1] + 0x30) * 1000);
 	s5pv210_dram_conf[1].freq = clk_get_rate(dmc1_clk);
 
 	policy->suspend_freq = SLEEP_FREQ;
-- 
2.8.1
