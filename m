From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V9 03/14] thermal: tegra: get rid of PDIV/HOTSPOT hack
Date: Tue, 29 Mar 2016 17:16:37 +0800
Message-ID: <1459242997-25211-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, mikko.perttunen-/1wQRMveznE@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Get rid of T124-specific PDIV/HOTSPOT hack.
tegra-soctherm.c contained a hack to set the SENSOR_PDIV and
SENSOR_HOTSPOT_OFFSET registers - it just did two writes of
T124-specific opaque values.  Convert these into a form that can be
substituted on a per-chip basis, and into structure fields that have
at least some independent meaning.

Signed-off-by: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/thermal/tegra/tegra-soctherm.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/tegra/tegra-soctherm.c b/drivers/thermal/tegra/tegra-soctherm.c
index 7c1f41c0733a..e486d034adb4 100644
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
