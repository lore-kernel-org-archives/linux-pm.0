From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH 3/8] thermal: rockchip: fix a impossible condition caused by the warning
Date: Wed,  3 Feb 2016 12:12:42 +0800
Message-ID: <1454472767-5767-4-git-send-email-wxt@rock-chips.com>
References: <1454472767-5767-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454472767-5767-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, edubezval@gmail.com
Cc: huangtao@rock-chips.com, linux-rockchip@lists.infradead.org, zhangqing@rock-chips.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Caesar Wang <wxt@rock-chips.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

As the Dan report the smatch check the thermal driver warning:
drivers/thermal/rockchip_thermal.c:551 rockchip_configure_from_dt()
warn: impossible condition '(thermal->tshut_temp > ((~0 >> 1))) =>
(s32min-s32max > s32max)'

Although The shut_temp read from DT is u32,the temperature is currently
represented as int not long in the thermal driver.
Let's change to make shut_temp instead of the thermal->tshut_temp for
the condition.

Fixes: commit 437df2172e8d
("thermal: rockchip: consistently use int for temperatures")

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 drivers/thermal/rockchip_thermal.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index b58e3fb..433085a 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -693,15 +693,14 @@ static int rockchip_configure_from_dt(struct device *dev,
 			 thermal->chip->tshut_temp);
 		thermal->tshut_temp = thermal->chip->tshut_temp;
 	} else {
+		if (shut_temp > INT_MAX) {
+			dev_err(dev, "Invalid tshut temperature specified: %d\n",
+				shut_temp);
+			return -ERANGE;
+		}
 		thermal->tshut_temp = shut_temp;
 	}
 
-	if (thermal->tshut_temp > INT_MAX) {
-		dev_err(dev, "Invalid tshut temperature specified: %d\n",
-			thermal->tshut_temp);
-		return -ERANGE;
-	}
-
 	if (of_property_read_u32(np, "rockchip,hw-tshut-mode", &tshut_mode)) {
 		dev_warn(dev,
 			 "Missing tshut mode property, using default (%s)\n",
-- 
1.9.1
