From: Vince Hsu <vinceh@nvidia.com>
Subject: [PATCH v2 03/17] memory: tegra: add flush operation for Tegra30 memory clients
Date: Thu, 12 Mar 2015 20:15:04 +0800
Message-ID: <1426162518-7405-4-git-send-email-vinceh@nvidia.com>
References: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, pdeschrijver@nvidia.com, swarren@wwwdotorg.org, gnurou@gmail.com, jroedel@suse.de, p.zabel@pengutronix.de, mturquette@linaro.org, pgaikwad@nvidia.com, sboyd@codeaurora.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tbergstrom@nvidia.com, airlied@linux.ie, bhelgaas@google.com, tj@kernel.org, arnd@arndb.de, robh@kernel.org, will.deacon@arm.com
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, Vince Hsu <vinceh@nvidia.com>
List-Id: linux-pm@vger.kernel.org

This patch adds the hot reset register table and flush related callback
functions for Tegra30.

Signed-off-by: Vince Hsu <vinceh@nvidia.com>
---
 drivers/memory/tegra/tegra30.c | 78 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/memory/tegra/tegra30.c b/drivers/memory/tegra/tegra30.c
index 3ed4bf409a72..71ed7ee0aace 100644
--- a/drivers/memory/tegra/tegra30.c
+++ b/drivers/memory/tegra/tegra30.c
@@ -6,6 +6,8 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/of.h>
 #include <linux/mm.h>
 
@@ -936,6 +938,79 @@ static const struct tegra_smmu_swgroup tegra30_swgroups[] = {
 	{ .swgroup = TEGRA_SWGROUP_ISP,  .reg = 0x258 },
 };
 
+static struct tegra_mc_hotreset tegra30_mc_hotreset[] = {
+	{TEGRA_SWGROUP_AFI,        0x200, 0x204,  0},
+	{TEGRA_SWGROUP_AVPC,       0x200, 0x204,  1},
+	{TEGRA_SWGROUP_DC,         0x200, 0x204,  2},
+	{TEGRA_SWGROUP_DCB,        0x200, 0x204,  3},
+	{TEGRA_SWGROUP_EPP,        0x200, 0x204,  4},
+	{TEGRA_SWGROUP_G2,         0x200, 0x204,  5},
+	{TEGRA_SWGROUP_HC,         0x200, 0x204,  6},
+	{TEGRA_SWGROUP_HDA,        0x200, 0x204,  7},
+	{TEGRA_SWGROUP_ISP,        0x200, 0x204,  8},
+	{TEGRA_SWGROUP_MPCORE,     0x200, 0x204,  9},
+	{TEGRA_SWGROUP_MPCORELP,   0x200, 0x204, 10},
+	{TEGRA_SWGROUP_MPE,        0x200, 0x204, 11},
+	{TEGRA_SWGROUP_NV,         0x200, 0x204, 12},
+	{TEGRA_SWGROUP_NV2,        0x200, 0x204, 13},
+	{TEGRA_SWGROUP_PPCS,       0x200, 0x204, 14},
+	{TEGRA_SWGROUP_VDE,        0x200, 0x204, 16},
+	{TEGRA_SWGROUP_VI,         0x200, 0x204, 17},
+};
+
+static int tegra30_mc_flush(struct tegra_mc *mc,
+		const struct tegra_mc_hotreset *hotreset)
+{
+	u32 val;
+
+	if (!mc || !hotreset)
+		return -EINVAL;
+
+	mutex_lock(&mc->lock);
+
+	val = mc_readl(mc, hotreset->ctrl);
+	val |= BIT(hotreset->bit);
+	mc_writel(mc, val, hotreset->ctrl);
+	mc_readl(mc, hotreset->ctrl);
+
+	mutex_unlock(&mc->lock);
+
+	/* poll till the flush is done */
+	do {
+		udelay(10);
+		val = mc_readl(mc, hotreset->status);
+	} while (!(val & BIT(hotreset->bit)));
+
+	dev_dbg(mc->dev, "%s bit %d\n", __func__, hotreset->bit);
+	return 0;
+}
+
+static int tegra30_mc_flush_done(struct tegra_mc *mc,
+		const struct tegra_mc_hotreset *hotreset)
+{
+	u32 val;
+
+	if (!mc || !hotreset)
+		return -EINVAL;
+
+	mutex_lock(&mc->lock);
+
+	val = mc_readl(mc, hotreset->ctrl);
+	val &= ~BIT(hotreset->bit);
+	mc_writel(mc, val, hotreset->ctrl);
+	mc_readl(mc, hotreset->ctrl);
+
+	mutex_unlock(&mc->lock);
+
+	dev_dbg(mc->dev, "%s bit %d\n", __func__, hotreset->bit);
+	return 0;
+}
+
+static const struct tegra_mc_ops tegra30_mc_ops = {
+	.flush = tegra30_mc_flush,
+	.flush_done = tegra30_mc_flush_done,
+};
+
 static void tegra30_flush_dcache(struct page *page, unsigned long offset,
 				 size_t size)
 {
@@ -967,4 +1042,7 @@ const struct tegra_mc_soc tegra30_mc_soc = {
 	.num_address_bits = 32,
 	.atom_size = 16,
 	.smmu = &tegra30_smmu_soc,
+	.hotresets = tegra30_mc_hotreset,
+	.num_hotresets = ARRAY_SIZE(tegra30_mc_hotreset),
+	.ops = &tegra30_mc_ops,
 };
-- 
2.1.4
