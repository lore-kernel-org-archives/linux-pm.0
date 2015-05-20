From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 11/16] thermal: bang-bang governor: act on lower trip boundary
Date: Wed, 20 May 2015 15:20:41 +0200
Message-ID: <1432128046-12921-12-git-send-email-s.hauer@pengutronix.de>
References: <1432128046-12921-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1432128046-12921-1-git-send-email-s.hauer@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-pm@vger.kernel.org
Cc: Stephen Warren <swarren@wwwdotorg.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, linux-mediatek@lists.infradead.org, kernel@pengutronix.de, Zhang Rui <rui.zhang@intel.com>, Brian Norris <computersforpeace@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

With interrupt driven thermal zones we pass the lower and upper temperature
on which shall be acted, so in the governor we have to act on the exact lower
temperature to be consistent. Otherwise an interrupt may be generated on the
exact lower temperature, but the bang bang governor does not react.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
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
2.1.4
