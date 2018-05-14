From: Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v2 10/13] soc: rockchip: power-domain: add power domain support for rk3228
Date: Mon, 14 May 2018 11:31:42 +0800
Message-ID: <1526268702-25242-1-git-send-email-zhangqing@rock-chips.com>
References: <1526268455-9133-1-git-send-email-zhangqing@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526268455-9133-1-git-send-email-zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, wxt@rock-chips.com, xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

This driver is modified to support RK3228 SoC.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/soc/rockchip/pm_domains.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 99a2dd8a7801..90dcd5e21ae6 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -20,6 +20,7 @@
 #include <linux/mfd/syscon.h>
 #include <dt-bindings/power/rk3036-power.h>
 #include <dt-bindings/power/rk3128-power.h>
+#include <dt-bindings/power/rk3228-power.h>
 #include <dt-bindings/power/rk3288-power.h>
 #include <dt-bindings/power/rk3328-power.h>
 #include <dt-bindings/power/rk3366-power.h>
@@ -729,6 +730,20 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 	[RK3128_PD_GPU]		= DOMAIN_RK3288(1, 1, 3, false),
 };
 
+static const struct rockchip_domain_info rk3228_pm_domains[] = {
+	[RK3228_PD_CORE]	= DOMAIN_RK3036(0, 0, 16, true),
+	[RK3228_PD_MSCH]	= DOMAIN_RK3036(1, 1, 17, true),
+	[RK3228_PD_BUS]		= DOMAIN_RK3036(2, 2, 18, true),
+	[RK3228_PD_SYS]		= DOMAIN_RK3036(3, 3, 19, true),
+	[RK3228_PD_VIO]		= DOMAIN_RK3036(4, 4, 20, false),
+	[RK3228_PD_VOP]		= DOMAIN_RK3036(5, 5, 21, false),
+	[RK3228_PD_VPU]		= DOMAIN_RK3036(6, 6, 22, false),
+	[RK3228_PD_RKVDEC]	= DOMAIN_RK3036(7, 7, 23, false),
+	[RK3228_PD_GPU]		= DOMAIN_RK3036(8, 8, 24, false),
+	[RK3228_PD_PERI]	= DOMAIN_RK3036(9, 9, 25, true),
+	[RK3228_PD_GMAC]	= DOMAIN_RK3036(10, 10, 26, false),
+};
+
 static const struct rockchip_domain_info rk3288_pm_domains[] = {
 	[RK3288_PD_VIO]		= DOMAIN_RK3288(7, 7, 4, false),
 	[RK3288_PD_HEVC]	= DOMAIN_RK3288(14, 10, 9, false),
@@ -816,6 +831,15 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 	.domain_info = rk3128_pm_domains,
 };
 
+static const struct rockchip_pmu_info rk3228_pmu = {
+	.req_offset = 0x40c,
+	.idle_offset = 0x488,
+	.ack_offset = 0x488,
+
+	.num_domains = ARRAY_SIZE(rk3228_pm_domains),
+	.domain_info = rk3228_pm_domains,
+};
+
 static const struct rockchip_pmu_info rk3288_pmu = {
 	.pwr_offset = 0x08,
 	.status_offset = 0x0c,
@@ -899,6 +923,10 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 		.data = (void *)&rk3128_pmu,
 	},
 	{
+		.compatible = "rockchip,rk3228-power-controller",
+		.data = (void *)&rk3228_pmu,
+	},
+	{
 		.compatible = "rockchip,rk3288-power-controller",
 		.data = (void *)&rk3288_pmu,
 	},
-- 
1.9.1
