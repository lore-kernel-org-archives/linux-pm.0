From: Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v3 07/13] soc: rockchip: power-domain: add power domain support for rk3128
Date: Wed, 23 May 2018 14:51:10 +0800
Message-ID: <1527058270-10412-1-git-send-email-zhangqing@rock-chips.com>
References: <1527058129-10260-1-git-send-email-zhangqing@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527058129-10260-1-git-send-email-zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, wxt@rock-chips.com, xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

This driver is modified to support RK3128 SoC.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/soc/rockchip/pm_domains.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 01d4ba26a054..99a2dd8a7801 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -19,6 +19,7 @@
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
 #include <dt-bindings/power/rk3036-power.h>
+#include <dt-bindings/power/rk3128-power.h>
 #include <dt-bindings/power/rk3288-power.h>
 #include <dt-bindings/power/rk3328-power.h>
 #include <dt-bindings/power/rk3366-power.h>
@@ -720,6 +721,14 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 	[RK3036_PD_SYS]		= DOMAIN_RK3036(8, 22, 29, false),
 };
 
+static const struct rockchip_domain_info rk3128_pm_domains[] = {
+	[RK3128_PD_CORE]	= DOMAIN_RK3288(0, 0, 4, false),
+	[RK3128_PD_MSCH]	= DOMAIN_RK3288(-1, -1, 6, true),
+	[RK3128_PD_VIO]		= DOMAIN_RK3288(3, 3, 2, false),
+	[RK3128_PD_VIDEO]	= DOMAIN_RK3288(2, 2, 1, false),
+	[RK3128_PD_GPU]		= DOMAIN_RK3288(1, 1, 3, false),
+};
+
 static const struct rockchip_domain_info rk3288_pm_domains[] = {
 	[RK3288_PD_VIO]		= DOMAIN_RK3288(7, 7, 4, false),
 	[RK3288_PD_HEVC]	= DOMAIN_RK3288(14, 10, 9, false),
@@ -796,6 +805,17 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 	.domain_info = rk3036_pm_domains,
 };
 
+static const struct rockchip_pmu_info rk3128_pmu = {
+	.pwr_offset = 0x04,
+	.status_offset = 0x08,
+	.req_offset = 0x0c,
+	.idle_offset = 0x10,
+	.ack_offset = 0x10,
+
+	.num_domains = ARRAY_SIZE(rk3128_pm_domains),
+	.domain_info = rk3128_pm_domains,
+};
+
 static const struct rockchip_pmu_info rk3288_pmu = {
 	.pwr_offset = 0x08,
 	.status_offset = 0x0c,
@@ -875,6 +895,10 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 		.data = (void *)&rk3036_pmu,
 	},
 	{
+		.compatible = "rockchip,rk3128-power-controller",
+		.data = (void *)&rk3128_pmu,
+	},
+	{
 		.compatible = "rockchip,rk3288-power-controller",
 		.data = (void *)&rk3288_pmu,
 	},
-- 
1.9.1
