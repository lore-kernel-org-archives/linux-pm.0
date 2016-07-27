From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH 2/2] thermal: rockchip: optimize sensor auto accessing period
Date: Wed, 27 Jul 2016 22:10:43 +0800
Message-ID: <1469628643-29661-2-git-send-email-wxt@rock-chips.com>
References: <1469628643-29661-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1469628643-29661-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: smbarber@chromium.org, dianders@chromium.org, briannorris@chromium.org, Rocky Hao <rocky.hao@rock-chips.com>, Caesar Wang <wxt@rock-chips.com>, Zhang Rui <rui.zhang@intel.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Rocky Hao <rocky.hao@rock-chips.com>

In less than 10 ms, the temperature of soc will arise 10 degree. 250 ms
is too big for soc tempeture control. Setting 2.5 ms will speed up
temperature accessing speed but introduce no more cpu's computing overhead.
We set AUTO_PERIOD_TIME and TSADCV3_AUTO_PERIOD_HT_TIME the same value,
because normal temperature update speed is also our consern in IPA.

Signed-off-by: Rocky Hao <rocky.hao@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-pm@vger.kernel.org

---

 drivers/thermal/rockchip_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index a90423d..1f165c9 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -213,8 +213,8 @@ struct rockchip_thermal_data {
 #define TSADCV2_HIGHT_TSHUT_DEBOUNCE_COUNT	4
 #define TSADCV2_AUTO_PERIOD_TIME		250 /* 250ms */
 #define TSADCV2_AUTO_PERIOD_HT_TIME		50  /* 50ms */
-#define TSADCV3_AUTO_PERIOD_TIME		187500 /* 250ms */
-#define TSADCV3_AUTO_PERIOD_HT_TIME		37500  /* 50ms */
+#define TSADCV3_AUTO_PERIOD_TIME		1875 /* 2.5ms */
+#define TSADCV3_AUTO_PERIOD_HT_TIME		1875 /* 2.5ms */
 
 #define TSADCV2_USER_INTER_PD_SOC		0x340 /* 13 clocks */
 
-- 
1.9.1
