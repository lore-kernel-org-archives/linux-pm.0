From: Vince Hsu <vinceh@nvidia.com>
Subject: [PATCH v2 05/17] memory: tegra: add flush operation for Tegra124 memory clients
Date: Thu, 12 Mar 2015 20:15:06 +0800
Message-ID: <1426162518-7405-6-git-send-email-vinceh@nvidia.com>
References: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16171 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754064AbbCLMPd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Mar 2015 08:15:33 -0400
In-Reply-To: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: thierry.reding@gmail.com, pdeschrijver@nvidia.com, swarren@wwwdotorg.org, gnurou@gmail.com, jroedel@suse.de, p.zabel@pengutronix.de, mturquette@linaro.org, pgaikwad@nvidia.com, sboyd@codeaurora.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tbergstrom@nvidia.com, airlied@linux.ie, bhelgaas@google.com, tj@kernel.org, arnd@arndb.de, robh@kernel.org, will.deacon@arm.com
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, Vince Hsu <vinceh@nvidia.com>

This patch adds the hot reset register table and flush related callback
functions for Tegra124.

Signed-off-by: Vince Hsu <vinceh@nvidia.com>

---
v2: move the drop of tegra124_mc_clients' const to patch #2
    move mc flush operations to tegra114

 drivers/memory/tegra/tegra124.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/memory/tegra/tegra124.c b/drivers/memory/tegra/tegra124.c
index ec25546835fe..ef74f060e59e 100644
--- a/drivers/memory/tegra/tegra124.c
+++ b/drivers/memory/tegra/tegra124.c
@@ -959,7 +959,40 @@ static const struct tegra_smmu_swgroup tegra124_swgroups[] = {
 	{ .swgroup = TEGRA_SWGROUP_VI,        .reg = 0x280 },
 };
 
+static struct tegra_mc_hotreset tegra124_mc_hotreset[] = {
+	{TEGRA_SWGROUP_AFI,        0x200, 0x204,  0},
+	{TEGRA_SWGROUP_AVPC,       0x200, 0x204,  1},
+	{TEGRA_SWGROUP_DC,         0x200, 0x204,  2},
+	{TEGRA_SWGROUP_DCB,        0x200, 0x204,  3},
+	{TEGRA_SWGROUP_HC,         0x200, 0x204,  6},
+	{TEGRA_SWGROUP_HDA,        0x200, 0x204,  7},
+	{TEGRA_SWGROUP_ISP2,       0x200, 0x204,  8},
+	{TEGRA_SWGROUP_MPCORE,     0x200, 0x204,  9},
+	{TEGRA_SWGROUP_MPCORELP,   0x200, 0x204, 10},
+	{TEGRA_SWGROUP_MSENC,      0x200, 0x204, 11},
+	{TEGRA_SWGROUP_PPCS,       0x200, 0x204, 14},
+	{TEGRA_SWGROUP_SATA,       0x200, 0x204, 15},
+	{TEGRA_SWGROUP_VDE,        0x200, 0x204, 16},
+	{TEGRA_SWGROUP_VI,         0x200, 0x204, 17},
+	{TEGRA_SWGROUP_VIC,        0x200, 0x204, 18},
+	{TEGRA_SWGROUP_XUSB_HOST,  0x200, 0x204, 19},
+	{TEGRA_SWGROUP_XUSB_DEV,   0x200, 0x204, 20},
+	{TEGRA_SWGROUP_TSEC,       0x200, 0x204, 22},
+	{TEGRA_SWGROUP_SDMMC1A,    0x200, 0x204, 29},
+	{TEGRA_SWGROUP_SDMMC2A,    0x200, 0x204, 30},
+	{TEGRA_SWGROUP_SDMMC3A,    0x200, 0x204, 31},
+	{TEGRA_SWGROUP_SDMMC4A,    0x970, 0x974,  0},
+	{TEGRA_SWGROUP_ISP2B,      0x970, 0x974,  1},
+	{TEGRA_SWGROUP_GPU,        0x970, 0x974,  2},
+};
+
 #ifdef CONFIG_ARCH_TEGRA_124_SOC
+
+static const struct tegra_mc_ops tegra124_mc_ops = {
+	.flush = tegra114_mc_flush,
+	.flush_done = tegra114_mc_flush_done,
+};
+
 static void tegra124_flush_dcache(struct page *page, unsigned long offset,
 				  size_t size)
 {
@@ -991,5 +1024,8 @@ const struct tegra_mc_soc tegra124_mc_soc = {
 	.num_address_bits = 34,
 	.atom_size = 32,
 	.smmu = &tegra124_smmu_soc,
+	.hotresets = tegra124_mc_hotreset,
+	.num_hotresets = ARRAY_SIZE(tegra124_mc_hotreset),
+	.ops = &tegra124_mc_ops,
 };
 #endif /* CONFIG_ARCH_TEGRA_124_SOC */
-- 
2.1.4

