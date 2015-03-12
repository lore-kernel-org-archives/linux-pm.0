From: Vince Hsu <vinceh@nvidia.com>
Subject: [PATCH v2 04/17] memory: tegra: add flush operation for Tegra114 memory clients
Date: Thu, 12 Mar 2015 20:15:05 +0800
Message-ID: <1426162518-7405-5-git-send-email-vinceh@nvidia.com>
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
functions for Tegra114.

Signed-off-by: Vince Hsu <vinceh@nvidia.com>
---
 drivers/memory/tegra/mc.h       |   5 ++
 drivers/memory/tegra/tegra114.c | 104 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+)

diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index d5d21147fc77..2c3b8db04073 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -25,6 +25,11 @@ static inline void mc_writel(struct tegra_mc *mc, u32 value,
 	writel(value, mc->regs + offset);
 }
 
+int tegra114_mc_flush(struct tegra_mc *mc,
+		const struct tegra_mc_hotreset *hotreset);
+int tegra114_mc_flush_done(struct tegra_mc *mc,
+		const struct tegra_mc_hotreset *hotreset);
+
 #ifdef CONFIG_ARCH_TEGRA_3x_SOC
 extern const struct tegra_mc_soc tegra30_mc_soc;
 #endif
diff --git a/drivers/memory/tegra/tegra114.c b/drivers/memory/tegra/tegra114.c
index 92ab5552fcee..b5040e653aa2 100644
--- a/drivers/memory/tegra/tegra114.c
+++ b/drivers/memory/tegra/tegra114.c
@@ -6,6 +6,8 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/of.h>
 #include <linux/mm.h>
 
@@ -914,6 +916,105 @@ static const struct tegra_smmu_swgroup tegra114_swgroups[] = {
 	{ .swgroup = TEGRA_SWGROUP_TSEC,      .reg = 0x294 },
 };
 
+static struct tegra_mc_hotreset tegra114_mc_hotreset[] = {
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
+	{TEGRA_SWGROUP_MSENC,      0x200, 0x204, 11},
+	{TEGRA_SWGROUP_NV,         0x200, 0x204, 12},
+	{TEGRA_SWGROUP_PPCS,       0x200, 0x204, 14},
+	{TEGRA_SWGROUP_VDE,        0x200, 0x204, 16},
+	{TEGRA_SWGROUP_VI,         0x200, 0x204, 17},
+};
+
+/*
+ * Must be called with mc->lock held
+ */
+static bool tegra114_stable_hotreset_check(struct tegra_mc *mc,
+		u32 reg, u32 *stat)
+{
+	int i;
+	u32 cur_stat;
+	u32 prv_stat;
+
+	/*
+	 * There might be a glitch seen with the status register if we program
+	 * the control register and then read the status register in a short
+	 * window (on the order of 5 cycles) due to a HW bug. So here we poll
+	 * for a stable status read.
+	 */
+	prv_stat = mc_readl(mc, reg);
+	for (i = 0; i < 5; i++) {
+		cur_stat = mc_readl(mc, reg);
+		if (cur_stat != prv_stat)
+			return false;
+	}
+	*stat = cur_stat;
+	return true;
+}
+
+int tegra114_mc_flush(struct tegra_mc *mc,
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
+	/* poll till the flush is done */
+	do {
+		udelay(10);
+		val = 0;
+		if (!tegra114_stable_hotreset_check(mc, hotreset->status, &val))
+			continue;
+	} while (!(val & BIT(hotreset->bit)));
+
+	mutex_unlock(&mc->lock);
+
+	dev_dbg(mc->dev, "%s bit %d\n", __func__, hotreset->bit);
+	return 0;
+}
+
+int tegra114_mc_flush_done(struct tegra_mc *mc,
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
+static const struct tegra_mc_ops tegra114_mc_ops = {
+	.flush = tegra114_mc_flush,
+	.flush_done = tegra114_mc_flush_done,
+};
+
 static void tegra114_flush_dcache(struct page *page, unsigned long offset,
 				  size_t size)
 {
@@ -945,4 +1046,7 @@ const struct tegra_mc_soc tegra114_mc_soc = {
 	.num_address_bits = 32,
 	.atom_size = 32,
 	.smmu = &tegra114_smmu_soc,
+	.hotresets = tegra114_mc_hotreset,
+	.num_hotresets = ARRAY_SIZE(tegra114_mc_hotreset),
+	.ops = &tegra114_mc_ops,
 };
-- 
2.1.4
