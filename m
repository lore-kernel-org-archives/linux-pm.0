From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Subject: [PATCH v8 08/18] clk: tegra: Save/restore CCLKG_BURST_POLICY on
 suspend
Date: Sun,  1 Mar 2015 14:44:31 +0200
Message-ID: <1425213881-5262-9-git-send-email-mikko.perttunen@kapsi.fi>
References: <1425213881-5262-1-git-send-email-mikko.perttunen@kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1425213881-5262-1-git-send-email-mikko.perttunen@kapsi.fi>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: swarren@wwwdotorg.org, thierry.reding@gmail.com, gnurou@gmail.com, pdeschrijver@nvidia.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: pgaikwad@nvidia.com, mturquette@linaro.org, vinceh@nvidia.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, tuomas.tynkkynen@iki.fi, Mikko Perttunen <mikko.perttunen@kapsi.fi>, Tuomas Tynkkynen <ttynkkynen@nvidia.com>, pwalmsley@nvidia.com, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

From: Tuomas Tynkkynen <ttynkkynen@nvidia.com>

Save and restore this register since the LP1 restore assembly routines
fiddle with it. Otherwise the CPU would keep running on PLLX after
resume from suspend even when DFLL was the original clocksource.

Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
Signed-off-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/clk/tegra/clk-tegra124.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
index 6c96daf..48dbeac 100644
--- a/drivers/clk/tegra/clk-tegra124.c
+++ b/drivers/clk/tegra/clk-tegra124.c
@@ -98,6 +98,8 @@
 #define PMC_PLLM_WB0_OVERRIDE 0x1dc
 #define PMC_PLLM_WB0_OVERRIDE_2 0x2b0
 
+#define CCLKG_BURST_POLICY 0x368
+
 #define UTMIP_PLL_CFG2 0x488
 #define UTMIP_PLL_CFG2_STABLE_COUNT(x) (((x) & 0xffff) << 6)
 #define UTMIP_PLL_CFG2_ACTIVE_DLY_COUNT(x) (((x) & 0x3f) << 18)
@@ -130,6 +132,8 @@
 #ifdef CONFIG_PM_SLEEP
 static struct cpu_clk_suspend_context {
 	u32 clk_csite_src;
+	u32 cclkg_burst;
+	u32 cclkg_divider;
 } tegra124_cpu_clk_sctx;
 #endif
 
@@ -1330,12 +1334,22 @@ static void tegra124_cpu_clock_suspend(void)
 	tegra124_cpu_clk_sctx.clk_csite_src =
 				readl(clk_base + CLK_SOURCE_CSITE);
 	writel(3 << 30, clk_base + CLK_SOURCE_CSITE);
+
+	tegra124_cpu_clk_sctx.cclkg_burst =
+				readl(clk_base + CCLKG_BURST_POLICY);
+	tegra124_cpu_clk_sctx.cclkg_divider =
+				readl(clk_base + CCLKG_BURST_POLICY + 4);
 }
 
 static void tegra124_cpu_clock_resume(void)
 {
 	writel(tegra124_cpu_clk_sctx.clk_csite_src,
 				clk_base + CLK_SOURCE_CSITE);
+
+	writel(tegra124_cpu_clk_sctx.cclkg_burst,
+					clk_base + CCLKG_BURST_POLICY);
+	writel(tegra124_cpu_clk_sctx.cclkg_divider,
+					clk_base + CCLKG_BURST_POLICY + 4);
 }
 #endif
 
-- 
2.3.0
