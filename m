From: Wei Ni <wni@nvidia.com>
Subject: [PATCH V8 03/14] thermal: tegra: get rid of PDIV/HOTSPOT hack
Date: Wed, 16 Mar 2016 16:56:00 +0800
Message-ID: <1458118571-29717-4-git-send-email-wni@nvidia.com>
References: <1458118571-29717-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458118571-29717-1-git-send-email-wni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, thierry.reding@gmail.com, rui.zhang@intel.com
Cc: MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Wei Ni <wni@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Get rid of T124-specific PDIV/HOTSPOT hack.
tegra-soctherm.c contained a hack to set the SENSOR_PDIV and
SENSOR_HOTSPOT_OFFSET registers - it just did two writes of
T124-specific opaque values.  Convert these into a form that can be
substituted on a per-chip basis, and into structure fields that have
at least some independent meaning.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/thermal/tegra/tegra-soctherm.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/tegra/tegra-soctherm.c b/drivers/thermal/tegra/tegra-soctherm.c
index b3ec0faa2bee..cc94069e0a31 100644
--- a/drivers/thermal/tegra/tegra-soctherm.c
+++ b/drivers/thermal/tegra/tegra-soctherm.c
@@ -48,14 +48,12 @@
 #define SENSOR_CONFIG2_THERMB_SHIFT		0
 
 #define SENSOR_PDIV				0x1c0
-#define SENSOR_PDIV_T124			0x8888
 #define SENSOR_PDIV_CPU_MASK			(0xf << 12)
 #define SENSOR_PDIV_GPU_MASK			(0xf << 8)
 #define SENSOR_PDIV_MEM_MASK			(0xf << 4)
 #define SENSOR_PDIV_PLLX_MASK			(0xf << 0)
 
 #define SENSOR_HOTSPOT_OFF			0x1c4
-#define SENSOR_HOTSPOT_OFF_T124			0x00060600
 #define SENSOR_HOTSPOT_CPU_MASK			(0xff << 16)
 #define SENSOR_HOTSPOT_GPU_MASK			(0xff << 8)
 #define SENSOR_HOTSPOT_MEM_MASK			(0xff << 0)
@@ -436,6 +434,7 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 	struct resource *res;
 	unsigned int i;
 	int err;
+	u32 pdiv, hotspot;
 
 	const struct tegra_tsensor *tsensors = t124_tsensors;
 	const struct tegra_tsensor_group **ttgs = tegra124_tsensor_groups;
@@ -493,8 +492,20 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 			goto disable_clocks;
 	}
 
-	writel(SENSOR_PDIV_T124, tegra->regs + SENSOR_PDIV);
-	writel(SENSOR_HOTSPOT_OFF_T124, tegra->regs + SENSOR_HOTSPOT_OFF);
+	/* Program pdiv and hotspot offsets per THERM */
+	pdiv = readl(tegra->regs + SENSOR_PDIV);
+	hotspot = readl(tegra->regs + SENSOR_HOTSPOT_OFF);
+	for (i = 0; i < TEGRA124_SOCTHERM_SENSOR_NUM; ++i) {
+		pdiv = REG_SET_MASK(pdiv, ttgs[i]->pdiv_mask,
+				    ttgs[i]->pdiv);
+		/* hotspot offset from PLLX, doesn't need to configure PLLX */
+		if (ttgs[i]->id != TEGRA124_SOCTHERM_SENSOR_PLLX)
+			hotspot =  REG_SET_MASK(hotspot,
+						ttgs[i]->pllx_hotspot_mask,
+						ttgs[i]->pllx_hotspot_diff);
+	}
+	writel(pdiv, tegra->regs + SENSOR_PDIV);
+	writel(hotspot, tegra->regs + SENSOR_HOTSPOT_OFF);
 
 	/* Initialize thermctl sensors */
 
-- 
1.9.1
