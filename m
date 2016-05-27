From: Caesar Wang <wxt@rock-chips.com>
Subject: [RESEND PATCH v4 4/5] thermal: bang-bang governor: act on lower trip boundary
Date: Fri, 27 May 2016 16:36:47 +0800
Message-ID: <1464338208-8105-5-git-send-email-wxt@rock-chips.com>
References: <1464338208-8105-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464338208-8105-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, linux-pm@vger.kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org, briannorris@google.com, smbarber@google.com, linux-rockchip@lists.infradead.org, cf@rock-chips.com, huangtao@rock-chips.com, dmitry.torokhov@gmail.com, javi.merino@arm.com, peter@piie.net, Sascha Hauer <s.hauer@pengutronix.de>, Caesar Wang <wxt@rock-chips.com>, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Sascha Hauer <s.hauer@pengutronix.de>

With interrupt driven thermal zones we pass the lower and upper
temperature on which shall be acted, so in the governor we have to act on
the exact lower temperature to be consistent. Otherwise an interrupt maybe
generated on the exact lower temperature, but the bang bang governor does
not react since The polling driven zones have to be one step cooler before
the governor reacts.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org
Acked-by: Peter Feuerer <peter@piie.net>

---

Changes in v4: None
Changes in v3:
- Add the peter's ACK.

Changes in v2:
- Update the commit for patch[v2 4/5].

 drivers/thermal/gov_bang_bang.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
index 70836c5..9d1dfea 100644
--- a/drivers/thermal/gov_bang_bang.c
+++ b/drivers/thermal/gov_bang_bang.c
@@ -59,7 +59,7 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 		if (instance->target == 0 && tz->temperature >= trip_temp)
 			instance->target = 1;
 		else if (instance->target == 1 &&
-				tz->temperature < trip_temp - trip_hyst)
+				tz->temperature <= trip_temp - trip_hyst)
 			instance->target = 0;
 
 		dev_dbg(&instance->cdev->device, "target=%d\n",
-- 
1.9.1
