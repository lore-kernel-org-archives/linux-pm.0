From: Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v3 04/13] soc: rockchip: power-domain: Fix wrong value when power up pd
Date: Wed, 23 May 2018 14:48:40 +0800
Message-ID: <1527058129-10260-5-git-send-email-zhangqing@rock-chips.com>
References: <1527058129-10260-1-git-send-email-zhangqing@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527058129-10260-1-git-send-email-zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, wxt@rock-chips.com, xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com, Finley Xiao <finley.xiao@rock-chips.com>, Elaine Zhang <zhangqing@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

From: Finley Xiao <finley.xiao@rock-chips.com>

Solve the pd could only ever turn off but never turn them on again,
If the pd registers have the writemask bits.

Fix up the code error for commit:
	commit 79bb17ce8edb3141339b5882e372d0ec7346217c
	Author: Elaine Zhang <zhangqing@rock-chips.com>
	Date:   Fri Dec 23 11:47:52 2016 +0800

	soc: rockchip: power-domain: Support domain control in hiword-registers

	New Rockchips SoCs may have their power-domain control in registers
	using a writemask-based access scheme (upper 16bit being the write
	mask). So add a DOMAIN_M type and handle this case accordingly.
	Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
	Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/soc/rockchip/pm_domains.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index ebd7c41898c0..01d4ba26a054 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -264,7 +264,7 @@ static void rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *pd,
 		return;
 	else if (pd->info->pwr_w_mask)
 		regmap_write(pmu->regmap, pmu->info->pwr_offset,
-			     on ? pd->info->pwr_mask :
+			     on ? pd->info->pwr_w_mask :
 			     (pd->info->pwr_mask | pd->info->pwr_w_mask));
 	else
 		regmap_update_bits(pmu->regmap, pmu->info->pwr_offset,
-- 
1.9.1
