From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [RFC 4/5] clk: tegra: Add soctherm and tsensor clocks to T124 initialization table
Date: Thu, 19 Jun 2014 14:50:39 +0300
Message-ID: <1403178640-16052-5-git-send-email-mperttunen@nvidia.com>
References: <1403178640-16052-1-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1403178640-16052-1-git-send-email-mperttunen@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: swarren@wwwdotorg.org, thierry.reding@gmail.com, pdeschrijver@nvidia.com, rui.zhang@intel.com, edubezval@gmail.com
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mikko.perttunen@kapsi.fi, mlongnecker@nvidia.com, dtundlam@nvidia.com, talho@nvidia.com, Mikko Perttunen <mperttunen@nvidia.com>
List-Id: linux-pm@vger.kernel.org

This adds the two clocks, soctherm and tsensor, to the T124 initialization table.
They are required for soctherm-based thermal sensing.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/clk/tegra/clk-tegra124.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
index 80efe51..abeec63 100644
--- a/drivers/clk/tegra/clk-tegra124.c
+++ b/drivers/clk/tegra/clk-tegra124.c
@@ -1369,6 +1369,8 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{TEGRA124_CLK_XUSB_HS_SRC, TEGRA124_CLK_PLL_U_60M, 60000000, 0},
 	{TEGRA124_CLK_XUSB_FALCON_SRC, TEGRA124_CLK_PLL_RE_OUT, 224000000, 0},
 	{TEGRA124_CLK_XUSB_HOST_SRC, TEGRA124_CLK_PLL_RE_OUT, 112000000, 0},
+	{TEGRA124_CLK_SOC_THERM, TEGRA124_CLK_PLL_P, 51000000, 0},
+	{TEGRA124_CLK_TSENSOR, TEGRA124_CLK_CLK_M, 400000, 0},
 	/* This MUST be the last entry. */
 	{TEGRA124_CLK_CLK_MAX, TEGRA124_CLK_CLK_MAX, 0, 0},
 };
-- 
1.8.1.5
