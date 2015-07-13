From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V3 03/19] memory: tegra: add flush operation for Tegra30 memory clients
Date: Mon, 13 Jul 2015 13:39:41 +0100
Message-ID: <1436791197-32358-4-git-send-email-jonathanh@nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1436791197-32358-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, =?UTF-8?q?Terje=20Bergstr=C3=B6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

This patch adds the hot reset register table and flush related callback
functions for Tegra30.

Signed-off-by: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
[jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org: Removed tegra_mc_ops and added
 metastable_flush_reads.]
Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

---
v3: removal of tegra_mc_ops
---
 drivers/memory/tegra/tegra30.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/memory/tegra/tegra30.c b/drivers/memory/tegra/tegra30.c
index 1abcd8f6f3ba..3b4987f39b52 100644
--- a/drivers/memory/tegra/tegra30.c
+++ b/drivers/memory/tegra/tegra30.c
@@ -6,6 +6,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/device.h>
 #include <linux/of.h>
 #include <linux/mm.h>
 
@@ -936,6 +937,26 @@ static const struct tegra_smmu_swgroup tegra30_swgroups[] = {
 	{ .name = "isp",  .swgroup = TEGRA_SWGROUP_ISP,  .reg = 0x258 },
 };
 
+static struct tegra_mc_flush tegra30_mc_flush[] = {
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
 static void tegra30_flush_dcache(struct page *page, unsigned long offset,
 				 size_t size)
 {
@@ -967,4 +988,7 @@ const struct tegra_mc_soc tegra30_mc_soc = {
 	.num_address_bits = 32,
 	.atom_size = 16,
 	.smmu = &tegra30_smmu_soc,
+	.flushes = tegra30_mc_flush,
+	.num_flushes = ARRAY_SIZE(tegra30_mc_flush),
+	.metastable_flush_reads = 0,
 };
-- 
2.1.4
