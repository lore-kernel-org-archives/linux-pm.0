From: Caesar Wang <wxt@rock-chips.com>
Subject: [RESEND PATCH 1/8] thermal: rockchip: disable thermal->clk in err case
Date: Fri, 22 Apr 2016 18:02:47 +0800
Message-ID: <1461319374-10024-2-git-send-email-wxt@rock-chips.com>
References: <1461319374-10024-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461319374-10024-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, Heiko Stuebner <heiko@sntech.de>
Cc: dianders@chromium.org, briannorris@google.com, smbarber@google.com, linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>, Caesar Wang <wxt@rock-chips.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Shawn Lin <shawn.lin@rock-chips.com>

Disable thermal->clk when enabling pclk fails in
resume routine.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Caesar Wang <wxt@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 drivers/thermal/rockchip_thermal.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 1dbd862..f4c4bcd 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -979,8 +979,10 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
 		return error;
 
 	error = clk_enable(thermal->pclk);
-	if (error)
+	if (error) {
+		clk_disable(thermal->clk);
 		return error;
+	}
 
 	rockchip_thermal_reset_controller(thermal->reset);
 
-- 
1.9.1
